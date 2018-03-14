<%-- 
    Document   : consultaDatosExterior
    Created on : 11-oct-2017, 11:47:24
    Author     : desarrolloJuan
--%>

<%@page import="BD.Conexion_MySQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashMap"%>
<%@page import="Modelo.Medicion"%>
<%@page import="Modelo.proyectos"%>
<%@page import="Modelo.localidad"%>
<%@page import="Modelo.Rasgo"%>
<%@page import="Modelo.taxonomia"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>

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
        padding-top: 110px;
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

<video id="video-background" style="z-index: -1; position: fixed;width: 100%;background-image: url(..//imagen/textura-troncos.jpg)" autoplay="" loop="" muted="" poster="../imagen/pattern.png" >
    <!--<source src="../imagen/lighthouse.mp4" type="video/mp4">-->
    <!--<source src="../imagen/videoDocument.mp4" type="video/mp4">-->

    <!--<source src="../imagen/video2.mp4" type="video/mp4">-->

    <!--<source src="../imagen/video2_1.mp4" type="video/mp4">-->
    Your browser does not support the <code>video</code> tag.

    <!--        <source src="../../imagen/lighthouse.mp4" type="video/mp4">
            Your browser does not support the <code>video</code> tag.-->

</video> 

<!--<section class="centrado-padre form-solicitud-acceso">-->
<div class="container-fluid center-block" style="padding: 100px 4%; ">
    <div class="col-xs-12 " style="color: #E8E8E8;">
        <h3>CONSULTAR RASGOS VEGETALES EN LA BD</h3>
        <!--<div class="centrado-hijo col-xs-11">-->
        <div class="col-md-11 row-flow panel-transparente " >
            <form action="../consultaDatosExterno" class="form-horizontal form-transparente" onsubmit="buscarDatosSegunFiltros(this); return false;">
                <input type="hidden" name="oper" value="consultaDatosExterno">
                <!--onsubmit="buscarDatosSegunFiltros(this); return false;"-->
                <div id="contenedor-filtros-principales">
                    <div class="col-xs-12 col-sm-6  col-md-3 m-b-1  conten-filtros" >
                        <div class="form-group">
                            <input type="checkbox" id="chek_1" name="filtro" value="filtroFechas" class="check-transparente check-filtro" data-toggle="collapse" data-target="#filtroFechasContent" />
                            <label for="chek_1">Filtrar por fecha</label>
                        </div>
                        <div id="filtroFechasContent" class=" animate bounceIn collapse ">
                            <div class="col-sm-6 col-md-12">
                                <!--<label for="fecIni"> Fecha Inicial</label>-->
                                Fecha inicial
                                <input id="fecIni" type="date" name="fechaInicial" class="input-transparente input-sm form-control" style="padding-right: 1px;">
                            </div>
                            <div class="col-sm-6 col-md-12">
                                <!--<label for="fecFin">Fecha Final</label>-->
                                Fecha final
                                <input id="fecFin" type="date" name="fechaFinal" class="input-transparente input-sm form-control" style="padding-right: 1px;">
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-12 col-sm-6  col-md-3 m-b-1 conten-filtros" >

                        <div class="form-group" >

                            <input type="checkbox" name="filtro" value="filtroLocalidad" id="check_localidad"  class="check-transparente  check-filtro" data-toggle="collapse" data-target="#filtroLocalidadContent"> 
                            <label  for="check_localidad" class="lbl-check">Filtrar por localidad</label>
                        </div>
                        <div id="filtroLocalidadContent" class="collapse">
                            Seleccione las localidades de su interes 
                            <select name="LocalidadBusqueda"  class="selectpicker form-control select-transparente" data-style="input-transparente" id="selectLocalidad"  data-live-search="true" multiple onchange="selectLocalidadChange(this, 'selectEspecie');">

                                <%
                                    Connection conn = null;
                                    if (session.getAttribute("connMySql") == null) {
                                        conn = Conexion_MySQL.conectar2();
                                        session.setAttribute("connMySql", conn);
                                    } else {
                                        conn = (Connection) session.getAttribute("connMySql");
                                    }
                                    ArrayList<localidad> listLocalidades = localidad.getLocalidadesList(conn);
                                    for (localidad miLocal : listLocalidades) {
                                %>
                                <option value="<%=miLocal.getIdlocalidad()%>"><%=miLocal.getNombre()%></option>
                                <%
                                    }
                                %>

                            </select>

                        </div>
                    </div>

                    <div class="col-xs-12 col-sm-6  col-md-3 m-b-1  conten-filtros" >

                        <div class="form-group" >
                            <input type="checkbox" name="filtro" value="filtroEspecie" id="check_2"  class="check-transparente check-filtro" data-toggle="collapse" data-target="#filtroEspecieContent"> 
                            <label  for="check_2" class="lbl-check">Filtrar por especie</label>
                        </div>
                        <div id="filtroEspecieContent" class="collapse">
                            Seleccione las especies de interes 
                            <select name="especieBusqueda"  class="selectpicker form-control select-transparente" data-style="input-transparente" id="selectEspecie"  data-live-search="true" multiple onchange="selectEspecieChange(this, 'selectRasgosBusqueda');">

                                <%
                                    ArrayList<taxonomia> listEspecies = taxonomia.getEspeciesList(conn);
                                    for (taxonomia miTax : listEspecies) {
                                %>
                                <option value="<%=miTax.getIdespecie()%>"><%=miTax.getEspecie()%> [<%=miTax.getNombreComun()%>]</option>
                                <%
                                    }
                                %>

                            </select>

                        </div>
                    </div>

                    <div class="col-xs-12 col-sm-6  col-md-3 m-b-1  conten-filtros" >

                        <div class="form-group" >

                            <input type="checkbox" name="filtro" value="filtroRasgos" id="check_3"  class="check-transparente check-filtro" data-toggle="collapse" data-target="#filtroRasgoContent"> 
                            <label  for="check_3" class="lbl-check">Filtrar por rasgos</label>
                        </div>
                        <div id="filtroRasgoContent" class="collapse">
                            Seleccione los Rasgos 
                            <select id="selectRasgosBusqueda" name="rasgoBusqueda"  class="selectpicker form-control select-transparente" data-style="input-transparente"   data-live-search="true" multiple >

                                <%
                                    ArrayList<Rasgo> listRasgo = Rasgo.getRasgosList(conn);
                                    for (Rasgo mirasgo : listRasgo) {
                                %>
                                <option value="<%=mirasgo.getIdrasgo()%>"><%=mirasgo.getNombre()%> (<%=mirasgo.getUnidad()%>)</option>
                                <%
                                    }
                                %>

                            </select>

                        </div>
                    </div>
                </div>
                <div class="col-md-12" style="border-top: 1px solid #F9F9F9;padding-top: 10px;margin-top: 10px;">
                    <div class="row" >
                        <p>InformaciÛn adicional: puede seleccionar de los siguiente datos climaticos cuales son de su interes, o si desea conocer los datos de la ubicacion de cada individuo (Localidad).</p>
                    </div>
                    <div class="form-group col-sm-4 col-xs-6" >
                        <input type="checkbox" name="filtro" value="tempPromedio" id="check_temp"  class="check-transparente" > 
                        <label  for="check_temp" class="lbl-check">Temperatura promedio</label>
                    </div>
                    <div class="form-group col-sm-4 col-xs-6" >
                        <input type="checkbox" name="filtro" value="tempMin" id="check_tempMin"  class="check-transparente" > 
                        <label  for="check_tempMin" class="lbl-check">Temperatura minima</label>
                    </div>
                    <div class="form-group col-sm-4 col-xs-6" >
                        <input type="checkbox" name="filtro" value="tempMax" id="check_tempMax"  class="check-transparente" > 
                        <label  for="check_tempMax" class="lbl-check">Temperatura maxima</label>
                    </div>
                    <div class="form-group col-sm-4 col-xs-6" >
                        <input type="checkbox" name="filtro" value="humedad" id="check_humedad"  class="check-transparente" > 
                        <label  for="check_humedad" class="lbl-check">Humedad</label>
                    </div>
                    <div class="form-group col-sm-4 col-xs-6" >
                        <input type="checkbox" name="filtro" value="lluvia" id="check_lluvia"  class="check-transparente" > 
                        <label  for="check_lluvia" class="lbl-check">PrecipitaciÛn</label>
                    </div>
                    <div class="form-group col-sm-4 col-xs-6" >
                        <input type="checkbox" name="filtro" value="radiacion" id="check_radiacion"  class="check-transparente" > 
                        <label  for="check_radiacion" class="lbl-check">RadiaciÛn</label>
                    </div>
                    <div class="form-group col-sm-4 col-xs-6" >
                        <input type="checkbox" name="filtro" value="infoLocalidad" id="check_infoLocalidad"  class="check-transparente" > 
                        <label  for="check_infoLocalidad" class="lbl-check">Informacion de la localidad</label>
                    </div>
                    <div class="form-group col-xs-12 line">
                        <button type="submit" class="btn btn-sm input-transparente " >
                            <i class="fa fa-search"></i> Buscar
                        </button>
                    </div>
                </div>
            </form>                
        </div>
        <br>
        <div class="col-md-11  panel-transparente " >

            <!--<input type="submit" value="Buscar" class="btn btn-sm input-transparente col-sm-3" >-->
            <div class="title col-xs-12 panel-transparente m-b-1" id="resultadosBusqueda">
                <h4>RESULTADO BUSQUEDA</h4>
                <!--                <button class="btn input-transparente" onclick="">
                                    agregar botones
                                </button>-->
