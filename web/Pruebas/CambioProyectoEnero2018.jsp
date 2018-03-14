<%-- 
    Document   : RecoleccionDatos
    Created on : 08-ago-2017, 19:33:45
    Author     : desarrolloJuan
--%>

<%@page import="java.sql.Connection"%>
<%@page import="Modelo.taxonomia"%>
<%@page import="java.io.Console"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Rasgo"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="Modelo.localidad"%>
<%@page import="Modelo.Individuo"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.proyectos"%>
<%@page import="BD.Conexion_MySQL"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<style>
    .accordion {
        background-color: #eee;
        color: #444;
        cursor: pointer;
        padding: 18px;
        width: 100%;
        border: none;
        text-align: left;
        outline: none;
        font-size: 15px;
        transition: 0.4s;
    }

    .active, .accordion:hover {
        background-color: #ccc; 
    }

    .panel {
        padding: 0 18px;
        display: none;
        background-color: white;
    }
    .check-transparente{
        display: none;
    }
    .check-transparente[type="checkbox"] + label:before, .check-transparente[type="radio"] + label:before {
        color: rgb(255, 253, 253);
        background: transparent;
    }
    .check-transparente[type="checkbox"]:focus + label:before, .check-transparente[type="radio"]:focus + label:before {
        border-color: #DE7E79;
        box-shadow: 0 0 0 1px #DE7F79;
    }

    .check-transparente[type="checkbox"] + label:before {
        border-radius: 0.25rem;
    }
    .check-transparente[type="checkbox"] + label:before, .check-transparente[type="radio"] + label:before {
        content: '';
        display: inline-block;
        position: absolute;
        top: 0;
        left: 0;
        width: 2rem;
        height: 1.9rem;
        line-height: 18px;
        background: rgba(255, 255, 255, 0.075);
        border: solid 1px rgba(255, 255, 255, 0.25);
        border-radius: 0.25rem;
        color: #2e2b37;
        text-align: center;
        font-size: 12px;
    }
    .check-transparente[type="checkbox"] + label:before, .check-transparente[type="radio"] + label:before {
        -moz-osx-font-smoothing: grayscale;
        -webkit-font-smoothing: antialiased;
        border-color: rgba(255, 255, 255, 0.675);
        font-family: FontAwesome;
        font-style: normal;
        font-weight: normal;
        text-transform: none !important;
    }

    *, *:before, *:after {
        -moz-box-sizing: border-box;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
    }
    .check-transparente[type="checkbox"] + label, .check-transparente[type="radio"] + label {
        text-decoration: none;
        position: relative;
        color: #F9F9F9;
        cursor: pointer;
        display: inline-block;
        font-size: 1.2rem;
        font-weight: 300;
        margin-bottom: 0;
        padding-left: 2.5rem;
        padding-right: 1rem;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none; 
    }
    .table-selectRow > tbody > tr{
        cursor: pointer;
    }
</style>
<%
    Connection conn = (Connection) session.getAttribute("connMySql");
