/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import BD.Conexion_MySQL;
import Modelo.Rasgo;
import Modelo.proyectos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author desarrolloJuan
 */
@WebServlet(name = "proyectoEstudio", urlPatterns = {"/proyectoEstudio"})
public class proyectoEstudio extends HttpServlet {

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
            String[] individuos = {"0"};
            individuos = request.getParameterValues("individuo");
            for (String idIndi : individuos) {
                out.println(idIndi + "<br>");
            }
        }
    }

    protected void cargaRasgosComunes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String[] idTaxonomia = request.getParameterValues("individuo");
            ArrayList<Rasgo> listRasgos = Rasgo.getRasgosComunesByListIndividuos(conn, idTaxonomia);
            if (listRasgos.size() > 0) {
                for (Rasgo miRasgo : listRasgos) {
                    String contenTabla = "<tr onclick=\"$(this).find('input[type=checkbox]').click();\"><td>" + miRasgo.getNombre() + "</td><td>" + miRasgo.getUnidad() + " </td><td><input type=\"checkbox\" name=\"rasgo\" value=\"" + miRasgo.getIdrasgo() + "\">  </td></tr>";
                    out.println(contenTabla);
                    out.println(miRasgo.getName() + "<br>");
                }
            } else {
                String contenTabla = "<div class=\"form-group\">\n"
                        + "                                    <div class=\"col-xs-12 \" style=\"margin-top: 10px;\">\n"
                        + "                                        <div class=\"alert alert-info alert-dismissible fade in\" role=\"alert\">\n"
                        + "                                            <!--                                                        <button type=\"button\" class=\"blanco close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span>\n"
                        + "                                                                                                    </button>-->\n"
                        + "                                            <strong>Sin Rasgos para asociar!</strong> Al parecer no se han asociado rasgos a las especies de Estudio, por favor verifique.\n"
                        + "                                        </div>\n"
                        + "                                    </div>\n"
                        + "                                </div>";
                out.println(contenTabla);
            }
        } catch (Exception ex) {
            Logger.getLogger(proyectoEstudio.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void guardarProyecto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (
                PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String[] idTaxonomia = request.getParameterValues("individuo");
            ArrayList<Rasgo> listRasgos = Rasgo.getRasgosComunesByListIndividuos(conn, idTaxonomia);
            if (listRasgos.size() > 0) {
                for (Rasgo miRasgo : listRasgos) {
                    String contenTabla = "<tr onclick=\"$(this).find('input[type=checkbox]').click();\"><td>" + miRasgo.getNombre() + "</td><td>" + miRasgo.getUnidad() + " </td><td><input type=\"checkbox\" name=\"rasgo\" value=\"" + miRasgo.getIdrasgo() + "\">  </td></tr>";
                    out.println(contenTabla);
                    out.println(miRasgo.getName() + "<br>");
                }
            } else {
                String contenTabla = "<div class=\"form-group\">\n"
                        + "                                    <div class=\"col-xs-12 \" style=\"margin-top: 10px;\">\n"
                        + "                                        <div class=\"alert alert-info alert-dismissible fade in\" role=\"alert\">\n"
                        + "                                            <!--                                                        <button type=\"button\" class=\"blanco close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span>\n"
                        + "                                                                                                    </button>-->\n"
                        + "                                            <strong>Sin Rasgos para asociar!</strong> Al parecer no se han asociado rasgos a las especies de Estudio, por favor verifique.\n"
                        + "                                        </div>\n"
                        + "                                    </div>\n"
                        + "                                </div>";
                out.println(contenTabla);
            }
        } catch (Exception ex) {
            Logger.getLogger(proyectoEstudio.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void nuevoProyecto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (
                PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String titulo, resumen, descripcion, palabras;
                titulo = request.getParameter("titulo");
                resumen = request.getParameter("resumen");
                palabras = request.getParameter("palabraClave");
                descripcion = request.getParameter("descripcion");
                int IdProyecto = proyectos.registrarProyecto(conn,titulo, descripcion, resumen,palabras, "ACTIVO");
                /*  Segundo paso Asignacion de individuos de INTERES */
                if (request.getParameterValues("individuo") != null) {
                        String[] individuos = request.getParameterValues("individuo");
                        if (proyectos.registrarProyectoIndividuo(conn,IdProyecto, individuos)) {
//        
//        <div class="col-xs-12 col-sm-9 col-lg-6 col-lg-offset-2" style="margin-top: 10px;">
//            <div class="alert alert-success alert-dismissible fade in" role="alert">
//                                <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
//                                </button>
//                <strong>Operación Exitosa!</strong><br> Se asignarón correctamente los individuos al proyecto de estudio.
//            </div>
//        </div>
                        }
                    }
                /* tecer paso Asignacion de Rasgos de INTERES */
                
                if (request.getParameterValues("rasgo") != null) {
                    String[] rasgos = request.getParameterValues("rasgo");
                    if (proyectos.registrarProyectoRasgos(conn,IdProyecto, rasgos)) {
//        %>
//        <div class="col-xs-12 col-sm-9 col-lg-6 col-lg-offset-2" style="margin-top: 10px;">
//            <div class="alert alert-success alert-dismissible fade in" role="alert">
//                <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
//                </button>
//                <strong>Operación Exitosa!</strong> Se asignarón correctamente los rasgos al proyecto de estudio .
//            </div>
//        </div>
//        <script>nuevaNotify('notice','Registro Exitoso','Se completo correctamente el registro del nuevo proyecto de estudio.',20000);</script>
//        <%
//                                        estadoRegistro = "paso_1";
                                    }
                                } else {
//                                    estadoRegistro = "paso_3";
//        %>
//        <div class="col-xs-12 col-sm-9 col-lg-6 col-lg-offset-2" style="margin-top: 10px;">
//            <div class="alert alert-warning alert-dismissible fade in" role="alert">
//                <button type="button" class="blanco close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
//                </button>
//                <strong>Faltan datos para completar la operación!</strong> Se debe seleccionar almenos uno de los rasgo de interes para el estudio, por favor verifique.
//            </div>
//        </div>
//        <%
                }
                
                /*  fin registro nuevo Proyecto */
                
        } catch (Exception ex) {
            Logger.getLogger(proyectoEstudio.class.getName()).log(Level.SEVERE, null, ex);
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
        processRequest(request, response);
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
//        processRequest(request, response);

        conn = (Connection) request.getSession().getAttribute("connMySql");
        if (request.getParameter("oper").equals("cargaRasgosComunes")) {
            cargaRasgosComunes(request, response);

        }
        if (request.getParameter("oper").equals("guardarProyecto")) {
            guardarProyecto(request, response);
        }
        if (request.getParameter("oper").equals("nuevoProyecto")) {
            nuevoProyecto(request, response);
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
