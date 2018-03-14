<%-- 
    Document   : mapasGoogle
    Created on : 2/08/2017, 08:43:50 PM
    Author     : desarrolloJuan
--%>

<%@page import="Modelo.taxonomia"%>
<%@page import="java.sql.Connection"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Modelo.localidad"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<style>
    .unidad{
        border-radius: 5px;
    }
</style>
<%    
    Usuario user = new Usuario();
    if (session.getAttribute("user") != null) {
        user = (Usuario) session.getAttribute("user");
        session.setMaxInactiveInterval(900);
        if (user.getId() > 0 && !user.getTipoUser().equals("ADMINISTRADOR")) {
            %><script>window.location = "index.jsp";</script> <% return;
        }
    } else { %><script>window.location = "index.jsp";</script> <% return;
        }
%>

<%
    Connection conn = (Connection) session.getAttribute("connMySql");
    String nombre = "" + request.getParameter("nombre");
    Float lat, lng, area;
    String descripcion, altitud;

    if (!nombre.equals("null")) {
        // registro de nueva localidad.
        String tempLat, tempLng;
        tempLat = request.getParameter("lat");
        tempLng = request.getParameter("lng");
//                if(tempLat.length()>10)tempLat = tempLat.substring(0, 10);
//                if(tempLng.length()>10)tempLng = tempLng.substring(0, 10);
        lat = Float.valueOf(tempLat.replace(",", "."));
        lng = Float.valueOf(tempLng.replace(",", "."));
        descripcion = request.getParameter("descripcion");
        altitud = request.getParameter("alt");
        String temArea = request.getParameter("area");
        if (temArea.equals("")) {
            temArea = "0";
        }
        area = Float.valueOf(temArea);
        if (altitud.equals("")) {
            altitud = "0";
        }
        int idNuevo = localidad.registrarLocalidad(conn, lat, lng, nombre, descripcion, altitud, area);
        if (idNuevo >= 0) {
            //se registro correctamente la nueva localidad
        }
    }

//Cargando los marcadores desde MySql
    String marcador = localidad.getMarcadores(conn);

%>

<div class="container">
    <div class="col-xs-12 col-sm-7 x_panel_Principal">
        <div class="x_panel ">
            <div class="x_title">
                <h2>Mapa de las Localidades</h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content form-horizontal">  
                <div id="map" class="col-xs-12" style="border: solid #111 1px;height: 400px;"></div>       
            </div>
        </div>
    </div>
    <div class="col-xs-12 col-sm-5 x_panel_Principal">
        <div class="x_panel ">
            <div class="x_title">
                <h2>Registrar Nueva Localidad</h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content form-horizontal">  
                <form method="post" style="padding: 5px;" >
                    <div class="row" ><label >Nombre</label><input class="form-control input-sm" type="text" name="nombre" required maxlength="100"></div>
                    <div class="row" ><label>Descripcion</label><textarea class="form-control input-sm" name="descripcion" maxlength="200" required placeholder="Use un maximo de 200 caracteres"></textarea></div>
                    <div class="row" ><label>latitud</label><input id="txtLat" class="form-control input-sm"  name="lat" required maxlength="10"></div>
                    <div class="row" ><label>longitud</label><input id="txtLng" class="form-control input-sm"  name="lng" required maxlength="10"></div>
                    <div class="row" ><label>altitud</label><input class="form-control input-sm" type="text" name="alt" ></div>
                    <div class="row" ><label>Area</label><input class="form-control input-sm" type="text" name="area"></div>
                    <div class="row" ><input class="btn btn-primary" type="submit" value="guardar"></div>
                </form>       
            </div>
        </div>
    </div>

    <div class="col-xs-12 col-md-7 x_panel_Principal">
        <div class="x_panel">
            <div class="x_title">
                <h2>Datos Localidades</h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content form-horizontal"> 

                <div class="well pre-scrollable" >
                    <table class="table">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>LOCALIDAD</th>
                                <th>DESCRIPCION</th>
                                <th>LATITUD</th>
                                <th>LONGITUD</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%                ArrayList<localidad> localidades = localidad.getLocalidadesList(conn);
                                for (localidad milocalidad : localidades) {
                            %><tr>
                                <td><%=milocalidad.getIdlocalidad()%> </td>
                                <td><%=milocalidad.getNombre()%> </td>
                                <td><%=milocalidad.getNombre()%> </td>
                                <td><%=milocalidad.getLat()%> </td>
                                <td><%=milocalidad.getLon()%> </td>
                            </tr><%
                                }
                            %>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>


    <!--localidades de estudio-->
    <%
        ArrayList<localidad> listAllLocalidades = localidad.getLocalidadesList(conn);
        ArrayList<taxonomia> ListaEspecie = null;
    %>
    <div class="x_panel_Principal ">
        <div class="x_panel">
            <div class="x_title">
                <a href="#1" class="collapse-link " > 
                    <h2 class="text-info enlace-x_titulo text-uppercase">Localidades registradas <span class="badge bg-blue" style="font-size: 15px;"><%=listAllLocalidades.size()%></span></h2>
                    <i class="fa fa-chevron-up"></i>
                </a>
