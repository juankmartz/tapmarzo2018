<%-- 
    Document   : registrarCaracteristicas
    Created on : 17-ago-2017, 8:34:00
    Author     : desarrolloJuan
--%>

<%@page import="java.sql.Connection"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.String"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Modelo.Rasgo"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>

<%
    Usuario user = new Usuario();
    Connection conn;
    if (session.getAttribute("user") != null) {
        user = (Usuario) session.getAttribute("user");
        session.setMaxInactiveInterval(900);
        conn = (Connection) session.getAttribute("connMySql");
    }else { %><script>window.location = "index.jsp";</script> <% return;
        } 
%> 

<style>
    .centrado-padre{
        display: -ms-flex;
        display: -webkit-flex;
        display: flex;
    }

    .centrado-hijo{
        display: -ms-flex;
        display: -webkit-flex;
        display: flex;
        justify-content: center;
        flex-direction: column;
    }
    section.centrado-padre {
        height: 100%;
    }


    div.centrado-hijo{
        margin-left: auto;
        margin-right: auto;
    }

    /*esquinas de nota*/  
    .note.blue {
        background: none repeat scroll 0 0 #53A3B4; /* color de fondo */
        color: #FFFFFF; /* color de texto */
        margin: 2em auto;
        overflow: hidden;
        padding: 1em 1.5em;
        position: relative;
        width: 480px; /* ancho */
    }
    .note.blue:before {
        -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.3), -1px 1px 1px rgba(0, 0, 0, 0.2);
        background: none repeat scroll 0 0 #658E15; /* color de fondo */
        border-color: #FFFFFF #FFFFFF #658E15 #658E15; /* color de esquina */
        border-style: solid;
        border-width: 0 16px 16px 0;
        content: "";
        display: block;
        position: absolute;
        right: 0;
        top: 0;
        width: 0;
    }

    .contenedor-teclado > div{
        padding-left: 1px!important;
        padding-right: 1px!important;
    }
</style>
<!--<div class="note blue"><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pulvinar rhoncus risus, vel ornare lacus sagittis sit amet. Duis vel sem magna. Proin pulvinar velit eleifend ligula ultrices vestibulum. Nunc posuere dolor eu mauris feugiat dignissim.</p></div>-->
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
    Launch demo modal
</button>
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleteclad0">
    Launch teclado
</button>
<div class="modal " tabindex="-1" role="dialog" id="exampleModal" >
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <span style="font-size: 20px; font-weight: bolder;">Detalles Rasgo</span>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <div class="col-xs-2 col-md-1"><label for="codigo">Cod</label>
                            <span class="form-group" id="codigo">1234</span></div>
                        <div class="col-xs-10 col-md-8"><label for="nombreRasgo">Nombre</label>
                            <span class="form-group" id="nombreRasgo">este sera el nombre del rasgo que puede ser muy largo segun vi</span></div>
                        <div class="col-xs-4 col-md-1"><label for="sigla">Sigla</label>
                            <span class="form-group" id="sigla">DNA-45</span></div>
                        <div class="col-xs-4 col-md-2"><label for="nombreRasgo">Unidad</label>
                            <span class="form-group" id="nombreRasgo">Mt*Pas-1</span></div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-10 xol-md-11"><label for="descripcionRasgo">Descripción</label>
                            <span class="form-group" id="descripcionRasgo">la descripción del rasgo puede ser larga, corta o no existir...</span></div>
                    </div>
                    <div class="form-group ">
                        <div class="col-xs-12 " >
                            <label for="listaEspecies">Especies </label>
                            <p><i class="text-muted ">Lista de especies a las que se les a asociado como rasgo medible.</i></p>
                            <table class="table tabla-lista" id="listaEspecies">
                                <thead><tr><th>Cod</th><th>Especie</th></tr></thead>
                                <tbody>
                                    <tr><td>0012</td><td>Especie 1</td></tr>
                                    <tr><td>0012</td><td>Especie 1</td></tr>
                                    <tr><td>0012</td><td>Especie 1</td></tr>
                                    <tr><td>0012</td><td>Especie 1</td></tr>
                                    <tr><a href="#3"><td>0012</td><td>Especie 1</td></a></tr>
                                <tr><td></td><td><a href="#3">+ Agregar Especie</a></td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal " tabindex="-1" role="dialog" id="exampleteclad0" >
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">

                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="contenedor-teclado">
                    <div class="col-md-1"><input type="button" value="&Alpha;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&sigma;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&AMP;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Afr;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Bcy;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Bernoullis;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Beta;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&CHcy;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Ccedil;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Delta;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Del;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&AElig;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&zeta;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&zeetrf;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&varphi;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Element;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Gamma;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Kappa;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Lambda;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&Pi;" class="form-control btn btn-xs btn-primary"></div>
                    <div class="col-md-1"><input type="button" value="&omega;" class="form-control btn btn-xs btn-primary"></div>

                </div>
            </div>
            <div class="modal-footer">
                <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>



