<%-- 
    Document   : taxonomia
    Created on : 3/08/2017, 10:28:03 AM
    Author     : desarrolloJuan
--%>

<%@page import="Modelo.localidad"%>
<%@page import="java.sql.Connection"%>
<%@page import="Modelo.Configuracion"%>
<%@page import="Bean.ManejoFicheros"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.poi.hssf.record.PageBreakRecord.Break"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Rasgo"%>
<%@page import="Modelo.Individuo"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Modelo.taxonomia"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%

//    if(request.getContentLength()>0){
//        File file = null;
//        String nombreImagen = "Temporal";
//        String rutaFotoEspecie = Configuracion.getValorConfiguracion("RUTA_IMAGENES");
//        file = ManejoFicherosExcel.guardarArchivoServidor(request,rutaFotoEspecie,nombreImagen);
//         }
%>
<style>
    .file_imagenPrevisualizar{
        position: relative;
        float: left;
        width: 100%;
        height: 100%;
        bottom: 0px;
        top: 0px;
        text-align: center;
        vertical-align: middle;
        line-height: 11;
        font-size: 18px;
        color: #f3f3f3;
    }
    .file_imagenPrevisualizar:hover{
        background: #337ab785;
        color: #FFF;
    }
    #imagenPrevisualizr {
        width: 100%;
        height: 100%;
        background-size: cover;
        float: left;
        position: relative;
        top: 0px;
    }
    .content-imgen {
        height: 200px;
        width: 200px;
        display: block;

    }
    /*
        .container {
            position: relative;
            width: 50%;
        }*/

    .image {
        display: block;
        width: 100%;
        height: auto;
    }

    .overlay {
        bottom: 100%;
        left: 0;
        right: 0;
        background-color: rgba(109, 172, 226, 0.68);
        overflow: hidden;
        width: 100%;
        height: 0;
        transition: .3s ease;
        color: #fff;
        position: relative;
        top: -197px;
    }

    .content-imgen:hover .overlay {
        bottom: 0;
        height: 100%;
    }

    /*    .text {
            white-space: nowrap; 
            color: white;
            font-size: 20px;
            position: absolute;
            overflow: hidden;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
        }*/
</style>


<%    Connection conn = (Connection) session.getAttribute("connMySql");
    Usuario user = new Usuario();
    if (session.getAttribute("user") != null) {
        user = (Usuario) session.getAttribute("user");
        session.setMaxInactiveInterval(900);
    } else { %><script>window.location = "index.jsp";</script> <% return;
        }
%> 

<%
    ArrayList<Rasgo> listRasgos = new ArrayList<>();
    String oper = "" + request.getParameter("oper");
    String pasoRegistro = "paso_1";
    int idEspecie = 0;
    if (oper.equals("especieNueva")) {
        String clase = request.getParameter("clase");
        String subclase = request.getParameter("subclase");
        String orden = request.getParameter("orden");
        String familia = request.getParameter("familia");
        String genero = request.getParameter("genero");
        String especie = request.getParameter("especie");
        String nombrecomun = request.getParameter("nombreComun");
        idEspecie = taxonomia.registrarEspecie(conn, clase, subclase, orden, familia, genero, especie, nombrecomun);
        pasoRegistro = "paso_2";
    } else
        if (oper.equals("resgistroRasgosIndividuo")) {
            idEspecie = Integer.valueOf(request.getParameter("idespecie"));
            if (request.getParameterValues("rasgo") != null) {
                String[] rasgos = request.getParameterValues("rasgo");
                boolean exitoRegistro = Rasgo.registroCaracteristicaEspecieRagos(conn, idEspecie, rasgos);
                pasoRegistro = "paso_1";
                if (exitoRegistro) {
%>
<div class="col-xs-12 col-sm-9 col-lg-6 col-lg-offset-2" style="margin-top: 10px;">
    <div class="alert alert-success alert-dismissible fade in" role="alert">
        <button type="button" class="close blanco" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
        </button>
        <strong>Registro Exitoso!</strong><br> Se registro correctamente la nueva especie, ya puedes usar la nueva especie para definir nuevos individuos.
    </div>
</div>
<%
                }
            } else {
                pasoRegistro = "paso_2";
            }
        }

