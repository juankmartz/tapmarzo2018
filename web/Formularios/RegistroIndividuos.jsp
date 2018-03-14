<%-- 
    Document   : RegistroIndividuos
    Created on : 08-ago-2017, 18:28:18
    Author     : desarrolloJuan
--%>

<%@page import="java.sql.Connection"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Individuo"%>
<%@page import="Modelo.localidad"%>
<%@page import="Modelo.taxonomia"%>
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

<div class="container-fluid">
                <%
                    Connection conn = (Connection) session.getAttribute("connMySql");
                    String taxo = "" + request.getParameter("taxonomia");
//                    boolean resetForm = true;
//                    if(request.getParameter("resetForm")!= null) resetForm = false;
                    if (!taxo.equals("null")) {
                        int idtax = Integer.valueOf(request.getParameter("taxonomia"));
                        int idlocal = Integer.valueOf(request.getParameter("localidad"));
                        String descripcion = "" + request.getParameter("descripcion");
                        String nombreInd = "" + request.getParameter("nombre");
                        String codigoInd = "" + request.getParameter("codigo");
                        int ultimoID = Individuo.registroIndividuo(conn,idtax, idlocal, nombreInd, codigoInd, descripcion);
                        // if ultimoId >0 el registro fue exitoso;
                        if(ultimoID>0){
                            %>
<script>nuevaNotify("notice","Registro Exitoso","Se completo satisfactoriamente el registro del individuo <i> <%=nombreInd %></i> con codigo '<i><%=codigoInd%></i>'.",15000);</script>
                <%
                        }else{
                        %>
<script>nuevaNotify("warning","Sin Registrar","No de realizo el registro del individuo <i> <%=nombreInd %></i> con codigo '<i><%=codigoInd%></i>', por favor verifique los datos he intentolo mas tarde.",150000);</script>
                <%
}
                    }

//                    ResultSet tax = taxonomia.getEspeciesList();
//                    ResultSet local = localidad.getLocalidades();
                    ArrayList <localidad> listLocalidad = localidad.getLocalidadesList(conn);
ArrayList<taxonomia> tax = taxonomia.getEspeciesList(conn);
                %>
    <div class="col-xs-11 col-md-5 col-sm-10" >
        <div class="x_panel">
            <div class="x_title"><h3>Registro Individuo</h3></div>
            <div class="x_content">
                <form style="padding: 10px;" class="form-horizontal">
                    <input type="hidden" name="oper" value="nuevoIndividuo">
<!--                    <div class="form-group">
                        <label class="checkbox-inline" >
                            <input type="checkbox" name="resetForm" value="false"> 
                            Limpiar formulario despues de registrar al individuo
                        </label>
                    </div>-->
                    <div class="form-group">
                        <label >Especie :  </label> 
                        <select class="form-control input-sm" name="taxonomia" required>
                            <%
                                for (taxonomia miTax : tax) {
                            %>
                            <option value="<%=miTax.getIdespecie() %>" selected><%=miTax.getEspecie() %> ( <%=miTax.getNombreComun() %> )</option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Localidad: </label>
                        <select class="form-control input-sm" name="localidad" required>
                            <%
                                for (localidad miLocal : listLocalidad) {
                            %>
                            <option value="<%=miLocal.getIdlocalidad() %>" selected><%=miLocal.getNombre() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div> 
                    <div class="form-group"><label for="txtnombre">Nombre</label><input class="form-control input-sm" type="text" name="nombre" id="txtnombre" maxlength="100" ></div>
                    <div class="form-group"><label for="txtcodigo">Codigo</label><input class="form-control input-sm" type="text" name="codigo" id="txtcodigo" maxlength="45" required></div>
                    <div class="form-group"><label for="txtdescripcion" >Descripcion</label><textarea class="form-control input-sm" name="descripcion" id="txtdescripcion" style="resize: none;" placeholder="Use maximo 200 caracteres" maxlength="200"></textarea></div>
                    <div class="form-group"><input type="submit" value="Guardar" class="btn btn-primary"></div>
                </form>
            </div>
        </div>
    </div>
                    
    <div class="col-xs-12 col-md-7 col-sm-10" >
        <div class="x_panel">
            <div class="x_title"><h3>Individuos Registrados</h3></div>
            <div class="x_content">
                <div class="">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Especie</th>
                                <th>Localidad</th>
                                <th>Descripcion</th>
                            </tr>
                        </thead>
                            <tbody >
                            
                                <%
                                    ArrayList<Individuo> listIndividuo = Individuo.obtenerTodosIndividuosList(conn);
                                    for (Individuo miIndi : listIndividuo) {
                                %>
                                <tr>
                                    <td><%=miIndi.getCodigo()%></td>
                                    <td><%=miIndi.getEspecie()%></td>
                                    <td><%=miIndi.getNombreLocalidad()%></td>
                                    <td><%=miIndi.getDescripcion()%></td>
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
         $("select").select2({
            placeholder: "Seleccione"
        });
        $('table').DataTable( );
        
        $("form").submit(function (){evioFormulario(this);return false;});
        $("form").attr("action","../Formularios/RegistroIndividuos.jsp"); 
    });  
            
    </script>

</div>
                            
