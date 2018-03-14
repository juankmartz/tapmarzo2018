<%-- 
    Document   : NuevoMenu
    Created on : 17-sep-2017, 14:33:41
    Author     : desarrolloJuan
--%>

<%@page import="BD.Conexion_MySQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.SolicitudAcceso"%>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
     Usuario user = new Usuario();
    if (session.getAttribute("user") != null) {
        user = (Usuario) session.getAttribute("user");
        session.setMaxInactiveInterval(900);
//         Connection conn = (Connection) session.getAttribute("connMySql");
         Conexion_MySQL connN = (Conexion_MySQL) session.getAttribute("conectorMySql");
        if (user.getId() > 0 && user.getTipoUser().equals("ADMINISTRADOR")) {
%>


<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="icon" type="image/png" href="../imagen/icono-hoja.png" />
        <link href="../Plugins/JQuery-UI/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/CSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        
        <!--Font Awesome--> 
        <link href="../Plugins/CSS/font-awesome.min.css" rel="stylesheet" type="text/css"/>
         
         <!--jQuery custom content scroller--> 
        <link href="../Plugins/CSS/jquery.mCustomScrollbar.min.css" rel="stylesheet" type="text/css"/>
         <!--NProgress--> 
        <link href="../Plugins/CSS/nprogress.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/Select2/css/select2.min.css" rel="stylesheet" type="text/css"/>
         <!--Custom Theme Style--> 
        <link href="../Plugins/CSS/custom.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/CSS/loader3DCuadros.css" rel="stylesheet" type="text/css"/>
        <!--notificacion-->
        <link href="../Plugins/CSS/loaderOnadaDeCubos.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/NotificationStyles/css/ns-default.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/NotificationStyles/css/ns-style-other.css" rel="stylesheet" type="text/css"/>
        <!--Data Table-->
        <link href="../Plugins/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
         
        <link href="../Plugins/CSS/bootstrap-select.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/CSS/stylosTAP.css" rel="stylesheet" type="text/css"/>
        
        
        <!--************************************************************************************-->
        
        
        <style>
        body{
            padding: 0px;
        }
        .flex-parent {
            display: -ms-flex;
            display: -webkit-flex;
            display: flex;
            height: 100%;
            position: fixed;
            top: 0px;
            left: 0px;
            width: 102%;
            height: 100%;
            /* border: red solid; */
            background: rgba(0, 0, 0, 0.58);
            z-index: 2000;
        }
        .col-md-3.left_col.menu_fixed.mCustomScrollbar._mCS_1.mCS-autoHide.mCS_no_scrollbar{
            z-index: 1000!important;
        }
        
        .ns-type-error{background-color:rgba(231,76,60,.8);border-color:rgba(231,76,60,.88); z-index: 1900;}
        .ns-type-error:hover{background-color:rgba(231,76,60,.9);border-color:rgba(231,76,60,.88); z-index: 1900;}
        .ns-type-warning {
            color: #E9EDEF;
            background-color: rgba(251, 168, 17, 0.8);
            border-color: rgb(160, 107, 9);
            z-index: 1900;
        }
        .ns-type-warning:hover {
            color: #FFF;
            background-color: rgba(251, 168, 17, 0.9);
            border-color: rgb(160, 107, 9);
            z-index: 1900;
        }
        .ns-type-notice {
            color: #E9EDEF;
            background-color: rgba(123, 178, 224, 0.8);
            border-color: rgb(160, 107, 9);
            z-index: 1900;
        }
        .ns-type-notice:hover {
            color: #FFF;
            background-color: rgba(123, 178, 224, 0.9);
            border-color: rgb(160, 107, 9);
            z-index: 1900;
        }
        .ns-type-sucess {
            color: #E9EDEF;
            background-color: rgb(145, 218, 65, 0.8);
            border-color: rgb(160, 107, 9);
            z-index: 1900;
        }
        .ns-type-sucess:hover {
            color: #FFF;
            background-color: rgb(145, 218, 65,0.9);
            border-color: rgb(160, 107, 9);
            z-index: 1900;
        }


        .ns-box{
            color : rgba(255, 255, 255, 0.88);
            display: block;
            position: relative;
            margin-top: 7px;
        }
        
        .contenedorNotificacion {
            position: fixed;
            top: 0px;
            right: 35px;
            z-index: 1900;
        }
        td{
            text-align: left;
        }
        .bootstrap-select>.dropdown-toggle.bs-placeholder{
            color: #f6f6f6;
        }
        .bootstrap-select>.dropdown-toggle.bs-placeholder:hover{
            color: #f6f6f6;
        }
       
        
        .input-sm > span.filter-option.pull-left {
            line-height: 18px;
            border: none;
        }
        .bootstrap-select > button.btn.dropdown-toggle.btn-info.input-sm {
            margin-bottom: 5px;
        }
        span.filter-option.pull-left {
            white-space: normal;
            min-height: 20px;
            height: 11px;
        }
        /*color de los select*/ 
        .dropdown-menu>li>a:hover {
            color: #FFFFFF;
            text-decoration: none;
            background-color: #5EC3E0;
        }
        li.selected > a {
            background: #E8E8E8;
            color: #337AB7;
            font-weight: bold;
        }
        
        /*check de colores*/
/*        .btn span.glyphicon {    			
            opacity: 0;				
        }*/
        
        .btn.active span.glyphicon {				
            opacity: 1;				
        }
/*        .form-group input[type="checkbox"] {
    display: none;
}*/

/*.form-group input[type="checkbox"] + .btn-group > label span:last-child {
    opacity:  1;   
}*/

/*.form-group input[type="checkbox"]:checked + .btn-group > label span {
    opacity:  0;
}*/

    </style>
  </head>

  <body class="nav-sm">
  <!--<body class="nav-md">-->
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col menu_fixed">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.jsp" class="site_title"><i class="glyphicon glyphicon-leaf"></i> <span>TAP </span></a>
            </div>
            <div class="clearfix"></div>
            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
<!--                    <li><a href="#" onclick="cargarPagina('ConsultaDatos.jsp')"><i class="fa fa-calculator"></i> Consulta Datos </a></li>
                    <li><a href="#" onclick="cargarPagina('consultaDatosExterno.jsp')"><i class="fa fa-calculator"></i> Consulta Datos Externo </a></li>-->
                    <li><a><i class="fa fa-edit"></i> Recolectar Datos <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                       
                      <li><a href="#" onclick="cargarPagina('Administracion/AdminProyectos.jsp')">Proyectos de estudio</a></li>
                      <li><a href="#" onclick="cargarPagina('RecoleccionDeMediciones.jsp')">Recoleccion datos</a></li>
                      <li><a href="#" onclick="cargarPagina('RegistroClima.jsp')">Datos climaticos</a></li>
                      
                    </ul>
                  </li>
                  <li><a><i class="fa fa-sitemap"></i> Configurar Entorno <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <!--<li><a href="#" onclick="cargarPagina('RegistrarCaracteristicas.jsp')" >Rasgos</a></li>-->
                      <li><a href="#" onclick="cargarPagina('Administracion/RasgosAdmin.jsp')" >Rasgos</a></li>
                      <!--<li><a href="#" onclick="cargarPagina('taxonomia_1.jsp')" >Especies</a></li>-->
                      <li><a href="#" onclick="cargarPagina('Administracion/AdminEspecies.jsp')" >Especies</a></li>
                      <li><a href="#" onclick="cargarPagina('RegistroIndividuos.jsp')" >Individuo</a></li>
                      <li><a href="#" onclick="cargarPagina('RegistroLocalidad.jsp')" >Localidades</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-sitemap"></i> Pruebas <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="#" onclick="cargarPagina('Configuracion/configurarAplicativo.jsp')" >Config avanzada</a></li>
<!--                        <li><a href="#" onclick="cargarPagina('../Pruebas/CambioProyectoEnero2018.jsp')" ><p>cambio Registro Proyecto</p></a></li>
                        <li><a href="#" onclick="cargarPagina('Administracion/AdminEspecies.jsp')" ><p>admin Especies</p></a></li>-->
                    </ul>
                  </li>
                  
                </ul>
              </div>
            

            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
<!--              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>-->
<a data-toggle="tooltip" data-placement="top" title="Logout" href="#1" onclick="cerrarSession()">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a >
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="images/img.jpg" alt=""><%=user.getNombre()%> 
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
<!--                    <li><a href="javascript:;"> Profile</a></li>
                    <li>
                      <a href="javascript:;">
                        <span class="badge bg-red pull-right">50%</span>
                        <span>Settings</span>
                      </a>
                    </li>-->
                    <li><a href="javascript:;">Help</a></li>
                    <li><a href="#1" onclick="cerrarSession()"><i class="fa fa-sign-out pull-right"></i> Salir </a></li>
                  </ul>
                </li>

                <li role="presentation" class="dropdown">
                    
                  <a href="javascript:" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope-o"></i>
 <%
    ArrayList <SolicitudAcceso> listSolicitudes  = SolicitudAcceso.obtenerSolicitudList(connN, "ESPERA");
    if(listSolicitudes.size()>0){
    %>
                    <span class="badge bg-green"><%=listSolicitudes.size()%></span>
<%
    }
    %>
                  </a>
                  <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
<%
//    ArrayList <SolicitudAcceso> listSolicitudes  = SolicitudAcceso.obtenerSolicitudList("ACTIVO");
    for(SolicitudAcceso miSolit : listSolicitudes){
        String mensaje = miSolit.getMensaje();
        if(mensaje.length()>90){
            mensaje = mensaje.substring(0, 90)+ "...";
        }
%>
                    <li>
                        
                        <a href="#" onclick="cargarPagina('AdminSolicitud.jsp');">
                        <!--<span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>-->
                        <span>
                          <span><%=miSolit.getNombre()%></span>
                          <span class="time"><%=miSolit.getFecha()%></span>
                        </span>
                        <span class="message">
                          <%=mensaje%>
                        </span>
                      </a>
                    </li>
<%
        }
        if(listSolicitudes.size()==0){
%>
<li>
                      <a>
                        <!--<span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>-->
                        
                        <span class="message">
                         No posee solicitudes en este momento.
                        </span>
                      </a>
                    </li>
<%
           }
%>
                  </ul>
                </li>
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main" id="contenedorPagina">
            
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
           
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>
<div id="loaderArchitic" class="row flex-parent" style="display:none"></div>
<div class="contenedorNotificacion" id="contenedorNotificacion"> </div>
      
      
      <!--<script src="../Plugins/Js/jquery.min.js" type="text/javascript"></script>-->
      <script src="../Plugins/jquery-3.2.1.min.js" type="text/javascript">
          
          
      </script>
    <script src="../Plugins/JQuery-UI/jquery-ui.min.js" type="text/javascript"></script>
    <!--<script src="../Plugins/DataTables-1.10.15/media/js/dataTables.jqueryui.js" type="text/javascript"></script>-->
    <!--<script src="../Plugins/Js/dataTables.bootstrap.min.js" type="text/javascript"></script>-->
    <script src="../Plugins/DataTables-1.10.15/media/js/jquery.dataTables.js" type="text/javascript"></script>
    <script src="../Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
    <!--<script src="../Plugins/Js/bootstrap.min.js" type="text/javascript"></script>-->
    
    <!--<script src="../Plugins/Js/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>-->
    <script src="../Plugins/Select2/js/select2.min.js" type="text/javascript"></script>
    
    <script src="../Plugins/NotificationStyles/js/modernizr.custom.js" type="text/javascript"></script>
    <script src="../Plugins/NotificationStyles/js/notificationFx.js" type="text/javascript"></script>
    <script src="../Plugins/NotificationStyles/js/classie.js" type="text/javascript"></script>
     
    <script src="../Plugins/Js/custom.min.js" type="text/javascript"></script>
   
     <script src="../Plugins/Js/bootstrap-select.js" type="text/javascript"></script>

    <script src="../Plugins/Js/globalFunciones.js" type="text/javascript"></script>
    <script >
        $("#miacc2").accordion();
//        init_sidebar();
        iniLoaderOndaDeCubos("Procesando");
//        $("table").DataTable();
        
    </script>
  </body>
</html>
<%
        } else {
            response.sendRedirect("../Formularios/index.jsp");
        }
    } else {
        response.sendRedirect("../Formularios/index.jsp");
    }
%>