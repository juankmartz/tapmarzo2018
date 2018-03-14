
package Modelo;

import BD.Conexion_MySQL;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author desarrolloJuan
 */
public class Usuario {
    int id;
    String  nombre, iduser, contrasenna, correo, tipoUser;
    Date fechaCreo;
    HashMap<String, String> permisos;
    Connection miconn;
    public Usuario() {
        id= -1;
        nombre = "Sin Definir";
        iduser = "Sin definir";
        contrasenna = "Sin definir";
        correo = "Sin definir";
        tipoUser = "VISITANTE";
        fechaCreo = Date.valueOf("1990-01-01");
    }
    
    
//    public Usuario( String _iduser, String _contrasenna) throws Exception {
//        this.iduser = _iduser;
//        this.contrasenna = _contrasenna;
//        try {
//        miconn = Conexion_MySQL.conectar(); 
//        ResultSet resp = Conexion_MySQL.ejecutarConsulta(miconn,"SELECT * from usuario where nombre_usuario='"+_iduser.toUpperCase()+"' ;");
//            while(resp.next()){
//                id = resp.getInt("idusuario");
//                nombre = resp.getString("nombre");
//                iduser = _iduser;
//                contrasenna = _contrasenna;
//                correo = resp.getString("correo");
//                tipoUser = resp.getString("tipo_usuario");
//                fechaCreo = resp.getDate("fecha_creacion");
//            }
////            miconn.cerrarConexcion();
//        } catch (SQLException ex) {
//            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
    
    public Usuario(Connection conn, String _iduser) throws Exception {
        this.iduser = _iduser;
        this.id = -1;
        try {
//        Conexion_MySQL miconn = new Conexion_MySQL();
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, "SELECT * from usuario where nombre_usuario='"+_iduser.toUpperCase()+"' ;");
            while(resp.next()){
                id = resp.getInt("idusuario");
                nombre = resp.getString("nombre");
                iduser = _iduser;
                contrasenna = resp.getString("contrasenna");
                correo = resp.getString("correo");
                tipoUser = resp.getString("tipo_usuario");
                fechaCreo = resp.getDate("fecha_creacion");
            }
//        miconn.cerrarConexcion();
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public Usuario(Conexion_MySQL conn, String _iduser) throws Exception {
        this.iduser = _iduser;
        this.id = -1;
        try {
//        Conexion_MySQL miconn = new Conexion_MySQL();
        ResultSet resp = conn.ejecutarConsulta( "SELECT * from usuario where nombre_usuario='"+_iduser.toUpperCase()+"' ;");
            while(resp.next()){
                id = resp.getInt("idusuario");
                nombre = resp.getString("nombre");
                iduser = _iduser;
                contrasenna = resp.getString("contrasenna");
                correo = resp.getString("correo");
                tipoUser = resp.getString("tipo_usuario");
                fechaCreo = resp.getDate("fecha_creacion");
            }
//        miconn.cerrarConexcion();
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    /*** 
     * @param correo electronico enlazado al usuario.
     * @return un INT que representa el Id del usuario, si no encuentra un usuario retorna cero 0
     */
    public static int usuarioExiste(Connection conn, String correo) throws Exception{
        try {
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,"select * from usuario where correo = '" + correo + "'");
            if (resp.next()) {
                int iduser = resp.getInt("idusuario");
//                miconn.cerrarConexcion();
                return iduser;
            }
//            miconn.cerrarConexcion();
            return 0;
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }
    
    public static int registrarUsuario(Connection conn, String nombre,String nombUser,String contrasenna, String correo,String estado){
       
            java.util.Calendar c = new java.util.GregorianCalendar();
            String fecha_creo = Integer.toString(c.get(java.util.Calendar.YEAR)) + "-" + Integer.toString(c.get(java.util.Calendar.MONTH) + 1) + "-" + Integer.toString(c.get(java.util.Calendar.DATE));
            
            int ultimoID = Conexion_MySQL.ejecutarInsertId(conn,"INSERT INTO `usuario` (`nombre`, `nombre_usuario`, `contrasenna`, `fecha_creacion`,  `correo`, `tipo_usuario`, `usuario_creo`, `estado`) "
                    + "VALUES ('"+nombre+"', '"+nombUser+"', '"+contrasenna+"', '"+fecha_creo+"',  '"+correo+"', 'COMUN', '1', '"+estado+"');");
            return ultimoID;
         
    }
    public static boolean actualizarUltimoAccesoUSuario(Connection conn, int idUsuario ){
        try {
            String fecha = Conexion_MySQL.obtenerFechaActualMySQL();
            return Conexion_MySQL.ejecutarSentencia(conn,"UPDATE `usuario` SET `ultimo_acceso`='"+fecha+"' WHERE `idusuario`='"+idUsuario+"';");
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    public boolean actualizarUltimoAccesoUSuario(Connection conn ){
        try {
            String fecha = Conexion_MySQL.obtenerFechaActualMySQL();
            return Conexion_MySQL.ejecutarSentencia(conn,"UPDATE `usuario` SET `ultimo_acceso`='"+fecha+"' WHERE `idusuario`='"+this.id+"';");
        } catch (SQLException ex) {
            Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getIduser() {
        return iduser;
    }

    public String getCorreo() {
        return correo;
    }

    public String getTipoUser() {
        return tipoUser;
    }

    public Date getFechaCreo() {
        return fechaCreo;
    }

    public String getContrasenna() {
       return contrasenna ;
    } 
    public void setId(int id) {
        this.id = id;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setIduser(String iduser) {
        this.iduser = iduser;
    }

    public void setContrasenna(String contrasenna) {
        this.contrasenna = contrasenna;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public void setTipoUser(String tipoUser) {
        this.tipoUser = tipoUser;
    }

    public void setFechaCreo(Date fechaCreo) {
        this.fechaCreo = fechaCreo;
    }

 
    
    
}
