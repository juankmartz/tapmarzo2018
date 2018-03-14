<%-- 
    Document   : Tabla dinamica
    Created on : 21-sep-2017, 15:55:37
    Author     : desarrolloJuan
--%>

<%@page import="java.util.HashMap"%>
<%@page import="Modelo.Medicion"%>
<%@page import="Modelo.proyectos"%>
<%@page import="Modelo.Rasgo"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<html lang="en">
  <head>
    
      <link href="../Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="../Plugins/CSS/bootstrap-table.css" rel="stylesheet" type="text/css"/>
    <!-- Bootstrap -->
    
    <!-- Font Awesome -->
   <link href="../Plugins/CSS/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <!-- NProgress -->
    <link href="../Plugins/CSS/nprogress.css" rel="stylesheet" type="text/css"/>

    
    <style>
        .ml10 {
    margin-left: 10px;
}

.menuHoverTabla {
    height: 30px;
    width: 200px;
    border: 1px solid #111;
    background: #C52121;
    position: absolute;
}

    </style>
  </head>

  <body >
       <%
            ArrayList<Rasgo> listRasgos =  proyectos.getCaracterisiticasInteresProyectoList(44);
            ArrayList<Medicion> listMedicion = Medicion.obtenerMedcionesProyecto(44, listRasgos);
        %>
        <table id="tablaDatos" >
    <thead>
    <tr>
                    <th>ID Medicion</th>
                    <th>Fecha</th>
                    <th>Hora</th>
                    <%
                        for(Rasgo miRasgo : listRasgos){
                    %>
                    <th><%=miRasgo.getNombre() %></th>
                    <%
                        }
                    %>
                </tr>
    </thead>
    <tbody>
     <%
            
                        for(Medicion miMedicion : listMedicion){
                    %>
                    
                    <tr> 
                    <td><%=miMedicion.getIdMedicion() %></td>
                    <td><%=miMedicion.getFecha()%></td>
                    <td><%=miMedicion.getHora()%></td>
                    <%
                    HashMap<String, String> valores = miMedicion.getValues();
//                    int numeroMedidas = valores.size();
                    for(Rasgo mirasgo : listRasgos){
                         %>
                         <td><%=valores.get(mirasgo.getNombre_columna()) %></td>
                    <%
                    }
                    %>
                    <!--<td><input type="button" value="eliminar" onclick="eliminarFila(this);"></td>-->
                    <!--<td><button  onclick="eliminarFila(this);">Eliminar</button></td>-->
                    </tr>
                    <%
                        
                        }
                    %>   
</tbody>
    </table>
       
      <script src="../Plugins/jquery-3.2.1.min.js" type="text/javascript"></script>
      <script src="../Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
      <script src="../Plugins/Js/bootstrap-table.js" type="text/javascript"></script>
    
    <!-- ECharts -->
    <script src="../Plugins/Js/echarts.min.js" type="text/javascript"></script>

       <div>
                        datos de X
                        <select id="selectRasgoX">
                            <%
                                int columna = 3;
                                for(Rasgo miRasgo : listRasgos){
                                    %>
                                    <option value="<%=columna%>"><%=miRasgo.getNombre()%></option>
                                    <%
                                }
                            %>
                            
                        </select>
                    </div>
                    <div>
                        datos en Y
                        <select  id="selectRasgoY">
                            <%
                                columna = 3;
                                for(Rasgo miRasgo : listRasgos){
                                    %>
                                    <option value="<%=columna%>"><%=miRasgo.getNombre()%></option>
                                    <%
                                }
                            %>
                            
                        </select>
                    </div>
                            <input id="btnBuscar1" type="button" class="btn btn-primary" value="Buscar 1"> 
                            <input id="btnBuscar2" type="button" class="btn btn-primary" value="Buscar 2"> 
                            <input id="btnBuscar3" type="button" class="btn btn-primary" value="Buscar 3"> 
            
                            
                            
                             <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Scatter Graph</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <div id="echart_scatter" style="height:350px;"></div>

                  </div>
                </div>
              </div>
                            <div id="contenedorMenuHover"></div>              
       <script>
    $('table').DataTable( { "lengthMenu": [[5, 25, 50, -1], [5, 25, 50, "All"]]});       
    $("#tablaDatos tbody").find("tr").each(function (){
        $td = $("<td/>").append($("<input/>",
        {
            'type':'button',
            'class':'btn btn-primary',
            'value':'Eliminar'
        }));
        $($td).on('click',function (){
                alert(this);
                $(this).parent("tr").remove();
            });
        $(this).append($td);
    });
    $("#btnBuscar1").on("click",function (){
                                   var rasgosSelectX = document.getElementById("selectRasgoX");
                                   var rasgosSelectY = document.getElementById("selectRasgoY");
                                   datosRasgoX = leerColumnaTabla("tablaDatos",rasgosSelectX.selectedIndex+3);
                                   datosRasgoY = leerColumnaTabla("tablaDatos",rasgosSelectY.selectedIndex+3);
//                                  alert(datosRasgoX.length);
                                  alert(datosRasgoX[0]);
                                  var datosXY= [] ;
//                                  var datosXY= [] ;
                                  for(var i = 0; i< datosRasgoX.length; i++){
                                      
                                      datosXY.push ( [datosRasgoX[i],datosRasgoY[i]]);
//                                      datosXY[i][0]= datosRasgoX[i];
//                                      datosXY[i][1]=datosRasgoY[i];
                                  }
                                  alert(datosXY[0]+"\n"+datosXY[1]);
                                  graficarDispersion2("echart_scatter",datosXY);
                                });
     $("#btnBuscar2").on("click",function (){graficarDispersion2("echart_scatter");});                            
     $("#btnBuscar3").on("click",function (){graficarDispersion3("echart_scatter");});                            
                               
