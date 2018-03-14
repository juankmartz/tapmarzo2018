<%-- 
    Document   : index
    Created on : 29-sep-2017, 12:07:12
    Author     : desarrolloJuan
--%>

<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Pagina Principal</title>
        <link href="../Plugins/CSS/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <!--<link href="../Codigo/css/style3.css" rel="stylesheet" type="text/css"/>-->
        <link href="../Plugins/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/JQuery-UI/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
        <!--<link href="../Plugins/CSS/custom.min.css" rel="stylesheet" type="text/css"/>-->
        <link href="../Plugins/CSS/loaderOnadaDeCubos.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/NotificationStyles/css/ns-default.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/NotificationStyles/css/ns-style-other.css" rel="stylesheet" type="text/css"/>        
        <link href="../Plugins/CSS/bootstrap-select.min.css" rel="stylesheet" type="text/css"/>
        <!--tabla dinamica-->
        <!--<link href="../Plugins/DataTables-1.10.15/media/css/jquery.dataTables.css" rel="stylesheet" type="text/css"/>-->
        <link href="../Plugins/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <!--select--> 
        <link href="../Plugins/CSS/custom.min.css" rel="stylesheet" type="text/css"/>

        <link href="../Plugins/CSS/bootstrap-select.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/Select2/css/select2.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/CSS/stylosTAP.css" rel="stylesheet" type="text/css"/>

        <%
            Usuario user = new Usuario();
            if (session.getAttribute("user") != null) {
                user = (Usuario) session.getAttribute("user");
            }
        %>
        <link href="../Plugins/slider/css/style.css" rel="stylesheet" type="text/css"/>
        <style>
            /* NUEVA VERSION DE ASPECTO PARA EL INDEX CON BARRA DE MENU FIJA NO FLEX */
            #wrap {
                margin: 0 auto;
                position: absolute; 
                z-index: 300;
                width: 100%;
            }
            #contentPag {
                /*padding-top: 20px;*/
                min-height: calc(0px + 70%);
                min-height: calc(100% - 200px);
                /*height: 370px;*/
            }
            .centrado-hijo {
                overflow-y: auto;
                /* margin-top: 90px; */
                padding-top: 20px;
                display: block;
                padding-bottom: 20px;
            }
            /* fin nueva presentacion */




            body , html{
                height: 100%; 
            }
            body:after {
                content: ' ';
                background: transparent url(..//imagen/pattern.png) repeat top left;

                /*background: #95284c!important;*/
                /*        background: -webkit-linear-gradient(-96deg, rgb(86, 43, 65) 0%, rgb(167, 101, 122) 46%, rgb(53, 3, 24) 100%)!important;
                        background: linear-gradient(120deg, rgb(181, 29, 105) 0%, rgb(171, 71, 104) 46%, rgb(53, 3, 24) 100%)!important;
                        background: linear-gradient(-96deg, rgb(86, 43, 65) 0%, rgb(167, 101, 122) 46%, rgb(53, 3, 24) 100%)!important;*/
                /*background: #373737!important;*/
            }
            .img-logo-uis{
                padding: 10px 20px 20px 20px;
                background: rgba(255, 255, 255, 0.9);
                border-radius: 5px;
                margin-top: 18px;
                margin-bottom: 20px;
            }
            .centrado-padre{
                display: -ms-flex;
                display: -webkit-flex;
                display: flex;
            }

            /*            .centrado-hijo{
                            display: -ms-flex;
                            display: -webkit-flex;
                            display: flex;
                            justify-content: center;
                            flex-direction: column;
                        }*/
            section.centrado-padre {
                height: 100%;
            }


            div.centrado-hijo{
                margin-left: auto;
                margin-right: auto;
            }

            .form-solicitud-acceso{
                color: #FFF;

            }
            .col-derecha{
                margin: 0px;
                padding: 0px 40px;
                /*padding-top: 10px;*/
                border-left: 1px solid #F6F6F6
            }
            .col-izquierda{
                margin: 0px;
                padding: 0px 40px;
                /*padding-top: 10px;*/
                /*border-right: 1px solid;*/
            }

            .input-transparente {
                background: none;
                border-color: #f6f6f6;
                color: #23DBDB;
                font-weight: bold;
            }
            .table.dataTable > tbody> tr > td {
                text-align: left;
            }
            .input-transparente::placeholder { color: #cccbcb; }
            .input-transparente::-webkit-input-placeholder{ color: #cccbcb; }
            .input-transparente:-moz-placeholder { color: #cccbcb; }
            .input-transparente::-moz-placeholder { color: #cccbcb; }
            .input-transparente:-ms-input-placeholder { color: #cccbcb; }
            .help-block-transparente {
                display: block;
                margin-top: 5px;
                margin-bottom: 10px;
                color: #cccbcb;
                font-style: italic;
            }
            .centrado-hijo.col-xs-10 {
                background: rgba(17, 17, 17, 0.25);
            }
            .form-transparente{
                background: rgba(17, 17, 17, 0.4);
                padding: 1em;

            }
            .input-transparente:-webkit-autofill{
                background: none;
            }
            .btn.input-transparente {
                background: rgba(255, 255, 255, 0.34);
                color: #fff;
            }

            .btn.input-transparente:hover {
                background: rgba(35, 219, 219, 0.64);
                color: #fff;
            }

            .input-transparente > option {
                background: rgba(70, 70, 70, 0.83);
                color: #fff;
                padding: 15px 10px;
                margin: 20px;
            }
            .input-transparente > option:hover {
                background: #23DBDB;
                color: #fff;
            }
            select.form-control.input-transparente {
                font-weight: 200;
            }
/*            @media only screen and (max-width: 700px), only screen and (max-device-width: 700px) {
                    .centrado-hijo {
                        overflow-y: auto;
                        margin-top: 90px;
                        padding-top: 110px;
                        display: block;
                    }
                .col-derecha{
                    margin: 0px;
                    padding: 20px;
                    padding-top: 10px;
                    border-left: none;
                }
            }*/
            .m-b-1{
                margin-bottom: 1em;
            }
            img.logo {
                width: 100%;
                padding-top: 10px;
            }

            footer {
                /*background: rgba(27, 26, 26, 0.56);*/
                background: none;
                padding: 15px 20px;
                display: table;
                color: rgba(236, 233, 233, 0.88);
                margin-left: 0px;
                /*z-index: 1;*/
                /* border: 2px solid red; */
                /*width: 100%;*/
            }
            .grupo-info {
                padding-top: 18px;
            }


        </style>

        <style>
            div#nuevosDatosGraficaLinea > .datosGrafica > .btn-group >.btnEliminarDatos {
                display: block!important;
            }
            .switch {
                position: relative;
                display: inline-block;
                width: 47px;
                height: 25px;
            }

            .switch input {display:none;}

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                -webkit-transition: .4s;
                transition: .4s;
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 17px;
                width: 15px;
                left: 3px;
                bottom: 4px;
                background-color: white;
                -webkit-transition: .4s;
                transition: .4s;
            }

            input:checked + .slider {
                background-color: #23DBDB;
            }

            input:focus + .slider {
                box-shadow: 0 0 1px #23DBDB;
            }

            input:checked + .slider:before {
                -webkit-transform: translateX(26px);
                -ms-transform: translateX(26px);
                transform: translateX(26px);
            }

            /* Rounded sliders */
            .slider.round {
                border-radius: 34px;
            }

            .slider.round:before {
                border-radius: 50%;
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

            body{
                background: rgb(222, 126, 121);
            }
            .check-transparente[type="radio"] + label:before {
                border-radius: 50%;
            }
            .check-transparente[type="checkbox"]:checked + label:before, .check-transparente[type="radio"]:checked + label:before {
                content: '\f00c';
                background: transparent;
                border-color: rgba(255, 255, 255, 0.875);
                /*color: rgba(255, 255, 255, 0.875);*/
                color: #23D3D3;
            }
            .check-transparente[type="radio"]:checked + label:before {
                border-radius: 50%;
                content: "\f111";
                color: #23D3D3;
            }
            .panel-transparente{
                background: rgba(0,0,0,0.25);
                padding: 1em 2em;
                float: none;
                margin-left:  auto;
                margin-right: auto;
                display: table;
                border-radius: 3px;
            }
            .lbl-check{

            }
            /*selecet multiple*/
            .input-transparente + .dropdown-menu   {
                background: none;
            }
            .input-transparente + .dropdown-menu > ul  {
                background: rgba(17, 17, 17, 0.81);
            }
            .input-transparente + .dropdown-menu > ul > li.no-results {
                background: rgba(17, 17, 17, 0.52)!important;
                color: #F1EEEC;
                font-style: italic;
                border-radius: 5px;
            }
            .input-transparente + .dropdown-menu > ul > li > a {
                color: #f9f9f9;
            }
            .input-transparente + .dropdown-menu > ul > li.selected > a {
                color: #23DBDB!important;
                background: rgba(17, 17, 17, 0.5);;
            }
            .input-transparente + .dropdown-menu > ul > li > a:hover {
                background: #309895;
                color: #f9f9f9!important;
            }
            button.btn.dropdown-toggle.input-transparente {
                background: rgba(17, 17, 17, 0.2);
                color: #23D3D3;
                font-size: 11px;
            }

            .select-transparente {
                background: none;

            }

            table.table-transparente tbody tr {
                background: transparent;
            }

            .content-table-transparente .dataTables_wrapper table tbody tr:hover  {
                background: rgba(35, 219, 219, 0.55);
            }

            .content-table-transparente > label {
                color: red!important;
            }

            .table-responsive.content-table-transparente .dataTables_wrapper .dataTables_length  label {
                color: #FFF;
            }

            .table-responsive.content-table-transparente  .dataTables_wrapper .dataTables_length  label  select {
                background: transparent;
                border: 1px solid #dddddd;
                border-radius: 3px;
                padding: 0.2em;
                padding-left: 0.5em;
            }

            .table-responsive.content-table-transparente  .dataTables_wrapper .dataTables_filter  label  input {
                background: transparent;
                border: 1px solid #dddddd;
                border-radius: 3px;
                padding: 0.2em;
                padding-left: 0.5em;
            }
            .centrado-hijo {
                overflow-y: auto;
                /*margin-top: 90px;*/
                padding-top: 10px;
                display: block;
            }
            .content-table-transparente > div > .dataTables_info {
                color: #BBBABA;
            }
            .content-table-transparente .dataTables_wrapper .dataTables_length {
                float: left;
            }
            .content-table-transparente .dataTables_wrapper .dataTables_paginate .paginate_button {
                background: rgba(255, 255, 255, 0.34)!important;
                cursor: pointer;
                color: #fff;
                border: 1px solid;
                border-radius: 5px;
                margin: 1px;
            }
            .content-table-transparente .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
                background: rgba(35, 219, 219, 0.64)!important;
                color: #fff;
                border: 1px solid;
                border-radius: 5px;
                margin: 1px;
            }
            .content-table-transparente .dataTables_wrapper .dataTables_length label select option {
                background: rgba(12, 12, 12, 0.86);
            }
            @media screen and (max-width: 767px){
                .table-responsive.content-table-transparente {
                    width: 100%;
                    margin-bottom: 15px;
                    padding-top: 1em;
                    overflow-y: hidden;
                    -ms-overflow-style: -ms-autohiding-scrollbar;
                    border: 1px solid rgba(221, 221, 221, 0.32);
                }
            }

            .menuHoverTabla {
                position: absolute;
                /*border: 1px solid red;*/
                z-index: 3;
                /* height: 200px; */
                /* width: 200px; */
                /*        top: 0px;
                        left: 20px;*/
            }
            #graficaDispersion {
                min-height: 350px;
            }
            canvas {
                background-color: #FFF; 
                width: 100%;
                height: auto;
            }
            .btnAgregarDatos{
                border-radius: 50%;
                font-size: 26px;
                padding: 0px;
                line-height: 0px;
                height: 30px;
                width: 30px;
            }
            .btnEliminarDatos{
                border-radius: 50%;
                font-size: 26px;
                padding: 0px;
                line-height: 0px;
                height: 30px;
                width: 30px;
                display: none;
            }
            #resultadosBusqueda, #graficaResultado{
                display: none;
            }
            /*    .btnEliminarDatos:hover{
                    background: rgba(243, 59, 59, 0.53)!important;
                }*/



        </style>

    </head>
    <body >
        <div id="wrap">
            <header>
                <div class="inner relative">
                    <a class="logo" href=""><i class="glyphicon glyphicon-grain" style="color: white; font-size: 30px;"> TAP </i> </a>
                    <a id="menu-toggle" class="button dark" href="#"><i class="glyphicon glyphicon-menu-hamburger"></i></a>
                    <span class="hidden visible-lg-inline-block visible-md-inline-block" style="color:#f6f6f6; font-size: 28px; margin-left: 10px;"> Tropical andean plants</span>
                    <span style="display: none; color:#f6f6f6; font-size: 28px; margin-left: 10px;"> Plantas Andinas Topicales</span>
                    <nav id="navigation">
                        <ul id="main-menu">
                            <%
                                if (user.getId() < 0) { // si es un usuario no registrado invitado
                            %>
                            <li class="current-menu-item"><a href="#" onclick="cargarPaguinaAjax('solicitudAcceso.jsp', 'contentPag', true)">Solicitar Acceso</a></li>
                                <% } %>
                            <li class="current-menu-item"><a href="#" onclick="cargarPaguinaAjax('Configuracion/plantillasFormularios.jsp', 'contentPag', true)">configuracion</a></li>
                            <!--                            <li class="parent">
                                                            <a href="#" onclick="cargarPaguinaAjax('../Pruebas/Tabla dinamica.jsp','contentPag',true)" >Tabla Dinamica</a>
                                                            <a href="http://www.freshdesignweb.com/responsive-drop-down-menu-jquery-css3-using-icon-symbol.html">Features</a>
                                                            <ul class="sub-menu">
                                                                <li><a href="http://www.freshdesignweb.com/responsive-drop-down-menu-jquery-css3-using-icon-symbol.html"><i class="icon-wrench"></i> Elements</a></li>
                                                                <li><a href="http://www.freshdesignweb.com/responsive-drop-down-menu-jquery-css3-using-icon-symbol.html"><i class="icon-credit-card"></i>  Pricing Tables</a></li>
                                                                <li><a href="http://www.freshdesignweb.com/responsive-drop-down-menu-jquery-css3-using-icon-symbol.html"><i class="icon-gift"></i> Icons</a></li>
                                                                <li>
                                                                    <a class="parent" href="#"><i class="icon-file-alt"></i> Pages</a>
                                                                    <ul class="sub-menu">
                                                                        <li><a href="http://www.freshdesignweb.com/responsive-drop-down-menu-jquery-css3-using-icon-symbol.html">Full Width</a></li>
                                                                        <li><a href="http://www.freshdesignweb.com/responsive-drop-down-menu-jquery-css3-using-icon-symbol.html">Left Sidebar</a></li>
                                                                        <li><a href="http://www.freshdesignweb.com/responsive-drop-down-menu-jquery-css3-using-icon-symbol.html">Right Sidebar</a></li>
                                                                        <li><a href="http://www.freshdesignweb.com/responsive-drop-down-menu-jquery-css3-using-icon-symbol.html">Double Sidebar</a></li>
                                                                    </ul>
                                                                </li>
                                                            </ul>
                                                        </li>-->

                            <li class="current-menu-item"><a href="#" onclick="cargarPaguinaAjax('ConsultaDatos/plataformaTAP.jsp', 'contentPag', true)">Datos TAP</a></li>
                                <%
                                    if (user.getId() > 0) {
                                %>
                            <li class="current-menu-item"><a href="#" onclick="cargarPaguinaAjax('ConsultaDatos/consultaDatosExterior.jsp', 'contentPag', true)">Busqueda en BD</a></li>
                            <li class="parent">
                                <a href="#2"><%=user.getNombre()%></a>
                                <ul class="sub-menu">
                                    <%  if (user.getTipoUser().equals("ADMINISTRADOR")) { %>
                                    <li><a href="AdminTAP.jsp">Panel Administrador</a></li>
                                        <%  } %>
                                    <li><a href="#1" onclick="cerrarSession()">Cerrar Session</a></li>
                                </ul>
                            </li>
                            <%
                            } else {
                            %>
                            <li><a href="login.jsp">Ingresar</a></li>
                                <%
                                    }
                                %>
                        </ul>
                    </nav>
                    <div class="clear"></div>
                </div>
            </header>	
        </div>

        <div id="contentPag" >
            <div class="flex" style="position: fixed;width: 100%;">
                <section class="slider-pages"  >

                    <article class="js-scrolling__page js-scrolling__page-1 js-scrolling--active">
                        <div class="slider-page slider-page--left">
                            <div class="slider-page--skew">
                                <div class="slider-page__content">
                                </div>
                                <!-- /.slider-page__content -->
                            </div>
                            <!-- /.slider-page--skew -->
                        </div>
                        <!-- /.slider-page slider-page--left -->

                        <div class="slider-page slider-page--right">
                            <div class="slider-page--skew">
                                <div class="slider-page__content">

                                    <h1 class="slider-page__title slider-page__title--big">
                                        Grupo de Investigación en Ecofisiología Vegetal &amp; Ecosistemas Terrestres (GIEFIVET)
                                    </h1>
                                    <!-- /.slider-page__title slider-page__title--big -->
                                    <h2 class="slider-page__title">
                                        INICIOS
                                    </h2>
                                    <!-- /.slider-page__title -->
                                    <p class="slider-page__description">
                                        El Grupo de Investigación en Ecofisiología Vegetal &amp; Ecosistemas Terrestres-GIEFIVET, fue creado en el 2003, centrando sus actividades investigativas, inicialmente, en el campo de la fisiología vegetal y ecofisiología vegetal tanto de especies cultivadas como silvestres. Posteriormente, con el apoyo y contribución de otros investigadores y alumnos que han hecho parte del grupo de investigación nuevas líneas de investigación han permitido la realización de estudios genético-moleculares de especies arbustivas aromáticas y evolución de plantas domesticadas; relaciones planta-microorganismos (relaciones simbióticas planta-micorrizas en sistemas de producción de palma de aceite, cacao y café) y ecología vegetal.
                                    </p>
                                    <!-- /.slider-page__description -->
                                </div>
                                <!-- /.slider-page__content -->
                            </div>
                            <!-- /.slider-page--skew -->
                        </div>
                        <!-- /.slider-page slider-page--right -->
                    </article>
                    <!-- /.js-scrolling__page js-scrolling__page-1 js-scrolling--active -->


                    <article class="js-scrolling__page js-scrolling__page-2">
                        <div class="slider-page slider-page--left">
                            <div class="slider-page--skew">
                                <div class="slider-page__content">
                                    <h1 class="slider-page__title">

                                    </h1>
                                    <!-- /.slider-page__title -->
                                    <p class="slider-page__description">
                                        Desde su creación se han mantenido contacto y alianzas con investigadores de diversas instituciones nacionales, entre las que figuran la Corporación Colombiana de Investigaciones Agropecuarias – CORPOICA, Universidad Nacional de Colombia, Universidad del Valle, Universidad de Córdoba, Instituto Alexander von Humboldt, entre otras. En el ámbito internacional, se tienen cooperaciones con investigadores de diferentes universidades de Estados Unidos (University of Illinois at Chicago, University of Louisiana at Baton Rouge; University of California at Los Angeles- UCLA); en Brasil ( Universidad Federal de Vicosa-UFV; Universidade Federal de Espirito Santo-UFES; Universidade de Londrina; Universidade Federal de Blumenau, Universidad Federal de Minas Gerais-UFMG), de Alemania ( University od Leyzip; Univesity of Bayrouth) de España (Universidad de las Islas Baleares; Universidad de Córdoba, Consejo Superior de Investigaciones Científicas-CSIC; Universidad del Pais Vasco); de Venezuela (Universidad Central de Venezuela- UCV; Universidad de los Andes-ULA).
                                    </p>
                                    <!-- /.slider-page__description -->
                                </div>
                                <!-- /.slider-page__content -->
                            </div>
                            <!-- /.slider-page--skew -->
                        </div>
                        <!-- /.slider-page slider-page--left -->

                        <div class="slider-page slider-page--right">
                            <div class="slider-page--skew">
                                <div class="slider-page__content">
                                </div>
                                <!-- /.slider-page__content -->
                            </div>
                            <!-- /.slider-page--skew -->
                        </div>
                        <!-- /.slider-page slider-page--right -->
                    </article>
                    <!-- /.js-scrolling__page js-scrolling__page-2 -->


                    <article class="js-scrolling__page js-scrolling__page-3">
                        <div class="slider-page slider-page--left">
                            <div class="slider-page--skew">
                                <div class="slider-page__content">
                                </div>
                                <!-- /.slider-page__content -->
                            </div>
                            <!-- /.slider-page--skew -->
                        </div>
                        <!-- /.slider-page slider-page--left -->

                        <div class="slider-page slider-page--right">
                            <div class="slider-page--skew">
                                <div class="slider-page__content">
                                    <h1 class="slider-page__title">
                                        <!--Final is just the beginning-->
                                    </h1>
                                    <!-- /.slider-page__title -->
                                    <p class="slider-page__description">
                                        En la actualidad, el GIEFIVET ha focalizado sus actividades en las siguientes temáticas de investigación: i) Ecofisiología de especies arbóreas caducifolias y siempre-verdes del bosque seco tropical; Regulación del crecimiento de especies arbóreas en zonas urbanas; Diversidad funcional de plantas: contribución en la dinámica y funcionamiento de bosques tropicales andinos, seco y húmedo tropical; Potencial de restauración asistida y natural afectadas por el cambio en el suelo; Regulación de la fotosíntesis y diversidad funcional de Rubisco en Solanaceas, Melatomataceae y Piperaceae ante la varicaion ambiental; Papel de la plasticidad fenotípica en la aclimtación y distribución de plantas en diferentes hábitats tropicales.
                                    </p>
                                    <!-- /.slider-page__description -->
                                </div>
                                <!-- /.slider-page__content -->
                            </div>
                            <!-- /.slider-page--skew -->
                        </div>
                        <!-- /.slider-page slider-page--right -->
                    </article>
                    <!-- /.js-scrolling__page js-scrolling__page-3 -->

                    <!-- /.js-scrolling__page js-scrolling__page-2 -->

                </section>
            </div>
        </div>
        <div id="loaderArchitic" class="row flex-parent" style="display:none"></div>
        <div class="contenedorNotificacion" id="contenedorNotificacion"> </div>

        <script src="../Plugins/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="../Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../Plugins/JQuery-UI/jquery-ui.min.js" type="text/javascript"></script>
        <script src="../Plugins/DataTables-1.10.15/media/js/jquery.dataTables.js" type="text/javascript"></script>
        <script src="../Plugins/slider/js/index.js" type="text/javascript"></script>
        <script src="../Plugins/Js/globalFunciones.js" type="text/javascript"></script>
        <!--notificacion-->
        <script src="../Plugins/NotificationStyles/js/modernizr.custom.js" type="text/javascript"></script>
        <script src="../Plugins/NotificationStyles/js/notificationFx.js" type="text/javascript"></script>
        <script src="../Plugins/NotificationStyles/js/classie.js" type="text/javascript"></script>
        <!--select-->
        <script src="../Plugins/Js/bootstrap-select.js" type="text/javascript"></script>
        <!--tablas-->

        <script>
                                        iniLoaderOndaDeCubos("Procesando");
        </script> 
        <footer>
            <!--<div class="row">-->
            <div class="col-xs-9 col-md-6 " style="background: rgba(17, 17, 17, 0.6);padding:  10px;border-radius: 5px;">

                <div class="col-xs-6 col-md-12 ">
                    <div class="col-xs-6 col-md-3 content-logo">
                        <!--                            <div class="col-md-8">-->
                        <img src="../imagen/logoGiefivet.png" class="logo">
                        <!--</div>-->
                    </div>
                    <div class="col-xs-12 col-md-6 ">
                        <span class="hidden-sm hidden-xs">Grupo de Investigación en Ecofisiología Vegetal & Ecosistemas Terrestres</span><br>
                        <span class="visible-sm visible-xs">GIEFIVET</span>
                        <span>correo@micorreo.com</span><br>
                        <span>3214534234 - 7540092 ext 203</span>
                    </div>
                </div>

                <div class="col-xs-6 col-md-12 ">
                    <div class="col-xs-8 col-md-3 content-logo">
                        <img src="../imagen/LOGO-STI-2017.png" class="logo">
                    </div>
                    <div class="col-xs-12 col-md-6 ">
                        <span class="hidden-sm hidden-xs">Grupo de sistemas y tecnologías de información</span><br>
                        <span class="visible-sm visible-xs">STI</span>
                        <span>gruposti@uis.edu.co</span><br>
                        <span>PBX: (7) 6344000 Ext. 2873-1304</span>
                    </div>
                </div>
            </div>
            <div class="col-xs-3 col-md-6">
                <div class="col-xs-12 col-md-4 col-md-offset-8 img-logo-uis" >
                    <img  src="../imagen/uisLogo.png" class="logo">
                </div>
<!--                <div class="col-xs-12">
                    Copyright © 2017
                </div>-->
            </div>
            <!--</div>-->
        </footer>
        <script>
//            $("#miacc").accordion();
//            function eliminarIfr(){
//            $("iframe").remove();
//            }
//            function cerrarSession()
//            {
//                mostrarLoaderOndaDeCubos("Saliendo ...");
//            $.ajax(
//            {
//            url: "../miLogin",
//                    type: "post",
//                    dataType: "html",
//                    data: "oper=cerrarSession&",
//                   
//                    success: function (result) {
//                    window.location.href = "../";
//                    },
//                    error: function () {
//                    ocultarLoaderOndaDeCubos();
//                    nuevaNotify('warning', 'Falla de session', 'Ha ocurrido un problema con el cierre de session', 7000);
//                    }
//            }
//            );
//            }
        </script>
    </body>

</html>
