/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import Modelo.Rasgo;
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
import org.apache.jasper.tagplugins.jstl.core.ForEach;

/**
 *
 * @author desarrolloJuan
 */
@WebServlet(name = "AdminRasgos", urlPatterns = {"/AdminRasgos"})
public class AdminRasgos extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminRasgos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminRasgos at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    protected void buscarRasgos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if(request.getParameter("datoBusqueda") != null && request.getParameter("datoBusqueda")!= ""){
            String datoBuscaqueda = request.getParameter("datoBusqueda");
            ArrayList<Rasgo> listaRasgos = new ArrayList<>();
            listaRasgos = Rasgo.getRasgosListPorCriterio(conn,datoBuscaqueda);
            out.println("<table class='table'>");
            out.println("<thead>");
            out.println("<tr><th>Codigo</th><th>Nombre</th><th>Sigla</th><th>Unidad</th></tr>");            
            out.println("</thead>");
            out.println("<tbody>");
            for(Rasgo elRasgo : listaRasgos){
            out.println("<tr><td>"+elRasgo.getIdrasgo()+"</td><td>"+elRasgo.getNombre()+"</td><td>"+elRasgo.getSigla()+"</td><td>"+elRasgo.getUnidad()+"</td></tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
            }else{
            String notificacion = "<script>nuevaNotify(\"warning\",\"Sin Criterio\",\"No fue posible realizar la busqueda. verifique por favor\",15000);</script>";
            out.println(notificacion);
            }
        }
    }
    
     protected void registroRasgo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String nombre = "", name = "", tipoRasgo = "", tipoDato = "", sigla = "",unidad = "", descripcion ="";
            if(request.getParameter("nombre")!= null)nombre = request.getParameter("nombre");
            if(request.getParameter("name")!= null)name = request.getParameter("name");
            if(request.getParameter("tipoDato")!= null)tipoDato = request.getParameter("tipoDato");
            if(request.getParameter("tipoRasgo")!= null)tipoRasgo = request.getParameter("tipoRasgo");
            if(request.getParameter("sigla")!= null)sigla = request.getParameter("sigla");
            if(request.getParameter("unidad")!= null)unidad = request.getParameter("unidad");
            if(request.getParameter("descripcion")!= null)descripcion = request.getParameter("descripcion");
            String nombreColumna = nombre.replace(" ", "");
            String notificacion = ""; 
            if(!Rasgo.existeNombreColumna(conn,nombreColumna)){
            if (Rasgo.registrarRasgo(conn,nombre,name,unidad,descripcion,nombreColumna,tipoDato,tipoRasgo,sigla)>0) {
                notificacion = "<script>nuevaNotify(\"notice\",\"Registro Rasgo\",\"Se registro correctamente el rasgo en la BD.\",15000);</script>";

            } else {
                notificacion = "<script>nuevaNotify(\"error\",\"Falla al registrar\",\"No fue posible registrar el nuevo rasgo. Intentelo mas tarde.\",15000);</script>";
            }
            }
            else{
                notificacion = "<script>nuevaNotify(\"warning\",\"Duplicidad \",\"Se encontro otro rasgo con el mismo nombre. verifique por favor.\",15000);</script>";
            }
            out.println(notificacion);
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
        conn = (Connection)request.getSession().getAttribute("connMySql");
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
        conn = (Connection)request.getSession().getAttribute("connMySql");
        String oper = request.getParameter("oper");
        if (oper.equals("resgistrarRasgo")) {
            try {
                registroRasgo(request, response);
            } catch (Exception ex) {
                Logger.getLogger(taxonomiaServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else
        if (oper.equals("buscarRasgos")) {
            try {
                buscarRasgos(request, response);
            } catch (Exception ex) {
                Logger.getLogger(taxonomiaServlet.class.getName()).log(Level.SEVERE, null, ex);
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