function leerColumnaTabla(idTabla,indexColumna){
          var respuesta ="" ;                          
        //seleccionamos la fila correcta segun el index
        $("#"+idTabla+" tr").find('td:eq('+indexColumna+')').each(function () {
            //obtenemos el valor de la celda
            valor = $(this).html();
            respuesta = respuesta + valor +"|x|x|";
            //sumamos, recordar parsear, si no se concatenara.           
        })
        respuesta = respuesta.split("|x|x|");
        return respuesta;
}

function graficarDispersion(idGrafica, datosXY){
            var a = {color: ["#636161", "#908E8E", "#C1BFBF", "#DCDBDB", "#9B59B6", "#8abb6f", "#759c6a", "#bfd3b7"], title: {itemGap: 8, textStyle: {fontWeight: "normal", color: "#408829"}}, dataRange: {color: ["#1f610a", "#97b58d"]}, toolbox: {color: ["#408829", "#408829", "#408829", "#408829"]}, tooltip: {backgroundColor: "rgba(0,0,0,0.5)", axisPointer: {type: "line", lineStyle: {color: "#408829", type: "dashed"}, crossStyle: {color: "#408829"}, shadowStyle: {color: "rgba(200,200,200,0.3)"}}}, dataZoom: {dataBackgroundColor: "#eee", fillerColor: "rgba(64,136,41,0.2)", handleColor: "#408829"}, grid: {borderWidth: 0}, categoryAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitLine: {lineStyle: {color: ["#eee"]}}}, valueAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitArea: {show: !0, areaStyle: {color: ["rgba(250,250,250,0.1)", "rgba(200,200,200,0.1)"]}}, splitLine: {lineStyle: {color: ["#eee"]}}}, timeline: {lineStyle: {color: "#408829"}, controlStyle: {normal: {color: "#408829"}, emphasis: {color: "#408829"}}}, k: {itemStyle: {normal: {color: "#68a54a", color0: "#a9cba2", lineStyle: {width: 1, color: "#408829", color0: "#86b379"}}}}, map: {itemStyle: {normal: {areaStyle: {color: "#ddd"}, label: {textStyle: {color: "#c12e34"}}}, emphasis: {areaStyle: {color: "#99d2dd"}, label: {textStyle: {color: "#c12e34"}}}}}, force: {itemStyle: {normal: {linkStyle: {strokeColor: "#408829"}}}}, chord: {padding: 4, itemStyle: {normal: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}, emphasis: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}}}, gauge: {startAngle: 225, endAngle: -45, axisLine: {show: !0, lineStyle: {color: [[.2, "#86b379"], [.8, "#68a54a"], [1, "#408829"]], width: 8}}, axisTick: {splitNumber: 10, length: 12, lineStyle: {color: "auto"}}, axisLabel: {textStyle: {color: "auto"}}, splitLine: {length: 18, lineStyle: {color: "auto"}}, pointer: {length: "90%", color: "auto"}, title: {textStyle: {color: "#333"}}, detail: {textStyle: {color: "auto"}}}, textStyle: {fontFamily: "Arial, Verdana, sans-serif"}}; 
