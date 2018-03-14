<%-- 
    Document   : RegistroClima
    Created on : 18-sep-2017, 13:57:32
    Author     : desarrolloJuan
--%>

<%@page import="java.sql.Connection"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.io.File"%>
<%@page import="Bean.ManejoFicheros"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Clima"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>

<%    
    Usuario user = new Usuario();
    if (session.getAttribute("user") != null) {
        user = (Usuario) session.getAttribute("user");
        session.setMaxInactiveInterval(900);
        if (user.getId() > 0 && !user.getTipoUser().equals("ADMINISTRADOR")) {
            %><script>window.location = "index.jsp";</script> <% return;
        }
    } else { %><script>window.location = "index.jsp";</script> <% return;
        }
%>

<%
    Connection conn = (Connection) session.getAttribute("connMySql");
    if(request.getContentLength()>0){
        File file = null;
        file = ManejoFicheros.guardarArchivoServidor(request);
         if( file!= null){
%><script> setTextoLoader("Registrando datos ...")</script><%
             int[] registros = {0,0};
             registros = ManejoFicheros.leerMasivoClima(conn, file);
           if(registros[0]>0) { 
%>
<script>nuevaNotify("notice","Registro Exitoso",
            "Se procesarón <b><%=registros[0]%></b> registros, equivalentes a <b> <%=registros[1]%></b> datos ingresados en la BD",15000);</script>

<% 
    if(registros[2]>0){
        %>
<script>
    nuevaNotify("warning","Sin Registrar","Se omitierón <b>(<%=registros[2]%>)</b> registros por presentar problemas en los datos, por favor verifique. ",15000);
</script>  <%
    }
        }
else{
%>
<script>
    nuevaNotify("error","Registro Fallido","Se ha presentado problemas al tratar de procesar el cargue masivo de datos, verique que el archivo y los datos no esten corruptos.",15000);
</script>           

<%
}
         }else{
%>
        <div class="col-xs-12 col-md-10 col-md-offset-1" style="margin-top: 10px;">
            <div class="alert alert-warning alert-dismissible fade in" role="alert">
                <button type="button" class="close blanco" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                </button>
                <b>Problemas al Cargar!</b> Se ha presentado problemas al tratar de cargar el archivo, verique la extesion y el tamaño se han correctos.
            </div>
        </div>    
<%
}
    }else
    {
%>
<div class="container-fluid">
    <div class="col-xs-12 ">
        <div class="x_panel ">
            <div class="x_title">
                <h2>Datos Climatico</h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content form-horizontal">
                
                <div class="form-group ">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Temp Out(c°)</th>
                                <th>Hi Temp(c°)</th>
                                <th>Low Temp(c°)</th>
                                <th>Out Hum(%)</th>
                                <th>Rain (mm)</th>
                                <th>Solar Rad. (w/m<sup>2</sup>)</th>
                            </tr>
                        </thead>
                        <tbody>
<%
    ArrayList<Clima> datosClimaticos = Clima.obtenerDatosClimaTodos(conn);
    for(Clima _clima : datosClimaticos){
        %>
        <tr>
            <td><%=_clima.getFecha()%></td>
            <td><%=_clima.getHora()%></td>
            <td><%=_clima.getTempOut()%></td>
            <td><%=_clima.getHiTemp()%></td>
            <td><%=_clima.getLowTemp()%></td>
            <td><%=_clima.getOutHum()%></td>
            <td><%=_clima.getRain()%></td>
            <td><%=_clima.getSolarRad()%></td>
            
        </tr>
<%
    }
%>
                        </tbody>
                    </table>
            </div>
                
            </div>
        </div>
    </div>
                        
<div class="col-xs-6 ">
    <div class="x_panel ">
        <div class="x_title">
            <h2>Datos Climatico</h2>
            <ul class="nav navbar-right panel_toolbox">
                <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
            </ul>
            <div class="clearfix"></div>
        </div>
        <div class="x_content form-horizontal">
            <div class="col-xs-12 ">
                <i class="text-muted">Para realizar la subida masiva de datos es necesario descargar el formato .xlsx es el unico formato permitido para realizar la recoleccion masiva de datos.</i>
            </div>
            <div class="form-group">
                <a href="../Documento/formatoClima.xlsx" id="enlaceFormatoExcel"  style="float: right; color: #339900;font-weight: bold;"><i class="fa fa-file-excel-o" style=" font-size: 21px;"></i> Descargar Formato excel</a>
            </div>
            <div class="ln_solid"></div>
            <form method="post"  enctype="multipart/form-data" onsubmit="envioFormularioFile(this);$('#fileUploadClima').val('');return false;" >
                <div class="form-group">
                    <label >Cargue el Archivo que contiene los datos climaticos a ingresar</label>
                    <p>El registro de los datos puede tardar algunos minutos dependiendo del numero de registros contenidos en el archivo y a la congestion en el servidor.</p>
                    <br>
                    <a href="#1" class="btn btn-primary" onclick="$('#fileUploadClima').click();"><i class="fa fa-upload"></i> Cargar Archivo</a>
                    <input type="file" name="archivoDatosClima" class="hidden" id="fileUploadClima" onchange="$(this).parents('form').submit();" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" required>
                </div>
                <div class="form-group">
                    <!--<input type="submit" class="btn btn-primary" value="Cargar Datos" >-->
                </div>
            </form>
        </div>
    </div>
</div>
</div>
<script>
    
    $(".table").DataTable();
    $("form").attr("action","../Formularios/RegistroClima.jsp")
    function cargarDatosClima(formulario)
    {
        
        var formData = new FormData(formulario);
        $.ajax({
        url: $(formulario).attr("action"),
        type: "post",
        dataType: "html",
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function (data){
            $(formulario).append(data);
        }
        });
        $("#fileUploadClima").val("");
    }
//}
</script>
<%
    }

%>