<%-- 
    Document   : archivosExcell
    Created on : 06-sep-2017, 14:04:37
    Author     : desarrolloJuan
--%>

<%@page import="java.sql.Connection"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="Modelo.Configuracion"%>
<%@page import="BD.Conexion_MySQL"%>
<%@page import="Bean.ManejoFicheros"%>
<%@page import="java.lang.String"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>

<%
    String oper = "" + request.getParameter("funcionalidad");
    Connection conn = (Connection) session.getAttribute("connMySql");
if(oper.equals("nuevoExcellPrueba")){
    if(request.getParameterValues("rasgo") != null){
        String [] titulo = request.getParameterValues("rasgo");
        String fecha = Conexion_MySQL.obtenerFechaActualMySQL();
        String hora = Conexion_MySQL.obtenerHoraActualMySQL().replace(":", "");
        String nombreArchivo = "masivo_"+fecha+ hora;
        nombreArchivo = "formatoMasivo";
        String rutaArchivo = ManejoFicheros.crearArchivoExcelMasivosMediciones(conn,nombreArchivo, titulo);
        if(!rutaArchivo.equals("")){
            String carpeta = Configuracion.getValorConfiguracion(conn, "CARPETA_ARCHIVO");
String urlLocation = request.getRequestURI().split("/")[0];
            %>
    <a id="enlaceFormatoExcel" onclick="$(this).remove();" style="float: right; color: #339900;font-weight: bold;"><i class="fa fa-file-excel-o" style=" font-size: 21px;"></i> Descargar Formato excel</a>

        <script>
alert('<%=urlLocation%>');
        var listURL = location.href.split('/');
        var ruta = listURL[0]+'//'+listURL[2]+'/'+listURL[3]+'/'+'<%=carpeta%>'+'/'+'<%=nombreArchivo%>'+'.xlsx';
        $("#enlaceFormatoExcel").attr("href",ruta);
    //    window.open(ruta);
        </script>
    <%
        }else{
             %>
            <div class="col-xs-12 col-sm-10" style="margin-top: 10px;">
                <div class="alert alert-warning alert-dismissible fade in" role="alert">
                    <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                    </button>
                    <strong>Ocurrio un Error!</strong>Ha ocurriodo un Error al intentar generar la plantilla para la subida masiva de datos, por favor intentelo mas tarde.
                </div>
            </div>
            <%
        }
        
    }else{
        %>
            <div class="col-xs-12 col-sm-10" style="margin-top: 10px;">
                <div class="alert alert-info alert-dismissible fade in" role="alert">
                    <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                    </button>
                    <strong>Importante </strong>Debe seleccionar los campos de datos que desea ingresar a travez del formato de masivas. 
                </div>
            </div>
            <%
    }
}else 
if(oper.equals("cargaDatosMasivos")){
     File destino = new File(Configuracion.getValorConfiguracion(conn, "RUTA_ARCHIVO")+"\\"); 
		ServletRequestContext src = new ServletRequestContext(request);
 
		if(ServletFileUpload.isMultipartContent(src)){
			DiskFileItemFactory factory = new DiskFileItemFactory((1024*1024),destino);
			ServletFileUpload upload = new  ServletFileUpload(factory);
 
			java.util.List lista = upload.parseRequest(src);
			File file = null;
			java.util.Iterator it = lista.iterator();
 String temp_masivo = "tempMasivo.xlsx"; 
			while(it.hasNext()){
				FileItem item=(FileItem)it.next();
				if(item.isFormField())
					out.println(item.getFieldName()+"<br>");
				else
				{
					file=new File(temp_masivo);
//					file=new File(item.getName());
					item.write(new File(destino,temp_masivo));
//					item.write(new File(destino,file.getName()));
					out.println("Fichero subido");
				} // end if
			} // end while
		} // end if
 
}else{
         if(request.getContentLength()>0){
                        File destino = new File(Modelo.Configuracion.getValorConfiguracion(conn, "RUTA_ARCHIVO")+"\\"); 
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
                                                out.println("Fichero subido");
                                        } // end if
                                } // end while
                        } // end if
                }
}
//    String pedro[1] = new String();


//}

%>