//            var a = {color: ["#26B99A", "#34495E", "#BDC3C7", "#3498DB", "#9B59B6", "#8abb6f", "#759c6a", "#bfd3b7"], title: {itemGap: 8, textStyle: {fontWeight: "normal", color: "#408829"}}, dataRange: {color: ["#1f610a", "#97b58d"]}, toolbox: {color: ["#408829", "#408829", "#408829", "#408829"]}, tooltip: {backgroundColor: "rgba(0,0,0,0.5)", axisPointer: {type: "line", lineStyle: {color: "#408829", type: "dashed"}, crossStyle: {color: "#408829"}, shadowStyle: {color: "rgba(200,200,200,0.3)"}}}, dataZoom: {dataBackgroundColor: "#eee", fillerColor: "rgba(64,136,41,0.2)", handleColor: "#408829"}, grid: {borderWidth: 0}, categoryAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitLine: {lineStyle: {color: ["#eee"]}}}, valueAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitArea: {show: !0, areaStyle: {color: ["rgba(250,250,250,0.1)", "rgba(200,200,200,0.1)"]}}, splitLine: {lineStyle: {color: ["#eee"]}}}, timeline: {lineStyle: {color: "#408829"}, controlStyle: {normal: {color: "#408829"}, emphasis: {color: "#408829"}}}, k: {itemStyle: {normal: {color: "#68a54a", color0: "#a9cba2", lineStyle: {width: 1, color: "#408829", color0: "#86b379"}}}}, map: {itemStyle: {normal: {areaStyle: {color: "#ddd"}, label: {textStyle: {color: "#c12e34"}}}, emphasis: {areaStyle: {color: "#99d2dd"}, label: {textStyle: {color: "#c12e34"}}}}}, force: {itemStyle: {normal: {linkStyle: {strokeColor: "#408829"}}}}, chord: {padding: 4, itemStyle: {normal: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}, emphasis: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}}}, gauge: {startAngle: 225, endAngle: -45, axisLine: {show: !0, lineStyle: {color: [[.2, "#86b379"], [.8, "#68a54a"], [1, "#408829"]], width: 8}}, axisTick: {splitNumber: 10, length: 12, lineStyle: {color: "auto"}}, axisLabel: {textStyle: {color: "auto"}}, splitLine: {length: 18, lineStyle: {color: "auto"}}, pointer: {length: "90%", color: "auto"}, title: {textStyle: {color: "#333"}}, detail: {textStyle: {color: "auto"}}}, textStyle: {fontFamily: "Arial, Verdana, sans-serif"}}; 
            var g = echarts.init(document.getElementById(idGrafica), a);
            g.setOption({title: {text: "Scatter Graph", subtext: "Heinz  2003"}, 
                tooltip: {trigger: "axis", showDelay: 0, axisPointer: {type: "cross", lineStyle: {type: "dashed", width: 1}}}, legend: {data: ["Data2", "Data1"]}, toolbox: {show: !0, feature: {saveAsImage: {show: !0, title: "Save Image"}}}, xAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} cm"}}], yAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} kg"}}], series: [{name: "Data1", type: "scatter", tooltip: {trigger: "item", formatter: function (a) {
                                return a.value.length > 1 ? a.seriesName + " :<br/>" + a.value[0] + "cm " + a.value[1] + "kg " : a.seriesName + " :<br/>" + a.name + " : " + a.value + "kg "
                            }}, data: datosXY,
                        markPoint: {data: [{type: "max", name: "Max"}, {type: "min", name: "Min"}]}, 
                        markLine: {data: [{type: "average", name: "Mean"}]}} 
                    ]})
        }
        function graficarDispersion2(idGrafica, datosXY){
            var a = {color: ["#636161", "#908E8E", "#C1BFBF", "#DCDBDB", "#9B59B6", "#8abb6f", "#759c6a", "#bfd3b7"], title: {itemGap: 8, textStyle: {fontWeight: "normal", color: "#408829"}}, dataRange: {color: ["#1f610a", "#97b58d"]}, toolbox: {color: ["#408829", "#408829", "#408829", "#408829"]}, tooltip: {backgroundColor: "rgba(0,0,0,0.5)", axisPointer: {type: "line", lineStyle: {color: "#408829", type: "dashed"}, crossStyle: {color: "#408829"}, shadowStyle: {color: "rgba(200,200,200,0.3)"}}}, dataZoom: {dataBackgroundColor: "#eee", fillerColor: "rgba(64,136,41,0.2)", handleColor: "#408829"}, grid: {borderWidth: 0}, categoryAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitLine: {lineStyle: {color: ["#eee"]}}}, valueAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitArea: {show: !0, areaStyle: {color: ["rgba(250,250,250,0.1)", "rgba(200,200,200,0.1)"]}}, splitLine: {lineStyle: {color: ["#eee"]}}}, timeline: {lineStyle: {color: "#408829"}, controlStyle: {normal: {color: "#408829"}, emphasis: {color: "#408829"}}}, k: {itemStyle: {normal: {color: "#68a54a", color0: "#a9cba2", lineStyle: {width: 1, color: "#408829", color0: "#86b379"}}}}, map: {itemStyle: {normal: {areaStyle: {color: "#ddd"}, label: {textStyle: {color: "#c12e34"}}}, emphasis: {areaStyle: {color: "#99d2dd"}, label: {textStyle: {color: "#c12e34"}}}}}, force: {itemStyle: {normal: {linkStyle: {strokeColor: "#408829"}}}}, chord: {padding: 4, itemStyle: {normal: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}, emphasis: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}}}, gauge: {startAngle: 225, endAngle: -45, axisLine: {show: !0, lineStyle: {color: [[.2, "#86b379"], [.8, "#68a54a"], [1, "#408829"]], width: 8}}, axisTick: {splitNumber: 10, length: 12, lineStyle: {color: "auto"}}, axisLabel: {textStyle: {color: "auto"}}, splitLine: {length: 18, lineStyle: {color: "auto"}}, pointer: {length: "90%", color: "auto"}, title: {textStyle: {color: "#333"}}, detail: {textStyle: {color: "auto"}}}, textStyle: {fontFamily: "Arial, Verdana, sans-serif"}}; 
