<html>
	<head>
		<title>EJERCICIO 04 SUBIR ARCHIVO</title>
	</head>
	<body>
		<!--Lo real mente importante es en el formulario decir -->
		<!--que van archivos con el enctype igual a MULTIPART/FORM-DATA -->
		<form action="subir.jsp" enctype="multipart/mixed stream" method="post">
			<input type="file" name="file" /><br/>
			<input type="submit" value="Upload" />
		</form>
	</body>
</html>


