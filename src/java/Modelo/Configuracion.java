/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import BD.Conexion_MySQL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author desarrolloJuan
 */
public class Configuracion {
    String parametro, valor, descripcion, estado;
    int idconfiguracion;

    public Configuracion(com.mysql.jdbc.Connection conn, String parametro) {
//        Conexion_MySQL miconn;
         try {
//             miconn = new Conexion_MySQL();
            ResultSet rs ;
            String SQL = "SELECT * FROM configuracion where parametro = '"+formatoValoresConfig(parametro)+"';";
            rs = Conexion_MySQL.ejecutarConsulta(conn,SQL);
            if(rs.next()){
                this.parametro = parametro;
                this.valor = rs.getString("valor");
                this.descripcion = rs.getString("descripcion");
                this.estado = rs.getString("estado");
                this.idconfiguracion = rs.getInt("idconfiguracion");
            }
//            miconn.cerrarConexcion();
        }catch (Exception ex) {
//            Logger.getLogger(contenido.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Configuracion(String parametro, String valor, String descripcion, String estado, int idconfiguracion) {
        this.parametro = parametro;
        this.valor = valor;
        this.descripcion = descripcion;
        this.estado = estado;
        this.idconfiguracion = idconfiguracion;
    }

    public String getParametro() {
        return parametro;
    }

    public String getValor() {
        return valor;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public int getIdconfiguracion() {
        return idconfiguracion;
    }
    
    public static String getValorConfiguracion(Connection conn, String parametro) {
             String valorCof = "";
//             Conexion_MySQL miconn = null;
         try {
//             miconn = new Conexion_MySQL();
            ResultSet rs ;
            String SQL = "SELECT * FROM configuracion where parametro = '"+formatoValoresConfig(parametro)+"' AND estado = 'SI';";
            rs = Conexion_MySQL.ejecutarConsulta(conn, SQL);
            if(rs.next()){
                valorCof = rs.getString("valor");
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
//            miconn.cerrarConexcion();
//            Logger.getLogger(contenido.class.getName()).log(Level.SEVERE, null, ex);
        }
         return valorCof;
    }

    
    
    public static HashMap<String,String> getConfiguracionCompleta(Connection conn ) {
       HashMap<String,String> config = new HashMap<>();
//        Conexion_MySQL miconn = null;
         try {
            ResultSet rs = null;
            String SQL = "SELECT * FROM configuracion where estado = 'SI';";
//            miconn = new Conexion_MySQL();
            rs = Conexion_MySQL.ejecutarConsulta(conn, SQL);
            while (rs.next()){
                config.put(rs.getString("clave"), rs.getString("valor"));
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
//            Logger.getLogger(contenido.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
            return new HashMap<>();
        }
        return config;
    }
    
    public static ArrayList<Configuracion> getConfiguracionCompletaList(Connection conn) {
       ArrayList<Configuracion> listConfig = new ArrayList<>();
//       Conexion_MySQL miconn = null;
         try {
            ResultSet rs = null;
            String SQL = "SELECT * FROM configuracion where estado = 'SI';";
//            miconn = new Conexion_MySQL();
            rs = Conexion_MySQL.ejecutarConsulta(conn, SQL);
            while(rs.next()){
                listConfig.add( new Configuracion(rs.getString("parametro"), rs.getString("valor"),
                        rs.getString("descripcion"), rs.getString("estado") , rs.getInt("idconfiguracion")));
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
//            Logger.getLogger(contenido.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
            return new ArrayList<>();
        }
        return listConfig;
    }
    
    private static String formatoValoresConfig(String variable){
        variable = variable.replace(" ","_");
        variable = variable.replace("á","a");
        variable = variable.replace("é","a");
        variable = variable.replace("í","i");
        variable = variable.replace("ó","o");
        variable = variable.replace("ú","u");
        variable = variable.replace("ñ","n");
        variable = variable.toUpperCase();
        return  variable;
    }
    
    
}
