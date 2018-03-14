<%-- 
    Document   : AdminSolicitud
    Created on : 2/08/2017, 11:13:32 AM
    Author     : desarrolloJuan
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.SolicitudAcceso"%>

<%@page import="Modelo.Usuario"%>
<%@page import="BD.Conexion_MySQL"%>
<%
    Usuario user = new Usuario();
    if (session.getAttribute("user") != null) {
        user = (Usuario) session.getAttribute("user");
        session.setMaxInactiveInterval(900);
//         Connection conn = (Connection) session.getAttribute("connMySql");
//        Conexion_MySQL connn = (Conexion_MySQL) session.getAttribute("conectorMySql");
        if (user.getId() > 0 && user.getTipoUser().equals("ADMINISTRADOR")) {

            Connection conn = (Connection) session.getAttribute("connMySql");

%>

<div class="container">
    <div class="col-xs-12  x_panel_Principal">
        <div class="x_panel ">
            <div class="x_title">
                <h4 style="display: inline-block">SOLICITUDES PENDIENTES</h4>
                <ul class="nav navbar-right panel_toolbox">
                    <!--<li><a class="close-link"><i class="fa fa-close"></i></a></li>-->
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content form-horizontal">  
                <table class="table table-condensed table-striped">
                    <thead>
                    <th>Titulo</th>
                    <th>Resumen</th>
                    <th>Tiempo</th>
                    <th>Institucion</th>
                    <th>Solicitante</th>
                    <th>Fecha Solicitud</th>
                    <!--<th>Estado</th>-->
                    <th>Accion</th>
                    </thead>
                    <tbody>


                        <%//            String sentencia = "SELECT * FROM solicitud_acceso WHERE estado = 'ESPERA';";
                            //       ResultSet res = miconn.ejecutarConsulta(sentencia);
                            ArrayList<SolicitudAcceso> listSolicitudesEspera = SolicitudAcceso.obtenerSolicitudList(conn, "ESPERA");
                            for (SolicitudAcceso miSolicitud : listSolicitudesEspera) {
                        %>

                        <tr>

                            <td><%=miSolicitud.getTitulo()%></td>
                            <td><p><%=miSolicitud.getResumen()%></p></td>
                            <td><%=miSolicitud.getTiempo_solicitado()%> Dias</td>
                            <td><%=miSolicitud.getInstitucion()%></td>
                            <td><%=miSolicitud.getNombre()%></td>
                            <td><%=miSolicitud.getFecha()%></td>
                            <!--<td>< %=miSolicitud.getCorreo() %></td>-->
                            <!--<td><%=miSolicitud.getEstado()%></td>--> 

                            <td>
                                
                                <form method="post"  action="../solicitudAccesoServlet" onsubmit="envioFormularioServlet(this, 'contenedorNotificacion', true);$(this).parents('tr').remove(); return false;" >
                                    <div class="btn-group" >
                                    <button type="button" class="btn btn-sm btn-primary dropdown-toggle"
                                            data-toggle="dropdown" >
                                        <span class="fa fa-gears"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li >
                                            <a href="#2" onclick="$(this).parents('form').find('input[name=oper]').val('Aceptar');$(this).parents('form').submit();"><span class="fa fa-check-circle-o"></span>  Aceptar</a>
                                        </li>
                                        <li>
                                            <!--<input type="submit" class="hide"  value="Aceptar" onclick="$(this).parents('form').find('input[name=oper]').val('Aceptar');" >-->
                                            <a href="#3" onclick="$(this).parents('form').find('input[name=oper]').val('Rechazar');;$(this).parents('form').submit();"><span class="fa fa-warning"></span> Rechazar</a>
                                            <!--<a href="#3" onclick="$('#oper').val('Rechazar');$(this).parents('form').submit();"><span class="fa fa-warning"></span> Rechazar</a>-->
                                        </li>
                                    </ul>
                                </div>
                                    <!--<input type="submit" class="btn btn-sm" value="Rechazar" onclick="$('#oper').val('Rechazar');">-->
                                    <input type="hidden" value="" name="oper">
                                    <input type="hidden" value="<%=miSolicitud.getIdsolicitud_acceso()%>" name="solicitud">
                                    <!--<input type="submit" class="btn btn-sm btn-primary" value="Aceptar" onclick="$('#oper').val('Aceptar');">-->
                                </form>
                            </td>
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

<script> iniPanelButon();</script>
<%
} else {
%>
<script> location.href = "../";</script>
<%
    }
} else {
//        response.sendRedirect("../Formularios/index.jsp");
%>
<script> location.href = "../";</script>
<%
    }
%>