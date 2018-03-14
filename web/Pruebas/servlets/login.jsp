<%-- 
    Document   : login
    Created on : 14-sep-2017, 19:05:11
    Author     : desarrolloJuan
--%>

<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
       
        <title>Login usuarios</title>
    </head>
    <body>
        <div class="container">
            <div class="col-md-offset-3 col-md-6">
                <h1>Formularios con Java Servlets</h1>
                <hr />
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        ${error}
                    </div>
                </c:if>  
                
                <form role="form" method="post" action="login">
                    <div class="form-group">
                      <label for="email">Email</label>
                      <input type="email" class="form-control" name="email"
                             placeholder="Introduce tu email">
                    </div>
                    <div class="form-group">
                      <label for="password">Contraseña</label>
                      <input type="password" class="form-control" name="password" 
                             placeholder="Contraseña">
                    </div>
                    <button type="submit" class="btn btn-success btn-block">Login</button>
                 </form>
            </div>           
        </div>    
    </body>
</html>