<div class="container-fluid">
    <!--  *******************  registro Nuevos Rasgos  *************** -->
    <div class="col-xs-10">
        <div class="x_panel ">
            <div class="x_title">
                <h2>Registro Rasgo</h2> 
                <ul class="nav navbar-right panel_toolbox">
                    <!--<li><a class="close-link"><i class="fa fa-close"></i></a></li>-->
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                </ul>
                <div class="clearfix"></div>

            </div>
            <div class="x_content">
                <div class="form-horizontal" >
                    <form method="post" action="../AdminRasgos" onsubmit="evioFormularioServlet(this, 'contenedorNotificacion', true);return false;">
                        <input type="hidden" value="resgistrarRasgo" name="oper">
                        <div class="form-group col-xs-6 col-md-6"><label for="txtnombre">Nombre</label><input value="" class="form-control input-sm" type="text" name="nombre" id="txtnombre" required></div>
                        <div class="form-group col-xs-6 col-md-6"><label for="txtname">Name</label><input value=""  class="form-control input-sm" type="text" name="name" id="txtname" ></div>
                        <div class="form-group col-xs-6 col-md-3"><label for="selctTipoRasgo">Tipo de Rasgo</label>
                            <select name="tipoRasgo" id="selctTipoRasgo" required class="form-control input-sm">
                                <option value="Alometrico" >Alometrico</option>
                                <option value="Alométrico-tallo">Alométrico-tallo</option>
                                <option value="Alométrico Raíz">Alométrico Raíz</option>
                                <option value="Externo a la planta">Externo a la planta</option>
                                <option value="Fisiológico" >Fisiológico</option>
                                <option value="Fisiológico-tallo">Fisiológico-tallo</option>
                                <option value="Funcional">Funcional</option>
                                <option value="Funcional-semilla">Funcional-semilla</option>
                                <option value="Funcional-Raíz">Funcional-Raíz</option>
                                <option value="Morfo-anatómico">Morfo-anatómico</option>
                                <option value="Morfo-anatómico-semilla">Morfo-anatómico-semilla</option>
                                <option value="Quimico">Quimico</option>
                                <option value="Químico-hoja">Químico-hoja</option>
                            </select>
                        </div>
                        <div class="form-group col-xs-6 col-md-3"><label for="selectTipoDato">Tipo de dato</label>
                            <select name="tipoDato" id="selectTipoDato" required class="form-control input-sm">
                                <option value="number" >Numerico</option>
                                <option value="texto">Texto</option>
                            </select>
                        </div>

                        <div class="form-group col-xs-4 col-md-3"><label for="txtsigla">sigla</label><input value=""  class="form-control input-sm" type="text" name="sigla" id="txtunidad" required></div>
                        <div class="form-group col-xs-4 col-md-3"><label for="txtunidad">Unidad de medicion</label><input value="" class="form-control input-sm" type="text" name="unidad" id="txtunidad" required></div>
                        <!--<div class="form-group" ><label for="txtrepM">Replica minima</label><input value="" class="form-control input-sm" type="number" name="replicaM" id="txtrepM" ></div>-->
                        <!--<div class="form-group"><label for="txtrepR">Replica recomendada</label><input value=""  class="form-control input-sm" type="number" name="replicaR" id="txtrepR" ></div>-->
                        <div class="form-group col-xs-12 "><label class="control-label" for="txtdesc">Descripcion</label><input value=""  class="form-control input-sm" type="text" name="descripcion" id="txtdesc" ></div>
                        <div class="form-group col-sx-4 col-xs-offsewt-8 col-md-2 col-md-offset-10"><input type="submit" value="Guardar" class="btn btn-primary "></div>
                    </form>  
                </div> 
            </div>
        </div>
    </div>
    <!--  *******************  Consulta de Rasgos  ******************* -->
    <div class="col-xs-10">
        <div class="x_panel ">
            <div class="x_title">
                <h2>Consultar Rasgo</h2> 
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <div class="form-horizontal" >
                    <form method="post" action="../AdminRasgos" onsubmit="evioFormularioServlet(this, 'resultadoBusquedaRasgo', true);return false;">
                        <input type="hidden" value="buscarRasgos" name="oper">
                        <div class="input-group ">
                            <input type="text" class="form-control input-sm" name="datoBusqueda" placeholder="Busque por nombre de rasgo o Sigla...">
                            <span class="input-group-btn">
                                <button class="btn btn-default btn-sm" type="submit">Buscar</button>
                            </span>
                        </div>
                    </form> 
                    <div class="panel-body" id="resultadoBusquedaRasgo">
                        <table>
                            <thead>
                                <tr><th></th></tr>
                            </thead>
                            <tbody>
                                <tr><td></td></tr>
                            </tbody>
                        </table>
                    </div>
                </div> 
            </div>
        </div>
    </div>                   

    <!--resgistro rasgos a Especie-->
    <div class="col-xs-12 col-md-7">
        <div class="x_panel">
            <div class="x_title"><h3>Asignar Rasgo a Especies </h3></div>
            <div class="x_content form-horizontal">
                <div class="form-group">
                    <label class="col-lg-4 control-label" for="selctEspecieRasgo">Selecccione El rasgo:</label>

                    <form action="../taxonomiaServlet" method="post" onsubmit="evioFormularioServlet(this, 'contCheckRasgos', true);return false;">
                        <input type="hidden" value="buscarEspeciesSegunRasgo"  name="oper">
                        <div class="input-group col-lg-8">
                            <select class="form-control btn-info" id="selctEspecieRasgo"  name="rasgoAsignarAEspecie" data-style="btn-info" data-live-search="true" onchange="$('#contCheckRasgos').html('');">
                                <%                                        
                                    ArrayList<Rasgo> listRasgos = new ArrayList<>();
                                    conn = (Connection) session.getAttribute("connMySql");
                                    listRasgos = Rasgo.getRasgosList(conn);
                                    for (Rasgo miRasgo : listRasgos) {
                                %><option value="<%=miRasgo.getIdrasgo()%>" ><%=miRasgo.getNombre()%> (<%=miRasgo.getUnidad()%>)</option><%
                                    }
                                %>
                            </select>
                            <span class="input-group-btn"><button class="btn btn-primary" type="submit" ><span class="glyphicon glyphicon-search "></span></button></span>
                        </div>
                    </form>
                </div>
                <form action="../taxonomiaServlet" onsubmit="evioFormularioServlet(this, 'contCheckRasgos', true);return false;">
                    <input type="hidden" name="oper" value="ActualizarEspeciesSegunRasgo">
                    <div id="contCheckRasgos" class="panel-primary columnas-lg-2">

                    </div>
                    <input type="submit" class="btn btn-primary" value="Guardar Cambios">
                </form>
                <div class="form-group" id="contenedorRasgoEspecie">

                </div>
            </div>
        </div> 
    </div> 
</div>







<script>
    $(document).ready(function () {
        $("select").select2({
            placeholder: "Seleccione"
        });
    });
 


</script>         
