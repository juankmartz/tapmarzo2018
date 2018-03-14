<%-- 
    Document   : resultado
    Created on : 13-02-2015, 05:13:03 PM
    Author     : Seba
--%>

<%@page import="Modelo.EnvioCorreos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RESULTADO CORREO ELECTRONICO</title>
    </head>
    <body>
        
        <%
            
            EnvioCorreos email = new EnvioCorreos();
            
            String de = request.getParameter("de");
            String clave = request.getParameter("clave");
            String para = request.getParameter("para");
            String mensaje = request.getParameter("mensaje");
            String asunto = request.getParameter("asunto");
            
           email.cargaDatosConfiguracion();
            if (de==""){ de = email.EmailMaestro;
                clave= email.PassEmail;
            }
            /* 
                
                String[] direcciones = {"correo numero 1","correo numero 2","correo numero 3","correo ..."}
                boolean resultado = email.enviarCorreo(de, clave, direcciones, mensaje, asunto);
            
            */
            
            boolean resultado = email.enviarCorreo(de, clave, para, mensaje, asunto);
            
            if(resultado){
                out.print("CORREO ELECTRONICO CORRECTAMENTE ENVIADO....."+"\n\n"+"<a href='index.jsp'>VOLVER AL INDEX</a>");
            }else{
                out.print("CORREO ELECTRONICO NO ENVIADO....."+"\n\n"+"<a href='index.jsp'>VOLVER AL INDEX</a>"); 
            }
            
        %>
        
    </body>
</html>
