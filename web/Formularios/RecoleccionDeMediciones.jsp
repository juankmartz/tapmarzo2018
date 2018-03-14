<%--
    Document   : RecoleccionDeMediciones
    Created on : 02-sep-2017, 16:10:52
    Author     : desarrolloJuan
--%>

<%@page import="java.sql.Connection"%>
<%@page import="Modelo.Usuario"%>
<%@page import="Bean.ManejoFicheros"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="java.io.File"%>
<%@page import="Modelo.localidad"%>
<%@page import="java.sql.Time"%>
<%@page import="java.util.HashMap"%>
<%@page import="Modelo.Medicion"%>
<%@page import="BD.Conexion_MySQL"%>
<%@page import="Modelo.Rasgo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Individuo"%>
<%@page import="Modelo.proyectos"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>

<%    Connection conn = (Connection) session.getAttribute("connMySql");
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
    
//    if (session.getAttribute("user") != null) {
//        user = (Usuario) session.getAttribute("user");
//        session.setMaxInactiveInterval(900);
//        if (user.getId() > 0 && user.getTipoUser().equals("ADMINISTRADOR")) { 
//        }else{response.sendRedirect("../Formularios/index.jsp");}
//    }else{response.sendRedirect("../Formularios/index.jsp");}
%> 


<%
    
    int idProyecto = 0;
    String horaReg = Conexion_MySQL.obtenerHoraActualMySQL();
    if (request.getParameter("proyecto") != null) {
        idProyecto = Integer.valueOf(request.getParameter("proyecto"));
    }
    if (request.getParameter("horaRegistro") != null) {
        horaReg = request.getParameter("horaRegistro").toString();
    }

    ArrayList<Rasgo> rasgosInteres = proyectos.getCaracterisiticasInteresProyectoList(conn, idProyecto);

    String oper = "";
    if (request.getParameter("oper") != null) {
        oper = request.getParameter("oper");
    }
    if (oper.equals("subirMasivasMedicion")) {
        if (request.getContentLength() > 0) {
            File file = null;
            file = ManejoFicheros.guardarArchivoServidor(request);
            if (file != null) {
                int[] registros = {0, 0};
                registros = ManejoFicheros.leerMasivoMediciones(conn, file);
                if (registros[0] > 0) {
%>
<script>nuevaNotify("notice", "Registros Exitoso", "Se procesaron <b>(<%=registros[1]%>/<%=registros[0]%>)</b> Registros exitoso; \n Registros omitidos <b>(<%=registros[2]%>)</b> ", 15000);</script>
<%

} else {
%>
<script>nuevaNotify("error", "Registros Fallido", "No fue posible procesar el archivo de masivas, por favor verifique que el archivo es el correcto y que los datos no estan corruptos", 15000);</script>
<%
    }
    file.delete();

} else {
%>
<div class="col-xs-12 col-md-10 col-md-offset-1" style="margin-top: 10px;">
    <div class="alert alert-warning alert-dismissible fade in" role="alert">
        <button type="button" class="close blanco" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
        </button>
        <strong>Problemas al Cargar!</strong> Se ha presentado problemas al tratar de cargar el archivo, verique la extesion y el tamaño se han correctos.
    </div>
</div>    
<%
        }
    }
} else {
    if (oper.equals("resgistroMediciones")) {
        int idIndividuo = Integer.valueOf(request.getParameter("individuo"));
        String fecha = Conexion_MySQL.obtenerFechaActualMySQL();
        String SQL = "INSERT INTO `proyecto_2`.`medicion` (`idproyecto`, `idindividuo`, `fecha`, `numerodehojas`, `alturadelaplanta`, `gruesodeltallo`, `areadelahoja`) VALUES ('10', '1', '2017-10-03', '1', '2', '3', '4');";
        String camposSQL = "`idproyecto`, `idindividuo`, `fecha`, `hora`";
        String valuesSQL = "'" + idProyecto + "', '" + idIndividuo + "', '" + fecha + "', '" + horaReg + "'";
        String[] valores = request.getParameterValues("valorrasgo");
        if (rasgosInteres.size() == valores.length) {
            for (Rasgo rasgoSelect : rasgosInteres) {
                int index = rasgosInteres.indexOf(rasgoSelect);
                if (rasgoSelect.getTipodato().equals("number")) {
                    valores[index] = valores[index].replace(",", ".");
                }
                camposSQL += ", `" + rasgoSelect.getNombre_columna() + "`";
                valuesSQL += ", '" + valores[index] + "'";
            }
            int ultimoID = Medicion.registroMedicion(conn, camposSQL, valuesSQL);
            if (ultimoID > 0) {
%>
<script>nuevaNotify('notice', 'REGISTRO EXITOSO', 'Se ha registro correctamente los datos', 15000);</script>
<%
    }
} else {
%><script>alert("El numero de mediciones no corresponde con el numero de rasgos de interes en el estudio actual, verifique por favor.");</script><%
        }
    }


%>

<div class="container-fluid">
    <div class="col-xs-12">
        <div class="x_panel">
            <div class="x_content">
                <div class="row-flow">
                    <div class="col-xs-8 col-md-4">
                        <!--formulario seleccion proyecto-->
                        <form method="post" class="formNormal form-horizontal" >
                            <!--<form method="post" class="form-horizontal"  action="../Formularios/RecoleccionDeMediciones.jsp" onsubmit="evioFormulario(this);return false;">-->
                            <label for="selectIdProyecto">Proyecto</label>

                            <!--<select id="selectProyecto" name="proyecto" class="form-control input-sm" onchange="$('#formSeleccionProyecto').submit();">-->
                            <select id="selectProyecto" name="proyecto" class="selectpicker input-sm" data-style="btn-info input-sm" data-live-search="true"  onchange="$(this).parent().submit();">
                                <option value="0" >seleccione un Proyecto</option>
                                <%                        ArrayList<proyectos> listProyectos = proyectos.getProyectosList(conn);

                                    String selected;
                                    for (proyectos proyect : listProyectos) {
                                        selected = "";
                                        int idPro = proyect.getIdProyecto();
                                        if (idProyecto == idPro) {
                                            selected = "selected";
                                        }
                                %><option  value="<%=proyect.getIdProyecto()%>" <%=selected%> ><%=proyect.getTitulo()%></option><%
                                    }
                                %>                    
                            </select>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<div class="container-fluid">
    <div class="col-xs-12">
        <div class="x_panel">
            <div class="x_content">
                <div class="row-flow">
                    <div class="col-xs-12">
                        <!--formulario registro datos proyecto-->
                        <form class="formNormal form-horizontal" method="post" >
                            <input type="hidden" name="oper" value="resgistroMediciones">
                            <input type="hidden" name="proyecto" value="<%=idProyecto%>">
                            <%
                                ArrayList<Medicion> listaMediciones = Medicion.obtenerMedcionesProyecto(conn, idProyecto, rasgosInteres);
                                if ((rasgosInteres.size() > 0)) {

                            %>
                            <div class="form-group">
                                <div class="col-xs-4 col-sm-3 col-md-2 ">
                                    <label for="horaRegistro">Hora:</label>
                                    <input type="time" required="required" class="form-control input-sm" name="horaRegistro" id="horaRegistro" value="<%=horaReg%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-xs-12">
                                    <table class="table" style="padding: 5px;" id="tabla_mediciones">
                                        <thead>                              
                                            <tr>
                                                <th><label>Individuo</label></th>
                                                    <%
                                                        for (Rasgo rasgoInt : rasgosInteres) {
                                                    %><th title="<%=rasgoInt.getNombre()%>"><label ><%=rasgoInt.getSigla()%></label></th><%
                                                        }
                                                    %>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td style="padding-left: 0px;">
                                                    <div class="form-group">
                                                        <select name="individuo" id="individuoMedicion" class="selectpicker input-md" data-style="btn-info input-sm"  data-live-search="true" required="required">
                                                            <%
                                                                //    ResultSet individuosProy = proyectos.getIndividuosProyecto(idProyecto);
                                                                ArrayList<Individuo> individuosProy = proyectos.getIndividuosProyectoList(conn, idProyecto);
                                                                for (Individuo indi : individuosProy) {
                                                            %> <option value="<%=indi.getIdIndividuo()%>" title="<%=indi.getEspecie()%>">individuo <%=indi.getCodigo()%>  <%=indi.getNombre()%></option><%
                                                                }
                                                            %>
                                                        </select>
                                                    </div>    
                                                </td>
                                                <%
                                                    int idmax = rasgosInteres.size() - 1;
                                                    for (Rasgo rasgoInt : rasgosInteres) {

                                                %>
                                                <td>
                                                    <div class="form-group">
                                                        <!--<label for="< %=idInput%>">< %=rasgoInt.getNombre()%></label>-->
                                                        <input   required="required" class="form-control input-sm" name="valorrasgo" placeholder="<%=rasgoInt.getUnidad()%>">
                                                        <%
                                                            int idActual = rasgosInteres.indexOf(rasgoInt);
                                                            if (idActual == idmax) {
                                                        %><input type="submit" class="btn btn-primary col-xs-12" value="Guardar"><%
                                                            }
                                                        %>
                                                    </div>
                                                </td>
                                                <%
                                                    }
                                                %>
                                            </tr>
                                        </tbody>   


                                    </table>
                                    <%
                                        if (listaMediciones.size() > 0) {
                                    %>
                                    <div class="x_panel ">
                                        <div class="x_title">
                                            <h2>Datos Registrados </h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                                <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                            </ul>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="x_content">
                                            <table class="table">   
                                                <thead>   
                                                    <tr>
                                                        <th>INDIVIDUO</th>
                                                            <%
                                                                for (Rasgo rasgoInt : rasgosInteres) {
                                                            %><th><%=rasgoInt.getNombre()%> </th><%
                                                                }
                                                            %>
                                                    </tr>
                                                </thead>
                                                <tbody>    
                                                    <%
                                                        for (Medicion medida : listaMediciones) {

                                                    %><tr><td><%=medida.getCodigoIndividuo()%> <%=medida.getNombreIndividuo()%> </td><%
                                                        HashMap<String, String> valores = medida.getValues();
                                                        for (Rasgo mirasgo : rasgosInteres) {
                                                        %><td><%=valores.get(mirasgo.getNombre_columna())%></td><%
                                                            }
                                                        %><tr><%
                                                            }
                                                        %>
                                                </tbody>

                                            </table>
                                        </div>
                                    </div>
                                    <%
                                    } else {
                                    %>


                                    <div class="col-xs-12 col-md-10 col-md-offset-1" style="margin-top: 10px;">
                                        <div class="alert alert-info alert-dismissible fade in" role="alert">
                                            <button type="button" class="close blanco" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                                            </button>
                                            <strong>Sin Datos de Mediciones!</strong> No se han ingresado aun ninguna recoleccion de datos.
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <%
                            } else {
                            %>
                            <div class="col-xs-12 col-sm-9 col-lg-6 col-lg-offset-2" style="margin-top: 10px;">
                                <div class="alert alert-info alert-dismissible fade in" role="alert">
                                    <!--                <button type="button" class="close blanco" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                                                    </button>-->
                                    <strong>Sin Rasgos Asocidos al Proyecto!</strong> No se encontrarón rasgos de interes asociados al proyecto, verique el registro del proyecto de estudio.
                                </div>
                            </div>
                            <%
                                }

                            %>

                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div> 

<div class="container-fluid">
    <div class="col-xs-12 col-sm-6">
        <div class="x_panel ">
            <div class="x_title">
                <h2>Recolección Masivo de Datos </h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content form-horizontal">
                <div class="col-xs-12 ">
                    <i class="text-muted">Para realizar la subida masiva de datos es necesario descargar el formato .xlsx es el unico formato permitido para realizar la recoleccion masiva de datos.</i>
                </div>
                <div class="col-xs-12 row-flow form-group">
                    <!--formulario descarga formato masivas-->
                    <form method="post" id="formMasivasPlantilla" class="formNormal" >
                        <!--<form method="post" id="formMasivasPlantilla" action="../Formularios/RecoleccionDeMediciones.jsp" onsubmit="evioFormulario(this);return false;">-->
                        <input type="hidden" name="funcionalidad" value="nuevoExcellPrueba">

                        <%                                    ArrayList<Rasgo> listRasgo = Rasgo.getRasgosList(conn);
                            String tipoRasgo = listRasgo.get(0).getTiporasgo();
                        %>
                        <div class="form-group">
                            <select id="selectRasgoMasivas" name="rasgo" class="selectpicker input-sm" data-style="btn-info input-sm" multiple data-live-search="true" onchange="modificarRasgosMasivas(this);">
                                <optgroup label="<%=tipoRasgo%>">
                                    <% for (Rasgo elRasgo : listRasgo) {
                                            String nombreTipoRasgo = elRasgo.getTiporasgo();
                                            if (!tipoRasgo.equals(nombreTipoRasgo)) {
                                    %>
                                </optgroup>
                                <optgroup label="<%=nombreTipoRasgo%>">
                                    <%        }
                                        tipoRasgo = nombreTipoRasgo;
                                    %>
                                    <option value="<%=elRasgo.getIdrasgo()%>"><%=elRasgo.getNombre()%> (<%=elRasgo.getUnidad()%>)</option>
                                    <%
                                        }
                                    %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Lista de los Rasgos de seleccionados para el masivo</label>
                            <table class="table">
                                <tbody id="tbody_listaRasgosMasivos" style="font-size: 14px; color:#00a2d3;">

                                </tbody>
                            </table>
                        </div>


                    </form>
                </div>
                <div class="form-group">
                    <button class="btn btn-success" value="" onclick="descargaFormatoMasivas()">
                        <span class="fa fa-file-excel-o"></span> Generar Formato
                    </button>
                </div>
                <div id="respuesta" class="form-group"></div>
                <div class="ln_solid"></div>
                <div class="form-group ">
                    <!--formulario subida datos masivas-->
                    <form method="post" id="formSubirMasivos" enctype="multipart/form-data" onsubmit="envioFormularioFile(this);$('#fileUploadClima').val('');return false;" action="../Formularios/RecoleccionDeMediciones.jsp?oper=subirMasivasMedicion">
                        <!--<input type="hidden" name="oper" value="SubirArchivoMasivasMediciones">-->
                        <label class="checkbox-inline" ><b> Seleccione el archivo que contiene los datos a cargar masivamente</b> 
                            <i class="text-muted">"El tiempo de procesamiento del archivo dependera del numero de registros a realizar segun el archivo y el trafico de porcesos existente en el servidor</i></label>
                        <div class="form-group">
                            <input type="checkbox" name="checkMasivoProyecto" value="filtroLocalidad" id="check_masivoProyecto"  class="check-transparente  check-filtro" data-toggle="collapse" data-target="#filtroLocalidadContent"> 
                            <label  for="check_masivoProyecto" class="lbl-check">Insertar Mediciones a proyecto</label>

                        </div>
                        <div id="filtroLocalidadContent" class="collapse">
                            Seleccione el proyecto al que desea relacionar los datos del masivo.
                            <select name="proyectoMasivo" class="selectpicker input-sm" data-style="btn-info input-sm" id="selectLocalidad"  data-live-search="true" >

                                <%
                                    for (proyectos miproyect : listProyectos) {
                                %>
                                <option value="<%=miproyect.getIdProyecto()%>" title="<%=miproyect.getResumen()%>"><%=miproyect.getTitulo()%></option>
                                <%
                                    }
                                %>

                            </select>

                        </div>
                        <div class="form-group">
                            <br>
                            <a href="#1" class="btn btn-primary" onclick="$('#fileUploadClima').click();"><i class="fa fa-upload"></i> Cargar Archivo</a>
                            <input type="file" name="archivoMedicionMasivo" class="hidden" id="fileUploadClima" onchange="$(this).parents('form').submit();" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" required>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>



<script>
    $(document).ready(function () {

        $('.selectpicker').selectpicker('show');
        $(".formNormal").submit(function () {
            evioFormulario(this);
            return false;
        });
        $(".formNormal").attr("action", "../Formularios/RecoleccionDeMediciones.jsp");
        iniPanelButon();
    });

    function descargaFormatoMasivas() {
        mostrarLoaderOndaDeCubos("Generando Formato...");
        $.ajax({
            type: "POST",
            url: "archivosExcell.jsp",
            data: $("#formMasivasPlantilla").serialize(),
            success: function (data)
            {
                $("#respuesta").html(data);
                ocultarLoaderOndaDeCubos();
            }
        });
    }
    ;

    function cargarFormatoMasivas(boton) {
        mostrarLoaderOndaDeCubos("Almacenando...");
//        $(boton).parents("form").css("border","1px solid red");
        $.ajax({
            type: "POST",
            url: "archivosExcell.jsp",
            data: $(boton).parents("form").serialize(),
            success: function (data)
            {
                $("#respuesta").html(data);
                ocultarLoaderOndaDeCubos();
            }
        });
    }
    ;
    function modificarRasgosMasivas(select) {
        $("#tbody_listaRasgosMasivos").html("");
        $(select).find("option:selected").each(function () {
//             alert($(this).text());
            var nombreRasgo = $(this).text();
            $("#tbody_listaRasgosMasivos").append('<tr><td><span class="fa fa-check"></span> ' + nombreRasgo + '</td></tr>');
        });
    }


</script>
<%
    }
%>