%>
<div class="container-fluid">
    <!--Registro nuevo Proyecto-->
    <div class="col-xs-12 col-sm-9 col-md-7">
        <div class="x_panel">
            <div class="x_content">
                <h2 style="font-size: 25px;font-weight: bolder">Registro de Proyecto de Estudio</h2>
                <!-- Tabs -->

                <div id="wizard_verticle" class="form_wizard wizard_verticle">
                    <ul class="list-unstyled wizard_steps">
                        <li>
                            <a href="#step_11" id="step_1" class="selected" >
                                <span class="step_no">1</span>
                            </a>
                        </li>
                        <li>
                            <a href="#step-22" id="step_2" class="disabled">
                                <span class="step_no">2</span>
                            </a>
                        </li>
                        <li>
                            <a href="#step-33" id="step_3" class="disabled">
                                <span class="step_no">3</span>
                            </a>
                        </li>
                    </ul>
                    <form method="post" id="form_nuevoProyecto" >
                        <div class="stepContainer" >

                            <div id="step-11" class="content">
                                <h2 class="StepTitle">Datos basicos del Estudio</h2>
                                <div >
                                    <!--<div class="col-lg-4 col-xs-10 col-md-5 " id="paso_1" style="opacity: 0;">-->
                                    <input type="hidden" name="form" value="nuevoProyecto">
                                    <div class="form-group"><label for="txtTitulo">Titulo</label><input class="input-sm form-control" type="text" name="titulo" id="txtTitulo" value="" required></div>
                                    <div class="form-group"><label for="txtResumen">Resumen</label>
                                        <textarea class="input-sm form-control" name="resumen" id="txtResumen"   style="resize: none;height: 85px;"></textarea>
                                    </div>
                                    <div class="form-group"><label for="txtDescripcion">Descripcion</label>
                                        <textarea class="input-sm form-control " name="descripcion" id="txtDescripcion"  style="resize: none;height: 85px;"></textarea>
                                    </div>
                                    <div class="form-group"><label for="txtPalabrasClave">Palabras claves</label>
                                        <textarea class="input-sm form-control " name="palabraClave" id="txtPalabrasClave"  style="resize: none;height: 60px;" placeholder="Palabras que ayuden a las  busquedas futuras..."></textarea>
                                    </div>
                                    <!--<input type="button" value="Continuar" class="btn btn-primary" onclick="nextStep('form_nuevoProyecto');">-->
                                    <div class="ln_solid"></div>
                                    <div class="form-group">
                                        <div class="col-sm-12" >
                                            <input type="button" value="Continuar" class="btn btn-primary" onclick="estadoRegistro('paso_2');">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="step-22" class="content " style="display: none;">
                                <h2 class="StepTitle">Asignar individuos de estudio</h2>
                                <p class="text-justify text-muted">Los individuos se encuentran organizados por localidad y por especie, puede usar el cuadro de busqueda para facilitar seleccionar los individuos deseados.</p>
                                <!--<div class="col-lg-6 col-xs-10 col-md-5 " id="paso_2" style="opacity:  0;">-->
                                <div >
                                    <h5></h5>
                                    <!--<input type="text" class="input-sm form-control" data-placement="bottom" data-toggle="tooltip" title="Hooray!">-->
                                    <!--<form method="post" style="padding: 15px;" action="../proyectoEstudio"  onsubmit="evioFormularioServlet(this, 'contendorResultados', true);return false;" id="form_asignarIndividuosProyecto"  enctype="multipart/form-data">-->
                                    <input type="hidden" name="form" value="asignarIndividuosProyecto">
                                    <%    ArrayList<localidad> localidades = localidad.getLocalidadesList(conn);
                                        for (localidad miLocalidad : localidades) {
                                            String[] idLocalidad = {String.valueOf(miLocalidad.getIdlocalidad())};
                                            ArrayList<taxonomia> listaEspecies = taxonomia.getEspeciesListByLocalidad(conn, idLocalidad);
                                            if (listaEspecies.size() > 0) {
                                    %>
                                    <div class="accordion accd-md" ><span><%=miLocalidad.getNombre()%></span>
                                        <sub class="">(<%=miLocalidad.getLat()%>,<%=miLocalidad.getLon()%>)</sub>
                                    </div>
                                    <div class="panel" >
                                        <%
                                            for (taxonomia especie : listaEspecies) {
                                                ArrayList<Individuo> listaIndividuos = Individuo.obtenerIndividuosLocalidadEspecie(conn, miLocalidad.getIdlocalidad(), especie.getIdespecie());
                                        %>
                                        <div class="">
                                            <div class="row">
                                                <div class="col-xs-12"> 
                                                    <h4><%=especie.getEspecie()%></h4>
                                                    <h6 class="text-muted"><%=especie.getNombreComun()%></h6></div>
                                            </div>
                                            <div class="row">
                                                <select id="select<%=especie.getIdespecie()%>l<%=miLocalidad.getIdlocalidad()%>" name="individuo" multiple class="selectpicker input-sm" data-style="btn-info input-sm" data-live-search="true" style="margin-top: -10px" >
                                                    <%
                                                        for (Individuo miIndi : listaIndividuos) {
                                                    %>
                                                    <option value="<%=miIndi.getIdIndividuo()%>" selected><%=miIndi.getNombre()%> [<%=miIndi.getCodigo()%>]</option>
                                                    <%}%>
                                                </select> 
                                                <div class="btn-group" >
                                                    <button type="button" class="btn btn-sm btn-default dropdown-toggle"
                                                            data-toggle="dropdown" >
                                                        <span class="glyphicon glyphicon-edit"></span>
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="#2" onclick="SeleccionarTodos('select<%=especie.getIdespecie()%>l<%=miLocalidad.getIdlocalidad()%>')"><span class="glyphicon glyphicon-check"></span> todos</a></li>
                                                        <li><a href="#3" onclick="deseleccionarTodos('select<%=especie.getIdespecie()%>l<%=miLocalidad.getIdlocalidad()%>')"><span class="glyphicon glyphicon-unchecked"></span> ninguno</a></li>
                                                    </ul>
                                                </div>
                                                <!--<button type="button" class="btn btn-primary input-sm"><span class="glyphicon glyphicon-check"></span></button>-->
                                            </div>
                                        </div>
                                        <%
                                            }
                                        %>
                                    </div>
                                    <%
                                            }
                                        }
                                    %>
                                    <br>
                                    <input type="button"  value="Atras" class="btn btn-default" onclick="estadoRegistro('paso_1')" >
                                    <input type="button" value="Continuar" class="btn btn-primary" onclick="estadoRegistro('paso_3')">
                                    <!--</form>-->
                                </div>
                            </div>

                            <div id="step-33" class="content" >

                                <h4 class="StepTitle">Rasgos de interes</h4>
                                <div class="form-group">
                                    <table class="table table-selectRow" id="tbRasgosComunes">
                                        <thead>
                                            <tr>
                                                <th>RASGO</th>
                                                <th>UNIDAD</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>
                                <div >
                                    <!--<div class="col-lg-4 col-xs-10 col-md-5 " id="paso_3" style="opacity: 0;">-->
                                    <h5></h5>

                                    <!--<form method="post" style="padding: 15px;" id="form_rasgosEstudio" action="../Formularios/RegistroProyectoEstudio_1.jsp" onsubmit="evioFormulario(this);return false;" enctype="multipart/form-data">-->

                                    <div class="form-group" id="sinResultadosRasgosComunes" style="display: none;">
                                        <div class="col-xs-12 " style="margin-top: 10px;">
                                            <div class="alert alert-info alert-dismissible fade in" role="alert">
                                                <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                                                </button>
                                                <strong>Sin Rasgos para asociar!</strong> Al parecer no se han asociado rasgos a las especies de Estudio, por favor verifique.
                                            </div>
                                        </div>
                                    </div>

                                    <div class="ln_solid"></div>
                                    <div class="form-group">
                                        <div class="col-sm-12" >
                                            <input type="button"  value="Atras" class="btn btn-default" onclick="estadoRegistro('paso_2')" >
                                            <input type="button" id="btnFinalizarNuevoProyecto" value="Finalizar" class="btn btn-primary" onclick="estadoRegistro('paso_final')" >
                                        </div>
                                    </div>
                                    <!--<input type="button" value="Finalizar" class="btn btn-primary" onclick="nextStep('form_rasgosEstudio');">-->
                                    <!--</form>-->
                                </div> 
                            </div>

                        </div>
                    </form>
                </div>
                <!-- End SmartWizard Content -->
            </div>
        </div>
    </div>

    <div class="col-xs-12 col-sm-12">
        <div class="x_panel">

            <div class="x_content content">
                <div class="menuHoverTabla" style="display: none;">
                    <button class="btn btn-xs input-transparente" title="Eliminar"><i class="fa fa-times"></i></button>
                </div>
                <div id="contendorResultados"></div>
                <h2 class="StepTitle">Proyectos Resgistrados</h2><br>
                <table class="table"  id="tbProyectosRegistrados">
                    <thead>
                        <tr>
                            <th>Titulo Poyecto</th>
                            <th>Descripción</th>
                            <th>Resumen</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                                    ArrayList<proyectos> listProyect = proyectos.getProyectosList(conn);
                            for (proyectos proy : listProyect) {
                        %>
                        <tr>
                            <td><%=proy.getTitulo()%></td>
                            <td><%=proy.getDescripcion()%></td>
                            <td><%=proy.getResumen()%></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div> 
        </div>
    </div>                
</div>    


<script>

    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip();
        estadoRegistro("paso_1");
        agregarMenuHoverTabla('tbProyectosRegistrados');
    });

    $("#accordeonLocalidades").accordion();
    accordionSimple();
    $('.selectpicker').selectpicker('show');
    function estadoRegistro(estado) {
        if (estado == "paso_2") {
            if ($('#txtTitulo').val() !== '') {
                if ($('#txtResumen').val() != '') {
                    $("#step_1").attr("class", "done");
                    $("#step_1").attr("href", "#1");
                    $("#step_2").attr("class", "selected");
                    $("#step_22").css("display", "block");
                    $("#step_3").attr("class", "disabled");
                    $("#step_3").attr("herf", "#1");
                    $("#step-22").css("display", "block");
                    $("#step-11").css("display", "none");
                    $("#step-33").css("display", "none");
                    $("#step_1").off("click");
                    $("#step_1").on('click', function () {
                        $("#step-11").css("display", "block");
                        $("#step-22").css("display", "none");
                        $("#step-33").css("display", "none");
                        $("#step_3").attr("class", "disabled");
                        $("#step_3").attr("href", "#1");
                        $("#step_2").attr("class", "disabled");
                        $("#step_2").attr("href", "#1");
                        $("#step_1").attr("class", "selected");
                    });
                } else {
                    nuevaNotify('warning', 'Campos Obligatorios', 'Los campo marcados con rojo son obligatorios', 9000);
                    $('#txtResumen').css('border', '1px solid red');
                    $('#txtTitulo').css('border', '1px solid #ccc');
                }
            } else {
                nuevaNotify('warning', 'Campos Obligatorios', 'Los campo marcados con rojo son obligatorios', 9000);
                $('#txtTitulo').css('border', '1px solid red');
                $('#txtResumen').css('border', '1px solid #ccc');
            }
        }
        if (estado == "paso_3") {
            var idIndi = [];
            $('select[name=individuo]').each(function () {
                var tempID = $(this).val();
                var subtemp = idIndi.concat(tempID);
                idIndi = subtemp;
            });
            var individuos = $("select[name=individuo]");
            $("#step_1").attr("class", "done");
            $("#step_1").attr("href", "#1");
            $("#step_2").attr("class", "done");
            $("#step_22").css("display", "block");
            $("#step_3").attr("class", "selected");
            $("#step_3").attr("herf", "#1");
            $("#step-22").css("display", "none");
            $("#step-11").css("display", "none");
            $("#step-33").css("display", "block");
            mostrarLoaderOndaDeCubos("Procesando..");
            $.ajax({
                url: "../proyectoEstudio",
                type: "post",
                dataType: "html",
                data: "oper=cargaRasgosComunes&" + $(individuos).serialize(),
                cache: false,
                processData: false,
                success: function (result) {
                    if (result == "") {
                        $("#sinResultadosRasgosComunes").css("display", "block");
                        $("#tbRasgosComunes").css("display", "none");
                        $("#btnFinalizarNuevoProyecto").css("display", "none");
                    } else {
                        $("#tbRasgosComunes").find("tbody").html(result);
                        $("#sinResultadosRasgosComunes").css("display", "none");
                        $("#tbRasgosComunes").css("display", "table");
                        $("#btnFinalizarNuevoProyecto").css("display", "inline-block");
                    }
                    ocultarLoaderOndaDeCubos();
                },
                error: function () {
                    ocultarLoaderOndaDeCubos();
                    nuevaNotify('error', 'Error', 'Ha ocurrido un error en el envio del formulario; intentelo mas tarde', 9000);
                }

            });
            $("#step_2").off("click");
            $("#step_2").on('click', function () {
                estadoRegistro('paso_2');
            });
        }
        if (estado == "paso_1") {
            $("#step-11").css("display", "block");
            $("#step-22").css("display", "none");
            $("#step-33").css("display", "none");
            $("#step_3").attr("class", "disabled");
            $("#step_3").attr("href", "#1");
            $("#step_2").attr("class", "disabled");
            $("#step_2").attr("href", "#1");
            $("#step_1").attr("class", "selected");
        }
        if (estado == "paso_final") {

            var validar = false;
            $("input[name=rasgo]").each(function () {
                if ($(this).is(':checked'))
                    validar = true;
            });
            var individuos = $("form[name=formNuevoProyecto]");
            if (validar) {
                $.ajax({
                    url: "../proyectoEstudio",
                    type: "post",
                    dataType: "html",
                    data: "oper=nuevoProyecto&" + $("#form_nuevoProyecto").serialize(),
                    cache: false,
                    processData: false,
                    success: function (result) {
                        if (result == "") {
                            $("#sinResultadosRasgosComunes").css("display", "block");
                            $("#tbRasgosComunes").css("display", "none");
                            nuevaNotify('notice', 'Registro Completo', 'El proyecto ya se encuentra disponible para la toma de mediciones ', 9000);
 //$("#form_nuevoProyecto").reset(); 
 document.getElementById("form_nuevoProyecto").reset();
 $("#step_2").unbind("click");

 estadoRegistro("paso_1");
                        } else {
                            $("#tbRasgosComunes").find("tbody").html(result);
                            $("#sinResultadosRasgosComunes").css("display", "none");
                            $("#tbRasgosComunes").css("display", "table");
                        }
                        ocultarLoaderOndaDeCubos();
                    },
                    error: function () {
                        ocultarLoaderOndaDeCubos();
                        nuevaNotify('error', 'Error', 'Ha ocurrido un error en el envio del formulario; intentelo mas tarde', 9000);
                    }

                });
            } else {
                nuevaNotify('warning', 'Registro Incompleto', 'Debe seleccionar al menos un rasgo de interes para su proyecto de estudio', 9000);
            }
        }
    }
    function accordionSimple() {
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
//    acc[i].addEventListener("click", function() {
            acc[i].addEventListener("click", function () {
                var panel = this.nextElementSibling;

                if (panel.style.display === "block") {
                    $(panel).slideUp('slow');
//                panel.style.display = "none";
                } else {
                    $(panel).slideDown('slow');

                }
            });
        }
    }
    function SeleccionarTodos(idSelect) {
        $("#" + idSelect).selectpicker('selectAll');
    }
    function deseleccionarTodos(idSelect) {
        $("#" + idSelect).selectpicker('deselectAll');
    }
    function nextStep() {

    }
</script>
