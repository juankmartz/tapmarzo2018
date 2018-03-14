/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import Modelo.Rasgo;
import Modelo.SolicitudAcceso;
import Modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author desarrolloJuan
 */
@WebServlet(name = "solicitudAccesoServlet", urlPatterns = {"/solicitudAccesoServlet"})
public class solicitudesAccesoServlet extends HttpServlet {

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
            out.println("<title>Servlet taxonomiaServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet taxonomiaServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
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

        conn = (Connection) request.getSession().getAttribute("connMySql");
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

        conn = (Connection) request.getSession().getAttribute("connMySql");
        String oper = request.getParameter("oper");
        int idSolicitud = Integer.parseInt(request.getParameter("solicitud"));
        if (oper == null) {
        }
        if (oper.equals("Rechazar")) {
//            int idSolicitud = Integer.parseInt( request.getParameter("solicitud"));
            if (SolicitudAcceso.rechazarSolicitudAcceso(conn, idSolicitud)) {
                response.setContentType("text/html;charset=UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script>nuevaNotify('warning','Solicitud rechazada','Se notificara por correo al solicitante que su acceso a la plataforma le fue negado.',10000);"
                            + "</script>");
                }
            }
        } else if (oper.equals("Aceptar")) {

                response.setContentType("text/html;charset=UTF-8");
            if (SolicitudAcceso.aprovarSolicitusAcceso(conn, idSolicitud, new Usuario())) {
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script>nuevaNotify('notice','Solicitud aprovada','Se notificara por correo al solicitante que su acceso a la plataforma le fue aprovado.',10000);</script>");
                }
            }else
                 try (PrintWriter out = response.getWriter()) {
                    out.println("<script>nuevaNotify('notice','Error aprovación','En el proceso de aprovar la solicitud se presento un error, puede ser el envio del correo electronico, por favor verifique que la solicitud no apareca como pendiente.',10000);</script>");
                }
        }

//        processRequest(request, response);
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
