<%-- 
    Document   : exportaExcelTablas
    Created on : 09-oct-2017, 20:00:46
    Author     : desarrolloJuan
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="form-group">
            <a id="DescargaExcel" href="../Formularios/excel.jsp" class=" btn btn-success btn-xs"><i class="fa fa-file-excel-o"></i>Export to Excel</a></div>
        <br>
        <div id="contenTabla_1">
        <table class="table" id="tabla_1">
            <thead>
                <tr>
                    <th>Mi titulo 1</th>
                    <th>mi titulo 2</th>
                    <th>mi titulo 3</th>
                    <th>mi titulo 4</th>
                    <th>este sera un extra</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>56.89</td>
                    <td>34.90</td>
                    <td>carita azul</td>
                    <td>78.90</td>
                    <td>postaa</td>
                </tr>
                <tr>
                    <td>56.89</td>
                    <td>34.90</td>
                    <td>carita azul</td>
                    <td>78.90</td>
                    <td>postaa</td>
                </tr>
                <tr>
                    <td>56.89</td>
                    <td>34.90</td>
                    <td>carita azul</td>
                    <td>78.90</td>
                    <td>postaa</td>
                </tr>
                <tr>
                    <td>56.89</td>
                    <td>34.90</td>
                    <td>carita azul</td>
                    <td>78.90</td>
                    <td>postaa</td>
                </tr>
                <tr>
                    <td>xxxxx</td>
                    <td>34.90</td>
                    <td>carita azul</td>
                    <td>78.90</td>
                    <td>postaa</td>
                </tr>
                <tr>
                    <td>56.89</td>
                    <td>34.90</td>
                    <td>carita azul</td>
                    <td>78.90</td>
                    <td>postaa</td>
                </tr>
                <tr>
                    <td>56.89</td>
                    <td>34.90</td>
                    <td>carita azul</td>
                    <td>78.90</td>
            
                    <td><img src="../imagen/icono-hoja.png" /></td>
                </tr>
            </tbody>
        </table>
        </div>
        <div id="contenSelectRasgosBusqueda"></div>
        <input type="button" value="Descarga xlsx" onclick="selectEspecieChange('contenTabla_1');">
        <%
            String exportToExcel = "";
            if(request.getParameter("tablaExportar")!= null){
                exportToExcel = request.getParameter("tablaExportar");
                
//                HttpSession sesion = request.getSession(false);
//                sesion.setAttribute("tablaResultados",exportToExcel);
                response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "inline; filename="
					+ "table.xls");
                out.println(exportToExcel);
            }
		
			
	%>
        <script src="../Plugins/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script>
        
            
        function selectEspecieChange(contentTabla){
                 $tabla = $("#"+contentTabla).html();
                
            $.ajax({
        url: "exportaExcelTablas.jsp?",
        type: "post",
        dataType: "html",
        data: "tablaExportar="+$tabla,
        cache: false,
        processData: false,
        success: function (result) {
//           $("#contenSelectRasgosBusqueda").html(result);
//            ocultarLoaderOndaDeCubos();
            $("#DescargaExcel").click();
        },
        error: function () {
//            ocultarLoaderOndaDeCubos();
//            nuevaNotify('error', 'Error', 'Ha ocurrido un error al buscar los rasgos asociados a las especies', 9000);
        }
    });
    }
        </script>
    </body>
</html>
