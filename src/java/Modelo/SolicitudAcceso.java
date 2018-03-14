/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import BD.Conexion_MySQL;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

/**
 *
 * @author desarrolloJuan
 */
public class SolicitudAcceso {

    String nombre, apellido, titulo, resumen, mensaje, correo, numero_identificacion, tipo_identificacion, institucion, estado;
    int idsolicitud_acceso, tiempo_solicitado;
    Date fecha_creo;

    public SolicitudAcceso() {
        idsolicitud_acceso = -1;
    }

    public SolicitudAcceso(String nombre, String apellido, String titulo, String resumen, String mensaje, String correo, String numero_identificacion, String tipo_identificacion, String institucion, String estado, int idsolicitud_acceso, int tiempo_solicitado, Date fecha) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.titulo = titulo;
        this.resumen = resumen;
        this.mensaje = mensaje;
        this.correo = correo;
        this.numero_identificacion = numero_identificacion;
        this.tipo_identificacion = tipo_identificacion;
        this.institucion = institucion;
        this.estado = estado;
        this.idsolicitud_acceso = idsolicitud_acceso;
        this.tiempo_solicitado = tiempo_solicitado;
        this.fecha_creo = fecha;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getResumen() {
        return resumen;
    }

    public String getMensaje() {
        return mensaje;
    }

    public String getCorreo() {
        return correo;
    }

    public String getNumero_identificacion() {
        return numero_identificacion;
    }

    public String getTipo_identificacion() {
        return tipo_identificacion;
    }

    public String getInstitucion() {
        return institucion;
    }

    public String getEstado() {
        return estado;
    }

    public int getIdsolicitud_acceso() {
        return idsolicitud_acceso;
    }

    public int getTiempo_solicitado() {
        return tiempo_solicitado;
    }

    public Date getFecha() {
        return fecha_creo;
    }

