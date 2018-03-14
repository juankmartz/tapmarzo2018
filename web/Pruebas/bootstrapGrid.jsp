<%-- 
    Document   : bootstrapGrid
    Created on : 03-sep-2017, 9:03:05
    Author     : desarrolloJuan
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
        <link href="../Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Plugins/CSS/custom.min.css" rel="stylesheet" type="text/css"/>
        <style>
            div{
                border: red solid 1px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-xs-12"> <h3>div col-xs-11</h3></div>
                <div class="col-xs-4">div col-xs-4</div>
                <div class="col-xs-4">div col-xs-4</div>
                <div class="col-xs-4">div col-xs-4</div>
            </div>
        </div>
        <div class="container-fluid center">
            <div class="col-sm-10 row panel center" >
                <div class="panel-title">
                    <div class="col-xs-11"><h3> div col-xs-12</h3></div>
                </div>
                <div class="panel-body">
                    <div class="col-xs-4 row-flow"> 
                        <div style="border: solid 1px #838383;"><h3>hola</h3></div> 
                    </div>
                    <div class="col-xs-4 row-flow"> 
                        <div style="border: solid 1px #838383;"><h3>hola</h3></div> 
                    </div>
                    <div class="col-xs-4 row-flow"> 
                        <div style="border: solid 1px #838383;"><h3>hola</h3></div> 
                    </div>
                    <div class="col-xs-4">div col-xs-4</div>
                    <div class="col-xs-4">div col-xs-4</div>
                </div>
                

            </div>
        </div>

    </body>
</html>
