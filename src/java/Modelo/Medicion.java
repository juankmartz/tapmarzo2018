/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import BD.Conexion_MySQL;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author desarrolloJuan
 */
public class Medicion {
    int   idMedicion,  idIndividuo, idproyecto;
    String nombreIndividuo,especie,codigoIndividuo;
    Date fecha;
    Time hora;
    HashMap<String, String> values;

    public Medicion() {
    }

    public Medicion(int idMedicion) {
        this.idMedicion = idMedicion;
    }

    public Medicion(int idMedicion, int idIndividuo, int idproyecto, String nombreIndividuo, String especie, Date fecha, Time hora, HashMap<String, String> values) {
        this.idMedicion = idMedicion;

        this.idIndividuo = idIndividuo;
        this.idproyecto = idproyecto;
        this.nombreIndividuo = nombreIndividuo;
        this.especie = especie;
        this.fecha = fecha;
        this.hora = hora;
        this.values = values;
    }
    

    public Medicion(int idMedicion, int idIndividuo, int idproyecto, String nombreIndividuo, String especie, Date fecha, Time hora, String codigo, HashMap<String, String> values) {
        this.idMedicion = idMedicion;

        this.idIndividuo = idIndividuo;
        this.idproyecto = idproyecto;
        this.nombreIndividuo = nombreIndividuo;
        this.especie = especie;
        this.fecha = fecha;
        this.hora = hora;
        this.codigoIndividuo = codigo;
        this.values = values;
    }
    public int getIdMedicion() {
        return idMedicion;
    }

    public int getIdIndividuo() {
        return idIndividuo;
    }

    public int getIdproyecto() {
        return idproyecto;
    }

    public String getNombreIndividuo() {
        return nombreIndividuo;
    }

    public String getEspecie() {
        return especie;
    }

    public Date getFecha() {
        return fecha;
    }

    public Time getHora() {
        return hora;
    }

    public HashMap<String, String> getValues() {
        return values;
    }

    public String getCodigoIndividuo() {
        return codigoIndividuo;
    }
        
    public static int registroMedicion(Connection conn,   String camposSQL, String valuesSQL ){
        String sql = "INSERT INTO `medicion` ( "+camposSQL+" ) "
                + "VALUES ("+valuesSQL+");";
        int ultimoID = Conexion_MySQL.ejecutarInsertId(conn, sql);
        return ultimoID;
    }
    
    public static ArrayList<Medicion> obtenerMedcionesProyecto(Connection conn, int idproyecto, ArrayList<Rasgo> rasgosInteres) throws Exception{
        ArrayList<Medicion> medicionProyec = new ArrayList<>();
//        Conexion_MySQL miconn = null;
        String camposSQL = " * ";
        
//        for(Rasgo rasgoSelect : rasgosInteres){
//            camposSQL += ", `"+rasgoSelect.getNombre_columna()+"`";
//        }
        String sql = "SELECT "+camposSQL+" ,(SELECT nombre FROM individuo WHERE idindividuo = M.idindividuo ) as nombreIndividuo, (SELECT codigo FROM individuo WHERE idindividuo = M.idindividuo ) as codigo FROM medicion M where idproyecto = '"+idproyecto+"' order by idmedicion desc;";
//        miconn = new Conexion_MySQL();
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
        try {
           while(resp.next()){
//               String[] values = new String[rasgosInteres.size()];
               HashMap<String, String> valores = new HashMap<>();
               for(Rasgo mirasgo: rasgosInteres){
                   valores.put(mirasgo.getNombre_columna(), resp.getString(mirasgo.getNombre_columna())) ;
               }
//               String hora = "13:30:00";
               medicionProyec.add(new Medicion(resp.getInt("idmedicion"),resp.getInt("idindividuo") ,resp.getInt("idproyecto") ,resp.getString("nombreIndividuo") , "Especie",Date.valueOf(resp.getString("fecha"))  ,Time.valueOf(resp.getString("hora")) ,resp.getString("codigo") , valores));
           }
//           miconn.cerrarConexcion();
        } catch (SQLException ex) {
            Logger.getLogger(Medicion.class.getName()).log(Level.SEVERE, null, ex);
           return medicionProyec = new ArrayList<>();
        }
        return medicionProyec;
    }
   
    
    public static ArrayList<Medicion> obtenerMedcionesRasgoEspecie(Connection conn, String [] idEspecies, ArrayList<Rasgo> rasgosInteres) throws Exception{
        ArrayList<Medicion> medicionProyec = new ArrayList<>();
//        Conexion_MySQL miconn = null;
        String camposSQL = " ";
        String condicionalOR = "";
        String condicionalAND = "";
        for(Rasgo rasgoSelect : rasgosInteres){
            condicionalAND += " M." + rasgoSelect.getNombre_columna()+ " != 'null' AND";
            camposSQL += " M."+rasgoSelect.getNombre_columna()+",";
        }
        condicionalAND = condicionalAND.substring(0, condicionalAND.length()-3);
        camposSQL = camposSQL.substring(0, camposSQL.length()-1);
        for(String idEspecieSelect : idEspecies){
            condicionalOR += " idtaxonomia = '"+idEspecieSelect+"' or";
        }
        condicionalOR = condicionalOR.substring(0,condicionalOR.length()-2);
        String sql = "select O.codigo, O.nombre, O.nombreEspecie, M.idmedicion, M.idindividuo, M.idproyecto,M.fecha, M.hora, "+camposSQL+"  FROM medicion M, ( select idindividuo, codigo, nombre, (select especie from taxonomia where idtaxonomia = I.idtaxonomia) as nombreEspecie From individuo I where "+condicionalOR+" ) O  where M.idindividuo = O.idindividuo   AND ( "+condicionalAND+" ) order by O.nombreEspecie asc;";
//        miconn = new Conexion_MySQL();
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
        try {
           while(resp.next()){
//               String[] values = new String[rasgosInteres.size()];
               HashMap<String, String> valores = new HashMap<>();
               for(Rasgo mirasgo: rasgosInteres){
                   valores.put(mirasgo.getNombre_columna(), resp.getString(mirasgo.getNombre_columna())) ;
               }
//               String hora = "13:30:00";
               medicionProyec.add(new Medicion(resp.getInt("idmedicion"),resp.getInt("idindividuo") ,resp.getInt("idproyecto") ,resp.getString("nombre") ,resp.getString("nombreEspecie") ,Date.valueOf(resp.getString("fecha"))  ,Time.valueOf(resp.getString("hora")) ,resp.getString("codigo") , valores));
           }
//           miconn.cerrarConexcion();
        } 
        catch (SQLException ex) {
            Logger.getLogger(Medicion.class.getName()).log(Level.SEVERE, null, ex);
           return medicionProyec = new ArrayList<>();
        }
        return medicionProyec;
    }
    
