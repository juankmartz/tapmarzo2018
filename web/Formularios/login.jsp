<%-- 
    Document   : loging
    Created on : 01-oct-2017, 11:31:21
    Author     : desarrolloJuan
--%>

<%@page import="BD.Conexion_MySQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="Modelo.Contenido"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="../Plugins/CSS/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/CSS/sliderFondo_2.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <!--notificacion-->
        <link href="../Plugins/CSS/loaderOnadaDeCubos.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/NotificationStyles/css/ns-default.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/NotificationStyles/css/ns-style-other.css" rel="stylesheet" type="text/css"/>

        <style>
            .btn-retorno-pag {
                /*border: red 1px solid;*/
                position: absolute;
                top: 40px;
                right: 50px;
                /*background: rgba(17, 17, 17, 0.38);*/
                padding: 10px;
                border-radius: 25px;
            }
            .btn-retorno-pag i.fa.fa-sign-in {
    font-size: 28px;
}
.btn-retorno-pag a:hover{
    color:rgb(0, 188, 212);
}
            
            body , html{
                height: 100%; 
            }         
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

            .inner-addon { 
                position: relative; 
            }

            /* style icon */
            .inner-addon .glyphicon {
                position: absolute;
                padding: 10px;
                pointer-events: none;
            }

            /* align icon */
            .left-addon .glyphicon  { left:  0px;}
            .right-addon .glyphicon { right: 0px;}

            /* add padding  */
            .left-addon input  { padding-left:  30px; }
            .right-addon input { padding-right: 30px; }
            .inner-addon:hover {
                color: #61ABEA;
            }
            .formLogin button {
                width: 100%;
                height: 100%;
                margin-top: -1px;
                font-size: 1.4em;
                line-height: 1.75;
                color: white;
                border: none;
                border-radius: inherit;
                background: #52cfeb;
                background: -moz-linear-gradient(#52cfeb, #42A2BC);
                background: -ms-linear-gradient(#52cfeb, #42A2BC);
                background: -o-linear-gradient(#52cfeb, #42A2BC);
                background: -webkit-gradient(linear, 0 0, 0 100%, from(#52cfeb), to(#42A2BC));
                background: -webkit-linear-gradient(#52cfeb, #42A2BC);
                background: linear-gradient(#52cfeb, #42A2BC);
                box-shadow: inset 0 1px 0 rgba(255,255,255,0.3), 0 1px 2px rgba(0,0,0,0.35), inset 0 3px 2px rgba(255,255,255,0.2), inset 0 -3px 2px rgba(0,0,0,0.1);
                cursor: pointer;
            }
            .formLogin {
                width: 300px;
                padding: 12px;
                box-shadow: 7px 7px 13px 0px rgba(130, 130, 130, 0.52);
                border: 1px solid rgba(224, 224, 224, 0.64);
                border-radius: 3px;
                height: 100px;
                background: #FFF;
                z-index: 3;
            }
            .formLogin .btnLogin {
                width: 65px;
                height: 65px;
                position: relative;
                top: -73px;
                float: right;
                padding: 10px;
                z-index: 2;
                background: #ffffff;
                border-radius: 50%;
                box-shadow: 0 0 2px rgba(0,0,0,0.1), 0 3px 2px rgba(0,0,0,0.1), inset 0 -3px 2px rgba(0,0,0,0.2);
                right: -35px;
            }

            /**, *:after, *:before {
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                -ms-box-sizing: border-box;
                -o-box-sizing: border-box;
                box-sizing: border-box;
                padding: 0;
                margin: 0;
            }*/
            .btnLogin:after {
                content: "";
                width: 12px;
                height: 10px;
                position: absolute;
                top: -2px;
                left: 30px;
                background: #ffffff;
                box-shadow: 0 62px white, -32px 31px white;
            }

            .mensajeBienvenida {
                color: white;
                z-index: 2;
                background: rgba(71, 175, 201, 0.8);
                top: 20px;
                left: 10px;
                position: absolute;
                padding: 16px 44px;
                border-radius: 66% 0;
                border: 6px solid rgba(111, 207, 228, 0.68);
                max-width: 50%
            }
            div.mensajeBienvenida:after {
                /*content: "";*/
                position: relative;
                border-top: 76px solid rgba(10, 10, 10, 0.54);
                border-right: 105px solid rgba(10, 10, 10, 0.54);
                border-bottom: 75px solid rgba(10, 10, 10, 0.54);
                top: -57px;
                right: -400px;
                border-radius: 0% 50% 50% 0%;
            }
            a{
                font-size: 17px;
                font-weight: bold;
                text-decoration: none;
                color: #FFF;
            }
            a:hover , a:focus{
                text-decoration: none;
                color: #99ff00;
            }
            /*notificacion*/

            .ns-type-error{background-color:rgba(231,76,60,.8);border-color:rgba(231,76,60,.88); z-index: 1900;}
            .ns-type-error:hover{background-color:rgba(231,76,60,.9);border-color:rgba(231,76,60,.88); z-index: 1900;}
            .ns-type-warning {
                color: #E9EDEF;
                background-color: rgba(251, 168, 17, 0.8);
                border-color: rgb(160, 107, 9);
                z-index: 1900;
            }
            .ns-type-warning:hover {
                color: #E9EDEF;
                background-color: rgba(251, 168, 17, 0.9);
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
            <%
//                Connection conn = (Connection) session.getAttribute("connMySql");
                Connection conn = Conexion_MySQL.conectar2();
                ArrayList<Contenido> listCont = new ArrayList<>();
                listCont = Contenido.obtenerContenidoByTipo(conn, "FONDO_LOGIN");
                conn.close();
                if (listCont.size() > 0) {
                    int maxTiempo = listCont.size() * 6;
            %>
            .cb-slideshow li div {
                z-index: 1000;
                position: absolute;
                bottom: 10px;
                left: 0px;
                width: 100%;
                text-align: right;
                opacity: 0;
                -webkit-animation: titleAnimation <%=maxTiempo%>s linear infinite 0s;
                -moz-animation: titleAnimation <%=maxTiempo%>s linear infinite 0s;
                -o-animation: titleAnimation <%=maxTiempo%>s linear infinite 0s;
                -ms-animation: titleAnimation <%=maxTiempo%>s linear infinite 0s;
                animation: titleAnimation <%=maxTiempo%>s linear infinite 0s;
            }

            .cb-slideshow li span {
                width: 100%;
                height: 100%;
                position: absolute;
                top: 0px;
                left: 0px;
                color: transparent;
                background-size: cover;
                background-position: 50% 50%;
                background-repeat: none;
                opacity: 0;
                z-index: 0;
                -webkit-backface-visibility: hidden;
                -webkit-animation: imageAnimation <%=maxTiempo%>s linear infinite 0s;
                -moz-animation: imageAnimation <%=maxTiempo%>s linear infinite 0s;
                -o-animation: imageAnimation <%=maxTiempo%>s linear infinite 0s;
                -ms-animation: imageAnimation <%=maxTiempo%>s linear infinite 0s;
                animation: imageAnimation <%=maxTiempo%>s linear infinite 0s;
            }
            <%
                }

                int tiempo = 0;
                for (Contenido miCont : listCont) {
                    int index = listCont.indexOf(miCont) + 1;

            %>
            .cb-slideshow li:nth-child(<%=index%>) span {
                background-image: url(<%=miCont.getImagen()%>);
                -webkit-animation-delay: <%=tiempo%>s;
                -moz-animation-delay: <%=tiempo%>s;
                -o-animation-delay: <%=tiempo%>s;
                -ms-animation-delay: <%=tiempo%>s;
                animation-delay: <%=tiempo%>s;
            }

            .cb-slideshow li:nth-child(<%=index%>) div {
                -webkit-animation-delay: <%=tiempo%>s;
                -moz-animation-delay: <%=tiempo%>s;
                -o-animation-delay: <%=tiempo%>s;
                -ms-animation-delay: <%=tiempo%>s;
                animation-delay: <%=tiempo%>s;
            }
            <%
                    tiempo += 6;
                }
            %>

        </style>

    </head>


    <body>
        <%

        %>
        <div class="fondoAnimado">
            <ul class="cb-slideshow" style="list-style: none;">
                <%    for (Contenido miCont : listCont) {
                %>
                <li><span>Image 01</span><div><h3><%=miCont.getSubtitulo()%></h3></div></li>
                    <%
                        }
                    %>
                <!--                <li><span>Image 02</span><div><h3>qui·e·tude</h3></div></li>
                            <li><span>Image 03</span><div><h3>Caño Cristales</h3></div></li>
                            <li><span>Image 04</span><div><h3>e·qua·nim·i·ty</h3></div></li>
                            <li><span>Image 05</span><div><h3>com·po·sure</h3></div></li>
                            <li><span>Image 06</span><div><h3>se·ren·i·ty</h3></div></li>-->
            </ul>
        </div>
        <div class="btn-retorno-pag" >
            <a href="../"><i class="fa fa-sign-in"></i> Regresar</a>
        </div>
        <section class="centrado-padre ">
            <div class="centrado-hijo ">
                <form class="formLogin form-horizontal" action="../miLogin" method="post" onsubmit=" mostrarLoaderOndaDeCubos('Verificando...');evioFormulario(this);return false;">
                    <div class="inner-addon left-addon">
                        <i class="glyphicon glyphicon-user"></i>
                        <input type="text" class="form-control" name="login" placeholder="email" required title="Ingrese le Correo Electronico registrado"/>
                    </div>
                    <div class="inner-addon left-addon" style="margin-top: 10px;">
                        <i class="glyphicon glyphicon-lock"></i>
                        <input type="password" class="form-control" name="password" placeholder="Password" title="Ingrese la contraseña, tenga encuenta las Mayusculas y minusculas" required/>
                    </div>
                    <input type="hidden" name="oper" value="iniciarsession">
                    <p class="btnLogin">
                        <button type="submit" name="submit"><i class="glyphicon glyphicon-arrow-right" > </i> </button>
                    </p>

                </form>
            </div>

        </section>
        <div class="mensajeBienvenida col-lg-3 col-sm-4">
            <h1>Ingreso a la plataforma</h1>
            <p>Los usuarios nuevos pueden solicitar acceso <a href="#1"> AQUI </a></p>

        </div>
        <!--contenedor para la respuesta del Servlet-->
        <div id="contenedorPagina" class="col-lg-3 col-sm-4"></div>
        <!--contendor para el loader-->
        <div id="loaderArchitic" class="row flex-parent" style="display:none"></div>   

        <div class="contenedorNotificacion" id="contenedorNotificacion"></div>
        <script src="../Plugins/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="../Plugins/Js/globalFunciones.js" type="text/javascript"></script>
        <!--notificacion-->
        <script src="../Plugins/NotificationStyles/js/modernizr.custom.js" type="text/javascript"></script>
        <script src="../Plugins/NotificationStyles/js/notificationFx.js" type="text/javascript"></script>
        <script src="../Plugins/NotificationStyles/js/classie.js" type="text/javascript"></script>

        <script>
                    iniLoaderOndaDeCubos("Cargando");
        </script>
    </body>
</html>
