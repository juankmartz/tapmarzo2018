<%-- 
    Document   : solicitudAcceso
    Created on : 1/08/2017, 12:36:13 PM
    Author     : desarrolloJuan
--%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Modelo.SolicitudAcceso"%>
<%@page import="Modelo.EnvioCorreos"%>
<%@page import="java.sql.Date"%>
<%@page import="BD.Conexion_MySQL"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<style>
    body{
        background-image: url(../imagen/video2.mp4)!important;
        background-repeat: round;
    }
</style>
<%
    String titulo = "" + request.getParameter("titulo");
    String tipoID = "" + request.getParameter("tipoID");

    if (titulo.equals("null")) {
%>

<video id="video-background" style="position: fixed;z-index: -1;top: 0px; width:100%;" autoplay=""  muted="" poster="../imagen/pattern.png" >
    <source src="../imagen/video2.mp4" type="video/mp4">
    <!--<source src="https://s3.amazonaws.com/distill-videos/videos/processed/2180/lighthouse.mp4" type="video/mp4">-->
</video> 

<section class="centrado-padre form-solicitud-acceso" style="padding: 100px;padding-bottom: 10px;">
    <div class="centrado-hijo col-xs-12 col-sm-12">
        <form autocomplete="off" action="../Formularios/solicitudAcceso.jsp" method="post" class="form-horizontal form-transparente" onsubmit="evioFormulario(this);return false;">
            <div class="title col-xs-12 center"><h5>SOLICITAR ACCESO A LA PLATAFORMA</h5></div>
            <div class="col-sm-6  col-xs-12 col-izquierda" >
                <div class="form-group">
                    <h6>DATOS PERSONALES</h6>
                </div>
                <div class="form-group">
                    <div class="renglon"><label>Nombre </label><input type="text" name="nombre" class="input-sm form-control input-transparente" placeholder="Nombres del interesado" required>
                    </div>
                </div>
                <div class="form-group">
                    <div class="renglon"><label>Apellidos </label><input type="text" name="apellido" class="input-sm form-control input-transparente" placeholder="Apellidos del interesado" required>
                    </div>
                </div>
                <div class="form-group">
                    <label>Correo Electronico</label><input type="email" name="correo" class="input-sm form-control input-transparente" placeholder="Correo de contacto, se usara para enviar los datos de acceso." required>
                </div>
                <div class="form-group">
                    <label>Pais:</label>
                    <!--<input type="text" name="pais" class="input-sm form-control input-transparente" placeholder="Nombre del pais" required>-->
                    <select name="pais" class="selectpicker form-control select-transparente" data-live-search="true" data-style="input-transparente" >
                        <%
                            Connection conn = Conexion_MySQL.conectar2();
                            ResultSet paises = Conexion_MySQL.ejecutarConsulta(conn, "SELECT `idpais`, `nombre`, `codigo`, `sigla` FROM `pais`;");
                            while(paises.next()){
                            %>
                            <option value="<%=paises.getInt("idpais")%>"><%=paises.getString("nombre")%></option>
                        
                        <%
                            }
%>
                    </select>
                </div>
                <div class="form-group"><label>Institución </label><input maxlength="100" type="text" name="institucion" class="input-sm form-control input-transparente" placeholder="Institución a la que pertenece" required>
                </div>
                <div class="form-group"><label>Rol </label><input maxlength="100" type="text" name="rol" class="input-sm form-control input-transparente" placeholder="Investigador, Docente ... " required><span class="help-block-transparente">Rol desempeñado en la institución </span>
                </div>

            </div>
            <div class="col-sm-6  col-xs-12  col-derecha" >
                <div class="form-group">
                    <h6>DATOS DE SU INVESTIGACIÓN</h6>
                </div>
                <div class="form-group">
                    <div class="renglon"><label>Titulo de su investigación </label><input maxlength="100" type="text" name="titulo" class="input-sm form-control input-transparente" placeholder="El Titulo de su investigación" required>
                    </div>
                </div>
                <div class="form-group">
                    <div class="renglon"><label>Resumen de la investigación </label>
                        <!--<input maxlength="200" type="text" name="resumen" class="input-sm form-control input-transparente" placeholder="Un breve resumen de la investigación, maximo de (200) caracteres." required>-->
                        <textarea maxlength="200" name="resumen" class="input-sm form-control input-transparente" placeholder="Un breve resumen de la investigación, maximo de (200) caracteres." required></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="renglon"><label>Por que desea acceder a nuestra base de datos </label>
                        <!--<input  maxlength="200" type="text" name="mensaje" class="input-sm form-control input-transparente" placeholder="cual es su interes en nuestra Base de Datos, maximo de (200) caracteres." required>-->
                        <textarea  maxlength="200"  name="mensaje" class="input-sm form-control input-transparente" placeholder="cual es su interes en nuestra Base de Datos, maximo de (200) caracteres." required></textarea>
                    </div>

                </div>    
                <div class="form-group">
                    <div class="renglon"><label>Tiempo Solicitado </label><input type="number" name="tiempo" class="input-sm form-control input-transparente" placeholder="Dias" required>
                    </div>   
                </div> 

                <div class="form-group">
                    <input type="submit" value="Enviar Solicitud" class="btn btn-sm input-transparente col-xs-12 col-md-6">
                </div>

            </div>
        </form>
    </div>
</section>

<div id="contenedorPagina"></div>
<script>
    $('.selectpicker').selectpicker('show');
</script>
<!--    <div class="col-md-6 ">
        <div class="panel">
            <div class="panel-heading">
                <h4 class="panel-title">Normas de la Plataforma GIEFIVET</h4>
            </div>
            <div class="panel-body">
                <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu.</p>

<p>In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar,</p>
            </div>
        </div>
    </div>-->
<%
} else if (titulo.equals("")) {%>
<script>
    alert("no se encontro un titulo valido");
</script>
<% } else {
    //registro de solicitud
    String mensaje = request.getParameter("mensaje");
    String resumen = request.getParameter("resumen");
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String numeroID = request.getParameter("numeroID");
    String institucion = request.getParameter("institucion");
    int tiempo = Integer.valueOf(request.getParameter("tiempo"));
    int idSolicitud = SolicitudAcceso.registrarSolicitusAcceso(titulo, resumen, mensaje, nombre, tipoID, numeroID, institucion, correo, "ESPERA", tiempo);
    if (idSolicitud > 0) {
        mensaje = "se registro correctamente su solicitud";
        EnvioCorreos mail = new EnvioCorreos();
        mail.enviarCorreo(correo, "Hola, su solicitud de permiso para acceder a los datos de nuestra plataforma se ha radicado con exito y se encuentra en espera para revision por parte del administrador. Se le informara mediante un correo la desicion tomada por parte del administrador, Feliz dia.", "Solicitud acceso a datos Ecologicos");
%>
<script>nuevaNotify("notice", "Registro Exitoso", "Su solicitud fue radicada con exito y fue tramitada para validación por parte del administrados.\n se enviara mas información al correo registrado", 15000);</script>
<%
} else {
%>
<script>nuevaNotify("warning", "Registro Fallido", "Se presento un problema que impidio realizar el registro de su solicitud, por favor intentelo mas tarde.", 10000);</script>
<%
    }
%>

<%}
%>
