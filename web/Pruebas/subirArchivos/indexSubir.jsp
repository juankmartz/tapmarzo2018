<%-- 
    Document   : indexSubir
    Created on : 05-dic-2017, 10:12:24
    Author     : desarrolloJuan
--%>

<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="Modelo.Configuracion"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
      
        <title>subirnedo archivos e imagenes</title>
    </head>
    <body>
        <%
             File destino = new File(Configuracion.getValorConfiguracion("RUTA_ARCHIVO")+"\\"); 
             
		ServletRequestContext src = new ServletRequestContext(request);
                
		if(ServletFileUpload.isMultipartContent(src)){
			DiskFileItemFactory factory = new DiskFileItemFactory((1024*1024),destino);
			ServletFileUpload upload = new  ServletFileUpload(factory);
 
			java.util.List lista = upload.parseRequest(src);
			File file = null;
			java.util.Iterator it = lista.iterator();
 
			while(it.hasNext()){
				FileItem item=(FileItem)it.next();
				if(item.isFormField())
					out.println(item.getFieldName()+"<br>");
				else
				{
					file=new File(item.getName());
					item.write(new File(destino,file.getName()));
                                        String nombre = request.getParameter("nombre");
					%>
                                        
                                        <h4>Se subio el fichero exitosamente </h4>
                                        <h6><%=nombre %></h6>
                                        <%
				} // end if
			} // end while
		} // end if
            %>
        <form action="indexSubir.jsp" method="post" enctype="multipart/form-data">
            selecciona tu archivo o imagen
            <input type="file" name="archivo" >
            nombre de quien sube el archivo<input type="text" name="nombre">
            <input type="submit" value="Guardar">
        </form>
    </body>
</html>
