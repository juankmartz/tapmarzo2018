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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author desarrolloJuan
 */
public class localidad {
    float lat,lon;
    int idlocalidad, altitud,diversidad;
    String nombre, descripcion,area ,estado;

    public float getLat() {
        return lat;
    }

    public float getLon() {
        return lon;
    }

    public int getIdlocalidad() {
        return idlocalidad;
    }

    public String getNombre() {
        return nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public int getAltitud() {
        return altitud;
    }

    

    public String getArea() {
        return area;
    }

    public int getDiversidad() {
        return diversidad;
    }

    public String getEstado() {
        return estado;
    }

    public localidad() {
    }

    public localidad(Connection conn, int idlocalidad) throws Exception {
        
        try {
            this.idlocalidad = idlocalidad;
            String sql = "SELECT * FROM localidad where idlocalidad = '"+idlocalidad+"';";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            if(resp.next()){
                this.nombre = resp.getString("nombre");
                this.descripcion = resp.getString("descripcion");
                this.altitud = resp.getInt("altitud");
                this.area = resp.getString("area");
                this.lat = resp.getFloat("latitud");
                this.lon = resp.getFloat("longitud");
                this.estado = resp.getString("estado");
            }
//            miconn.cerrarConexcion();
        } catch (SQLException ex) {
            Logger.getLogger(localidad.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public localidad(float lat, float lon, String nombre, String descripcion, int altitud) {
        this.lat = lat;
        this.lon = lon;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.altitud = altitud;
    }

    public localidad(float lat, float lon, int idlocalidad, String nombre, String descripcion, int altitud, String area, String estado) {
        this.lat = lat;
        this.lon = lon;
        this.idlocalidad = idlocalidad;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.altitud = altitud;
        this.area = area;
        this.estado = estado;
    }
    
    public localidad(float lat, float lon, int idlocalidad, String nombre, String descripcion, int altitud, String area, String estado, int diversidad) {
        this.lat = lat;
        this.lon = lon;
        this.idlocalidad = idlocalidad;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.altitud = altitud;
        this.area = area;
        this.estado = estado;
        this.diversidad = diversidad;
    }
    
    public static int registrarLocalidad(Connection conn, float lat, float lng, String nombre, String descripcion, String altitud,float area){
        String sql = "INSERT INTO `localidad` (`nombre`, `descripcion`, `area`, `latitud`, `longitud`, `altitud`) "
                + "VALUES ('"+nombre+"', '"+descripcion+"', '"+area+"', '"+lat+"', '"+lng+"', '"+altitud+"');";
        int idlocal = Conexion_MySQL.ejecutarInsertId(conn,sql);
        return idlocal;
    }
    
public static int getDiversidadByLocalidad(Connection conn, int idLocalidad) throws Exception {
        try {
            int conteo = 0;
            String sql = "select count(*) as total from taxonomia where idtaxonomia in (select idtaxonomia from  individuo where idlocalidad = "+idLocalidad+") ;";
            
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while (resp.next()) {
                conteo = resp.getInt("total");
            }
            return conteo;
        } catch (SQLException ex) {
            Logger.getLogger(taxonomia.class.getName()).log(Level.SEVERE, null, ex);
            return  -1;
        }
    }

    public static ArrayList <localidad> getLocalidadesList(Connection conn ) throws Exception{
        ArrayList <localidad> listLocal = new ArrayList <>();
            String sql = "SELECT * FROM localidad where estado = 'ACTIVO';";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
            resp.getFetchSize();
            while(resp.next()){
                int idlocal = resp.getInt("idlocalidad");
                int diversidad = getDiversidadByLocalidad(conn, idlocal);
                listLocal.add(new localidad(resp.getFloat("latitud"),resp.getFloat("longitud") ,resp.getInt("idlocalidad") 
                        ,resp.getString("nombre") , resp.getString("descripcion"), resp.getInt("altitud"),
                        resp.getString("area"), resp.getString("estado"),diversidad));
            }
//            miconn.cerrarConexcion();
            return listLocal;
    }
    
    public static ArrayList <localidad> getLocalidadesList(Connection conn, String [] idLocalidad) throws Exception{
        ArrayList <localidad> listLocal = new ArrayList <>();
        String remplazos = "";
        for(String idlocal : idLocalidad){
            remplazos += "'"+idlocal+"',";
        }
        remplazos = remplazos.substring(0, remplazos.length()-1);
            String sql = "SELECT *, " +
" (select count(*) as diversidad  from (select idtaxonomia, idindividuo, idlocalidad from individuo  group by idlocalidad, idtaxonomia) Taa where Taa.idlocalidad = L.idlocalidad group by Taa.idlocalidad) as diversidad " +
" FROM localidad L " +
" where estado = 'ACTIVO' and L.idlocalidad in ("+remplazos+");";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while(resp.next()){
                listLocal.add(new localidad(resp.getFloat("latitud"),resp.getFloat("longitud") ,resp.getInt("idlocalidad") 
                        ,resp.getString("nombre") , resp.getString("descripcion"), resp.getInt("altitud"),
                        resp.getString("area"), resp.getString("estado"),resp.getInt("diversidad")));
            }
//            miconn.cerrarCConnection conn, onexcion();
            return listLocal;
    }
    /**
     * lista las locaclidades asociadas a un proyecto.
     * @param idProyecto
     * @return Localidad[] lista de las localidades
     */
    public static ArrayList<localidad> getLocalidadProyecto (Connection conn, int idProyecto){
         
        try {
           ArrayList <localidad> local = new ArrayList<>() ;
            String sql = "SELECT L.idlocalidad AS idlocalidad, L.nombre as nombrelocalidad, L.descripcion as descripcionlocalidad, area, latitud, longitud, altitud, I.idindividuo as idindividuo " +
", idtaxonomia, I.nombre as nombreindividuo, I.descripcion as descripcionindividuo, codigo FROM localidad L, proyecto_individuo PI,individuo I, proyecto P " +
" where    PI.idproyecto = '"+idProyecto+"' and PI.idindividuo = I.idindividuo and L.idlocalidad = I.idlocalidad and P.estado = 'ACTIVO'  group by L.nombre";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while(resp.next()){
                String nombreLocalidad, descripcionLocalidad,area; 
                int alt;
                int idLocalidad =resp.getInt("idlocalidad");
                nombreLocalidad = resp.getString("nombrelocalidad");
                descripcionLocalidad = resp.getString("descripcionlocalidad");
                area = resp.getString("area");
                float lat = resp.getFloat("latitud");
                float lng = resp.getFloat("longitud");
                alt = resp.getInt("altitud");
                localidad nuevaLocalidad = new localidad(lat, lng, idLocalidad, nombreLocalidad, descripcionLocalidad, alt, area, "ACTIVO");
               boolean add;
               add = local.add(nuevaLocalidad );
               if(add){
                   
               }
            }
//            miconn.cerrarConexcion();
            return local;
        } catch (Exception ex) {
            Logger.getLogger(localidad.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    public static String getMarcadores(Connection conn ) throws Exception{
        try {
            String marcador = "var marcadores = [ ";
            String sql = "SELECT * FROM localidad where estado = 'ACTIVO';";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while(resp.next()){
                marcador += "['"+resp.getString("nombre")+"', "+resp.getFloat("latitud")+", "+resp.getFloat("longitud")+", 4],";
                
            }
            marcador = marcador.substring(0, marcador.length() - 1);
            marcador = marcador + "];";
            return marcador;
        } catch (SQLException ex) {
            Logger.getLogger(localidad.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        }
    }
    
    public static ArrayList <localidad> getLocalidadesListByIdEspecie(Connection conn, int idEspecie ) throws Exception{
        ArrayList <localidad> listLocal = new ArrayList <>();
            String sql = "SELECT * FROM localidad  where idlocalidad in ( select idlocalidad from individuo where idtaxonomia = '"+idEspecie+"' group by idlocalidad ) and estado = 'ACTIVO';";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
            while(resp.next()){
                listLocal.add(new localidad(resp.getFloat("latitud"),resp.getFloat("longitud") ,resp.getInt("idlocalidad") 
                        ,resp.getString("nombre") , resp.getString("descripcion"), resp.getInt("altitud"),
                        resp.getString("area"), resp.getString("estado")));
            }
//            miconn.cerrarConexcion();
            return listLocal;
    }
}