%>

<div class="container-fluid">
    <div class="col-xs-12 col-md-10">
        <div class="x_panel"> 
            <div class="x_title"><h3>Registro Nueva Especie</h3></div>
            <div class="x_content">
                <div class="form_wizard wizard_verticle">
                    <ul class="list-unstyled wizard_steps">
                        <li>
                            <a href="#1" id="numberstep1" class="selected" >
                                <span class="step_no">1</span>
                            </a>
                        </li>
                        <li>
                            <a href="#2" id="numberstep2" class="disabled">
                                <span class="step_no">2</span>
                            </a>
                        </li>

                    </ul>
                    <div class="stepContainer" >

                        <div id="step_1" class="container" style="display: none;">
                            <!--<form method="post" action="../taxonomiaServlet"   >-->
                            <div class="col-md-6">
                                <form method="post" action="../taxonomiaServlet" enctype="multipart/form-data"  id='form_imgNuevaEspecie' onsubmit="envioFormularioFile2(this);return false;">
                                    <input type="hidden" name="oper" value="guardarImagenEspecie">
                                    <input type="hidden" name="idEspecieNueva" value="0" id="idEspecieNueva">
                                    <div class="form-group">
                                        <div class="content-imgen" id="vistaPrevia">
                                            <img id="imagenPrevisualizr">
                                            <div class="overlay">
                                                <a href="#1" class="file_imagenPrevisualizar" onclick="$('#fileImagenEspecie').click();" style="color:#FFF;"><i class="fa fa-upload"></i> Imagen</a>
                                                <input type="file" name="ImagenEspecie" class="hidden" id="fileImagenEspecie"  >                                   
                                            </div>
                                        </div>

                                    </div>

                                </form>
                            </div>
                            <div class="col-md-6">
                                <form method="post" role="form" class="form-horizontal center-block " action="../taxonomiaServlet" id="form_data1NuevaEspecie" onsubmit="return false;">
                                    <div class="form-group">
                                        <!--<input type="hidden" value="nuevaEspecie" name="oper">-->
                                        <!--<label for="clasetxt">Clase</label><input type="text" name="clase" class="form-control input-sm" id="clasetxt" >-->
                                        <!--<label for="subclasetxt">SubClase</label><input type="text" name="subclase" class="form-control input-sm" id="subclasetxt">-->
                                        <label for="ordentxt">Orden</label><input type="text" name="orden" class="form-control input-sm" id="ordentxt" >
                                        <label for="familiatxt">Familia</label><input type="text" name="familia" class="form-control input-sm" id="familiatxt" >
                                        <label for="generotxt">Genero</label><input type="text" name="genero" class="form-control input-sm" id="generotxt" >
                                        <label for="especietxt">Especie</label><input type="text" name="especie" class="form-control input-sm" id="especietxt" required>
                                        <label for="nombComtxt">Nombre Comun</label><input type="text" name="nombreComun" class="form-control input-sm" id="nomComtxt" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="button" class="btn btn-primary" value="Siguiente" onclick="estadoRegistro('paso_2')">
                                    </div>
                                    <!--<input type="submit" value="Guardar" class="btn-primary btn-sm form-control" style="margin-top: 10px;">-->
                                </form>
                            </div>
                        </div>                                

                        <div id="step_2" class="container" style="display: none;">
                            <form method="post" class="form-horizontal" action="../Formularios/taxonomia_1.jsp" id="form_data2NuevaEspecie" onsubmit="return false;">
                                <input type="hidden" name="idespecie" value="<%=idEspecie%>">
                                <input type="hidden" name="oper" value="registroNuevaEspecie">

                                <div class="form-group">
                                    <div class="col-xs-12 ">
                                        <p> Seleccionas los rasgos que se aplicaran a esta Especie.</p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <select class="selectpicker form-control" id="selectRasgoNuevaEspecie" multiple  name="rasgo" data-style="btn-info" data-live-search="true" onchange="seleccionarRasgo(this)">
                                        <%
                                            listRasgos = Rasgo.getRasgosList(conn);
                                            for (Rasgo rasgoSelect : listRasgos) {
                                        %>
                                        <option  value="<%=rasgoSelect.getIdrasgo()%>" sigla="<%=rasgoSelect.getSigla()%>" ><%=rasgoSelect.getNombre()%> [<%=rasgoSelect.getUnidad()%>]</option>
                                        <!--                                    <div class="form-group">
                                                                                <div class="col-xs-12 ">
                                                                                    <label class="checkbox-inline" ><input type="checkbox" name="rasgo" value="<%=rasgoSelect.getIdrasgo()%>"> <%=rasgoSelect.getNombre()%></label>
                                                                                </div>
                                                                            </div>-->
                                        <%
                                            }
                                        %>
                                    </select>
                                    <table class="table">
                                        <thead>
                                            <tr><th>RASGO</th><th>SIGLA</th><th>ID</th></tr>
                                        </thead>
                                        <tbody id="tbodyRasgoNuevaEspecie">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="ln_solid"></div>
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-6 col-lg-4 " style="float: right;">
                                        <input type="button" class="btn btn-primary" value="Finalizar" onclick="estadoRegistro('paso_final')">
                                        <!--<input type="submit" class="btn btn-primary" value="Finalizar" style="float: right;">-->
                                    </div>
                                </div>


                            </form>
                        </div>                                

                    </div>
                </div>
            </div>
        </div>
    </div> 

    <div class="col-xs-12 col-md-7">
        <div class="x_panel">
            <div class="x_title"><h3>Editar Rasgos Especie</h3></div>
            <div class="x_content form-horizontal">
                <div class="form-group">
                    <label class="col-lg-4 control-label" for="selctEspecieRasgo">Selecccione La Especie :</label>
                    <%
                        ArrayList<taxonomia> listaEspecie = taxonomia.getEspeciesList(conn);
                    %>
                    <form action="../taxonomiaServlet" method="post" onsubmit="evioFormularioServlet(this, 'contCheckRasgos', true);
                            return false;">
                        <input type="hidden" value="buscarRasgoEspecie"  name="oper">
                        <div class="input-group col-lg-8">
                            <select class="selectpicker form-control" id="selctEspecieRasgo"  name="especieEditarRasgos" data-style="btn-info" data-live-search="true">
                                <%
                                    for (taxonomia miEspecie : listaEspecie) {
                                %><option value="<%=miEspecie.getIdespecie()%>" ><%=miEspecie.getEspecie()%></option><%
                                    }
                                %>
                            </select>
                            <span class="input-group-btn"><button class="btn btn-primary" type="button" onclick="$(this).parents('form').submit();"><span class="glyphicon glyphicon-search "></span></button></span>
                        </div>
                    </form>
                </div>
                <form action="../taxonomiaServlet" onsubmit="evioFormularioServlet(this, 'contCheckRasgos', true);return false;">
                    <input type="hidden" name="oper" value="ActualizarRasgosEspecie">
                    <table class="table">
                        <p class="text-info"> * Lista de los rasgos asociados a esta especie. puede desseleccionar o seleccionar los rasgos uqe desee <br>* Recuerde que no puede eliminar todos los rasgos asociados al individuo, debe existir al menos un rasgo.</p>
                        <thead>
                            <tr><th>RASGO</th><th>SIGLA</th><th>ID</th></tr>
                        </thead>
                        <tbody id="tbodyRasgoEspecie"></tbody>
                    </table>

                    <div id="contCheckRasgos" class="panel-primary ">

                    </div> 
                    <!--<p>lista de los rasgos seleccionados como permitidos para esta especie.</p>-->

                </form>
                <div class="form-group" id="contenedorRasgoEspecie">

                </div>
            </div>
        </div> 
    </div> 

                                
                                <!--lista de las especies egistradas-->
