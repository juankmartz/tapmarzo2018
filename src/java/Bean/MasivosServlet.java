/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import Modelo.Configuracion;
import Modelo.Rasgo;
import Modelo.taxonomia;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

/**
 *
 * @author desarrolloJuan
 */
@WebServlet(name = "masivoServlet", urlPatterns = {"/masivoServlet"})
public class MasivosServlet extends HttpServlet {

    private Connection conn;
    private File fichero;

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
            out.println("</html>");
        }
    }

    protected void guardarImagenespecie(HttpServletRequest request, HttpServletResponse response, List items)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            int idNuevaEspecie = 0;
            FileItem imagen = null;

            for (Object item : items) {
                FileItem uploaded = (FileItem) item;

                // Hay que comprobar si es un campo de formulario. Si no lo es, se guarda el fichero
                if (!uploaded.isFormField()) {

                    imagen = uploaded;

                } else {
                    // es un campo de formulario, podemos obtener clave y valor
                    String key = uploaded.getFieldName();
                    String valor = uploaded.getString();
                    switch (key) {
                        case "idEspecieNueva":
                            idNuevaEspecie = Integer.valueOf(valor);
                            break;
                    }
                }
            }
            if (imagen != null && idNuevaEspecie > 0) {
                // No es campo de formulario, guardamos el fichero en algún sitio
                String rutaImagen = Configuracion.getValorConfiguracion(conn, "RUTA_IMAGENES") + "\\" + Configuracion.getValorConfiguracion(conn, "CARPETA_IMAGEN_ESPECIE") + "\\";

//                    String nombreFile = uploaded.getName();
                String extencion = imagen.getName();
                extencion = extencion.substring(extencion.lastIndexOf("."));
                String nombreFile = "especie_" + idNuevaEspecie + extencion;
                File fichero = new File(rutaImagen, nombreFile);
                imagen.write(fichero);
                rutaImagen = Configuracion.getValorConfiguracion(conn, "CARPETA_IMAGEN_ESPECIE") + "\\" + nombreFile;
                taxonomia.actualizarImagenByIdEspecie(conn, idNuevaEspecie, rutaImagen);
            }

        }
    }

    protected void nuevaEspecie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
//            String clase =  request.getParameter("clase");
//        String subclase = request.getParameter("subclase");
            String orden = request.getParameter("orden");
            String familia = request.getParameter("familia");
            String genero = request.getParameter("genero");
            String especie = request.getParameter("especie");
            String nombrecomun = request.getParameter("nombreComun");

            String notificacion = "";
            ArrayList<taxonomia> especieExistente = taxonomia.getEspeciesListByNombre(conn, especie);
            if (0 == especieExistente.size()) {
                int idEspecie = taxonomia.registrarEspecie(conn, "", "", orden, familia, genero, especie, nombrecomun);
//        registrando los rasgos asociados a la nueva especie
                if (idEspecie > 0) {
                    notificacion = "$('#idEspecieNueva').val('" + idEspecie + "');$('#form_imgNuevaEspecie').submit();";
                    String[] rasgos = request.getParameterValues("rasgo");
                    if (Rasgo.registroCaracteristicaEspecieRagos(conn, idEspecie, rasgos)) {
                        notificacion += "nuevaNotify(\"notice\",\"REGISTRO EXITOSO\",\"La Especie '" + especie + "' fue registrada correctamente y esta disponible para ser utilizada.\",10000);";
                    } else {
//                   se registro sin Rasgos la nueva Especie
                        notificacion += "nuevaNotify(\"notice\",\"REGISTRO EXITOSO\",\"La Especie '" + especie + "' fue registrada sin asignarsele NINGUN rasgo, se recomienda asignar los rasgos a la especie antes de utilizarla.\",20000);";
                    }
                } else {
                    notificacion = "nuevaNotify(\"warning\",\"REGISTRO FALLIDO\",\"No fue completar el registro de la nueva especie. verifique los datatos suministrados o Intentelo mas tarde.\",10000);";
                }
            } else {
                notificacion += "nuevaNotify(\"warning\",\"DUPLICIDAD DE ESPECIE\",\"La Especie '" + especie + "' ya se encuentra registra en la BD, por favor verifiquelo e intentelo nuevamente.\",10000);";
            }
            out.println("<script>" + notificacion + "</script>");
        }
    }

    protected void imagenEspecie(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession sesion = request.getSession();
            response.setContentType("image/jpeg");

            if (sesion.getAttribute("imagenEspecie") != null) {
                byte[] imag = (byte[]) sesion.getAttribute("imagenEspecie");
                ServletOutputStream out2 = response.getOutputStream();
                out2.write(imag);
            } else {
                JOptionPane.showMessageDialog(null, "Else Null");
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Error" + ex);
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
        List items = null;
        if (oper == null) {
            try {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                items = upload.parseRequest(new ServletRequestContext(request));
                for (Object item : items) {
                    FileItem uploaded = (FileItem) item;
                    if (!uploaded.isFormField()) {
                        // No es campo de formulario, guardamos el fichero en algún sitio
//                        String rutaImagen = Configuracion.getValorConfiguracion(conn, "RUTA_IMAGENES") + "\\";
//                        File fichero = new File("/tmp", uploaded.getName());
//                        uploaded.write(fichero);
                    } else {
                        // es un campo de formulario, podemos obtener clave y valor
                        String key = uploaded.getFieldName();
                        String valor = uploaded.getString();
                        if (key.equals("oper")) {
                            oper = valor;
                        }

                    }
                }
            } catch (FileUploadException ex) {
                Logger.getLogger(MasivosServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (Exception ex) {
                Logger.getLogger(MasivosServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if (oper.equals("buscarRasgoEspecie")) {
            try {
//                buscarRagosAsociadosEspecie(request, response);
            } catch (Exception ex) {
                Logger.getLogger(MasivosServlet.class.getName()).log(Level.SEVERE, null, ex);
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
