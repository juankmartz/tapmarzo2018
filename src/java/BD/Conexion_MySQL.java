/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BD;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author desarrolloJuan
 */
public class Conexion_MySQL {

    public  Connection con_mysql;

    public  Connection getCon_mysql() {
        return con_mysql;
    }

    public  Connection conectar(String pHost, String pUser,
            String pPassword) throws Exception {
        try {
            String databaseURL = "jdbc:mysql://" + pHost + "/cism";
            Class.forName("com.mysql.jdbc.Driver");
            DriverManager.setLoginTimeout(300);
            con_mysql = java.sql.DriverManager.getConnection(pHost,
                    pUser, pPassword);
            System.out.println("Conexion con MySQL Establecida..");
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
        return con_mysql;
    }

    public Conexion_MySQL() throws Exception {
        conectar();
    }

    public void cerrarConexcion(){
        try {
            System.out.println("iniciando close() Conexcion desde metodo 'cerrarConexcion'  ");
            con_mysql.close();
            System.out.println(" Conexcion CERRADA desde metodo 'cerrarConexcion'  ");
        } catch (SQLException ex) {
            Logger.getLogger(Conexion_MySQL.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public  Connection conectar() throws Exception {
        try {

            String databaseURL = "jdbc:mysql://127.0.0.1/2018dbenero";
//            String databaseURL = "jdbc:mysql://127.0.0.1/bdavance20sep2017";
//            String databaseURL = "jdbc:mysql://node150448-tropicalandeanplants.jelasticlw.com.br/bdavance20sep2017";
//            String databaseURL = "jdbc:mysql://127.0.0.1/juankmar_BD_Gefivet";
//			String databaseURL = "jdbc:mysql://127.0.0.1/proyecto_2";
//			String databaseURL = "jdbc:mysql://127.0.0.1/prueba_proyect";
            Class.forName("com.mysql.jdbc.Driver");
            DriverManager.setLoginTimeout(500);
            con_mysql = java.sql.DriverManager.getConnection(databaseURL,
                    "root", "123");
            System.out.println("Conexion con MySQL Establecida..");
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
        return con_mysql;
    }
    
    public static  Connection conectar2() throws Exception {
        Connection con_mysql = null;
        try {

            String databaseURL = "jdbc:mysql://127.0.0.1/2018dbenero";
//            String databaseURL = "jdbc:mysql://127.0.0.1/bdavance20sep2017";
//            String databaseURL = "jdbc:mysql://node150448-tropicalandeanplants.jelasticlw.com.br/bdavance20sep2017";
//            String databaseURL = "jdbc:mysql://127.0.0.1/juankmar_BD_Gefivet";
//			String databaseURL = "jdbc:mysql://127.0.0.1/proyecto_2";
//			String databaseURL = "jdbc:mysql://127.0.0.1/prueba_proyect";
            Class.forName("com.mysql.jdbc.Driver");
            DriverManager.setLoginTimeout(500);
            con_mysql = java.sql.DriverManager.getConnection(databaseURL,
                    "root", "123");
            System.out.println("Conexion con MySQL Establecida..");
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
        return con_mysql;
    }
    public static ResultSet ejecutarConsulta(Connection conn, String sql) {
        ResultSet resp = null;
        try {
//            conn = conectar();
            PreparedStatement ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            resp = ps.executeQuery();
//            conn.close();
            return resp;

        } catch (Exception ex) {
           
            System.out.println("inicando close conexcion desde esception");
            System.out.println("conexcion cerrada desde esception");
            return resp;
        }

    }
    
    public ResultSet ejecutarConsulta( String sql) {
        ResultSet resp = null;
        try {
//            conn = conectar();
            if(con_mysql.isClosed());
            PreparedStatement ps = con_mysql.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            resp = ps.executeQuery();
//            conn.close();
            return resp;

        } catch (Exception ex) {
           
            System.out.println("inicando close conexcion desde esception");
            System.out.println("conexcion cerrada desde esception");
            return resp;
        }

    }

    /**
     * Ejecuta sentencias de UPDATE y DELETED en la BD
     *
     * @param sql senencia de actualizacion o eliminacion de registros.
     * @return Retorna TRUE cuando se ha ejecutado correctamente la sentencia
     * sql, de lo contrario retorna FALSE
     */
    public static boolean ejecutarSentencia(Connection conn, String sql) throws SQLException {
//        Connection conn = null;
        try {
//            conn = conectar();
            PreparedStatement ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            boolean exq = ps.execute();
            System.out.println("inicando close conexcion desde ");
//            conn.close();
            return true;

        } catch (Exception ex) {
           
            System.out.println("Exception close conexcion ");
//            conn.close();
            System.out.println("conexcion cerrada desde ejecutarSentencia");
            return false;
        }

    }
    
    public  boolean ejecutarSentencia( String sql) throws SQLException {
//        Connection conn = null;
        try {
//            conn = conectar();
            PreparedStatement ps = con_mysql.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            boolean exq = ps.execute();
            System.out.println("inicando close conexcion desde ");
            return true;

        } catch (Exception ex) {
           
            System.out.println("Exception close conexcion ");
            System.out.println("conexcion cerrada desde ejecutarSentencia");
            return false;
        }

    }

    /**
     * ejecuta las sentencia de insert devolviendo el valor entero del id del
     * registro insertado
     *
     * @param sql sentencia con la estructura de "INSERT INTO `nombre_tabla`
     * (`campo1`, `campo2`, `campo3`) VALUES ('valor1', 'valor2', 'valo3');"
     * @return El id del ultimo INSERT cuando todo sale correctamente; cuando se
     * a presentado algun error en el INSERT se retorna -1
     *
     */
    public static int ejecutarInsertId(Connection conn, String sql) {
//        Connection conn = null;
        try {
            System.out.println();
//            conn = conectar();
            PreparedStatement ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            boolean exq = ps.execute();
            ps = conn.prepareStatement("SELECT LAST_INSERT_ID()", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet resp = ps.executeQuery();
            int ultimoID = 0;
            if (resp.next()) {
                ultimoID = resp.getInt(1);
            }
//            conn.close();
             System.out.println("conexcion cerrada desde ejecutarInsertId");
            return ultimoID;
        } catch (Exception ex) {
            Logger.getLogger(Conexion_MySQL.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("inicando close conexcion desde esception");
            System.out.println("conexcion cerrada desde exception");
            return -1;
        }

    }
    
    public int ejecutarInsertId( String sql) {
//        Connection conn = null;
        try {
            System.out.println();
//            conn = conectar();
            PreparedStatement ps = con_mysql.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            boolean exq = ps.execute();
            ps = con_mysql.prepareStatement("SELECT LAST_INSERT_ID()", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet resp = ps.executeQuery();
            int ultimoID = 0;
            if (resp.next()) {
                ultimoID = resp.getInt(1);
            }
             System.out.println("conexcion cerrada desde ejecutarInsertId");
            return ultimoID;
        } catch (Exception ex) {
            Logger.getLogger(Conexion_MySQL.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("inicando close conexcion desde esception");
            System.out.println("conexcion cerrada desde esception");
            return -1;
        }

    }

    public static String obtenerFechaActualMySQL() {
        java.util.Calendar c = new java.util.GregorianCalendar();
        String dia = Integer.toString(c.get(java.util.Calendar.DATE));
        String mes = Integer.toString(c.get(java.util.Calendar.MONTH) + 1);
        String anio = Integer.toString(c.get(java.util.Calendar.YEAR));
        String fecha = anio + "-" + mes + "-" + dia;
        return fecha;
    }

    public static String obtenerHoraActualMySQL() {
        java.util.Calendar c = new java.util.GregorianCalendar();
        String hora = Integer.toString(c.get(java.util.Calendar.HOUR_OF_DAY));
        String minuto = Integer.toString(c.get(java.util.Calendar.MINUTE));
        String segundo = Integer.toString(c.get(java.util.Calendar.SECOND));
        if (hora.length() < 2) {
            hora = "0" + hora;
        }
        if (minuto.length() < 2) {
            minuto = "0" + minuto;
        }
        if (segundo.length() < 2) {
            segundo = "0" + segundo;
        }
        String horaCompleta = hora + ":" + minuto;
        return horaCompleta;
    }

    public static String fechaFormateada(String fecha) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaNueva = (Date) sdf.parse(fecha);
            int anno = fechaNueva.getYear();
            int mes = fechaNueva.getMonth();
            int dia = fechaNueva.getDay();
            return anno + "-" + mes + "-" + dia;
        } catch (ParseException ex) {
            Logger.getLogger(Conexion_MySQL.class.getName()).log(Level.SEVERE, null, ex);
            return "1700-01-01";
        }
    }

}