<%
        ArrayList<taxonomia> ListaEspecie = taxonomia.getEspeciesList(conn);
    %>

    <div class="x_panel_Principal ">
        <div class="x_panel ">
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
                <div  class="columnas-lg-3">
                    <%
                        for (taxonomia miEspecie : ListaEspecie) {
                            String rutaFoto = "../" + Configuracion.getValorConfiguracion(conn, "CARPETA_IMAGEN") + miEspecie.getImagen();
                            ArrayList<localidad> listaLocalidades = localidad.getLocalidadesListByIdEspecie(conn, miEspecie.getIdespecie());
                            ArrayList<Individuo> listaIndividuos = Individuo.obtenerIndividuosByEspecie(conn, miEspecie.getIdespecie());
                    %>
                    <div class="panel-transparente x_panel" >
                        <h5 class="text-uppercase text-info"><%=miEspecie.getEspecie()%></h5>
                        <h6 class="text-info">(<%=miEspecie.getNombreComun()%>)</h6>
                        <!--<div class="imagen-fondo" style="background-image: url(<%=rutaFoto%>);"></div>-->
                        <div class="content-imagen" style="background-image: url(<%=rutaFoto%>);">
                            <!--<img src="< %=rutaFoto%>" style="width: 100%;height: 100%" >-->
                            <div class="overlay-text ">
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
                
                
                
</div>
<script>
    $('.selectpicker').selectpicker('show');
iniPanelButon(700);
    document.getElementById('fileImagenEspecie').addEventListener('change', vistaPrevia, false);
    function estadoRegistro(estado) {
        if (estado == "paso_2") {
            $("#numberstep1").attr("class", "done");
            $("#numberstep1").attr("href", "#1");
            $("#numberstep2").attr("class", "selected");
            $("#step_1").css("display", "none");
            $("#step_2").css("display", "block");
            $("#numberstep1").on("click", function () {
                estadoRegistro(("paso_1"))
            });
        }
        if (estado == "paso_1") {
            $("#numberstep2").attr("class", "disabled");
            $("#numberstep2").attr("href", "#1");
            $("#numberstep1").attr("class", "selected");
            $("#step_1").css("display", "block");
            $("#step_2").css("display", "none");
            $("#numberstep1").unbind("click");
        }
        if (estado == "paso_final") {
            mostrarLoaderOndaDeCubos('Procesando...');
            $.ajax({
                url: $("#form_data1NuevaEspecie").attr("action"),
                type: "post",
                dataType: "html",
                data: $("#form_data1NuevaEspecie").serialize() + "&" + $("#form_data2NuevaEspecie").serialize(),
                cache: false,
//                contentType: false,
                processData: false,
                success: function (result) {
                    $("#contenedorPagina").append(result);
                    ocultarLoaderOndaDeCubos();
                },
                error: function () {
                    ocultarLoaderOndaDeCubos();
                    nuevaNotify('error', 'Error', 'Ha ocurrido un error en el envio del formulario; intentelo mas tarde', 9000);
                }
            });
        }
    }
    function vistaPrevia(evt) {
        var files = evt.target.files;
        var f = files[0];
        var leerArchivo = new FileReader();
//        document.getElementById('resetear').style.display= 'block';
        leerArchivo.onload = (function () {
            return function (e) {
                $("#imagenPrevisualizr").attr("src", e.target.result);
//                document.getElementById('vistaPrevia').innerHTML = '<img src="' + e.target.result + '" alt="" width="250" />';
            };
        })(f);
        leerArchivo.readAsDataURL(f);
    }

    estadoRegistro('<%=pasoRegistro%>');

    function seleccionarRasgoEspecie(select) {
        $("#tbodyRasgoEspecie").html("");
        $(select).find("option:selected").each(function () {
            var nombreRasgo = $(this).text();
            var sigla = $(this).attr("sigla");

            $("#tbodyRasgoEspecie").append('<tr><td>' + nombreRasgo + '</td><td>' + sigla + '</td><td>' + $(this).val() + '</td></tr>');
        });
    }
    function seleccionarRasgo(select) {
        $("#tbodyRasgoNuevaEspecie").html("");
        $(select).find("option:selected").each(function () {
            var nombreRasgo = $(this).text();
            var sigla = $(this).attr("sigla");

            $("#tbodyRasgoNuevaEspecie").append('<tr><td>' + nombreRasgo + '</td><td>' + sigla + '</td><td>' + $(this).val() + '</td></tr>');
        });
    }

    function envioFormularioFile2(formulario)
    {
        mostrarLoaderOndaDeCubos("Procesando archivo")
        var formData = new FormData(formulario);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: $(formulario).attr("action"),
            dataType: "html",
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                $(formulario).append(data);
                ocultarLoaderOndaDeCubos();
            }
        });
    }

</script>
