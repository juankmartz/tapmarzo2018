<%-- 
    Document   : consultaDatosExterior
    Created on : 11-oct-2017, 11:47:24
    Author     : desarrolloJuan
--%>

<%@page import="Modelo.Medicion"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Modelo.Configuracion"%>
<%@page import="Modelo.Individuo"%>
<%@page import="org.apache.catalina.ant.ListTask"%>
<%@page import="BD.Conexion_MySQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashMap"%>
<%@page import="Modelo.proyectos"%>
<%@page import="Modelo.localidad"%>
<%@page import="Modelo.Rasgo"%>
<%@page import="Modelo.taxonomia"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<style>
    body{
        background-image: url(..//imagen/1.jpg)!important;
        background-size: cover!important;
        background-blend-mode: hard-light;
    }  
    .panel-transparente {
        background: rgba(0, 0, 0, 0.5);
    }
    .bg-blue {
        background: #030c11!important;
        border: 1px solid #3498db!important;
        color: #3498db;
    }
    .panel-transparente .text-info {
        color: #e6e6e6;
    }
    .x_panel {
        border: 1px solid #6b6b6bd1;
    }
    .x_title {
        border-bottom: 2px solid #575757;
        padding: 0px 5px 0px;
    }
    .panel_toolbox>li>a:hover {
        color: #3498db;
    }
    .enlace-x_titulo{
        width: 95%;
        cursor: pointer;
    }
    .text-muted{
        color: #808080;
    }
</style>
 
<video id="video-background" style="position: fixed;z-index: -1;top: 0px;width: 100%;" autoplay="" loop="" muted="" poster="../imagen/pattern.png" >
    <source src="../imagen/videoDocument.mp4" type="video/mp4">
    <!--<source src="https://s3.amazonaws.com/distill-videos/videos/processed/2180/lighthouse.mp4" type="video/mp4">-->
</video>
<!--<section class="centrado-padre form-solicitud-acceso">-->
<div class="container-fluid center-block columnas-md-2 " style="padding-top:100px;" id="accordionSecciones">
    <%
        Connection conn = Conexion_MySQL.conectar2();
        ArrayList<taxonomia> ListaEspecie = taxonomia.getEspeciesList(conn);
    %>

    <div class="x_panel_Principal ">
        <div class="x_panel panel-transparente">
            <div class="x_title">
                <a href="#1" class="collapse-link " > 
                    <h2 class=" text-info accordion enlace-x_titulo">Especies estudiadas <span class="badge bg-blue" style="font-size: 15px;"><%=ListaEspecie.size()%></span></h2>
                    <i class="fa fa-chevron-up"></i>
                </a>
                <!--                <ul class="nav navbar-right panel_toolbox">
                                    <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                </ul>-->
                <div class="clearfix"></div>
            </div>
            <div class="x_content form-horizontal"> 
                <div  class="columnas-lg-2">
                    <%
                        for (taxonomia miEspecie : ListaEspecie) {
                            String rutaFoto = "../" + Configuracion.getValorConfiguracion(conn, "CARPETA_IMAGEN") + miEspecie.getImagen();
                            ArrayList<localidad> listaLocalidades = localidad.getLocalidadesListByIdEspecie(conn, miEspecie.getIdespecie());
                            ArrayList<Individuo> listaIndividuos = Individuo.obtenerIndividuosByEspecie(conn, miEspecie.getIdespecie());
                    %>
                    <div class="unidad panel-transparente x_panel" >
                        <h5 class="text-uppercase text-info"><%=miEspecie.getEspecie()%></h5>
                        <h6 class="text-info">(<%=miEspecie.getNombreComun()%>)</h6>
                        <!--<div class="imagen-fondo" style="background-image: url(<%=rutaFoto%>);"></div>-->
                        <div class="content-imagen" style="background-image: url(<%=rutaFoto%>);">
                            <!--<img src="< %=rutaFoto%>" style="width: 100%;height: 100%" >-->
                            <div class="overlay-text">
                                <span class="text-capitalize">individuos registrados: <b><%=listaIndividuos.size()%> </b></span><br>
                                <b class="text-capitalize">Localidades : </b>
                                <ul class="picker_1">
                                    <%
                                        if (listaLocalidades.size() == 0) {
                                    %> <li><i class="text-muted">Esta especie no se ha asociado a ninguna localidad</i></li><%
                                    } else
                                        for (localidad milocalidad : listaLocalidades) {
                                            int numeroIndividuos = 0;
                                            for (Individuo miIndividuo : listaIndividuos) {
                                                if (miIndividuo.getLocalidad() == milocalidad.getIdlocalidad()) {
                                                    numeroIndividuos++;
                                                }
                                            }
                                        %>
                                    <li><%=milocalidad.getNombre()%> con <%=numeroIndividuos%> individuos</li>

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
    <%                ResultSet conteoRasgos = Rasgo.conteoRasgosByTipoRasgo(conn);

        int totalRagos = 0;
        while (conteoRasgos.next()) {
            int rasgosTipo = conteoRasgos.getInt("total");
            totalRagos += rasgosTipo;
        }
    %>
    <div class="x_panel_Principal ">
        <div class="x_panel panel-transparente">
            <div class="x_title">
                <a href="#1" class="collapse-link " > 
                    <h2 class="text-info enlace-x_titulo">Rasgos registrado <span class="badge bg-blue" style="font-size: 15px;"> <%=totalRagos%></span></h2>
                    <i class="fa fa-chevron-up"></i>
                </a>
                <!--                <ul class="nav navbar-right panel_toolbox">
                                    <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                </ul>-->
                <div class="clearfix"></div>
            </div>
            <div class="x_content form-horizontal"> 
                <div class="col-xs-10 col-xs-offset-1 form-horizontal">                

                    <div class="form-group"><div class="col-xs-4" style="text-align: right;">Total rasgos registrados</div>
                        <div class="col-xs-2"> <b><%=totalRagos%></b> (100%)</div>
                        <div class="col-xs-6"><span class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="60" style="width: 100%;height: 20px;" ></span> </div></div>
                        <%
                            conteoRasgos.beforeFirst();
                            while (conteoRasgos.next()) {
                                int conteo = conteoRasgos.getInt("total");
                                int porcentaje = (conteo * 100) / totalRagos;
                        %>
                    <div class="form-group"><div class="col-xs-4" style="text-align: right;"><%=conteoRasgos.getString("tipo_rasgo")%></div>
                        <div class="col-xs-2"><b> <%=conteo%> </b>(<%=porcentaje%>%)</div>
                        <div class="col-xs-6"><span class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="60" style="width: <%=porcentaje%>%;height: 20px;" > </span>  </div></div>
                        <%
                            }
                        %>
                </div>
            </div>
        </div>
    </div>

    <%
        ArrayList<localidad> listAllLocalidades = localidad.getLocalidadesList(conn);
    %>
    <div class="x_panel_Principal ">
        <div class="x_panel panel-transparente">
            <div class="x_title">
                <a href="#1" class="collapse-link " > 
                    <h2 class="text-info enlace-x_titulo">Localidades estudiadas <span class="badge bg-blue" style="font-size: 15px;"><%=listAllLocalidades.size()%></span></h2>
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
                    <div class="unidad panel-transparente x_panel">
                        <div class="col-xs-12"><span class="h4 text-info text-uppercase text-left"><%=local.getNombre()%></span>
                            <span class="h6">(<%=local.getLat()%> , <%=local.getLon()%>)</span></div>
                        <div class="col-xs-6">
                            <h5 class="text-info">Información general</h5>
                            <b>Altitud : </b> <%=local.getAltitud()%> mt<br>
                            <b>Area : </b> <%=local.getArea()%> mt<sup>2</sup><br>
                            <b>Diversidad : </b> <%=ListaEspecie.size() %> <br>
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
                    <%
                        }
                    %>

                </div>
            </div>
        </div>
    </div>







</div>
<br>
<%
    ArrayList<proyectos> listProyectos = proyectos.getProyectosList(conn);
%>
<div class="container-fluid center-block ">
    <div class="panel_Principal ">
        <div class="col-xs-12 panel panel-transparente">
            <div class="x_title">
                <!--                <ul class="">
                                    <li>-->
                <a href="#1" class="collapse-link cerrar" onclick="$('#contenedorProyectos').slideToggle();"> 
                    <h2 class="text-info enlace-x_titulo ">Proyectos registrados <span class="badge bg-blue" style="font-size: 15px;"><%=listProyectos.size()%></span></h2>
                    <i class="fa fa-chevron-up"></i>
                </a>
                <!--                    </li>
                                </ul>-->

                <!--                <ul class="nav navbar-right panel_toolbox">
                                    <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                    <li><a class="collapse-link cerrar"><i class="fa fa-chevron-up"></i></a></li>
                                </ul>-->

                <div class="clearfix"></div>
            </div>
                    <div class=" form-horizontal" id="contenedorProyectos"> 
                <div class="columnas-md-2 columnas-lg-3" >
                    <%

                        for (proyectos proyect : listProyectos) {
                            ArrayList<taxonomia> especiesProyect = proyectos.getEspecieByProyectoList(conn, proyect.getIdProyecto());
                            ArrayList<Rasgo> rasgosProyect = proyectos.getCaracterisiticasInteresProyectoList(conn, proyect.getIdProyecto());
                            ArrayList<localidad> localidadProyect = localidad.getLocalidadProyecto(conn, proyect.getIdProyecto());
                            ArrayList<Medicion> medicionProyect = Medicion.obtenerMedcionesProyecto(conn, proyect.getIdProyecto(), rasgosProyect);
//                            proyect.getFechaCreo().toString();
                    %>
                    <div class=" x_panel_Principal" >
                        <div class="x_panel panel-transparente" style="height: auto;">
                            <div class="x_title">
                                <!--<a href="#proy< %=numero_proyecto%>" class="collapse-link cerrar" > <h2 class="text-uppercase text-info">< %=proyect.getTitulo()%> <br> <sub>< %=proyect.getResumen()%></sub></h2><i class="fa fa-chevron-up"></i></a>-->
                                <!--<h2 class="text-uppercase text-info">< %=proyect.getTitulo()%> <br> <sub>< %=proyect.getResumen()%></sub></h2>-->
                                <!--<ul class="nav navbar-right panel_toolbox">-->
                                <ul class="">
                                    <li><a href="#1" class="collapse-link cerrar" > <h2 class="text-uppercase text-info enlace-x_titulo"><%=proyect.getTitulo()%> <br> <span class="h5 text-lowercase"><%=proyect.getResumen()%></span></h2><i class="fa fa-chevron-up"></i></a></li>
                                    <li style="text-align: right"><small><%=proyect.getFechaCreo().toString()%></small></li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content form-horizontal collapsed"> 
                                <div class="col-xs-12 ">
                                    <h5 class="text-muted" style="font-weight: bold">Especies de estudio</h5>
                                    <%
                                        if (especiesProyect.size() == 0) {
                                    %> <i class="text-muted" style="padding-left: 10px;"> Sin definir especies en este proyecto</i><%
                                        }
                                    %>
                                    <ul style="padding-left: 10px;">
                                        <%                    for (taxonomia especie : especiesProyect) {
                                        %>
                                        <li><%=especie.getEspecie()%> (<i class="text-muted"><%=especie.getNombreComun()%></i>)</li>
                                            <%
                                                }
                                            %>
                                    </ul>
                                </div>
                                <div class="col-xs-12 ">
                                    <h5 class="text-muted" style="font-weight: bold">Localidades de estudio</h5>
                                    <%
                                        if (localidadProyect.size() == 0) {
                                    %> <i class="text-muted" style="padding-left: 10px;"> Sin definir Localidades a este proyecto</i><%
                                        }
                                    %>
                                    <ul style="padding-left: 10px;">
                                        <%
                                            for (localidad locald : localidadProyect) {
                                        %>
                                        <li><%=locald.getNombre()%> (<i class="text-muted"><%=locald.getLat()%>, <%=locald.getLon()%></i>)</li>
                                            <%
                                                }
                                            %>
                                    </ul>
                                </div>
                                <div class="col-xs-12">
                                    <h5 class="text-muted" style="font-weight: bold">Rasgos de estudio</h5>
                                    <%
                                        if (rasgosProyect.size() == 0) {
                                    %> <i class="text-muted" style="padding-left: 10px;"> Sin rasgos de interes en este proyecto</i><%
                                        }
                                    %>
                                    <ul style="padding-left: 10px;">
                                        <%
                                            for (Rasgo rasgop : rasgosProyect) {
                                        %>
                                        <li><%=rasgop.getNombre()%> (<i class="text-muted"><%=rasgop.getUnidad()%></i>)</li>
                                            <%
                                                }
                                            %>
                                    </ul>
                                </div>
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
<script>
    iniPanelButon(700);
    $(".cerrar").each(function () {
        $(this).click();
    });
//    $('[data-toggle="tooltip"]').tooltip();
</script>

<!--</section>-->