<div class="menuHoverTabla" style="display: none;">
                            <button class="btn btn-xs input-transparente" title="Eliminar"><i class="fa fa-times"></i></button>
                        </div>
                <div class="table-responsive content-table-transparente" id="contenedorResultadoConsulta">

                </div>
                <div class="col-md-8 col-md-offset-2" style="color: #FFF!important">
                    <div class="table-responsive content-table-transparente " id="contenedorLocalidades">
                        <br>
                        <h3>InformaciÛn  localidades</h3>
                        
                        <table class="table-transparente table" id="tablaLocalidades">
                            <thead>
                            <th>codigo</th>
                            <th>Localidad</th>
                            <th>Latitud</th>
                            <th>Longitud</th>
                            <th>Altitud</th>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-12 panel-transparente m-b-1 " id="graficaResultado">
                <div class="col-md-9 col-xs-12 contenedorDatosGrafica">
                    <br>
                    <h4>GRAFICAR</h4>
                    <div class="col-xs-11 col-md-11 datosGrafica">
                        <div class="col-xs-4 col-lg-3">
                            nombre Datos
                            <input class="input-transparente input-sm form-control" type="text" name="nombreDato" value="Grafica 1">
                        </div>
                        <div class="col-xs-3 col-lg-4">
                            Datos eje X
                            <select name="selectDatos_x" class="selectpicker form-control select-transparente  " data-style="input-transparente input-sm"></select>
                            <!--<select id="selectDatos_x" class="selectpicker form-control select-transparente  " data-style="input-transparente input-sm"></select>-->
                        </div>
                        <div class="col-xs-3 col-lg-4">
                            Datos eje Y
                            <select name="selectDatos_y" class="selectpicker form-control select-transparente" data-style="input-transparente input-sm"></select>
                            <!--<select id="selectDatos_y" class="selectpicker form-control select-transparente" data-style="input-transparente input-sm"></select>-->
                        </div>

                        <br>
                        <div class="btn-group">
                            <button class="btn btn-sm input-transparente btn-round btnAgregarDatos"  >
                                <i class="fa fa-plus-circle"></i>
                            </button>
                            <button class="btn btn-sm input-transparente btn-round btnEliminarDatos"  >
                                <i class="fa fa-minus-circle"></i>
                            </button>
                        </div>

                    </div>
                    <div class="">
                        <br>
                        <button id="btnGraficarDispersion" class="btn btn-sm input-transparente">
                            <i class="fa fa-line-chart"></i> 
                        </button>

                    </div>
                    <div id="nuevosDatosGraficaLinea"></div>
                </div>
                <div class="col-xs-12 col-md-3 ">
                    <div class="col-xs-11 col-md-9" style="padding-right: 0px;">
                        Selecciones los datos:
                        <select name="selectDatosLineas" class="selectpicker form-control select-transparente" data-style="input-transparente input-sm" multiple ></select>

                    </div>
                    <div class="">
                        <br>
                        <button id="btnGraficarLineas" class="btn btn-sm input-transparente">
                            <i class="fa fa-area-chart"></i> 
                        </button>
                    </div>
                </div>

                <div class="panel-transparente col-xs-12" style="background: #fff;">
                    <div id="graficaDispersion" class="col-xs-12" ></div>

                </div>
                <div class="form-group">
                    <table class="table-transparente" id="tablaResultadoGrafica">
                        <!--<thead><tr><th></th></tr></thead>-->
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <!--
                                        <div class="form-group">
                                            <input type="checkbox" id="chek_1" name="demo-copy" class="check-transparente" />
                                            <label for="chek_1">Email a copy</label>
                                        </div>-->


        </div>

    </div >
</div>