//            var a = {color: ["#26B99A", "#34495E", "#BDC3C7", "#3498DB", "#9B59B6", "#8abb6f", "#759c6a", "#bfd3b7"], title: {itemGap: 8, textStyle: {fontWeight: "normal", color: "#408829"}}, dataRange: {color: ["#1f610a", "#97b58d"]}, toolbox: {color: ["#408829", "#408829", "#408829", "#408829"]}, tooltip: {backgroundColor: "rgba(0,0,0,0.5)", axisPointer: {type: "line", lineStyle: {color: "#408829", type: "dashed"}, crossStyle: {color: "#408829"}, shadowStyle: {color: "rgba(200,200,200,0.3)"}}}, dataZoom: {dataBackgroundColor: "#eee", fillerColor: "rgba(64,136,41,0.2)", handleColor: "#408829"}, grid: {borderWidth: 0}, categoryAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitLine: {lineStyle: {color: ["#eee"]}}}, valueAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitArea: {show: !0, areaStyle: {color: ["rgba(250,250,250,0.1)", "rgba(200,200,200,0.1)"]}}, splitLine: {lineStyle: {color: ["#eee"]}}}, timeline: {lineStyle: {color: "#408829"}, controlStyle: {normal: {color: "#408829"}, emphasis: {color: "#408829"}}}, k: {itemStyle: {normal: {color: "#68a54a", color0: "#a9cba2", lineStyle: {width: 1, color: "#408829", color0: "#86b379"}}}}, map: {itemStyle: {normal: {areaStyle: {color: "#ddd"}, label: {textStyle: {color: "#c12e34"}}}, emphasis: {areaStyle: {color: "#99d2dd"}, label: {textStyle: {color: "#c12e34"}}}}}, force: {itemStyle: {normal: {linkStyle: {strokeColor: "#408829"}}}}, chord: {padding: 4, itemStyle: {normal: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}, emphasis: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}}}, gauge: {startAngle: 225, endAngle: -45, axisLine: {show: !0, lineStyle: {color: [[.2, "#86b379"], [.8, "#68a54a"], [1, "#408829"]], width: 8}}, axisTick: {splitNumber: 10, length: 12, lineStyle: {color: "auto"}}, axisLabel: {textStyle: {color: "auto"}}, splitLine: {length: 18, lineStyle: {color: "auto"}}, pointer: {length: "90%", color: "auto"}, title: {textStyle: {color: "#333"}}, detail: {textStyle: {color: "auto"}}}, textStyle: {fontFamily: "Arial, Verdana, sans-serif"}}; 
            var g = echarts.init(document.getElementById(idGrafica), a);
            g.setOption({
                title: {text: "Scatter Graph", subtext: "Heinz  2003"}, 
                tooltip: {trigger: "axis", showDelay: 0, axisPointer: {type: "cross", lineStyle: {type: "dashed", width: 1}}}, 
                legend: {data: ["Dato2", "Dato1"]}, 
                toolbox: {show: !0, feature: {saveAsImage: {show: !0, title: "Save Image"}}}, 
                xAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} cm"}}], 
                yAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} kg"}}], 
                series: [
                    {name: "Dato1", type: "scatter", symbol: 'rectangle', //'circle', 'rectangle', 'triangle', 'diamond', 'emptyCircle', 'emptyRectangle', 'emptyTriangle', 'emptyDiamond'
            tooltip: {trigger: "item", formatter: function (a) {
                                return a.value.length > 1 ? a.seriesName + " :<br/>" + a.value[0] + "cm " + a.value[1] + "kg " : a.seriesName + " :<br/>" + a.name + " : " + a.value + "kg "
                            }}, data: datosXY, markPoint: {data: [{type: "max", name: "Max"}, {type: "min", name: "Min"}]}, markLine: {data: [{type: "average", name: "Mean"}]}}, 
                         {name: "Dato2", type: "scatter", tooltip: {trigger: "item", formatter: function (a) {
                                return a.value.length > 1 ? a.seriesName + " :<br/>" + a.value[0] + "cm " + a.value[1] + "kg " : a.seriesName + " :<br/>" + a.name + " : " + a.value + "kg "
                            }}, data: [[174, 65.6], [175.3, 71.8], [193.5, 80.7], [186.5, 72.6], [187.2, 78.8], [181.5, 74.8], [184, 86.4], [184.5, 78.4], [175, 62], [184, 81.6], [180, 76.6], [177.8, 83.6], [192, 90], [176, 74.6], [174, 71], [184, 79.6], [192.7, 93.8], [171.5, 70], [173, 72.4], [176, 85.9], [176, 78.8], [180.5, 77.8], [172.7, 66.2], [176, 86.4], [173.5, 81.8], [178, 89.6], [180.3, 82.8], [180.3, 76.4], [164.5, 63.2], [173, 60.9], [183.5, 74.8], [175.5, 70], [188, 72.4], [189.2, 84.1], [172.8, 69.1], [170, 59.5], [182, 67.2], [170, 61.3], [177.8, 68.6], [184.2, 80.1], [186.7, 87.8], [171.4, 84.7], [172.7, 73.4], [175.3, 72.1], [180.3, 82.6], [182.9, 88.7], [188, 84.1], [177.2, 94.1], [172.1, 74.9], [167, 59.1], [169.5, 75.6], [174, 86.2], [172.7, 75.3], [182.2, 87.1], [164.1, 55.2], [163, 57], [171.5, 61.4], [184.2, 76.8], [174, 86.8], [174, 72.2], [177, 71.6], [186, 84.8], [167, 68.2], [171.8, 66.1], [182, 72], [167, 64.6], [177.8, 74.8], [164.5, 70], [192, 101.6], [175.5, 63.2], [171.2, 79.1], [181.6, 78.9], [167.4, 67.7], [181.1, 66], [177, 68.2], [174.5, 63.9], [177.5, 72], [170.5, 56.8], [182.4, 74.5], [197.1, 90.9], [180.1, 93], [175.5, 80.9], [180.6, 72.7], [184.4, 68], [175.5, 70.9], [180.6, 72.5], [177, 72.5], [177.1, 83.4], [181.6, 75.5], [176.5, 73], [175, 70.2], [174, 73.4], [165.1, 70.5], [177, 68.9], [192, 102.3], [176.5, 68.4], [169.4, 65.9], [182.1, 75.7], [179.8, 84.5], [175.3, 87.7], [184.9, 86.4], [177.3, 73.2], [167.4, 53.9], [178.1, 72], [168.9, 55.5], [157.2, 58.4], [180.3, 83.2], [170.2, 72.7], [177.8, 64.1], [172.7, 72.3], [165.1, 65], [186.7, 86.4], [165.1, 65], [174, 88.6], [175.3, 84.1], [185.4, 66.8], [177.8, 75.5], [180.3, 93.2], [180.3, 82.7], [177.8, 58], [177.8, 79.5], [177.8, 78.6], [177.8, 71.8], [177.8, 116.4], [163.8, 72.2], [188, 83.6], [198.1, 85.5], [175.3, 90.9], [166.4, 85.9], [190.5, 89.1], [166.4, 75], [177.8, 77.7], [179.7, 86.4], [172.7, 90.9], [190.5, 73.6], [185.4, 76.4], [168.9, 69.1], [167.6, 84.5], [175.3, 64.5], [170.2, 69.1], [190.5, 108.6], [177.8, 86.4], [190.5, 80.9], [177.8, 87.7], [184.2, 94.5], [176.5, 80.2], [177.8, 72], [180.3, 71.4], [171.4, 72.7], [172.7, 84.1], [172.7, 76.8], [177.8, 63.6], [177.8, 80.9], [182.9, 80.9], [170.2, 85.5], [167.6, 68.6], [175.3, 67.7], [165.1, 66.4], [185.4, 102.3], [181.6, 70.5], [172.7, 95.9], [190.5, 84.1], [179.1, 87.3], [175.3, 71.8], [170.2, 65.9], [193, 95.9], [171.4, 91.4], [177.8, 81.8], [177.8, 96.8], [167.6, 69.1], [167.6, 82.7], [180.3, 75.5], [182.9, 79.5], [176.5, 73.6], [186.7, 91.8], [188, 84.1], [188, 85.9], [177.8, 81.8], [174, 82.5], [177.8, 80.5], [171.4, 70], [185.4, 81.8], [185.4, 84.1], [188, 90.5], [188, 91.4], [182.9, 89.1], [176.5, 85], [175.3, 69.1], [175.3, 73.6], [188, 80.5], [188, 82.7], [175.3, 86.4], [170.5, 67.7], [179.1, 92.7], [177.8, 93.6], [175.3, 70.9], [182.9, 75], [170.8, 93.2], [188, 93.2], [180.3, 77.7], [177.8, 61.4], [185.4, 94.1], [168.9, 75], [185.4, 83.6], [180.3, 85.5], [174, 73.9], [167.6, 66.8], [182.9, 87.3], [160, 72.3], [180.3, 88.6], [167.6, 75.5], [186.7, 101.4], [175.3, 91.1], [175.3, 67.3], [175.9, 77.7], [175.3, 81.8], [179.1, 75.5], [181.6, 84.5], [177.8, 76.6], [182.9, 85], [177.8, 102.5], [184.2, 77.3], [179.1, 71.8], [176.5, 87.9], [188, 94.3], [174, 70.9], [167.6, 64.5], [170.2, 77.3], [167.6, 72.3], [188, 87.3], [174, 80], [176.5, 82.3], [180.3, 73.6], [167.6, 74.1], [188, 85.9], [180.3, 73.2], [167.6, 76.3], [183, 65.9], [183, 90.9], [179.1, 89.1], [170.2, 62.3], [177.8, 82.7], [179.1, 79.1], [190.5, 98.2], [177.8, 84.1], [180.3, 83.2], [180.3, 83.2]], markPoint: {data: [{type: "max", name: "Max"}, {type: "min", name: "Min"}]}, markLine: {data: [{type: "average", name: "Mean"}]}}]}
                    )
        }
        function graficarDispersion3(idGrafica){
            var a = {color: ["#26B99A", "#34495E", "#BDC3C7", "#3498DB", "#9B59B6", "#8abb6f", "#759c6a", "#bfd3b7"], 
                title: {itemGap: 8, textStyle: {fontWeight: "normal", color: "#408829"}}, 
                dataRange: {color: ["#1f610a", "#97b58d"]}, toolbox: {color: ["#408829", "#408829", "#408829", "#408829"]}, tooltip: {backgroundColor: "rgba(0,0,0,0.5)", axisPointer: {type: "line", lineStyle: {color: "#408829", type: "dashed"}, crossStyle: {color: "#408829"}, shadowStyle: {color: "rgba(200,200,200,0.3)"}}}, dataZoom: {dataBackgroundColor: "#eee", fillerColor: "rgba(64,136,41,0.2)", handleColor: "#408829"}, grid: {borderWidth: 0}, categoryAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitLine: {lineStyle: {color: ["#eee"]}}}, valueAxis: {axisLine: {lineStyle: {color: "#408829"}}, splitArea: {show: !0, areaStyle: {color: ["rgba(250,250,250,0.1)", "rgba(200,200,200,0.1)"]}}, splitLine: {lineStyle: {color: ["#eee"]}}}, timeline: {lineStyle: {color: "#408829"}, controlStyle: {normal: {color: "#408829"}, emphasis: {color: "#408829"}}}, k: {itemStyle: {normal: {color: "#68a54a", color0: "#a9cba2", lineStyle: {width: 1, color: "#408829", color0: "#86b379"}}}}, map: {itemStyle: {normal: {areaStyle: {color: "#ddd"}, label: {textStyle: {color: "#c12e34"}}}, emphasis: {areaStyle: {color: "#99d2dd"}, label: {textStyle: {color: "#c12e34"}}}}}, force: {itemStyle: {normal: {linkStyle: {strokeColor: "#408829"}}}}, chord: {padding: 4, itemStyle: {normal: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}, emphasis: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}, chordStyle: {lineStyle: {width: 1, color: "rgba(128, 128, 128, 0.5)"}}}}}, gauge: {startAngle: 225, endAngle: -45, axisLine: {show: !0, lineStyle: {color: [[.2, "#86b379"], [.8, "#68a54a"], [1, "#408829"]], width: 8}}, axisTick: {splitNumber: 10, length: 12, lineStyle: {color: "auto"}}, axisLabel: {textStyle: {color: "auto"}}, splitLine: {length: 18, lineStyle: {color: "auto"}}, pointer: {length: "90%", color: "auto"}, title: {textStyle: {color: "#333"}}, detail: {textStyle: {color: "auto"}}}, textStyle: {fontFamily: "Arial, Verdana, sans-serif"}}; 
            var g = echarts.init(document.getElementById(idGrafica), a);
            g.getPrototypeOf();
            g.setOption({title: {text: "Scatter Graph", subtext: "Heinz  2003"}, 
                tooltip: {trigger: "axis", showDelay: 0, axisPointer: {type: "shadow", lineStyle: {type: "dashed", width: 1}}}, legend: {data: ["Data2", "Data1"]}, toolbox: {show: !0, feature: {saveAsImage: {show: !0, title: "Save Image"}}}, xAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} cm"}}], yAxis: [{type: "value", scale: !0, axisLabel: {formatter: "{value} kg"}}], series: [{name: "Data1", type: "scatter", tooltip: {trigger: "item", formatter: function (a) {
                                return a.value.length > 1 ? a.seriesName + " :<br/>" + a.value[0] + "cm " + a.value[1] + "kg " : a.seriesName + " :<br/>" + a.name + " : " + a.value + "kg "
                            }}, data: [[161.2, 51.6], [167.5, 59], [159.5, 49.2], [157, 63], [155.8, 53.6], [170, 59], [159.1, 47.6], [166, 69.8], [176.2, 66.8], [160.2, 75.2], [172.5, 55.2], [170.9, 54.2], [172.9, 62.5], [153.4, 42], [160, 50], [147.2, 49.8], [168.2, 49.2], [175, 73.2], [157, 47.8], [167.6, 68.8], [159.5, 50.6], [175, 82.5], [166.8, 57.2], [176.5, 87.8], [170.2, 72.8], [174, 54.5], [173, 59.8], [179.9, 67.3], [170.5, 67.8], [160, 47], [154.4, 46.2], [162, 55], [176.5, 83], [160, 54.4], [152, 45.8], [162.1, 53.6], [170, 73.2], [160.2, 52.1], [161.3, 67.9], [166.4, 56.6], [168.9, 62.3], [163.8, 58.5], [167.6, 54.5], [160, 50.2], [161.3, 60.3], [167.6, 58.3], [165.1, 56.2], [160, 50.2], [170, 72.9], [157.5, 59.8], [167.6, 61], [160.7, 69.1], [163.2, 55.9], [152.4, 46.5], [157.5, 54.3], [168.3, 54.8], [180.3, 60.7], [165.5, 60], [165, 62], [164.5, 60.3], [156, 52.7], [160, 74.3], [163, 62], [165.7, 73.1], [161, 80], [162, 54.7], [166, 53.2], [174, 75.7], [172.7, 61.1], [167.6, 55.7], [151.1, 48.7], [164.5, 52.3], [163.5, 50], [152, 59.3], [169, 62.5], [164, 55.7], [161.2, 54.8], [155, 45.9], [170, 70.6], [176.2, 67.2], [170, 69.4], [162.5, 58.2], [170.3, 64.8], [164.1, 71.6], [169.5, 52.8], [163.2, 59.8], [154.5, 49], [159.8, 50], [173.2, 69.2], [170, 55.9], [161.4, 63.4], [169, 58.2], [166.2, 58.6], [159.4, 45.7], [162.5, 52.2], [159, 48.6], [162.8, 57.8], [159, 55.6], [179.8, 66.8], [162.9, 59.4], [161, 53.6], [151.1, 73.2], [168.2, 53.4], [168.9, 69], [173.2, 58.4], [171.8, 56.2], [178, 70.6], [164.3, 59.8], [163, 72], [168.5, 65.2], [166.8, 56.6], [172.7, 105.2], [163.5, 51.8], [169.4, 63.4], [167.8, 59], [159.5, 47.6], [167.6, 63], [161.2, 55.2], [160, 45], [163.2, 54], [162.2, 50.2], [161.3, 60.2], [149.5, 44.8], [157.5, 58.8], [163.2, 56.4], [172.7, 62], [155, 49.2], [156.5, 67.2], [164, 53.8], [160.9, 54.4], [162.8, 58], [167, 59.8], [160, 54.8], [160, 43.2], [168.9, 60.5], [158.2, 46.4], [156, 64.4], [160, 48.8], [167.1, 62.2], [158, 55.5], [167.6, 57.8], [156, 54.6], [162.1, 59.2], [173.4, 52.7], [159.8, 53.2], [170.5, 64.5], [159.2, 51.8], [157.5, 56], [161.3, 63.6], [162.6, 63.2], [160, 59.5], [168.9, 56.8], [165.1, 64.1], [162.6, 50], [165.1, 72.3], [166.4, 55], [160, 55.9], [152.4, 60.4], [170.2, 69.1], [162.6, 84.5], [170.2, 55.9], [158.8, 55.5], [172.7, 69.5], [167.6, 76.4], [162.6, 61.4], [167.6, 65.9], [156.2, 58.6], [175.2, 66.8], [172.1, 56.6], [162.6, 58.6], [160, 55.9], [165.1, 59.1], [182.9, 81.8], [166.4, 70.7], [165.1, 56.8], [177.8, 60], [165.1, 58.2], [175.3, 72.7], [154.9, 54.1], [158.8, 49.1], [172.7, 75.9], [168.9, 55], [161.3, 57.3], [167.6, 55], [165.1, 65.5], [175.3, 65.5], [157.5, 48.6], [163.8, 58.6], [167.6, 63.6], [165.1, 55.2], [165.1, 62.7], [168.9, 56.6], [162.6, 53.9], [164.5, 63.2], [176.5, 73.6], [168.9, 62], [175.3, 63.6], [159.4, 53.2], [160, 53.4], [170.2, 55], [162.6, 70.5], [167.6, 54.5], [162.6, 54.5], [160.7, 55.9], [160, 59], [157.5, 63.6], [162.6, 54.5], [152.4, 47.3], [170.2, 67.7], [165.1, 80.9], [172.7, 70.5], [165.1, 60.9], [170.2, 63.6], [170.2, 54.5], [170.2, 59.1], [161.3, 70.5], [167.6, 52.7], [167.6, 62.7], [165.1, 86.3], [162.6, 66.4], [152.4, 67.3], [168.9, 63], [170.2, 73.6], [175.2, 62.3], [175.2, 57.7], [160, 55.4], [165.1, 104.1], [174, 55.5], [170.2, 77.3], [160, 80.5], [167.6, 64.5], [167.6, 72.3], [167.6, 61.4], [154.9, 58.2], [162.6, 81.8], [175.3, 63.6], [171.4, 53.4], [157.5, 54.5], [165.1, 53.6], [160, 60], [174, 73.6], [162.6, 61.4], [174, 55.5], [162.6, 63.6], [161.3, 60.9], [156.2, 60], [149.9, 46.8], [169.5, 57.3], [160, 64.1], [175.3, 63.6], [169.5, 67.3], [160, 75.5], [172.7, 68.2], [162.6, 61.4], [157.5, 76.8], [176.5, 71.8], [164.4, 55.5], [160.7, 48.6], [174, 66.4], [163.8, 67.3]],
                        markPoint: {data: [{type: "max", name: "Max"}, {type: "min", name: "Min"}]}, 
                        markLine: {data: [{type: "average", name: "Mean"}]}} 
                    ]})
        }
        
        function crearMenu(trSelect)
        {
//            var idMenuHover = 'menuHoverTabla_'+$(trSelect).attr("id");
            $menuHover = $('<div/>', {'class' : 'menuHoverTabla' });
            $('#contenedorMenuHover').append($('<div/>', {'class' : 'menuHoverTabla' ,'style':'top: '+y+'px; left: '+x+'px'}));
        var x = window.event.x;
            var y = window.event.y;
            console.log('variable x ='+ $(trSelect).x);
            console.log('variable y ='+ y);
            $($menuHover).css('top','45px');
            
//            alert(x+" : "+y);
//            document.getElementById("idMenuHover").style.left = x + "px";
//            document.getElementById("idMenuHover").style.top = y + "px";
        }
        
        function eliminarFila(btn){
            var mensaje = confirm("Desea Eliminar esta fila?");
            //Detectamos si el usuario acepto el mensaje
            if (mensaje) {
            $(btn).parents("tr").remove();
            }
            //Detectamos si el usuario denegó el mensaje
            else {
            alert("¡Haz denegado el mensaje!");
            }
            
        }
         
                                </script>
  </body>
</html>
