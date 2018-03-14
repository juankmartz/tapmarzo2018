<%-- 
    Document   : RecoleccionDatos
    Created on : 08-ago-2017, 19:33:45
    Author     : desarrolloJuan
--%>

<%@page import="java.sql.Connection"%>
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
            String formulario = "";
           Connection conn = (Connection) session.getAttribute("connMySql");
            int IdProyecto = 0;
            String estadoRegistro = "paso_1";
             if(request.getParameter("form") != null){
                 formulario =  request.getParameter("form");
            if (formulario.equals("nuevoProyecto")) {
                String titulo, resumen, descripcion;
                titulo = request.getParameter("titulo");
                resumen = request.getParameter("resumen");
                descripcion = request.getParameter("descripcion");
                IdProyecto = proyectos.registrarProyecto(conn,titulo, descripcion, resumen,"", "ACTIVO");
                estadoRegistro = "paso_2";
            } else
                if (formulario.equals("asignarIndividuosProyecto")) {
                    IdProyecto = Integer.valueOf(request.getParameter("proyecto"));
                    if (request.getParameterValues("individuo") != null) {
                        String[] individuos = request.getParameterValues("individuo");
                        if (proyectos.registrarProyectoIndividuo(conn,IdProyecto, individuos)) {
        %>
        <div class="col-xs-12 col-sm-9 col-lg-6 col-lg-offset-2" style="margin-top: 10px;">
            <div class="alert alert-success alert-dismissible fade in" role="alert">
                                <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                                </button>
                <strong>Operación Exitosa!</strong><br> Se asignarón correctamente los individuos al proyecto de estudio.
            </div>
        </div><%
                            estadoRegistro = "paso_3";
                        }
                    } else {
                        estadoRegistro = "paso_2";
        %>
        <div class="col-xs-12 col-sm-9 col-lg-6 col-lg-offset-2" style="margin-top: 10px;">
            <div class="alert alert-warning alert-dismissible fade in" role="alert">
                <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                </button>
                <strong>Faltan datos para completar la operación!</strong> Se debe seleccionar almenos uno de los individuos de interes para el estudio, por favor verifique.
            </div>
        </div>
        <%
                    }
                }else
            if (formulario.equals("rasgosEstudio")) {
                IdProyecto = Integer.valueOf(request.getParameter("proyecto"));
                if (request.getParameterValues("rasgo") != null) {
                    String[] rasgos = request.getParameterValues("rasgo");
                    if (proyectos.registrarProyectoRasgos(conn,IdProyecto, rasgos)) {
        %>
        <div class="col-xs-12 col-sm-9 col-lg-6 col-lg-offset-2" style="margin-top: 10px;">
            <div class="alert alert-success alert-dismissible fade in" role="alert">
                <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                </button>
                <strong>Operación Exitosa!</strong> Se asignarón correctamente los rasgos al proyecto de estudio .
            </div>
        </div>
        <script>nuevaNotify('notice','Registro Exitoso','Se completo correctamente el registro del nuevo proyecto de estudio.',20000);</script>
        <%
                                        estadoRegistro = "paso_1";
                                    }
                                } else {
                                    estadoRegistro = "paso_3";
        %>
        <div class="col-xs-12 col-sm-9 col-lg-6 col-lg-offset-2" style="margin-top: 10px;">
            <div class="alert alert-warning alert-dismissible fade in" role="alert">
                <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                </button>
                <strong>Faltan datos para completar la operación!</strong> Se debe seleccionar almenos uno de los rasgo de interes para el estudio, por favor verifique.
            </div>
        </div>
        <%
                }

            }
}
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
                            <div class="stepContainer" >
                                <%                        if (estadoRegistro.equals("paso_1")) {
                                %>

                                <div id="step-11" class="content">
                                    <h2 class="StepTitle">Datos basicos del Estudio</h2>
                                    <div >
                                        <!--<div class="col-lg-4 col-xs-10 col-md-5 " id="paso_1" style="opacity: 0;">-->

                                        <form method="post" style="padding: 15px;" id="form_nuevoProyecto" action="../Formularios/RegistroProyectoEstudio_1.jsp" onsubmit="evioFormulario(this);return false;" enctype="multipart/form-data">
                                            <input type="hidden" name="form" value="nuevoProyecto">
                                            <div class="form-group"><label for="txtTitulo">Titulo</label><input class="input-sm form-control" type="text" name="titulo" id="txtTitulo" value="" required></div>
                                            <div class="form-group"><label for="txtResumen">Resumen</label>
                                                <textarea class="input-sm form-control" name="resumen" id="txtResumen"   style="resize: none;height: 85px;"></textarea>
                                            </div>
                                            <div class="form-group"><label for="txtDescripcion">Descripcion</label>
                                                <textarea class="input-sm form-control " name="descripcion" id="txtDescripcion"  style="resize: none;height: 85px;"></textarea>
                                            </div>
                                            <!--<input type="button" value="Continuar" class="btn btn-primary" onclick="nextStep('form_nuevoProyecto');">-->
                                            <div class="ln_solid"></div>
                                            <div class="form-group">
                                                <div class="col-sm-12" >
                                                    <input type="submit" value="Continuar" class="btn btn-primary" >
                                                </div>
                                            </div>

                                        </form>
                                    </div>
                                </div>
                                <%
                                } else
                                    if (estadoRegistro.equals("paso_2")) {
                                %>
                                <div id="step-22" class="content">
                                    <h2 class="StepTitle">Asignar individuos de estudio</h2>
                                    <!--<div class="col-lg-6 col-xs-10 col-md-5 " id="paso_2" style="opacity:  0;">-->
                                    <div >
                                        <h5></h5>
                                        <form method="post" style="padding: 15px;" id="form_asignarIndividuosProyecto" action="../Formularios/RegistroProyectoEstudio_1.jsp" onsubmit="evioFormulario(this);return false;" enctype="multipart/form-data">
                                            <input type="hidden" name="form" value="asignarIndividuosProyecto">
                                            <input type="hidden" name="proyecto" value="<%=IdProyecto%>">
                                            <div id="accordeonLocalidades">
                                                <%                        ArrayList <localidad> ListLocalidades = localidad.getLocalidadesList(conn);
                                                    for (localidad milocal : ListLocalidades) {
                                                        int idlocalidad = milocal.getIdlocalidad();
                                                %>
                                                <div class=""><%=milocal.getNombre()%> </div>
                                                <div class="form-group" >
                                                    <%
                                                        ArrayList<Individuo> individuoLocalidad = Individuo.obtenerIndividuosLocalidadList(conn,idlocalidad);
                                                        for (Individuo miindividuo : individuoLocalidad) {
                                                    %>
                                                    <div class="col-xs-12" style="padding-bottom: 5px;">
                                                        <label class="checkbox-inline" ><input type="checkbox" value="<%=miindividuo.getIdIndividuo() %>" name="individuo">
                                                            <%=miindividuo.getCodigo() %> : <%=miindividuo.getNombre()%>  
                                                            <i class="text-primary">(<%=miindividuo.getEspecie()%>)</i>
                                                        </label>
                                                        <!--<input type="checkbox" name="individuo" value="< %=individuoLocalidad.getString("idindividuo")%>" > < %=individuoLocalidad.getString("nombre")%> <i class="text-primary">(< %=individuoLocalidad.getString("especie")%>)</i>--> 
                                                    </div>
                                                        <%
                                                            }
                                                        %>
                                                </div>

                                                <%
                                                    }
                                                %>
                                            </div>
                                            <div class="ln_solid"></div>
                                            <div class="form-group">
                                                <div class="col-sm-12" >
                                                    <input type="submit" value="Continuar" class="btn btn-primary" >
                                                </div>
                                            </div>
                                            <!--<input type="button" value="Continuar" class="btn btn-primary" onclick="nextStep('form_asignarIndividuosProyecto');">-->
                                        </form>
                                    </div>
                                </div>
                                <%
                                } else
                                    if (estadoRegistro.equals("paso_3")) {
                                %>            
                                <div id="step-33" class="content">
                                    <h2 class="StepTitle">Seleccionar Rasgos de interes en el estudio</h2>
                                    <div >
                                        <!--<div class="col-lg-4 col-xs-10 col-md-5 " id="paso_3" style="opacity: 0;">-->
                                        <h5></h5>
                                        
                                        <form method="post" style="padding: 15px;" id="form_rasgosEstudio" action="../Formularios/RegistroProyectoEstudio_1.jsp" onsubmit="evioFormulario(this);return false;" enctype="multipart/form-data">
                                            <input type="hidden" name="form" value="rasgosEstudio">
                                            <input type="hidden" name="proyecto" value="<%=IdProyecto%>">
                                            <div class="form-group">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>RASGO</th>
                                                            <th>UNIDAD</th>
                                                            <th></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            ArrayList <Rasgo> listRasgos = proyectos.getCaracteristicasComunesEspecieProyecto(conn,IdProyecto);
                                                            for (Rasgo miRasgo : listRasgos) {
                                                        %>
                                                        <tr>
                                                            <td><%=miRasgo.getNombre()%> </td>
                                                            <td><%=miRasgo.getUnidad() %> </td>
                                                            <td><input type="checkbox" name="rasgo" value="<%=miRasgo.getIdrasgo() %>">  </td>
                                                        </tr>
                                                        <%
                                                            }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <%
                                                
                                                if (listRasgos.size()<=0) {
                                            %>                              
                                            <div class="form-group">
                                                <div class="col-xs-12 " style="margin-top: 10px;">
                                                    <div class="alert alert-info alert-dismissible fade in" role="alert">
<!--                                                        <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                                                        </button>-->
                                                        <strong>Sin Rasgos para asociar!</strong> Al parecer no se han asociado rasgos a las especies de Estudio, por favor verifique.
                                                    </div>
                                                </div>
                                            </div>
                                            <%
                                                }

                                            %>
                                            <div class="ln_solid"></div>
                                            <div class="form-group">
                                                <div class="col-sm-12" >
                                                    <input type="submit" value="Finalizar" class="btn btn-primary" >
                                                </div>
                                            </div>
                                            <!--<input type="button" value="Finalizar" class="btn btn-primary" onclick="nextStep('form_rasgosEstudio');">-->
                                        </form>
                                    </div> 
                                </div>
                                <%                                            }
                                %>                
                            </div>

                        </div>
                        <!-- End SmartWizard Content -->
                    </div>
                </div>
            </div>

            <div class="col-xs-12 col-sm-12">
                <div class="x_panel">
                    
                    <div class="x_content content">
                        <h2 class="StepTitle">Proyectos Resgistrados</h2><br>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Titulo Poyecto</th>
                                    <th>Descripción</th>
                                    <th>Resumen</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    ArrayList<proyectos> listProyect = proyectos.getProyectosList(conn);
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
                
         $( "#accordeonLocalidades" ).accordion();
        
function estadoRegistro(estado) {
    if (estado == "paso_2") {
        $("#step_1").attr("class", "done");
        $("#step_1").attr("href", "#1");
        $("#step_2").attr("class", "selected");
        $("#step_22").css("display", "block");
        $("#step_3").attr("class", "disabled");
        $("#step_3").attr("herf", "#1");
    }
    if (estado == "paso_3") {
        $("#step_1").attr("class", "done");
        $("#step_1").attr("href", "#1");
        $("#step_2").attr("class", "done");
        $("#step_2").attr("href", "#1");
        $("#step_3").attr("class", "selected");
        $("#step_33").css("display", "block");
    }
    if (estado == "paso_1") {
        $("#step_3").attr("class", "disabled");
        $("#step_3").attr("href", "#1");
        $("#step_2").attr("class", "disabled");
        $("#step_2").attr("href", "#1");
        $("#step_1").attr("class", "selected");
    }
}
estadoRegistro('<%=estadoRegistro%>');
        </script>