<!-- ECharts -->
<!--<script src="../Plugins/Js/echarts.js" type="text/javascript"></script>-->
<script src="../Plugins/Js/ecStat.min.js" type="text/javascript"></script>
<script src="../Plugins/Js/echarts.min.js" type="text/javascript"></script>
<!--</section>-->
<script>
                                $b0 = 0;
                                $b1 = 0;
                                $('.selectpicker').selectpicker('show');
                                $('.btnAgregarDatos').on('click', function () {
                                    btnAgregarDatosGrafica_click();
                                });
                                $('.btnEliminarDatos').on('click', function (e) {
                                    btnEliminarDatosGrafica_click(e);
                                });
                                $('#contenedor-filtros-principales').find('.conten-filtros').each(function () {

                                    var comboBoxs = $(this).find('select');
                                    $(this).find('.check-filtro').on('click', function () {

                                        console.log('ejecutando funcion de agregar required');
                                        if ($(this).is(':checked')) {
                                            console.log('checkeado');
                                            comboBoxs.each(function () {
                                                console.log('el select era ' + $(this).attr('required'));
                                                $(this).attr('required', 'required');
                                                console.log('el select es ' + $(this).attr('required'));
                                            });
                                        } else {
                                            console.log('sin checkear !! ');
                                            comboBoxs.each(function () {
                                                console.log('el select era ' + $(this).attr('required'));
                                                $(this).removeAttr('required');
                                                console.log('el select ahora es ' + $(this).attr('required'));
                                            });
                                        }
                                    });
                                });

                                function ocultarResultados() {
                                    $("#resultadosBusqueda").css("display", "none");
                                    $("#graficaResultado").css("display", "none");
                                }
                                function mostrarResultados() {
                                    $("#resultadosBusqueda").css("display", "block");
                                    $("#graficaResultado").css("display", "block");
                                }
                                function buscarDatosSegunFiltros(formulario) {
                                    var continuar = false;
                                    ocultarResultados();
                                    var index = 1;
                                    $("#contenedor-filtros-principales").find("input[type=checkbox]").each(function () {
                                        if ($(this).prop('checked')) {
                                            switch (index) {
                                                case 1:
                                                    {
                                                        console.log("fechIni" + $("#fecIni").val());
                                                        if ($("#fecIni").val() != "" && $("#fecFin").val() != "")
                                                            continuar = true;
                                                    }
                                                    break;
                                                case 2:
                                                    {
                                                        console.log($("#selectLocalidad").val());
                                                        if ($("#selectLocalidad").val().length > 0)
                                                            continuar = true;
                                                    }
                                                    break;
                                                case 3:
                                                    {
                                                        console.log($("#selectEspecie").val());
                                                        if ($("#selectEspecie").val().length > 0)
                                                            continuar = true;
                                                    }
                                                    break;
                                                case 4:
                                                    {
                                                        console.log($("#selectRasgosBusqueda").val());
                                                        if ($("#selectRasgosBusqueda").val().length > 0)
                                                            continuar = true;
                                                    }
                                                    break;
                                                default :
                                                    break;
                                            }
//                                continuar = true;
                                        }
                                        index++;
                                    });
                                    if (continuar) {
//                            $("#contenedorResultadoConsulta").html("<i> Sin Resultados para la consulta... </i><br> Verifique los filtros y realizae nuevamente la busqueda. ");
//             nuevaNotify("notice","listos Check","ya se puede enviar el formulario",10000);

                                        evioFormularioServlet(formulario, 'contenedorResultadoConsulta', true);
                                        return false;
                                    } else {
                                        nuevaNotify("error", "Filtros vacios", "Debe seleccionar al menos uno de los criterios de busqueda. verifique", 10000);
                                    }
                                }

                                function selectEspecieChange(selectEspecie, idRemplazoSelect) {
                                    $formulario = $(selectEspecie).parents("form");
//        $($formulario).children("input[name=oper]").val("seleccionEspecieBuscarRasgos");
//        $(selectEspecie).parents("form").submit();
                                    var valorSelect = "" + $('select[name=especieBusqueda]').serialize();
//        alert($($formulario).attr("action")+'?');
                                    $.ajax({
                                        url: $($formulario).attr("action") + '?',
                                        type: "post",
                                        dataType: "html",
                                        data: "oper=seleccionEspecieBuscarRasgos&" + valorSelect,
                                        cache: false,
                                        processData: false,
                                        success: function (result) {
                                            $("#" + idRemplazoSelect).html(result);
                                            $('#' + idRemplazoSelect).selectpicker('refresh');
                                            ocultarLoaderOndaDeCubos();
                                        },
                                        error: function () {
                                            ocultarLoaderOndaDeCubos();
                                            nuevaNotify('error', 'Error', 'Ha ocurrido un error al buscar los rasgos asociados a las especies', 9000);
                                        }
                                    });
                                }

                                function selectLocalidadChange(selectLocalidad, idRemplazoSelect) {
                                    $formulario = $(selectLocalidad).parents("form");
                                    var valorSelect = "" + $(selectLocalidad).serialize();
                                    $.ajax({
                                        url: $($formulario).attr("action") + '?',
                                        type: "post",
                                        dataType: "html",
                                        data: "oper=seleccionLocalidadBuscarEspecie&" + valorSelect,
                                        cache: false,
                                        processData: false,
                                        success: function (result) {
                                            $("#" + idRemplazoSelect).html(result);
                                            $('#' + idRemplazoSelect).selectpicker('refresh');
                                            ocultarLoaderOndaDeCubos();
                                        },
                                        error: function () {
                                            ocultarLoaderOndaDeCubos();
                                            nuevaNotify('error', 'Error', 'Ha ocurrido un error al buscar los rasgos asociados a las especies', 9000);
                                        }
                                    });
                                }

                                function evioFormularioServlet(formulario, idContRespuesta, remplazarContenido) {
                                    mostrarLoaderOndaDeCubos('Procesando...');
                                    console.log($(formulario).serialize());
                                    $.ajax({
                                        url: $(formulario).attr("action"),
                                        type: "post",
                                        dataType: "html",
                                        data: $(formulario).serialize(),
                                        cache: false,
                                        processData: false,
                                        success: function (result) {
                                            if (remplazarContenido) {
                                                $("#" + idContRespuesta).html(result);
                                            } else {
                                                $("#" + idContRespuesta).append(result);
                                            }
                                            ocultarLoaderOndaDeCubos();
                                        },
                                        error: function () {
                                            ocultarLoaderOndaDeCubos();
                                            nuevaNotify('error', 'Error', 'Ha ocurrido un error en el envio del formulario; intentelo mas tarde', 9000);
                                        }
                                    });
                                }

                                function cargarSelectGrafica(idCampos, nombreCampos) {
                                    $tabla = $("#tablaResultado").find("th");
                                    var indexTh = 0;
                                    $("select[name=selectDatos_x]").html("");
                                    $("select[name=selectDatos_y]").html("");
                                    $("select[name=selectDatosLineas]").html("");
                                    for (var j = $(".datosGrafica").length; j > 0; j--) {
                                        $($(".datosGrafica")[j]).remove();
                                    }
//        $tabla.each(function (){
//            if(indexTh > 2){
//                $("#selectDatos_x").append('<option value="'+indexTh+'">'+$(this).html()+'</option>');
//                $("#selectDatos_y").append('<option value="'+indexTh+'">'+$(this).html()+'</option>');
//            }
//            indexTh++;
//        });
                                    $(nombreCampos).each(function () {
                                        var nombre = this;
                                        var indexSelect = 0;
                                        $("select[name=selectDatos_x]").append('<option value="' + idCampos[indexTh] + '">' + this + '</option>');
                                        $("select[name=selectDatos_y]").append('<option value="' + idCampos[indexTh] + '">' + this + '</option>');
                                        $("select[name=selectDatosLineas]").append('<option value="' + idCampos[indexTh] + '">' + this + '</option>');
                                        indexTh++;
                                    });
                                    $("select[name=selectDatos_x]").selectpicker("refresh");
                                    $("select[name=selectDatos_y]").selectpicker("refresh");
                                    $("select[name=selectDatosLineas]").selectpicker("refresh");
                                }

                                function leerColumnaTabla(idTabla, indexColumna) {
                                    var respuesta = "";
                                    //seleccionamos la fila correcta segun el index
                                    $("#" + idTabla + " tr").find('td:eq(' + indexColumna + ')').each(function () {
                                        //obtenemos el valor de la celda
                                        valor = $(this).html();
                                        respuesta = respuesta + valor + "|x|x|";
                                        //sumamos, recordar parsear, si no se concatenara.           
                                    });
                                    respuesta = respuesta.split("|x|x|");
                                    return respuesta;
                                }
                                var a = {
                                    // Èª?ËÆ§Ë?≤Êùø
                                    color: [
                                        '#757575', '#c7c7c7', '#dadada',
                                        '#8b8b8b', '#b5b5b5', '#e9e9e9'
                                    ],
                                    // Â?æË°®Ê ?È¢?
                                    title: {
                                        textStyle: {
                                            fontWeight: 'normal',
                                            color: '#757575'
                                        }
                                    },
                                    // Â?ºÂ??
                                    dataRange: {
                                        color: ['#636363', '#dcdcdc']
                                    },
                                    // Â∑•Â?∑ÁÆ±
                                    toolbox: {
                                        color: ['#757575', '#757575', '#757575', '#757575']
                                    },
                                    // ÊèêÁ§∫Ê°?
                                    tooltip: {
                                        backgroundColor: 'rgba(0,0,0,0.5)',
                                        axisPointer: {// ÂùêÊ ?ËΩ¥Ê??Á§∫Â?®Ôº?ÂùêÊ ?ËΩ¥Ëß¶Âè?Ê??Ê??
                                            type: 'line', // Èª?ËÆ§‰∏∫Á?¥Á∫øÔº?ÂèØÈ??‰∏∫Ôº?'line' | 'shadow'
                                            lineStyle: {// Á?¥Á∫øÊ??Á§∫Â?®Ê ∑ÂºèËÆæÁΩÆ
                                                color: '#757575',
                                                type: 'dashed'
                                            },
                                            crossStyle: {
                                                color: '#757575'
                                            },
                                            shadowStyle: {// È?¥ÂΩ±Ê??Á§∫Â?®Ê ∑ÂºèËÆæÁΩÆ
                                                color: 'rgba(200,200,200,0.3)'
                                            }
                                        }
                                    },
                                    // Â?∫Â??Áº©Ê?æÊ?ßÂ?∂Â?®
                                    dataZoom: {
                                        dataBackgroundColor: '#eee', // Ê?∞ÊçÆË??Ê?ØÈ¢?Ë?≤
                                        fillerColor: 'rgba(117,117,117,0.2)', // Â°´Â??È¢?Ë?≤
                                        handleColor: '#757575'     // Ê??Ê??È¢?Ë?≤
                                    },
                                    // ÁΩ?Ê º
                                    grid: {
                                        borderWidth: 0
                                    },
                                    // Á±ªÁ?ÆËΩ¥
                                    categoryAxis: {
                                        axisLine: {// ÂùêÊ ?ËΩ¥Á∫ø
                                            lineStyle: {// Â±?Ê?ßlineStyleÊ?ßÂ?∂Á∫øÊù°Ê ∑Âºè
                                                color: '#757575'
                                            }
                                        },
                                        splitLine: {// Â??È??Á∫ø
                                            lineStyle: {// Â±?Ê?ßlineStyleÔº?ËØ¶ËßÅlineStyleÔº?Ê?ßÂ?∂Á∫øÊù°Ê ∑Âºè
                                                color: ['#eee']
                                            }
                                        }
                                    },
                                    // Ê?∞Â?ºÂ??ÂùêÊ ?ËΩ¥Èª?ËÆ§Âè?Ê?∞
                                    valueAxis: {
                                        axisLine: {// ÂùêÊ ?ËΩ¥Á∫ø
                                            lineStyle: {// Â±?Ê?ßlineStyleÊ?ßÂ?∂Á∫øÊù°Ê ∑Âºè
                                                color: '#757575'
                                            }
                                        },
                                        splitArea: {
                                            show: true,
                                            areaStyle: {
                                                color: ['rgba(250,250,250,0.1)', 'rgba(200,200,200,0.1)']
                                            }
                                        },
                                        splitLine: {// Â??È??Á∫ø
                                            lineStyle: {// Â±?Ê?ßlineStyleÔº?ËØ¶ËßÅlineStyleÔº?Ê?ßÂ?∂Á∫øÊù°Ê ∑Âºè
                                                color: ['#eee']
                                            }
                                        }
                                    },
                                    timeline: {
                                        lineStyle: {
                                            color: '#757575'
                                        },
                                        controlStyle: {
                                            normal: {color: '#757575'},
                                            emphasis: {color: '#757575'}
                                        }
                                    },
                                    // KÁ∫øÂ?æÈª?ËÆ§Âè?Ê?∞
                                    k: {
                                        itemStyle: {
                                            normal: {
                                                color: '#8b8b8b', // È?≥Á∫øÂ°´Â??È¢?Ë?≤
                                                color0: '#dadada', // È?¥Á∫øÂ°´Â??È¢?Ë?≤
                                                lineStyle: {
                                                    width: 1,
                                                    color: '#757575', // È?≥Á∫øËæπÊ°?È¢?Ë?≤
                                                    color0: '#c7c7c7'   // È?¥Á∫øËæπÊ°?È¢?Ë?≤
                                                }
                                            }
                                        }
                                    },
                                    map: {
                                        itemStyle: {
                                            normal: {
                                                areaStyle: {
                                                    color: '#ddd'
                                                },
                                                label: {
                                                    textStyle: {
                                                        color: '#c12e34'
                                                    }
                                                }
                                            },
                                            emphasis: {// ‰π?Ê?ØÈ??‰∏≠Ê ∑Âºè
                                                areaStyle: {
                                                    color: '#99d2dd'
                                                },
                                                label: {
                                                    textStyle: {
                                                        color: '#c12e34'
                                                    }
                                                }
                                            }
                                        }
                                    },
                                    force: {
                                        itemStyle: {
                                            normal: {
                                                linkStyle: {
                                                    color: '#757575'
                                                }
                                            }
                                        }
                                    },
                                    chord: {
                                        padding: 4,
                                        itemStyle: {
                                            normal: {
                                                borderWidth: 1,
                                                borderColor: 'rgba(128, 128, 128, 0.5)',
                                                chordStyle: {
                                                    lineStyle: {
                                                        color: 'rgba(128, 128, 128, 0.5)'
                                                    }
                                                }
                                            },
                                            emphasis: {
                                                borderWidth: 1,
                                                borderColor: 'rgba(128, 128, 128, 0.5)',
                                                chordStyle: {
                                                    lineStyle: {
                                                        color: 'rgba(128, 128, 128, 0.5)'
                                                    }
                                                }
                                            }
                                        }
                                    },
                                    gauge: {
                                        axisLine: {// ÂùêÊ ?ËΩ¥Á∫ø
                                            show: true, // Èª?ËÆ§Ê?æÁ§∫Ôº?Â±?Ê?ßshowÊ?ßÂ?∂Ê?æÁ§∫‰∏?Âê¶
                                            lineStyle: {// Â±?Ê?ßlineStyleÊ?ßÂ?∂Á∫øÊù°Ê ∑Âºè
                                                color: [[0.2, '#b5b5b5'], [0.8, '#757575'], [1, '#5c5c5c']],
                                                width: 8
                                            }
                                        },
                                        axisTick: {// ÂùêÊ ?ËΩ¥Â∞èÊ ?ËÆ∞
                                            splitNumber: 10, // ÊØè‰ªΩsplitÁª?Â??Â§?Â∞?ÊÆµ
                                            length: 12, // Â±?Ê?ßlengthÊ?ßÂ?∂Á∫øÈ?ø
                                            lineStyle: {// Â±?Ê?ßlineStyleÊ?ßÂ?∂Á∫øÊù°Ê ∑Âºè
                                                color: 'auto'
                                            }
                                        },
                                        axisLabel: {// ÂùêÊ ?ËΩ¥Ê??Ê?¨Ê ?Á≠æÔº?ËØ¶ËßÅaxis.axisLabel
                                            textStyle: {// Â?∂‰Ω?Â±?Ê?ßÈª?ËÆ§‰ΩøÁ?®Â?®Â±?Ê??Ê?¨Ê ∑ÂºèÔº?ËØ¶ËßÅTEXTSTYLE
                                                color: 'auto'
                                            }
                                        },
                                        splitLine: {// Â??È??Á∫ø
                                            length: 18, // Â±?Ê?ßlengthÊ?ßÂ?∂Á∫øÈ?ø
                                            lineStyle: {// Â±?Ê?ßlineStyleÔº?ËØ¶ËßÅlineStyleÔº?Ê?ßÂ?∂Á∫øÊù°Ê ∑Âºè
                                                color: 'auto'
                                            }
                                        },
                                        pointer: {
                                            length: '90%',
                                            color: 'auto'
                                        },
                                        title: {
                                            textStyle: {// Â?∂‰Ω?Â±?Ê?ßÈª?ËÆ§‰ΩøÁ?®Â?®Â±?Ê??Ê?¨Ê ∑ÂºèÔº?ËØ¶ËßÅTEXTSTYLE
                                                color: '#333'
                                            }
                                        },
                                        detail: {
                                            textStyle: {// Â?∂‰Ω?Â±?Ê?ßÈª?ËÆ§‰ΩøÁ?®Â?®Â±?Ê??Ê?¨Ê ∑ÂºèÔº?ËØ¶ËßÅTEXTSTYLE
                                                color: 'auto'
                                            }
                                        }
                                    },
                                    textStyle: {
                                        fontFamily: ' Arial, Verdana, sans-serif'
                                    }
                                };

                                function graficarDispersion2(idGrafica, datosXY, ordenDatos, nombreGrafica, unidadEje_x, unidadEje_y) {
                                    console.log(datosXY);
//                            'circle', 'rectangle', 'triangle', 'diamond', 'emptyCircle', 'emptyRectangle', 'emptyTriangle', 'emptyDiamond'
//                        var a = {color: ["#1E1F1F", "#656969", "#839696", "#B7BDBD", "#D6DADA", "#52728E", "#8498A9", "#C1C9D0"], title: {itemGap: 8, textStyle: {fontWeight: "normal", color: "#408829"}}, dataRange: {color: ["#1f610a", "#97b58d"]}, toolbox: {color: ["#408829", "#408829", "#408829", "#408829"]}, tooltip: {backgroundColor: "rgba(0,0,0,0.5)", axisPointer: {type: "line", lineStyle: {color: "#408829", type: "dashed"}, crossStyle: {color: "#408829"}, shadowStyle: {color: "rgba(200,200,200,0.3)"}}}, dataZoom: {dataBackgroundColor: "#eee", fillerColor: "rgba(64,136,41,0.2)", handleColor: "#408829"}, grid: {borderWidth: 0}, categoryAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitLine: {lineStyle: {color: ["#eee"]}}}, valueAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitArea: {show: !0, areaStyle: {color: ["rgba(250,250,250,0.1)", "rgba(200,200,200,0.1)"]}}, splitLine: {lineStyle: {color: ["#eee"]}}}, timeline: {lineStyle: {color: "#408829"}, controlStyle: {normal: {color: "#408829"}, emphasis: {color: "#408829"}}}, k: {itemStyle: {normal: {color: "#68a54a", color0: "#a9cba2", lineStyle: {width: 1, color: "#408829", color0: "#86b379"}}}}, map: {itemStyle: {normal: {areaStyle: {color: "#ddd"}, label: {textStyle: {color: "#c12e34"}}}, emphasis: {areaStyle: {color: "#99d2dd"}, label: {textStyle: {color: "#c12e34"}}}}}, force: {itemStyle: {normal: {linkStyle: {strokeColor: "#408829"}}}}, chord: {padding: 4, itemStyle: {normal: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}, emphasis: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}}}, gauge: {startAngle: 225, endAngle: -45, axisLine: {show: !0, lineStyle: {color: [[.2, "#86b379"], [.8, "#68a54a"], [1, "#408829"]], width: 8}}, axisTick: {splitNumber: 10, length: 12, lineStyle: {color: "auto"}}, axisLabel: {textStyle: {color: "auto"}}, splitLine: {length: 18, lineStyle: {color: "auto"}}, pointer: {length: "90%", color: "auto"}, title: {textStyle: {color: "#333"}}, detail: {textStyle: {color: "auto"}}}, textStyle: {fontFamily: "Arial, Verdana, sans-serif"}};
                                    var g = echarts.init(document.getElementById(idGrafica), a);
                                    var fecha = new Date();
                                    var subtitulo = "TAP " + fecha.getFullYear();
                                    g.setOption({
                                        title: {text: nombreGrafica, subtext: subtitulo},
                                        tooltip: {trigger: "axis", showDelay: 10, axisPointer: {type: "cross", lineStyle: {type: "dashed", width: 1}}},
                                        legend: {data: ordenDatos},
                                        toolbox: {show: !0, feature: {saveAsImage: {show: !0, title: "Guardar Imagen"}}},
                                        calculable: !0, dataZoom: {
                                            show: true,
                                            realtime: true,
                                            start: 0,
                                            end: 100
                                        },
                                        xAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} " + unidadEje_x}}],
                                        yAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} " + unidadEje_y}}],
                                        series: datosXY}
                                    );
                                }
                                function graficarDispersionRegresion(idGrafica, datosXY, ordenDatos, nombreGrafica, unidadEje_x, unidadEje_y) {

//                            'circle', 'rectangle', 'triangle', 'diamond', 'emptyCircle', 'emptyRectangle', 'emptyTriangle', 'emptyDiamond'
//                        var a = {color: ["#1E1F1F", "#656969", "#839696", "#B7BDBD", "#D6DADA", "#52728E", "#8498A9", "#C1C9D0"], title: {itemGap: 8, textStyle: {fontWeight: "normal", color: "#408829"}}, dataRange: {color: ["#1f610a", "#97b58d"]}, toolbox: {color: ["#408829", "#408829", "#408829", "#408829"]}, tooltip: {backgroundColor: "rgba(0,0,0,0.5)", axisPointer: {type: "line", lineStyle: {color: "#408829", type: "dashed"}, crossStyle: {color: "#408829"}, shadowStyle: {color: "rgba(200,200,200,0.3)"}}}, dataZoom: {dataBackgroundColor: "#eee", fillerColor: "rgba(64,136,41,0.2)", handleColor: "#408829"}, grid: {borderWidth: 0}, categoryAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitLine: {lineStyle: {color: ["#eee"]}}}, valueAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitArea: {show: !0, areaStyle: {color: ["rgba(250,250,250,0.1)", "rgba(200,200,200,0.1)"]}}, splitLine: {lineStyle: {color: ["#eee"]}}}, timeline: {lineStyle: {color: "#408829"}, controlStyle: {normal: {color: "#408829"}, emphasis: {color: "#408829"}}}, k: {itemStyle: {normal: {color: "#68a54a", color0: "#a9cba2", lineStyle: {width: 1, color: "#408829", color0: "#86b379"}}}}, map: {itemStyle: {normal: {areaStyle: {color: "#ddd"}, label: {textStyle: {color: "#c12e34"}}}, emphasis: {areaStyle: {color: "#99d2dd"}, label: {textStyle: {color: "#c12e34"}}}}}, force: {itemStyle: {normal: {linkStyle: {strokeColor: "#408829"}}}}, chord: {padding: 4, itemStyle: {normal: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}, emphasis: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}}}, gauge: {startAngle: 225, endAngle: -45, axisLine: {show: !0, lineStyle: {color: [[.2, "#86b379"], [.8, "#68a54a"], [1, "#408829"]], width: 8}}, axisTick: {splitNumber: 10, length: 12, lineStyle: {color: "auto"}}, axisLabel: {textStyle: {color: "auto"}}, splitLine: {length: 18, lineStyle: {color: "auto"}}, pointer: {length: "90%", color: "auto"}, title: {textStyle: {color: "#333"}}, detail: {textStyle: {color: "auto"}}}, textStyle: {fontFamily: "Arial, Verdana, sans-serif"}};
                                    var g = echarts.init(document.getElementById(idGrafica), a);
                                    var fecha = new Date();
                                    var subtitulo = "TAP " + fecha.getFullYear();
                                    var data = datosXY;
                                    var myRegression = ecStat.regression('linear', data, 3);
                                    option = {
                                        title: {text: nombreGrafica, subtext: subtitulo},
                                        tooltip: {
                                            trigger: "axis", showDelay: 0, axisPointer: {type: "cross", lineStyle: {type: "dashed", width: 1}}},
                                        legend: {data: ordenDatos},
                                        toolbox: {show: !0, feature: {saveAsImage: {show: !0, title: "Guardar Imagen"}}},
                                        calculable: !0, dataZoom: {
                                            show: true,
                                            realtime: true,
                                            start: 0,
                                            end: 100
                                        },
                                        xAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} " + unidadEje_x}}],
                                        yAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} " + unidadEje_y}}],
                                        series: [{
                                                name: 'scatter',
                                                type: 'scatter',
                                                label: {
                                                    emphasis: {
                                                        show: true,
                                                        position: 'right',
                                                        textStyle: {
                                                            color: 'blue',
                                                            fontSize: 16
                                                        }
                                                    }
                                                },
                                                data: data
                                            }, {
                                                name: 'line',
                                                type: 'line',
                                                smooth: true,
                                                showSymbol: false,
                                                data: myRegression.points,
                                                markPoint: {
                                                    itemStyle: {
                                                        normal: {
                                                            color: 'transparent'
                                                        }
                                                    },
                                                    label: {
                                                        normal: {
                                                            show: true,
                                                            position: 'left',
                                                            formatter: myRegression.expression,
                                                            textStyle: {
                                                                color: '#333',
                                                                fontSize: 14
                                                            }
                                                        }
                                                    },
                                                    data: [{
                                                            coord: myRegression.points[myRegression.points.length - 1]
                                                        }]
                                                }
                                            }]
                                    };
                                    ;
                                    if (option && typeof option === "object") {
                                        g.setOption(option, true);
                                    }

