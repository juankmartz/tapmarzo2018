<%-- 
    Document   : comboxBuscador
    Created on : 3/08/2017, 11:50:08 PM
    Author     : desarrolloJuan
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
            <script src="../Plugins/jquery-3.2.1.min.js" type="text/javascript"></script>
            <link href="../Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
            <link href="../Plugins/Select2/css/select2.min.css" rel="stylesheet" type="text/css"/>
            <script src="../Plugins/Select2/js/select2.min.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				var country = ["Australia", "Bangladesh", "Denmark", "Hong Kong", "Indonesia", "Netherlands", "New Zealand", "South Africa"];
				$("#country").select2({
                                  
				  data: country,
                                  value: ["1", "2", "3", "4", "5", "6", "7", "8"]
				});
                                
                                $("#generado").select2({
                                    placeholder: "Seleccione un estado"
                                });
			});
                        
                        function cambioSelect() {
//                                alert($('select[id=generado]').val());
$("#formulario").submit();
                            }
                        
		</script>
	</head>
	<body>
            <%
            String valor = ""+ request.getParameter("valorSelect");
            
            %>
		<h1>el valor es : <%=valor %></h1>
		<div>
			<select id="country" style="width:300px;">
			<!-- Dropdown List Option -->
			</select>
		</div>
                <div>
                    <form method="post" id="formulario">
                    <select id="generado" name="valorSelect" style="width:300px;" >
                            
                                <option value="1">Primer registro</option>
                                <option value="2">segundo registro</option>
                                <option value="3">Primer registro</option>
                                <option value="ca">carlos</option>
                                <option value="ma">maria</option>
                                <option value="is">isabel</option>	
			</select>
                        <input type="submit" value="Enviar">
                    </form>
		</div>
	</body>
</html>
