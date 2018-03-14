<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Export to Excel - Demo</title>
</head>
<body>
	<%
           String exportToExcel = (String) session.getAttribute("tablaResultados");
           exportToExcel = exportToExcel.replace(".", ",");
           
//			response.setContentType("application/vnd.ms-excel");
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline; filename=excel.xls");
                        response.setHeader("Pragma", "no-cache");
                        response.setDateHeader("Expires", 0);
                out.println(exportToExcel);
	%>
        
</body>
</html>