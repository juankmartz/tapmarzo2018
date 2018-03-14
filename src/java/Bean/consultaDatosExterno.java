/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import BD.Conexion_MySQL;
import Modelo.Rasgo;
import Modelo.localidad;
import Modelo.taxonomia;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author desarrolloJuan
 */
@WebServlet(name = "consultaDatosExterno", urlPatterns = {"/consultaDatosExterno"})
public class consultaDatosExterno extends HttpServlet {

    int numero_decimales = 4;
    private Connection conn;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("</html>");
            try {
                ResultSet miResp = Conexion_MySQL.ejecutarConsulta(conn,"");
            } catch (Exception ex) {
                Logger.getLogger(consultaDatosExterno.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    protected void exportarExcelTabla(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "inline; filename=excel.xls");
        String tabla = "";
        HttpSession sesion = request.getSession(false);
        tabla = (String) sesion.getAttribute("tablaResultados");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println(tabla);
        }
    }

    protected void seleccionEspecieBuscarRasgos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        String[] ListIdEspecie = {"0"};
        ArrayList<Rasgo> listRasgos = new ArrayList<>();
        if (request.getParameterValues("especieBusqueda") != null) {
            ListIdEspecie = request.getParameterValues("especieBusqueda");
            listRasgos = Rasgo.getRasgosComunesbyIdEspecie(conn,ListIdEspecie);
        } else {
            listRasgos = Rasgo.getRasgosList(conn);
        }
        try (PrintWriter out = response.getWriter()) {
//            String opciones = "<select name=\"rasgoBusqueda\" class=\"form-control selectpicker\" id=\"selctEspecieRasgo\" data-style=\"btn-info\" data-live-search=\"true\" multiple>";
            String opciones = "";
//            String tipoRasgo = "";

            /* TODO output your page here. You may use following sample code. */
            for (Rasgo miRasgo : listRasgos) {
//                if(miRasgo.getTiporasgo() == null) miRasgo.setTiporasgo("sin definir");
//                if(!miRasgo.getTiporasgo().equals(tipoRasgo)){
//                    if(tipoRasgo.equals("")){
//                        opciones += "<optgroup label=\""+miRasgo.getTiporasgo()+"\">";
//                        tipoRasgo = miRasgo.getTiporasgo();
//                    }
//                    else
//                        opciones += "</optgroup><optgroup label=\""+miRasgo.getTiporasgo()+"\">";
//                        tipoRasgo = miRasgo.getTiporasgo();
//                }
                opciones += " <option value=\"" + miRasgo.getIdrasgo() + "\">" + miRasgo.getNombre() + "</option>";
            }
//             opciones += "</optgroup></select>"
//                 + "<script>$('.selectpicker').selectpicker('show');</script>";
            out.println(opciones);
        }
    }

    protected void seleccionLocalidadBuscarEspecie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        String[] ListIdLocalidad = {"0"};
        ArrayList<taxonomia> listEspecies = new ArrayList<>();
        if (request.getParameterValues("LocalidadBusqueda") != null) {
            ListIdLocalidad = request.getParameterValues("LocalidadBusqueda");
            listEspecies = taxonomia.getEspeciesListByLocalidad(conn,ListIdLocalidad);
        } else {
            listEspecies = taxonomia.getEspeciesList(conn);
        }
        try (PrintWriter out = response.getWriter()) {
            String opciones = "";

            for (taxonomia miEspecie : listEspecies) {

                opciones += " <option value=\"" + miEspecie.getIdespecie() + "\">" + miEspecie.getEspecie() + "</option>";
            }

            out.println(opciones);
        }
    }

    protected void consultaDatos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String[] filtros = request.getParameterValues("filtro");

        response.setContentType("text/html;charset=UTF-8");
        String sql = "select M.fecha , M.hora , (select especie from taxonomia t where t.idtaxonomia = (select idtaxonomia from individuo where idindividuo = M.idindividuo) ) as especie ,";
        String filts = "";
        String filtEspecie = "";
        String camposRasgos = "";
        String filtRasgos = "";
        String filtFechas = "";
        String[] listaEspecie = {"0"};
        ArrayList<Rasgo> listRasgos = new ArrayList<>();
        if (request.getParameterValues("filtro") != null) {
            for (String nombreFiltro : filtros) {
                if (nombreFiltro.equals("tempPromedio")) {
                    filts += " (select ROUND(avg(temp)," + numero_decimales + ")  from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as temp , ";
                }
                if (nombreFiltro.equals("tempMax")) {
                    filts += " (select ROUND(avg(temp_max)," + numero_decimales + ")  from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as temp_max ,";
                }
                if (nombreFiltro.equals("tempMin")) {
                    filts += " (select ROUND(avg(temp_min)," + numero_decimales + ")  from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as temp_min ,";
                }
                if (nombreFiltro.equals("humedad")) {
                    filts += " (select ROUND(avg(humedad)," + numero_decimales + ")  from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as humedad ,";
                }
                if (nombreFiltro.equals("lluvia")) {
                    filts += " (select ROUND(avg(lluvia)," + numero_decimales + ") from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as lluvia ,";
                }
                if (nombreFiltro.equals("radiacion")) {
                    filts += " (select ROUND(avg(radiacion)," + numero_decimales + ")  from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as radiacion ";
                }
                if (nombreFiltro.equals("filtroEspecie") && request.getParameterValues("rasgoBusqueda") == null) {
                    listaEspecie = request.getParameterValues("especieBusqueda");
//                ArrayList <taxonomia> listEspecie = taxonomia.getEspeciesList(listaEspecie);
                    for (String idTax : listaEspecie) {
                        filtEspecie += " '" + idTax + "' ,";
                    }
                    filtEspecie = filtEspecie.substring(0, filtEspecie.length() - 1);
                    filtEspecie = " M.idindividuo in (select I.idindividuo from individuo I where I.idtaxonomia IN ( " + filtEspecie + " ) ) ";
                }

                if (nombreFiltro.equals("filtroRasgos") && request.getParameterValues("rasgoBusqueda") != null) {

                    String[] listaRasgo = request.getParameterValues("rasgoBusqueda");
                    listRasgos = Rasgo.getRasgosList(conn, listaRasgo);
                    for (Rasgo miRasgo : listRasgos) {
                        camposRasgos += " M." + miRasgo.getNombre_columna() + " ,";
                        filtRasgos += " M." + miRasgo.getNombre_columna() + " != 'null' AND";
                    }
                    filtRasgos = filtRasgos.substring(0, filtRasgos.length() - 3);
                    camposRasgos = camposRasgos.substring(0, camposRasgos.length() - 1);

                }

                if (nombreFiltro.equals("filtroFechas") && request.getParameterValues("fechaInicial") != null && request.getParameterValues("fechaFinal") != null) {
                    String fechaIni = "", fechaFin = "";
                    fechaIni = request.getParameter("fechaInicial");
                    fechaFin = request.getParameter("fechaFinal");
                    filtFechas = "  M.fecha between '" + fechaIni + "' and '" + fechaFin + "' ";
                }

            }
        }
        if (!filts.equals("")) {
            if (filts.substring(filts.length() - 1, filts.length()).equals(",")) {
                filts = filts.substring(0, filts.length() - 1);
            }
            sql = sql + filts + ",";
        }

        if (!camposRasgos.equals("")) {
            sql = sql + camposRasgos;
        } else {
            if (request.getParameterValues("especieBusqueda") != null) {
                listaEspecie = request.getParameterValues("especieBusqueda");
            }
            listRasgos = Rasgo.getRasgosComunesByListIndividuos(conn, listaEspecie);
            for (Rasgo miRasgo : listRasgos) {
                camposRasgos += " M." + miRasgo.getNombre_columna() + " ,";
                filtRasgos += " M." + miRasgo.getNombre_columna() + " != 'null' AND";
            }
            if (filtRasgos.length() > 0) {
                filtRasgos = filtRasgos.substring(0, filtRasgos.length() - 3);
            }
            if (camposRasgos.length() > 0) {
                camposRasgos = camposRasgos.substring(0, camposRasgos.length() - 1);
            }
            sql = sql + camposRasgos;
        }

        if (sql.substring(sql.length() - 1, sql.length()).equals(",")) {
            sql = sql.substring(0, sql.length() - 1);
        }
        sql += " FROM medicion M ";
        if (!filtEspecie.equals("") || !filtFechas.equals("") || !filtRasgos.equals("")) {
            sql = sql + " WHERE ";
            if (!filtEspecie.equals("")) {
                sql += filtEspecie + "AND";
            }
            if (!filtFechas.equals("")) {
                sql += filtFechas + "AND";
            }
            if (!filtRasgos.equals("")) {
                sql += filtRasgos;
            }
            if (sql.substring(sql.length() - 3, sql.length()).equals("AND")) {
                sql = sql.substring(0, sql.length() - 3);
            }
        }
        System.out.println("\n*********\n" + sql + "\n********\n");
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
        String tabla = "<table class= \"table\" id=\"tablaResultado\"> ";
        if (resp.next()) {
            resp.beforeFirst();
            String tablaHeder = "<thead> <tr>";
            String tablaBody = "<tbody>";
            ResultSetMetaData rsmd = resp.getMetaData();
//            int numColum = rsmd.getColumnCount();

            for (int k = 1; k <= rsmd.getColumnCount(); k++) {
                tablaHeder += "<th>" + rsmd.getColumnName(k) + "</th>";
            }
            tablaHeder += "</tr></thead>";
            while (resp.next()) {
                tablaBody += "<tr>";
                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    tablaBody += "<td>" + resp.getString(i) + "</td>";
                }
                tablaBody += "</tr>";
            }
            tablaBody += "</tbody>";
            tabla = tabla + tablaHeder + tablaBody + "</table>";
        } else {
            tabla = "<i> Sin Resultados para la consulta</i> <br>Modifique y verique los filtros aplicados y realize una nueva busqueda.";
        }
        String exportExcel = "";
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<div class=\"form-group\"><a href=\"excel.jsp\" class=\" btn btn-success btn-xs\"><i class=\"fa fa-file-excel-o\"></i> Exportar a Excel</a></div>");
//           out.println( tabla + "<script>$('table').DataTable( { \"lengthMenu\": [[5, 25, 50, -1], [5, 25, 50, \"All\"]]});</script>");
//            out.println(tabla + "<script>$('#tablaResultado').DataTable( );</script>");
            out.println(tabla );
            HttpSession sesion = request.getSession(false);
            sesion.setAttribute("tablaResultados", tabla);
        }
    }

    protected void consultaDatos2(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String[] filtros = request.getParameterValues("filtro");
        String tablaLocalidades = "";
        boolean filtEspecie = false, filtRasgo = false, filtFecha = false, filtLocalidad = false;
        response.setContentType("text/html;charset=UTF-8");
        String sql = "select M.fecha , M.hora , (select especie from taxonomia t where t.idtaxonomia = (select idtaxonomia from individuo where idindividuo = M.idindividuo) ) as especie ,";
        String filts = "";
        boolean existeResultados = false;
        /* filtros adicionales que se mostraran en los resultados */
        String filtEspecies = "";
        String camposRasgos = "";
        String filtRasgos = "";
        String filtFechas = "";
        String filtLocalidades = "";
        String[] listaEspecie = {"0"};
        ArrayList<Rasgo> listRasgos = new ArrayList<>();
        String unidadCampos = "", nombreCampos = "";
        if (request.getParameterValues("filtro") != null) {
            for (String nombreFiltro : filtros) {
                if (nombreFiltro.equals("filtroEspecie") && request.getParameterValues("especieBusqueda") != null) {
                    filtEspecie = true;
                }
                if (nombreFiltro.equals("filtroRasgos") && request.getParameterValues("rasgoBusqueda") != null) {
                    filtRasgo = true;
                }
                if (nombreFiltro.equals("filtroFechas") && request.getParameter("fechaInicial") != null && request.getParameter("fechaFinal") != null) {
                    filtFecha = true;
                }
                if (nombreFiltro.equals("filtroLocalidad") && request.getParameterValues("LocalidadBusqueda") != null) {
                    filtLocalidad = true;
                }
                if (nombreFiltro.equals("tempPromedio")) {
                    filts += " (select ROUND(avg(temp)," + numero_decimales + ")   from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as 'xxtemperatura promedio' , ";
                    unidadCampos += "'°c',";
                    nombreCampos += "'Temp Out',";
                    nombreCampos += "'Temp prom',";
                }
                if (nombreFiltro.equals("tempMax")) {
                    filts += " (select ROUND(avg(temp_max)," + numero_decimales + ") from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as 'xxtemperatura maxima' ,";
                    unidadCampos += "'°c',";
                    nombreCampos += "'High Temp ',";
                    nombreCampos += "'Max temp',";
                }
                if (nombreFiltro.equals("tempMin")) {
                    filts += " (select ROUND(avg(temp_min)," + numero_decimales + ")   from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as 'temperatura minima' ,";
                    unidadCampos += "'°c',";
                    nombreCampos += "'Low Temp',";
                    nombreCampos += "'Min temp',";
                }
                if (nombreFiltro.equals("humedad")) {
                    filts += " (select ROUND(avg(humedad)," + numero_decimales + ")  from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as humedad ,";
                    unidadCampos += "'%',";
                    nombreCampos += "'Out Hum',";
                    nombreCampos += "'Hum prom',";
                }
                if (nombreFiltro.equals("lluvia")) {
                    filts += " (select ROUND(avg(lluvia)," + numero_decimales + ") from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as lluvia ,";
                    unidadCampos += "'mm',";
                    nombreCampos += "'Rain',";
                    nombreCampos += "'precipitación',";
                }
                if (nombreFiltro.equals("radiacion")) {
                    filts += " (select ROUND(avg(radiacion)," + numero_decimales + ")  from clima where month( clima.fecha) = month(M.fecha) AND year(clima.fecha) = year(M.fecha) ) as radiacion ";
                    unidadCampos += "'w/m2',";
                    nombreCampos += "'Solar Rad',";
                    nombreCampos += "'Rad solar',";
                }
                if (nombreFiltro.equals("infoLocalidad")) {
                    camposRasgos = " (select nombre from localidad where idlocalidad = (select idlocalidad from individuo where idindividuo = M.idindividuo)) as Localidad ," + camposRasgos;
//                    String tablaLocalidades = "";
                    String sql2 = "";
                    if (camposRasgos.substring(0, camposRasgos.length() - 1).equals(",")) {
                        camposRasgos = camposRasgos.substring(0, camposRasgos.length() - 1);
                    }
                    if(filtLocalidad){
                        String[] idLocalidades = request.getParameterValues("LocalidadBusqueda");
                       ArrayList<localidad> infoLocalidad = new ArrayList<>();
                       infoLocalidad = localidad.getLocalidadesList(conn,idLocalidades);
                    }else{
                        if(filtEspecie){
                            String remplazo = "";
                        String[] idEspecie = request.getParameterValues("especieBusqueda");
                        for(String local : idEspecie){
                            remplazo += "'"+local+"' ,";
                        }
                        if(remplazo.substring(remplazo.length()-1,remplazo.length()).equals(","))remplazo = remplazo.substring(0, remplazo.length()-1);
                        sql2 = "select nombre as localidad, longitud, latitud, altitud, (select count(idlocalidad) from individuo where idlocalidad= L.idlocalidad) as diversidad from localidad L where idlocalidad in (xxx||xxx) ;";
                        sql2 = sql2.replace("xxx||xxx", remplazo);
                        }else
                            if(filtRasgo){
                                
                            }
                    }
                       ArrayList<localidad> infoLocalidad = new ArrayList<>();
                       infoLocalidad = localidad.getLocalidadesList(conn);
                       
                       for(localidad miLocal : infoLocalidad){
                          tablaLocalidades = tablaLocalidades + "<tr><td>"+miLocal.getIdlocalidad()+"</td>"
                               + "<td>"+miLocal.getNombre()+"</td>"
                               + "<td>"+miLocal.getLat()+"</td>"
                               + "<td>"+miLocal.getLon()+"</td>"
                               + "<td>"+miLocal.getAltitud()+"</td></tr>";
                       }
                }
            }
        }
        if (filtEspecie) {

            listaEspecie = request.getParameterValues("especieBusqueda");
            for (String idTax : listaEspecie) {
                filtEspecies += " '" + idTax + "' ,";
            }
//            if (filtEspecies.substring(0, filtEspecies.length() - 1).equals(",")) {
                filtEspecies = filtEspecies.substring(0, filtEspecies.length() - 1);
//            }
            filtEspecies = " M.idindividuo in (select I.idindividuo from individuo I where I.idtaxonomia IN ( " + filtEspecies + " ) ) ";

        }
        if (filtRasgo) {

            String[] listaRasgo = request.getParameterValues("rasgoBusqueda");
            listRasgos = Rasgo.getRasgosList(conn,listaRasgo);
            for (Rasgo miRasgo : listRasgos) {
                unidadCampos += "'" + miRasgo.getUnidad() + "',";
//                nombreCampos += "'" + miRasgo.getNombre() + "',";
                nombreCampos += "'" + miRasgo.getSigla()+ "',";
//                camposRasgos += " ROUND(M." + miRasgo.getNombre_columna() + "," + numero_decimales + ") as '" + miRasgo.getNombre() + "' ,";
                camposRasgos += " ROUND(M." + miRasgo.getNombre_columna() + "," + numero_decimales + ") as '" + miRasgo.getSigla()+ "' ,";
                filtRasgos += " M." + miRasgo.getNombre_columna() + " != 'null' AND";
            }
            filtRasgos = filtRasgos.substring(0, filtRasgos.length() - 3);
            camposRasgos = camposRasgos.substring(0, camposRasgos.length() - 1);
        }
        if (filtFecha) {
            String fechaIni = "", fechaFin = "";
            fechaIni = request.getParameter("fechaInicial");
            fechaFin = request.getParameter("fechaFinal");
            filtFechas = "  M.fecha between '" + fechaIni + "' and '" + fechaFin + "' ";
        }
        if (filtLocalidad) {
            
            String idLocalidades = "";
            String[] listaLocalidad = request.getParameterValues("LocalidadBusqueda");
            for (String idLocal : listaLocalidad) {
                idLocalidades += " '" + idLocal + "' ,";
            }
            idLocalidades = idLocalidades.substring(0, idLocalidades.length() - 1);/* eliminamos la como del final*/
            filtLocalidades = "M.idindividuo in (select idindividuo from  individuo where idlocalidad in ( " + idLocalidades + " )) ";

        }
        if (!filts.equals("")) {
            if (filts.substring(filts.length() - 1, filts.length()).equals(",")) {
                filts = filts.substring(0, filts.length() - 1);
            }
            sql = sql + filts + ",";
        }

        if (filtRasgo) {
            sql = sql + camposRasgos;
        } else {
            if (filtEspecie) {
                listRasgos = Rasgo.getRasgosComunesByListIndividuos(conn, listaEspecie);
            } else {
                listRasgos = Rasgo.getRasgosList(conn);
            }
            for (Rasgo miRasgo : listRasgos) {
                unidadCampos += "'" + miRasgo.getUnidad() + "',";
//                nombreCampos += "'" + miRasgo.getNombre() + "',";
                nombreCampos += "'" + miRasgo.getSigla()+ "',";
                camposRasgos += " ROUND(M." + miRasgo.getNombre_columna() + "," + numero_decimales + ") as '" + miRasgo.getSigla()+ "' ,";
//                camposRasgos += " ROUND(M." + miRasgo.getNombre_columna() + "," + numero_decimales + ") as 'xxx_" + miRasgo.getNombre() + "' ,";
                filtRasgos += " M." + miRasgo.getNombre_columna() + " != 'null' AND";
            }
            if (filtRasgos.length() > 0) {
                filtRasgos = filtRasgos.substring(0, filtRasgos.length() - 3);
            }
            if (camposRasgos.length() > 0) {
                camposRasgos = camposRasgos.substring(0, camposRasgos.length() - 1);
            }
            sql = sql + camposRasgos;
        }

        if (sql.substring(sql.length() - 1, sql.length()).equals(",")) {
            sql = sql.substring(0, sql.length() - 1);
        }
        sql += " FROM medicion M ";
         String tabla = "";
        if (filtEspecie || filtFecha || filtRasgo || filtLocalidad) {
            sql = sql + " WHERE ";
            if (filtLocalidad) {
                sql += filtLocalidades + "AND";
            }
            if (filtEspecie) {
                sql += filtEspecies + "AND";
            }
            if (filtFecha) {
                sql += filtFechas + "AND";
            }
//            if (filtRasgo) {
            sql += filtRasgos;
            /* verificar no nullos en resultados */
//            }
            if (sql.substring(sql.length() - 3, sql.length()).equals("AND")) {
                sql = sql.substring(0, sql.length() - 3);
            }
//        }
            System.out.println("\n*********\n" + sql + "\n********\n");
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            tabla = "<table class= \"table\" id=\"tablaResultado\"> ";

            if (resp.next()) {

                resp.beforeFirst();
                String tablaHeder = "<thead> <tr>";
                String tablaBody = "<tbody>";
                ResultSetMetaData rsmd = resp.getMetaData();
                int numColum = rsmd.getColumnCount();

                for (int k = 1; k <= rsmd.getColumnCount(); k++) {
                    tablaHeder += "<th>" + rsmd.getColumnLabel(k) + "</th>";
                }
                tablaHeder += "</tr></thead>";
                while (resp.next()) {
                    tablaBody += "<tr>";
                    for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                        tablaBody += "<td>" + resp.getString(i) + "</td>";
                    }
                    tablaBody += "</tr>";
                }
                tablaBody += "</tbody>";
                tabla = tabla + tablaHeder + tablaBody + "</table>";
                existeResultados = true;
            } else {
                existeResultados = false;
                tabla = "<i> Sin Resultados para la consulta</i> <br>Modifique y verique los filtros aplicados y realize una nueva busqueda.";
            }
            if (unidadCampos.substring(unidadCampos.length() - 1, unidadCampos.length()).equals(",")) {
                unidadCampos = unidadCampos.substring(0, unidadCampos.length() - 1);
            }
            if (nombreCampos.substring(nombreCampos.length() - 1, nombreCampos.length()).equals(",")) {
                nombreCampos = nombreCampos.substring(0, nombreCampos.length() - 1);
            }
        }
