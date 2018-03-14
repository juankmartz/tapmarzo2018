/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import BD.Conexion_MySQL;
import Modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
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
@WebServlet(name = "miLogin", urlPatterns = {"/miLogin"})
public class loginServlet extends HttpServlet {

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
            String nombreUser = request.getParameter("login");
            String password = request.getParameter("password");
            Conexion_MySQL conector = new Conexion_MySQL();
            conn = conector.getCon_mysql();
//            conn = Conexion_MySQL.conectar();
//            Usuario user = new Usuario(conn,nombreUser);
            Usuario user = new Usuario(conector,nombreUser);
            HttpSession misession = request.getSession(true);
            out.println("<script>ocultarLoaderOndaDeCubos();</script>");
            if (user.getId() > 0) {
                if (password.equals(user.getContrasenna())) {
                    user.actualizarUltimoAccesoUSuario(conn);
                    misession.setAttribute("user", user);
                    misession.setAttribute("connMySql",conn);
                    misession.setAttribute("conectorMySql",conector);
                    out.println("<script>nuevaNotify(\"notice\",\"Bienvenido\",\"Te damos la bienvenida " + user.getNombre() + ","
                            + " en segundo se redireccionara para tener acceso a la plataforma.\", 15000);</script>");
                    if(user.getTipoUser().equals("ADMINISTRADOR")){
                        out.println("<script>location.href =\"../Formularios/index.jsp\";</script>");
                    }else{
                         out.println("<script>setInterval(function(){ location.href =\"../\"; }, 10000);</script>");
                    }
                } else {
                    out.println("<script>nuevaNotify(\"warning\",\"Falla de Autentificación\",\"El nombre de usuario no se encuentra registrado, por favor verifiquelo\", 15000);</script>");
                    misession.removeAttribute("user");
                }
            } else {
                misession.removeAttribute("user");
                out.println("<script>nuevaNotify(\"warning\",\"Falla de Autentificación\",\"El nombre de usuario no se encuentra registrado, por favor verifiquelo\", 15000);</script>");
            }
        } catch (Exception ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    protected void cerrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            HttpSession session = request.getSession();
            conn = (Connection)request.getSession().getAttribute("connMySql");
            conn.close();
            session.invalidate();
        } catch (SQLException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        String oper = request.getParameter("oper");
        if (oper != null) {
            if (oper.equals("iniciarsession")) {
        processRequest(request, response);
            }
            if (oper.equals("cerrarSession")) {
        cerrar(request, response);
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