<!--                <h2 class="text-info">Localidades estudiadas <span class="badge bg-blue" style="font-size: 15px;"><%=listAllLocalidades.size()%></span></h2>
<ul class="nav navbar-right panel_toolbox">
    <li><a class="close-link"><i class="fa fa-close"></i></a></li>
    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
</ul>-->
                <div class="clearfix"></div>
            </div>
            <div class="x_content form-horizontal"> 
                <div class=" ">
                    <%
                        for (localidad local : listAllLocalidades) {
                            String[] idLocalidad = {String.valueOf(local.getIdlocalidad())};
                            ListaEspecie = taxonomia.getEspeciesListByLocalidad(conn, idLocalidad);
                    %>
                    <div class="col-md-6 col-xs-12">
                        <div class="unidad x_panel">
                            <div class="col-xs-12"><span class="h4 text-info text-uppercase text-left"><%=local.getNombre()%></span>
                                <span class="h6">(<%=local.getLat()%> , <%=local.getLon()%>)</span></div>
                            <div class="col-xs-6">
                                <h5 class="text-info">Información general</h5>
                                <b>Altitud : </b> <%=local.getAltitud()%> mt<br>
                                <b>Area : </b> <%=local.getArea()%> mt<sup>2</sup><br>
                                <b>Diversidad : </b> <%=local.getDiversidad()%> <br>
                                <!--<b>Diversidad : </b> <%=ListaEspecie.size()%> <br>-->
                            </div>
                            <div class="col-xs-6">
                                <h5 class="text-info">Lista de especies</h5>
                                <ul>
                                    <%
                                        for (taxonomia especie : ListaEspecie) {
                                    %>
                                    <li><%=especie.getEspecie()%> <sub><%=especie.getNombreComun()%></sub></li>

                                    <%
                                        }
                                    %>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>

                </div>
            </div>
        </div>
    </div>


</div>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBh1G0LrtklkAkfo7_WgrZ7YGHozA3pGaI&callback=initMap">
</script>
<script>
    var infowindow = null;
    var map = null;
    iniPanelButon();
    function initMap() {
        var coodenadaInicial = {lat: 7.131169383857156, lng: -73.12507796813958};
//  var beaches = [
//  ['Bondi Beach', 7.1338, -73.1296, 4],
//   ['La casona', 7.1342, -73.12856, 4],
//   ['Botija', 7.13154, -73.12984, 4]
//];
    <%=marcador%>
        map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15,
            center: coodenadaInicial
        });

        var contentString = '<div>' +
                '<form method="post">' +
                '<input type="text" name="minombre" placeholder="Ingresa tu nombre"> ' +
                '<input type="submit" value="Guardar">' +
                '</form>' +
                '</div>';

        infowindow = new google.maps.InfoWindow();

        for (var i = 0; i < marcadores.length; i++) {
            var datoMarcador = marcadores[i];
            var marker = new google.maps.Marker({
                position: {lat: datoMarcador[1], lng: datoMarcador[2]},
                map: map,
                icon: '../Pruebas/tree.png',
                animation: google.maps.Animation.DROP,
                title: "Localidad: " + datoMarcador[0],
                zIndex: 3
            });
            marker.addListener('click', function () {

                var html = '<p>Localizado en :' + marker.getPosition() + '</p>';
                infowindow.setContent(html);
                infowindow.open(map, this);
            });
        }
        //creando marcador dragable
        var marker = new google.maps.Marker({
            position: coodenadaInicial,
//      position: {lat:  7.16136, lng:  -73.14027},
            map: map,
            animation: google.maps.Animation.DROP,
            title: "Marcador Arrastable",
            draggable: true,
            zIndex: 100
        });
        google.maps.event.addListener(marker, 'click', function () {
            openInfoWindow(marker);
        });
    }

    function openInfoWindow(marker) {
        infoWindow = new google.maps.InfoWindow();


        var markerLatLng = marker.getPosition();
        var lat = markerLatLng.lat();
        var lng = markerLatLng.lng();
        $("#txtLng").attr("value", lng);
        $("#txtLat").attr("value", lat);
        var html = 'La posición del marcador es</br> <b>Lat : </b>' + markerLatLng.lat() + '</br><b>Lon : </b>' + markerLatLng.lng() + '<p>Arrastrame y haz click para actualizar la posición.</p>';
        infowindow.setContent(html);
        infowindow.open(map, marker);
    }


</script>
<script>
    $("form").submit(function () {
        evioFormulario(this);
        return false;
    });
    $("form").attr("action", "../Formularios/RegistroLocalidad.jsp");
</script>

