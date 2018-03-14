<%-- 
    Document   : mapasGoogle
    Created on : 2/08/2017, 08:43:50 PM
    Author     : desarrolloJuan
--%>

<%@page import="Modelo.localidad"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
        <style>
            /* Always set the map height explicitly to define the size of the div
 * element that contains the map. */
#map {
  height: 100%;
}
/* Optional: Makes the sample page fill the window. */
html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}
        </style>
            
    </head>
    <body>
        
        <%
            String nombre = "" + request.getParameter("nombre");
            Float lat, lng,area;
            String descripcion,altitud;
            
             
             
            if (!nombre.equals("null")) {
                // registro de nueva localidad.
                String tempLat, tempLng;
                tempLat= request.getParameter("lat");
                tempLng= request.getParameter("lng");
                if(tempLat.length()>10)tempLat = tempLat.substring(0, 10);
                if(tempLng.length()>10)tempLng = tempLng.substring(0, 10);
                lat = Float.valueOf(tempLat);
                lng = Float.valueOf(tempLng);
                descripcion = request.getParameter("descripcion");
                altitud = request.getParameter("alt");
                String temArea = request.getParameter("area");
                if(temArea.equals("")) temArea = "0";
                area = Float.valueOf(temArea);
                if(altitud.equals("")) altitud = "0";
                int idNuevo = localidad.registrarLocalidad(lat, lng, nombre, descripcion, altitud, area);
                if (idNuevo >= 0) {
                    //se registro correctamente la nueva localidad
                }
            }
            
//Cargando los marcadores desde MySql
            String marcador = localidad.getMarcadores();

        %>
        
        <div id="map" class="col-xs-11 col-md-5 col-lg-6 col-sm-10"></div>
 <!-- Replace the value of the key parameter with your own API key. -->
<script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC8wajbRRM8kmfNR37XI43VLDBkx38kFH4&callback=initMap">
</script>
<script>
     function initMap() {
  var coodenadaInicial = {lat: 7.1338, lng: -73.1296};
//  var beaches = [
//  ['Bondi Beach', 7.1338, -73.1296, 4],
//   ['La casona', 7.1342, -73.12856, 4],
//   ['Botija', 7.13154, -73.12984, 4]
//];
  <%=marcador %>
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 15,
    center: coodenadaInicial
  });

//  var contentString = '<div id="content">'+
//      '<div id="siteNotice">'+
//      '</div>'+
//      '<h1 id="firstHeading" class="firstHeading">Uluru</h1>'+
//      '<div id="bodyContent">'+
//      '<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
//      'sandstone rock formation in the southern part of the '+
//      'Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) '+
//      'south west of the nearest large town, Alice Springs; 450&#160;km '+
//      '(280&#160;mi) by road. Kata Tjuta and Uluru are the two major '+
//      'features of the Uluru - Kata Tjuta National Park. Uluru is '+
//      'sacred to the Pitjantjatjara and Yankunytjatjara, the '+
//      'Aboriginal people of the area. It has many springs, waterholes, '+
//      'rock caves and ancient paintings. Uluru is listed as a World '+
//      'Heritage Site.</p>'+
//      '<p>Attribution: Uluru, <a href="https://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">'+
//      'https://en.wikipedia.org/w/index.php?title=Uluru</a> '+
//      '(last visited June 22, 2009).</p>'+
//      '</div>'+
//      '</div>';
var contentString = '<div>'+
    '<form method="post">'+
        '<input type="text" name="minombre" placeholder="Ingresa tu nombre"> '+
        '<input type="submit" value="Guardar">'+
    '</form>'+
'</div>';

  var infowindow = new google.maps.InfoWindow({
    content: contentString
  });
  
   for (var i = 0; i < marcadores.length; i++) {
    var datoMarcador = marcadores[i];
    var marker = new google.maps.Marker({
      position: {lat:  datoMarcador[1], lng:  datoMarcador[2]},
      map: map,
      icon: '../Pruebas/tree.png',
    animation: google.maps.Animation.DROP,
      title:  datoMarcador[0],
      zIndex:  datoMarcador[3]
    });
    marker.addListener('click', function() {
    infowindow.open(map, this);
  });
  }
}
      function doNothing() {}
</script>
<div class="form-horizontal col-xs-11 col-md-5 col-lg-4 col-sm-10" >
    <form method="post">
        <div class="row" ><label class="label">Nombre</label><input class="form-control input-sm" type="text" name="nombre" required></div>
        <div class="row" ><label>Descripcion</label><textarea class="form-control input-sm" name="descripcion" required></textarea></div>
        <div class="row" ><label>latitud</label><input class="form-control input-sm" type="text" name="lat" required></div>
        <div class="row" ><label>longitud</label><input class="form-control input-sm" type="text" name="lng" required></div>
        <div class="row" ><label>altitud</label><input class="form-control input-sm" type="text" name="alt"></div>
        <div class="row" ><label>Area</label><input class="form-control input-sm" type="text" name="area"></div>
        <div class="row" ><input class="btn btn-primary" type="submit" value="guardar"></div>
    </form>
</div>
    </body>
</html>
