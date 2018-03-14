/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import BD.Conexion_MySQL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author desarrolloJuan
 */
public class Individuo extends Object{
    
    int taxonomia, localidad, idIndividuo;
    String nombre, codigo, descripcion, especie, nombreLocalidad;

    public Individuo(int idIndividuo) {
        this.idIndividuo = idIndividuo;
    }

    public Individuo(int taxonomia, int localidad, int idIndividuo, String nombre, String codigo, String descripcion, String especie, String nombreLocalidad) {
        this.taxonomia = taxonomia;
        this.localidad = localidad;
        this.idIndividuo = idIndividuo;
        this.nombre = nombre;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.especie = especie;
        this.nombreLocalidad = nombreLocalidad;
    }

    public int getTaxonomia() {
        return taxonomia;
    }

    public int getLocalidad() {
        return localidad;
    }

    public int getIdIndividuo() {
        return idIndividuo;
    }

    public String getNombre() {
        return nombre;
    }

    public String getCodigo() {
        return codigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getEspecie() {
        return especie;
    }

    public String getNombreLocalidad() {
        return nombreLocalidad;
    }


    public static int registroIndividuo(Connection conn, int taxonomia, int localidad, String nombre, String codigo, String descripcion) {

        String sql = "INSERT INTO `individuo` ( `idtaxonomia`, `idlocalidad`, `nombre`, `descripcion`, `codigo`) "
                + "VALUES ('"+taxonomia+"', '"+localidad+"', '"+nombre+"', '"+descripcion+"', '"+codigo+"');";
        int ultimoID = Conexion_MySQL.ejecutarInsertId(conn, sql);
        return ultimoID; 
    }
    
//    public static ResultSet obtenerTodosIndividuos() {
//        Conexion_MySQL miconn = null;
//        try {
//            miconn= new Conexion_MySQL();
//        } catch (Exception ex) {
//            Logger.getLogger(Individuo.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        String sql = "SELECT idindividuo, idtaxonomia, idlocalidad, nombre, descripcion, codigo, (SELECT especie FROM taxonomia where idtaxonomia = I.idtaxonomia ) as especie, ( select nombre from localidad where idlocalidad = I.idlocalidad) as localidad  FROM individuo I;";
//        ResultSet respuesta = miconn.ejecutarConsulta(sql);
//        miconn.cerrarConexcion();
//        return respuesta;
//    }
    
    public static HashMap<String, Integer>  obtenerTodosIndividuosMapt(Connection conn ) throws Exception{
//        Conexion_MySQL miconn = null;
        try {
            HashMap<String, Integer> mapIndividuos = new HashMap<String, Integer>();
            String sql = "SELECT idindividuo, codigo FROM individuo I;" ;
//            miconn = new Conexion_MySQL();
            ResultSet respuesta = Conexion_MySQL.ejecutarConsulta(conn,sql);
            while(respuesta.next()){
                mapIndividuos.put(respuesta.getString("codigo"), respuesta.getInt("idindividuo"));
            }
//            miconn.cerrarConexcion();
            return  mapIndividuos;
        } catch (SQLException ex) {
            Logger.getLogger(Individuo.class.getName()).log(Level.SEVERE, null, ex);
            return new HashMap<>();
        } 
    }
    
    public static ArrayList <Individuo> obtenerTodosIndividuosList(Connection conn ) throws Exception{
//        Conexion_MySQL miconn = null;
        try {
            ArrayList <Individuo> listIndividuo = new ArrayList<>();
            String sql = "SELECT idindividuo, idtaxonomia, idlocalidad, nombre, descripcion, codigo, (SELECT especie FROM taxonomia where idtaxonomia = I.idtaxonomia ) as especie, ( select nombre from localidad where idlocalidad = I.idlocalidad) as localidad  FROM individuo I;" ;
//            miconn = new Conexion_MySQL();
            ResultSet respuesta = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while(respuesta.next()){
                listIndividuo.add(new Individuo(respuesta.getInt("idtaxonomia"),respuesta.getInt("idlocalidad") ,
                        respuesta.getInt("idindividuo"),respuesta.getString("nombre") ,respuesta.getString("codigo") ,
                        respuesta.getString("descripcion"), respuesta.getString("especie"),respuesta.getString("localidad") ));
            }
//            miconn.cerrarConexcion();
            return  listIndividuo;
        } catch (SQLException ex) {
            Logger.getLogger(Individuo.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
            return new ArrayList<>();
        }
    }
    
//    public static ResultSet obtenerIndividuosLocalidad(int idLocalidad){
//            Conexion_MySQL miconn = null;
//            ResultSet respuesta = null;
//        try {
//            String sql = "SELECT idindividuo, idtaxonomia, idlocalidad, nombre, descripcion, codigo, (SELECT especie FROM taxonomia where idtaxonomia = I.idtaxonomia ) as especie  FROM individuo I WHERE idlocalidad = '"+idLocalidad+"';" ;
//            miconn = new Conexion_MySQL();
//            respuesta = miconn.ejecutarConsulta(sql);
//            
//        } catch (Exception ex) {
//            Logger.getLogger(Individuo.class.getName()).log(Level.SEVERE, null, ex);
//            
//        }
//        return  respuesta;
//    }
    
    public static ArrayList<Individuo> obtenerIndividuosLocalidadList(Connection conn, int idLocalidad){
        ArrayList <Individuo> listIndividuo = new ArrayList<>();
//            Conexion_MySQL miconn = null;
            ResultSet respuesta = null;
        try {
            String sql = "SELECT idindividuo, idtaxonomia, idlocalidad, nombre, descripcion, codigo, (SELECT especie FROM taxonomia where idtaxonomia = I.idtaxonomia ) as especie, (SELECT nombre FROM localidad where idlocalidad = I.idlocalidad ) as localidad  FROM individuo I WHERE idlocalidad = '"+idLocalidad+"';" ;
//            miconn = new Conexion_MySQL();
            respuesta = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while(respuesta.next()){
                listIndividuo.add(
                        new Individuo(respuesta.getInt("idtaxonomia"), respuesta.getInt("idlocalidad"), 
                                respuesta.getInt("idindividuo") , respuesta.getString("nombre"), respuesta.getString("codigo"), respuesta.getString("descripcion"),
                                respuesta.getString("especie"), respuesta.getString("localidad")));
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
            Logger.getLogger(Individuo.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
        }
        return  listIndividuo;
    }
    public static ArrayList<Individuo> obtenerIndividuosLocalidadEspecie(Connection conn, int idLocalidad, int idEspecie){
        ArrayList <Individuo> listIndividuo = new ArrayList<>();
//            Conexion_MySQL miconn = null;
            ResultSet respuesta = null;
        try {
//            String sql = "SELECT idindividuo, idtaxonomia, idlocalidad, nombre, descripcion, codigo, (SELECT especie FROM taxonomia where idtaxonomia = I.idtaxonomia ) as especie, (SELECT nombre FROM localidad where idlocalidad = I.idlocalidad ) as localidad  FROM individuo I WHERE idlocalidad = '"+idLocalidad+"';" ;
            String sql = "SELECT idindividuo, idtaxonomia, idlocalidad, nombre, descripcion, codigo FROM individuo I WHERE idlocalidad = "+idLocalidad+" and I.idtaxonomia = "+idEspecie+"" ;
//            miconn = new Conexion_MySQL();
            respuesta = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while(respuesta.next()){
                listIndividuo.add(
                        new Individuo(respuesta.getInt("idtaxonomia"),respuesta.getInt("idlocalidad"),respuesta.getInt("idindividuo"),respuesta.getString("nombre"),respuesta.getString("codigo")
                                ,respuesta.getString("descripcion"),"",""));
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
            Logger.getLogger(Individuo.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
        }
        return  listIndividuo;
    }
    
    
    public static ArrayList<Individuo> obtenerIndividuosByEspecie(Connection conn, int idEspecie){
        ArrayList <Individuo> listIndividuo = new ArrayList<>();
//            Conexion_MySQL miconn = null;
            ResultSet respuesta = null;
        try {
//            String sql = "SELECT idindividuo, idtaxonomia, idlocalidad, nombre, descripcion, codigo, (SELECT especie FROM taxonomia where idtaxonomia = I.idtaxonomia ) as especie, (SELECT nombre FROM localidad where idlocalidad = I.idlocalidad ) as localidad  FROM individuo I WHERE idlocalidad = '"+idLocalidad+"';" ;
            String sql = "SELECT idindividuo, idtaxonomia, idlocalidad, nombre, descripcion, codigo FROM individuo I WHERE  I.idtaxonomia = "+idEspecie+"" ;
//            miconn = new Conexion_MySQL();
            respuesta = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while(respuesta.next()){
                listIndividuo.add(
                        new Individuo(respuesta.getInt("idtaxonomia"),respuesta.getInt("idlocalidad"),respuesta.getInt("idindividuo"),respuesta.getString("nombre"),respuesta.getString("codigo")
                                ,respuesta.getString("descripcion"),"",""));
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
            Logger.getLogger(Individuo.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
        }
        return  listIndividuo;
    }
    
}