//        String exportExcel  = ""; 
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            if (existeResultados) {
                out.println("<div class=\"form-group\"><a href=\"excel.jsp\" class=\" btn btn-success btn-xs\"><i class=\"fa fa-file-excel-o\"></i> Exportar a Excel</a></div>");
//           out.println( tabla + "<script>$('table').DataTable( { \"lengthMenu\": [[5, 25, 50, -1], [5, 25, 50, \"All\"]]});"
                out.println(tabla + "<script>$tablaResultado = $('#tablaResultado').DataTable( { \"lengthMenu\": [[ -1,20,50,100], [\"All\",20,50,100]]});"
                        + "cargarSelectGrafica([" + unidadCampos + "],[" + nombreCampos + "]);\n" +
"$('#tablaLocalidades').find('tbody').html('"+tablaLocalidades+"'); mostrarResultados();agregarMenuHoverTabla('tablaResultado');</script>");
                HttpSession sesion = request.getSession(false);
                sesion.setAttribute("tablaResultados", tabla);
            } else {
                out.println(tabla + "<script>ocultarResultados();nuevaNotify(\"warning\",\"Sin Resultados\", \"No se encontrarón resultados con los filtros actuales de busqueda, modifique los filtros e intentelo nuevamente\", 15000); </script>");
            }
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        exportarExcelTabla(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
conn = (Connection)request.getSession().getAttribute("connMySql");
        String oper = request.getParameter("oper");
        if (oper != null) {
            if (oper.equals("consultaDatosExterno")) {
                try {
                    consultaDatos2(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(consultaDatosExterno.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (oper.equals("exportExcelTable")) {
                exportarExcelTabla(request, response);
            }
            if (oper.equals("seleccionEspecieBuscarRasgos")) {
                try {
                    seleccionEspecieBuscarRasgos(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(consultaDatosExterno.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (oper.equals("seleccionLocalidadBuscarEspecie")) {
                try {
                    seleccionLocalidadBuscarEspecie(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(consultaDatosExterno.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