//                                    g.setOption({
//                                        title: {text: nombreGrafica, subtext: subtitulo},
//                                        tooltip: {
//                                            trigger: "axis", showDelay: 0, axisPointer: {type: "cross", lineStyle: {type: "dashed", width: 1}}},
//                                        legend: {data: ordenDatos},
//                                        toolbox: {show: !0, feature: {saveAsImage: {show: !0, title: "Guardar Imagen"}}},
//                                        calculable: !0, dataZoom: {
//                                            show: true,
//                                            realtime: true,
//                                            start: 0,
//                                            end: 100
//                                        },
//                                        xAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} " + unidadEje_x}}],
//                                        yAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} " + unidadEje_y}}],
//                                        series: datosXY}
//                                    );
                                }


                                function graficarLineas(idGrafica, serieLineas, ordenDatos, labelAxes) {
                                    console.log(serieLineas);
//                        var a = {color: ["rgba(95, 97, 97, 0.62)", "#656969", "#c3cece", "#a8a9a9", "#D6DADA", "#52728E", "#8498A9", "#C1C9D0"], 
//                            title: {itemGap: 8, textStyle: {fontWeight: "normal", color: "#408829"}}, 
//                            dataRange: {color: ["#1f610a", "#97b58d"]}, 
//                            toolbox: {color: ["#408829", "#408829", "#408829", "#408829"]}, 
//                            tooltip: {backgroundColor: "rgba(0,0,0,0.5)", 
//                                axisPointer: {type: "line", lineStyle: {color: "#408829", type: "dashed"}, crossStyle: {color: "#408829"}, shadowStyle: {color: "rgba(200,200,200,0.3)"}}}, 
//                            dataZoom: {dataBackgroundColor: "#eee", fillerColor: "rgba(64,136,41,0.2)", handleColor: "#408829"}, 
//                            grid: {borderWidth: 0}, 
//                            categoryAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitLine: {lineStyle: {color: ["#eee"]}}}, 
//                            valueAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitArea: {show: !0, areaStyle: {color: ["rgba(250,250,250,0.1)", "rgba(200,200,200,0.1)"]}}, splitLine: {lineStyle: {color: ["#eee"]}}}, 
//                            timeline: {lineStyle: {color: "#408829"}, controlStyle: {normal: {color: "#408829"}, emphasis: {color: "#408829"}}}, 
//                            k: {itemStyle: {normal: {color: "#68a54a", color0: "#a9cba2", lineStyle: {width: 1, color: "#408829", color0: "#86b379"}}}}, 
//                            map: {itemStyle: {normal: {areaStyle: {color: "#ddd"}, label: {textStyle: {color: "#c12e34"}}}, emphasis: {areaStyle: {color: "#99d2dd"}, label: {textStyle: {color: "#c12e34"}}}}}, 
//                            force: {itemStyle: {normal: {linkStyle: {strokeColor: "#408829"}}}}, 
//                            chord: {padding: 4, itemStyle: {normal: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}, emphasis: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}}}, 
//                            gauge: {startAngle: 225, endAngle: -45, axisLine: {show: !0, lineStyle: {color: [[.2, "#86b379"], [.8, "#68a54a"], [1, "#408829"]], width: 8}}, axisTick: {splitNumber: 10, length: 12, lineStyle: {color: "auto"}}, axisLabel: {textStyle: {color: "auto"}}, splitLine: {length: 18, lineStyle: {color: "auto"}}, pointer: {length: "90%", color: "auto"}, title: {textStyle: {color: "#333"}}, detail: {textStyle: {color: "auto"}}}, 
//                            textStyle: {fontFamily: "Arial, Verdana, sans-serif"}};
//                            
//                        var a = {color: ["#1E1F1F", "#656969", "#839696", "#B7BDBD", "#D6DADA", "#52728E", "#8498A9", "#C1C9D0"], title: {itemGap: 8, textStyle: {fontWeight: "normal", color: "#408829"}}, dataRange: {color: ["#1f610a", "#97b58d"]}, toolbox: {color: ["#408829", "#408829", "#408829", "#408829"]}, tooltip: {backgroundColor: "rgba(0,0,0,0.5)", axisPointer: {type: "line", lineStyle: {color: "#408829", type: "dashed"}, crossStyle: {color: "#408829"}, shadowStyle: {color: "rgba(200,200,200,0.3)"}}}, dataZoom: {dataBackgroundColor: "#eee", fillerColor: "rgba(64,136,41,0.2)", handleColor: "#408829"}, grid: {borderWidth: 0}, categoryAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitLine: {lineStyle: {color: ["#eee"]}}}, valueAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitArea: {show: !0, areaStyle: {color: ["rgba(250,250,250,0.1)", "rgba(200,200,200,0.1)"]}}, splitLine: {lineStyle: {color: ["#eee"]}}}, timeline: {lineStyle: {color: "#408829"}, controlStyle: {normal: {color: "#408829"}, emphasis: {color: "#408829"}}}, k: {itemStyle: {normal: {color: "#68a54a", color0: "#a9cba2", lineStyle: {width: 1, color: "#408829", color0: "#86b379"}}}}, map: {itemStyle: {normal: {areaStyle: {color: "#ddd"}, label: {textStyle: {color: "#c12e34"}}}, emphasis: {areaStyle: {color: "#99d2dd"}, label: {textStyle: {color: "#c12e34"}}}}}, force: {itemStyle: {normal: {linkStyle: {strokeColor: "#408829"}}}}, chord: {padding: 4, itemStyle: {normal: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}, emphasis: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}}}, gauge: {startAngle: 225, endAngle: -45, axisLine: {show: !0, lineStyle: {color: [[.2, "#86b379"], [.8, "#68a54a"], [1, "#408829"]], width: 8}}, axisTick: {splitNumber: 10, length: 12, lineStyle: {color: "auto"}}, axisLabel: {textStyle: {color: "auto"}}, splitLine: {length: 18, lineStyle: {color: "auto"}}, pointer: {length: "90%", color: "auto"}, title: {textStyle: {color: "#333"}}, detail: {textStyle: {color: "auto"}}}, textStyle: {fontFamily: "Arial, Verdana, sans-serif"}};
                                    var f = echarts.init(document.getElementById(idGrafica), a);
                                    var fecha = new Date();
                                    var subtitulo = "GIEFIVET " + fecha.getFullYear();
                                    f.setOption({
                                        title: {
                                            text: 'Grafica Lineal',
                                            subtext: subtitulo
                                        },
                                        tooltip: {
                                            trigger: 'axis'
                                        },
                                        legend: {
                                            data: ordenDatos
                                        },
                                        toolbox: {
                                            show: true,
                                            feature: {
                                                mark: {show: true},
//                                    dataView: {show: true, readOnly: false, title: "Ver datos"},
                                                magicType: {show: true, type: ['line', 'bar'], title: {line: "Lineas", bar: "Barras"}},
                                                restore: {show: true, title: "Restaurar"},
                                                saveAsImage: {show: true, title: "Guardar"}
                                            }
                                        },
                                        calculable: true,
                                        xAxis: [
                                            {
                                                type: 'category',
                                                boundaryGap: false,
                                                data: labelAxes
                                            }
                                        ],
                                        yAxis: [
                                            {
                                                type: 'value',
                                                axisLabel: {
                                                    formatter: '{value}'
                                                }
                                            }
                                        ],
                                        series: serieLineas
                                    });
//                        f.setOption({
//                            title: {text: "Line Graph", subtext: "Subtitle"},
//                            tooltip: {trigger: "axis"},
//                            legend: {x: 220, y: 40, data: ordenDatos},
//                            toolbox: {show: !0, 
//                            feature: {magicType: {show: !0, title: {line: "Line", bar: "Bar", stack: "Stack", tiled: "Tiled"}, type: ["line", "bar", "stack", "tiled"]}, 
//                            restore: {show: !0, title: "Restore"}, 
//                            saveAsImage: {show: !0, title: "Guardar Imagen"}}},
//                            calculable: !0, dataZoom: {
//                                show: true,
//                                realtime: true,
//                                start: 0,
//                                end: 100
//                            },
//                            xAxis: [{type: "category", boundaryGap: !1, data: labelAxes}],
//                            yAxis: [{type: "value"}],
//                            series: serieLineas
//                        })

//                            'circle', 'rectangle', 'triangle', 'diamond', 'emptyCircle', 'emptyRectangle', 'emptyTriangle', 'emptyDiamond'

                                }
                                /**
                                 * Agrega los botones de leiminar row a la tabla 
                                 * @param {type} idtabla
                                 * @returns {undefined}
                                 */


                                function agregarMenuHoverTabla(idtabla) {
                                    $("#" + idtabla + " tbody").find("tr").each(function () {
//                            $td = $("<td/>").append($("<input/>"));
//                            $(this).append($td);

                                        $(this).hover(function () {
                                            var posicion = $(this).position();
//                                            var height = $(this).outerHeight(true);
                                            indexRow = $(this).index();
                                            Row = $(this);
                                            console.log("index: " + $(this).index() + ", left: " + posicion.left + ", top: " + posicion.top);
//            console.log($(this).index());
                                            var posicX = (86 + posicion.top) + "px";
                                            var posicy = (-5 + posicion.left) + "px";
//                                var posicy = (30 + width + posicion.left) + "px";
                                            $(".menuHoverTabla").css("top", posicX);
                                            $(".menuHoverTabla").css("left", posicy);
                                            $(".menuHoverTabla").css("display", "block");
                                            $(".menuHoverTabla").on("click", function () {
//                                    var tabla = $.fn.dataTable.isDataTable( '#tablaResultado' );
                                                $(".menuHoverTabla").css("display", "none");
                                                $(Row).attr("class", "selected");
//                                   
                                                var table = $('#tablaResultado').DataTable();
//                                                var rows = table
//                                                        .rows('.selected')
//                                                        .remove()
//                                                        .draw();
                                            });
                                        });
                                    });
                                }

                                $("#btnGraficarDispersion").on("click", function () {
                                    var series = [];
                                    var ordenDatos = [];
                                    var symbolo = ['circle', 'rectangle', 'triangle', 'diamond', 'emptyCircle', 'emptyRectangle', 'emptyTriangle', 'emptyDiamond'];
                                    var datosGrafica = $(".datosGrafica");
                                    var numbsaltos = 3;
                                    if ($('#check_infoLocalidad').is(':checked'))
                                        numbsaltos = 4;
//                                    var datosXY = [];
//                        console.log("datos grafica numero " + $(datosGrafica).length);
                                    $("#tablaResultadoGrafica").find("tbody").html("");
                                    for (var i = 0; i < $(datosGrafica).length; i++) {
                                        var rasgosSelectX = $(datosGrafica).find("select[name=selectDatos_x]")[i];
                                        var rasgosSelectY = $(datosGrafica).find("select[name=selectDatos_y]")[i];
//                            var nombGrafica = $($(rasgosSelectX).find("option")[rasgosSelectX.selectedIndex]).html() +
                                        " vs " + $($(rasgosSelectY).find("option")[rasgosSelectY.selectedIndex]).html();
                                        datosRasgoX = leerColumnaTabla("tablaResultado", rasgosSelectX.selectedIndex + numbsaltos);
                                        datosRasgoY = leerColumnaTabla("tablaResultado", rasgosSelectY.selectedIndex + numbsaltos);
//                                  alert(datosRasgoX[0]);
                                        var datosXY = [];

                                        /* +++ variables para regresion +++*/
//                                        var b0 = 0;
//                                        var b1 = 0;
                                        var zumaXY = 0;
                                        var zumaX = 0;
                                        var zumaY = 0;
                                        var zumaX2 = 0;
                                        var zumaY2 = 0;
                                        var maximoX = datosRasgoX[0];
                                        var minimoX = datosRasgoX[0];
                                        for (var k = 0; k < datosRasgoX.length; k++) {
                                            var datox = 1 * (datosRasgoX[k]);
                                            var datoy = 1 * (datosRasgoY[k]);
                                            datosXY.push([datox, datoy]);
                                            /*  ------------- Calcular variacion R2  --------------- */
                                            zumaX += 1 * (datosRasgoX[k]);
                                            zumaY += 1 * (datosRasgoY[k]);
                                            zumaX2 += (datosRasgoX[k] * datosRasgoX[k]);
                                            zumaY2 += (Math.pow(datosRasgoY[k], 2));
                                            zumaXY += (datosRasgoX[k] * datosRasgoY[k]);
                                            /* --------------  Fin calculo R2 --------------- */
                                            if (maximoX < 1 * datosRasgoX[k])
                                                maximoX = 1 * datosRasgoX[k];
                                            if (minimoX > 1 * datosRasgoX[k])
                                                minimoX = 1 * datosRasgoX[k];
                                        }
                                        var n = datosXY.length - 1;
//                                         var promX = zumaX/n;
//                                         var promY = zumaY/n;
                                        $b1 = (zumaXY - ((zumaX * zumaY) / n)) / (zumaX2 - (Math.pow(zumaX, 2) / n));
                                        $b0 = (zumaY / n) - ($b1 * (zumaX / n));
                                        var correlacion = (n * (zumaXY) - (zumaX * zumaY)) / (Math.sqrt(n * zumaX2 - Math.pow(zumaX, 2)) * Math.sqrt(n * zumaY2 - Math.pow(zumaY, 2)));
                                        correlacion = Math.pow(correlacion, 2);
                                        var datosRegresion = [];
                                        datosRegresion.push([0, eval("$b0 + $b1*0")]);
                                        for (var z = 0; z < datosRasgoX.length; z++) {
                                            datosRegresion.push([datosRasgoX[z], eval("$b0 + $b1*datosRasgoX[z]")]);
                                        }
                                        maximoX = maximoX + ((maximoX - minimoX) / datosRasgoX.length);
                                        datosRegresion.push([maximoX, eval("$b0 + $b1*maximoX")]);
                                        console.log(datosRegresion);
                                        alert("zumaX " + zumaX + "\n" + "zumaY " + zumaY + "\n" + "zumaXY " + zumaXY + "\n" + "zumaX2 " + zumaX2 + "\n" + "zumaY2 " + zumaY2 + "\n" + "correlacion r2 " + correlacion.toFixed(4) + "\n" + "bo = " + $b0 + "\n" + "b1 = " + $b1 + "\n" + " N = " + n);
                                        var nombDatos = $($(".datosGrafica")[i]).find("input[name=nombreDato]").val();
                                        ordenDatos.push(nombDatos);
                                        $("#tablaResultadoGrafica").find("tbody").append("<tr><th>" + nombDatos + "</th></tr><tr><td>R<sup>2</sup></td><td>" + correlacion.toFixed(4) + "</td></tr>\n\
                            <tr><td>Recta</td><td> y = " + $b0.toFixed(4) + " + " + $b1.toFixed(4) + "x </td></tr>");

//                            console.log("nombreDatos " + nombDatos);
                                        var serie = {name: nombDatos, type: "scatter", symbol: symbolo[i], //'circle', 'rectangle', 'triangle', 'diamond', 'emptyCircle', 'emptyRectangle', 'emptyTriangle', 'emptyDiamond'
                                            tooltip: {trigger: "item", formatter: function (a) {
                                                    return a.value.length > 1 ? a.seriesName + " :<br/>" + a.value[0] + rasgosSelectX.value + " " + a.value[1] + " " + rasgosSelectY.value : a.seriesName + " :<br/>" + a.name + " : " + a.value + " " + rasgosSelectY.value
                                                }}, data: datosXY,
//                                            markLine: {data: [{type: "average", name: "Promedio"}]}
                                        };
////                            console.log("serie " + serie);
//                                        series.push(serie);
//var data = datosXY;
//console.log(data);
//var myRegression = ecStat.regression('linear', data);
//  var serie = {
//        name: nombDatos,
//        type: 'scatter',symbol: symbolo[i],
//        label: {
//            emphasis: {
//                show: true,
//                position: 'right',
//                textStyle: {
//                    color: 'blue',
//                    fontSize: 16
//                }
//            }
//        },
//        data: data
//    };
                                        series.push(serie);
                                        serie = {
                                            name: 'ResgreciÛn ' + nombDatos,
                                            type: 'line',
                                            smooth: true,
                                            showSymbol: true,
                                            data: datosRegresion,
//        data: myRegression.points,
//        markPoint: {
//            itemStyle: {
//                normal: {
//                    color: 'transparent'
////                    color: 'red'
//                }
//            },
//            label: {
//                normal: {
//                    show: true,
//                    position: 'right',
//                    formatter: myRegression.expression,
//                    textStyle: {
//                        color: '#333',
//                        fontSize: 14
//                    }
//                }
//            },
//            data: [{
//                coord: myRegression.points[myRegression.points.length - 1]
//            }]
//        }
                                        };
                                        series.push(serie);
                                    }
//                        alert($(this).attr("value"))
                                    graficarDispersion2("graficaDispersion", series, ordenDatos, "Grafica de DispersiÛn", rasgosSelectX.value, rasgosSelectY.value);
//                                    graficarDispersionRegresion("graficaDispersion", datosXY, ordenDatos, "Grafica de DispersiÛn", rasgosSelectX.value, rasgosSelectY.value);
                                });
                                $("#btnGraficarLineas").on("click", function () {
                                    var series = [];
                                    var ordenDatos = [];
                                    var labelAxes = leerColumnaTabla("tablaResultado", 0);
                                    var select = $("select[name=selectDatosLineas]")[0];
//                            alert(select.selectedIndex);
                                    $("select[name=selectDatosLineas]").find("option:selected").each(function () {
//                            alert(select.selectedIndex);
                                        ordenDatos.push($(this).html());
                                        var numbsaltos = 3;
                                        if ($('#check_infoLocalidad').is(':checked'))
                                            numbsaltos = 4;
                                        var ser = {name: $(this).html(),
                                            type: "line",
                                            smooth: !0,
                                            itemStyle: {normal: {areaStyle: {type: "default"}}},
                                            data: leerColumnaTabla("tablaResultado", select.selectedIndex + numbsaltos),
                                            markPoint: {
                                                data: [
                                                    {type: 'max', name: 'Max'},
                                                    {type: 'min', name: 'Min'}
                                                ]
                                            },
                                            markLine: {
                                                data: [
                                                    {type: 'average', name: 'Promedio'}
                                                ]
                                            }};
                                        series.push(ser);
//                            console.log("datos serie " + select.selectedIndex + " nombre " + $(this).html());
//                            console.log(ser);
                                        $(this).prop("selected", false);
                                    });
                                    $("select[name=selectDatosLineas]").selectpicker('refresh');
                                    graficarLineas("graficaDispersion", series, ordenDatos, labelAxes);
                                });
                                $originalDatosGrafica = $(".datosGrafica")[0];
                                function btnAgregarDatosGrafica_click2() {
                                    var datosGrafica = $(".datosGrafica");
                                    if ($(datosGrafica).length < 8) {
                                        var clone = $($(".datosGrafica")[0]).clone().appendTo(".contenedorDatosGrafica");
//                            alert( $(clone).find(".selectpicker").length);
                                        $(clone).find(".dropdown-menu").remove();
                                        $(clone).find(".dropdown-toggle").remove();
                                        $(clone).find(".selectpicker").selectpicker('refresh');
                                        $($(".datosGrafica")[$(datosGrafica).length]).find("input").val('dato ' + ($(datosGrafica).length + 1));
                                        $('.btnAgregarDatos').off('click');
                                        $('.btnEliminarDatos').off('click');
                                        $('.btnAgregarDatos').on('click', function () {
                                            btnAgregarDatosGrafica_click();
                                        });
                                        $('.btnEliminarDatos').on('click', function () {
                                            btnEliminarDatosGrafica_click(this);
                                        });
                                    }
                                }
                                function btnAgregarDatosGrafica_click() {
                                    var datosGrafica = $(".datosGrafica");
                                    if ($('#nuevosDatosGraficaLinea').children('.datosGrafica').length < 7) {
                                        var clone = $($(".datosGrafica")[0]).clone().appendTo("#nuevosDatosGraficaLinea");
//                            alert( $(clone).find(".selectpicker").length);
                                        $(clone).find(".dropdown-menu").remove();
                                        $(clone).find(".dropdown-toggle").remove();
                                        $(clone).find(".selectpicker").selectpicker('refresh');
                                        $($(".datosGrafica")[$(datosGrafica).length]).find("input").val('dato ' + ($(datosGrafica).length + 1));
                                        $('.btnAgregarDatos').off('click');
                                        $('.btnEliminarDatos').off('click');
                                        $('.btnAgregarDatos').on('click', function () {
                                            btnAgregarDatosGrafica_click();
                                        });
                                        $('.btnEliminarDatos').on('click', function () {
                                            btnEliminarDatosGrafica_click(this);
                                        });
                                    }
                                }

                                function btnEliminarDatosGrafica_click(e) {
                                    var datosGrafica = $(".datosGrafica");
                                    var resultadoBusqueda = $("#nuevosDatosGraficaLinea").find(e);
                                    if (resultadoBusqueda.length > 0) {
                                        $(e).parents(".datosGrafica").remove();
                                    }
                                }
                                function btnEliminarDatosGrafica_click2(e) {
                                    var datosGrafica = $(".datosGrafica");

                                    if ($(datosGrafica).length > 1) {
                                        $(e).parents(".datosGrafica").remove();
                                    }
                                }

</script>
