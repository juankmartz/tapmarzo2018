<%-- 
    Document   : tablaExportExcell
    Created on : 04-sep-2017, 20:49:31
    Author     : desarrolloJuan
--%>

<%@page import="Bean.ManejoFicherosExcel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Rasgo"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="../Plugins/DataTables-1.10.15/extensions/Buttons/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/DataTables-1.10.15/media/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
   
        
    </head>
    <body>
        <%
        ArrayList<Rasgo> listRasgos = Rasgo.getRasgosList();
        %>
        <table class="table table-striped table-bordered" cellspacing="0" id="tablaRasgos">
                             <thead>
                             <th>Rasgo</th>
                             <th>Name</th>
                             <th>Tipo Rasgo</th>
                             <th>Unidad</th>
                             <th>Asociar</th>
                             </thead>
                             <tbody>
                                 <%    for (Rasgo mirasgo: listRasgos) {
                                     
                                 %>
                                 <tr>
                                     <td><%=mirasgo.getNombre()%></td>
                                     <td><%=mirasgo.getName() %></td>
                                     <td><%=mirasgo.getTiporasgo() %></td>
                                     <td><%=mirasgo.getUnidad() %></td>
                                     <td><input type="checkbox" name="rasgoEstudio" value="<%=mirasgo.getIdrasgo() %>" > </td>
                                 </tr>
                                 <%
                                     }
                                 %>

                             </tbody>
                         </table>
                                 
        <%
            String tablaDelExcel = ManejoFicherosExcel.leerArchivoExcelPrueba();
            out.println(tablaDelExcel);
        %>                         
        <script src="../Plugins/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="../Plugins/JQuery-UI/jquery-ui.min.js" type="text/javascript"></script>
        <script src="../Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../Plugins/DataTables-1.10.15/media/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="../Plugins/DataTables-1.10.15/media/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
                         <script >
                                 $(document).ready(function() {
                             $('#tablaRasgos').DataTable( {
                                 buttons: [
                                     'copy', 'csv', 'excel', 'pdf'
                                 ]
                             } );
                         } );
                         </script>
    </body>
</html>