    public static ArrayList<SolicitudAcceso> obtenerSolicitudList(Connection conn, String Estado) {
        ArrayList<SolicitudAcceso> listSolicitudes = new ArrayList<>();
        try {
            String sql = "SELECT * FROM solicitud_acceso Where Estado = '" + Estado + "';";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while (resp.next()) {
                listSolicitudes.add(new SolicitudAcceso(resp.getString("nombre"), resp.getString("apellido"), resp.getString("titulo"),
                        resp.getString("resumen"), resp.getString("mensaje"), resp.getString("correo"),
                        resp.getString("numero_identificacion"), resp.getString("tipo_identificacion"), resp.getString("institucion"),
                        resp.getString("estado"), resp.getInt("idsolicitud_acceso"), resp.getInt("tiempo_solicitado"), resp.getDate("fecha_creo")));
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
            Logger.getLogger(SolicitudAcceso.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
        return listSolicitudes;
    }

    public static ArrayList<SolicitudAcceso> obtenerSolicitudList(Conexion_MySQL conn, String Estado) {
        ArrayList<SolicitudAcceso> listSolicitudes = new ArrayList<>();
        try {
            String sql = "SELECT * FROM solicitud_acceso Where Estado = '" + Estado + "';";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = conn.ejecutarConsulta(sql);
            while (resp.next()) {
                listSolicitudes.add(new SolicitudAcceso(resp.getString("nombre"), resp.getString("apellido"), resp.getString("titulo"),
                        resp.getString("resumen"), resp.getString("mensaje"), resp.getString("correo"),
                        resp.getString("numero_identificacion"), resp.getString("tipo_identificacion"), resp.getString("institucion"),
                        resp.getString("estado"), resp.getInt("idsolicitud_acceso"), resp.getInt("tiempo_solicitado"), resp.getDate("fecha_creo")));
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
            Logger.getLogger(SolicitudAcceso.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
        return listSolicitudes;
    }

    public static SolicitudAcceso obtenerSolicitud(Connection conn, int idSolicitud) {
        SolicitudAcceso miSolicitudes = null;
        try {
            String sql = "SELECT * FROM solicitud_acceso WHERE idsolicitud_acceso = '" + idSolicitud + "';";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while (resp.next()) {
                miSolicitudes = new SolicitudAcceso(resp.getString("nombre"), resp.getString("apellido"), resp.getString("titulo"),
                        resp.getString("resumen"), resp.getString("mensaje"), resp.getString("correo"),
                        resp.getString("numero_identificacion"), resp.getString("tipo_identificacion"), resp.getString("institucion"),
                        resp.getString("estado"), resp.getInt("idsolicitud_acceso"), resp.getInt("tiempo_solicitado"), resp.getDate("fecha_creo"));
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
            Logger.getLogger(SolicitudAcceso.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return miSolicitudes;
    }

    public static int registrarSolicitusAcceso(String titulo, String resumen, String mensaje, String nombre, String tipoID, String numeroID, String institucion, String correo, String estado, int diasSolicitados) throws Exception {
        int idSolicitud;
        Connection conn = Conexion_MySQL.conectar2();
        String fecha = Conexion_MySQL.obtenerFechaActualMySQL();
        String sql = "INSERT INTO `solicitud_acceso` (`nombre`, `titulo`, `resumen`, `mensaje`, `correo`, `numero_identificacion`, `tipo_identificacion`, `institucion`, `tiempo_solicitado`, `fecha_creo`, `estado`) "
                + "VALUES ('" + nombre + "', '" + titulo + "', '" + resumen + "', '" + mensaje + "', '" + correo + "', '" + numeroID + "', '" + tipoID + "', '" + institucion + "', '" + diasSolicitados + "', '" + fecha + "', 'ESPERA');";
        idSolicitud = Conexion_MySQL.ejecutarInsertId(conn, sql);
        conn.close();
        return idSolicitud;
    }

    public static boolean aprovarSolicitusAcceso(Connection conn, int idsolicitud, Usuario userAdmin) {
        try {
            boolean aprovado = false;
            SolicitudAcceso miSolicitud = SolicitudAcceso.obtenerSolicitud(conn, idsolicitud);

            if (miSolicitud != null) {
                Calendar Calendario = java.util.Calendar.getInstance();
                Calendar calCalendario = java.util.Calendar.getInstance();
//sumando los dias  a la fecha
                calCalendario.add(calCalendario.DATE, miSolicitud.getTiempo_solicitado());
//asignando la nueva fecha
                long numbFecha = calCalendario.getTimeInMillis();
                Timestamp tmsFecha = new Timestamp(numbFecha);
                Timestamp fechaNow = new Timestamp(Calendario.getTimeInMillis());
                int idUser = Usuario.usuarioExiste(conn, miSolicitud.getCorreo());
                String mensajeCorreo = "";
                if (idUser <= 0) {
                    String contrasenna;
                     SecureRandom sr = new SecureRandom();
                    int aleatorio = sr.nextInt(99999999);
                    contrasenna = miSolicitud.getNombre().substring(0,1)+aleatorio;
//                    if(miSolicitud.getNumero_identificacion()!=null)
//                        contrasenna =miSolicitud.getNumero_identificacion();
                    idUser = Usuario.registrarUsuario(conn, miSolicitud.getNombre(), miSolicitud.getCorreo(),
                            contrasenna, miSolicitud.getCorreo(), "ACTIVO");
                   mensajeCorreo = "Su solicitud de acceso a la plataforma TAP ( Tropical andean plants ) ha sido aprovada, ya puede ingresar usando su correo como usuario y contraseña : "+contrasenna+".\n Feliz dia.";
                }else{
                    mensajeCorreo = "Su solicitud de acceso a la plataforma TAP ( Tropical andean plants ) ha sido aprovada, ya puede ingresar usando el usuario registrado .\n Feliz dia.";
                }
                idUser = Conexion_MySQL.ejecutarInsertId(conn, "INSERT INTO `acceso` (`idusuario`, `fecha_inicio`, `fecha_fin`, `usuario_creo`, `fecha_creo`, `estado`) "
                        + "VALUES ('" + idUser + "', '" + fechaNow.toString() + "', '" + tmsFecha.toString() + "', '" + userAdmin.getId() + "', '" + fechaNow.toString() + "', 'ACTIVO');");
                Conexion_MySQL.ejecutarSentencia(conn, "UPDATE `solicitud_acceso` SET `estado`='APROVADA' WHERE `idsolicitud_acceso`='" + miSolicitud.getIdsolicitud_acceso() + "';");
                EnvioCorreos mail = new EnvioCorreos();
                aprovado = mail.enviarCorreo(miSolicitud.getCorreo(), mensajeCorreo, "Acceso a la plataforma Aprovado");
            }
            return aprovado;
        } catch (Exception ex1) {
            Logger.getLogger(SolicitudAcceso.class.getName()).log(Level.SEVERE, null, ex1);
            return false;
        }
    }

    public static boolean rechazarSolicitudAcceso(Connection conn, int idsolicitud) {
        try 
        {
            String sql = "UPDATE `solicitud_acceso` SET `estado` = 'RECHAZADA' WHERE `idsolicitud_acceso` = " + idsolicitud + ";";
            return Conexion_MySQL.ejecutarSentencia(conn, sql);
            
        } catch (Exception ex1) {
            Logger.getLogger(SolicitudAcceso.class.getName()).log(Level.SEVERE, null, ex1);
            return false;
        }
    }
}
