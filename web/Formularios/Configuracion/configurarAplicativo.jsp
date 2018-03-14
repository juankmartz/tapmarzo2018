<%-- 
    Document   : consultaDatosExterior
    Created on : 11-oct-2017, 11:47:24
    Author     : desarrolloJuan
--%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.HashMap"%>
<%@page import="Modelo.Medicion"%>
<%@page import="Modelo.proyectos"%>
<%@page import="Modelo.localidad"%>
<%@page import="Modelo.Rasgo"%>
<%@page import="Modelo.taxonomia"%>
<%@page import="java.util.ArrayList"%>
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

<!--Estas variables son válidas para la aplicación. Permanecen hasta que repleguemos nuestra aplicación del servidor o echemos el servidor abajo. Son compartidas para todos los usuarios que visiten nuestra página web.
Dentro de un JSP podemos fijarlas o leerlas con la variable application que viene predefinida en cualquier JSP, usando los conocidos métodos setAttribute() y getAttribute().

   // Para fijar una variable en un jsp
   application.setAttribute("variable", new Integer(22));

   // Para leerla en otro o el mismo JSP
   Integer valor = (Integer)application.getAttribute("variable");

Y en un Servlet, se puede acceder obteniendo el ServletContext y llamando a sus métodos setAttribute() o getAttribute()
public class UnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

       // Para fijar la variable
       getServletContext().setAttribute("PI", new Double(3.1416));
       ...
       // Y para leerla en otro o el mismo servlet
       Double pi = (Double)getServletContext().getAttribute("PI");-->

<style>
    
    
    .icono-config {
        align-content: center;
        color: #1abb9c;
        /*color: #2196F3;*/
        font-size: 20px;
        align-content: center;
    }
    .icono-config .fa{
        font-size: 30px;
    }
    .content-btn-config:hover {
        background:#f6f6f6; 
    }
    .content-btn-config.active {
        background:#23527c;
        /*background:#2196F3;*/
        color: #fff;
    }
/*    .content-btn-config.active:hover {
        background:#1abb9c;
        background:#55aef4;
    }*/
    .content-btn-config {
        width: 19%;
        display: inline-block;
        /* border: red 1px solid; */
        margin: 0px;
        text-align: center;
        padding: 10px 0px;
        border-radius: 15px;
    }
    .content-btn-config.active .icono-config{
        color: #fff;
    }
/*    .content-btn-config:hover .icono-config {
        color: #23527c;
    }*/
    body .container.body .right_col{
        background: #fff;
    }
    
    @media (max-width: 780px) {

    .icono-config {
        align-content: center;
        color: #1abb9c;
        /*color: #2196F3;*/
        font-size: 13px;
        align-content: center;
    }
     .content-btn-config {
         width: 19%;
     }
} 

</style>
<!--<section class="centrado-padre form-solicitud-acceso">-->
<DIV class="h3">CONFIGURACION AVANZADA</DIV>
<div class="container-fluid center-block" style="padding-top:10px;">
    <div class="col-xs-12 menu-config" style="color: #E8E8E8;">
        <!--<div class="centrado-hijo col-xs-11">-->
        <div class="content-btn-config">
            <a href="#1" class="icono-config">
                <i class="fa fa-server"></i><br>
                <span>Servidor</span>
            </a>
        </div>
        <div class="content-btn-config">
            <a href="#1" class="icono-config">
                <i class="fa fa-desktop"></i><br>
                <span>Apariencia</span>
            </a>
        </div>
        <div class="content-btn-config">
            <a href="#1" class="icono-config">
                <i class="fa fa-envelope"></i><br>
                <span>Mensajeria</span>
            </a>
        </div>
        <div class="content-btn-config">
            <a href="#1" class="icono-config">
                <i class="fa fa-folder-open"></i><br>
                <span>Archivos</span>
            </a>
        </div>
        <div class="content-btn-config">
            <a href="#1" class="icono-config">
                <i class="fa fa-cogs"></i><br>
                <span>Plataforma</span>
            </a>
        </div>



    </div >
</div>

<script>
    $(".content-btn-config").on('click', function () {
        $(".content-btn-config.active").each(function () {
            $(this).attr('class', 'content-btn-config');
        });
        $(this).attr('class', 'content-btn-config active')
    });

</script>
