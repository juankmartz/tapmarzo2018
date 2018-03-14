<%-- 
    Document   : modal
    Created on : 24-ago-2017, 17:14:46
    Author     : desarrolloJuan
--%>

<%@page import="Modelo.Rasgo"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
        <link href="../Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/JQuery-UI/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <input type="button" value="Mostrar Modal" onclick="showModal('idmodal')">
        <button type="button" data-toggle="modal" data-target="#idmodal">Open Modal</button>
        <table>
            <thead>
            
           
        <%
            int[] numero = { 1, 2,3,1,4,4};
            ArrayList<Integer> listaNuemeros = new ArrayList<>();
            for(int minumero : numero){
            %>
                <th>array : <%=minumero%></th>
            <%
                listaNuemeros.add(minumero);
                }
                %>
                </thead>
                <tbody><tr>
           <%
            for(Integer miNum : listaNuemeros){
            %>
                <td>ArrayList : <%=miNum%></td>
            <%
                }
                %>
                    </tr>
                </tbody>
                 
        </table>
        <div id="idmodal" class="modal" role="dialog">
            <div class="modal-dialog " >
                <div class="modal-content" >
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Modal Header</h4>
                    </div>
                    <div class="modal-body " >
                        <table>
                            <tr>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                <th>nombre</th>
                                <th>apellido</th>
                                <th>edad</th>
                                
                            </tr>
                            <tr>
                                <td>claudia</td>
                                <td>patiño</td>
                                <td>25</td>
                            </tr>
                            <tr>
                                <td>paola</td>
                                <td>rey</td>
                                <td>26</td>
                            </tr>
                            <tr>
                                <td>andrea</td>
                                <td>castillo</td>
                                <td>54</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </div>
        
        <script src="../Plugins/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="../Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
        
        <script>
            function showModal(){
                
            }
        </script>
    </body>
</html>