    public static ArrayList<Medicion> obtenerMedcionesEspecie(Connection conn, int idEspecie, ArrayList<Rasgo> rasgosInteres) throws Exception{
        ArrayList<Medicion> medicionProyec = new ArrayList<>();
        String camposSQL = " * ";
//        Conexion_MySQL miconn = null;
        String xxxRAsgoxxx = "";
        for(Rasgo rasgoSelect : rasgosInteres){
            camposSQL += ", `"+rasgoSelect.getNombre_columna()+"`";
            xxxRAsgoxxx += " M." + rasgoSelect.getNombre_columna()+ " != 'null' AND";
        }
        xxxRAsgoxxx = xxxRAsgoxxx.substring(0,xxxRAsgoxxx.length()-3);// retiro el AND del final
        String sql = "SELECT M.*, I.codigo  FROM medicion M, ( select idindividuo, codigo from individuo where idtaxonomia = '"+idEspecie+"') I where I.idindividuo = M.idindividuo AND ( #xxxRASGOSxxx# ) order by idmedicion desc;";
        sql = sql.replace("#xxxRASGOSxxx#", xxxRAsgoxxx);
//        miconn = new Conexion_MySQL();
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
        try {
           while(resp.next()){
//               String[] values = new String[rasgosInteres.size()];
               HashMap<String, String> valores = new HashMap<>();
               for(Rasgo mirasgo: rasgosInteres){
                   valores.put(mirasgo.getNombre_columna(), resp.getString(mirasgo.getNombre_columna())) ;
               }
               //guardo en nombre individuo el codigo
               medicionProyec.add(new Medicion(resp.getInt("idmedicion"),resp.getInt("idindividuo") ,resp.getInt("idproyecto") 
                       ,resp.getString("codigo") , "Especie",Date.valueOf(resp.getString("fecha"))  
                       ,resp.getTime("hora"),resp.getString("codigo")  , valores));
           }
//           miconn.cerrarConexcion();
        } catch (SQLException ex) {
            Logger.getLogger(Medicion.class.getName()).log(Level.SEVERE, null, ex);
//           miconn.cerrarConexcion();
            return medicionProyec = new ArrayList<>();
        }
        return medicionProyec;
    }
    
//    public static  ResultSet ontenerMedicionProyecto(int idproyecto) throws Exception{
//        try {
//            String sql = "select * from ";
//            String campos = "";
//            ResultSet rasgos = proyectos.getCaracterisiticasInteresProyecto(idproyecto);
//            while(rasgos.next()){
//                
//                String idRasgo = rasgos.getString("idrasgos");
//                String nombre = rasgos.getString("nombre").replace(" ", "");
//                campos = campos +" ("+nombre+".valor) as "+nombre+" ,";
//                sql = sql+"(SELECT valor FROM medicion where idproyecto = '"+idproyecto+"' and idrasgo = '"+idRasgo+"' order by numeroMedicion asc ) "+nombre+" ,";
//                
//            }
//            campos = campos.substring(0, campos.length()-1);
//            sql = sql.substring(0, sql.length()-1);
//            sql = sql.replace("*", campos);
//            Conexion_MySQL miconn = new Conexion_MySQL();
//            ResultSet resp = miconn.ejecutarConsulta(sql);
//            miconn.cerrarConexcion();
//            return resp;
//        } catch (SQLException ex) {
//            Logger.getLogger(Medicion.class.getName()).log(Level.SEVERE, null, ex);
//            
//            return null;
//        }
//    }
}
