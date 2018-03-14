/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import BD.Conexion_MySQL;
import com.sun.mail.handlers.image_gif;
import java.awt.Image;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author desarrolloJuan
 */
public class Contenido {
    
    int idcontenido;
    String titulo, subtitulo, texto, tipo_contenido;
    String imagen;
//    Image imagen;
    public Contenido(int idcontenido, String titulo, String subtitulo, String texto, String imagen, String tipo_contenido) {
        this.idcontenido = idcontenido;
        this.titulo = titulo;
        this.subtitulo = subtitulo;
        this.texto = texto;
        this.imagen = imagen;
        this.tipo_contenido = tipo_contenido;
    }

    public int getIdcontenido() {
        return idcontenido;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getSubtitulo() {
        return subtitulo;
    }

    public String getTexto() {
        return texto;
    }

    public String getImagen() {
        return imagen;
    }

    public String getTipo_contenido() {
        return tipo_contenido;
    }
    
    public static ArrayList<Contenido> obtenerContenidoByTipo(Connection conn,String tipoContenido) {
        ArrayList<Contenido> listaContenidos = new ArrayList<>();
        try {
            String sql = "SELECT * FROM contenido WHERE tipo_contenido = '" + tipoContenido + "';";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
            while (resp.next()) {
//                Image miImagen = javax.imageio.ImageIO.read(resp.getBlob("imagen").getBinaryStream());
                listaContenidos.add(new Contenido(resp.getInt("idcontenido"), resp.getString("titulo"),
                        resp.getString("subtitulo"), resp.getString("texto"), resp.getString("imagen"),
                        resp.getString("tipo_contenido")));
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
            Logger.getLogger(Contenido.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listaContenidos;
    }
      
}
