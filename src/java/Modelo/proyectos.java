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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author desarrolloJuan
 */
public class proyectos {
    
    String titulo, descripcion, resumen, estado;
    Date fechaCreo;
    int idProyecto, numeroMedicion;
//    HashMap<Integer,localidad> localidades;
    ArrayList<localidad> localidades;

    public String getTitulo() {
        return titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getResumen() {
        return resumen;
    }

    public String getEstado() {
        return estado;
    }

    public Date getFechaCreo() {
        return fechaCreo;
    }

    public int getIdProyecto() {
        return idProyecto;
    }

    public ArrayList<localidad> getLocalidades() {
        return localidades;
    }

    public int getNumeroMedicion() {
        return numeroMedicion;
    }

    public proyectos(String titulo, String descripcion, String resumen, String estado, int idProyecto,Date fechaCreo) {
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.resumen = resumen;
        this.estado = estado;
        this.idProyecto = idProyecto;
        this.fechaCreo = fechaCreo;
    }

    public proyectos(Connection conn, int idProyecto) throws Exception {
        try {
            this.idProyecto = idProyecto;
            String sql = "SELECT * FROM proyecto WHERE idproyecto = '"+idProyecto+"' ;";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
            if(resp.next()){
                this.titulo = resp.getString("titulo");
                this.descripcion = resp.getString("descripcion");
                this.resumen = resp.getString("resumen");
                this.estado = resp.getString("estado");
                this.fechaCreo = resp.getDate("fecha");
                this.idProyecto = resp.getInt("idproyecto");
                this.numeroMedicion = resp.getInt("numeroMedicion");
                localidades = getLocalidadProyecto(conn);
            }
        } catch (SQLException ex) {
            Logger.getLogger(proyectos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static int  registrarProyecto(Connection conn, String titulo, String descripcion, String resumen, String palabra, String estado){ 
                String fecha = Conexion_MySQL.obtenerFechaActualMySQL();
                String sql = "INSERT INTO `proyecto` (`titulo`, `descripcion`, `fecha`, `estado`, `resumen`,`palabraClave`) "
                + "VALUES ('"+titulo+"', '"+descripcion+"', '"+fecha+"', '"+estado+"', '"+resumen+"', '"+palabra+"');";
                int ultimoID = Conexion_MySQL.ejecutarInsertId(conn,sql);                
        return ultimoID;

    }
    public static boolean registrarProyectoIndividuo(Connection conn, int idProyecto, String[] individuos) throws SQLException{
        boolean resp = true;
        //Eliminamos todos los registros de individuos asocidos al idProyecto
         String sql = "DELETE FROM `proyecto_individuo` WHERE `idproyecto`='"+idProyecto+"' ;";
        Conexion_MySQL.ejecutarSentencia(conn, sql);
        // registramos todos los individuos asociados al proyecto
        for (String individuoSelect : individuos) {
             sql = "INSERT INTO `proyecto_individuo` (`idproyecto`, `idindividuo`, `estado`) "
                        + "VALUES ('"+idProyecto+"', '"+individuoSelect+"', 'ACTIVO');";
                int ultimoID = Conexion_MySQL.ejecutarInsertId(conn, sql);
                if (ultimoID == -1)resp = false;
        }  
        return resp;
    }
    
    public static boolean registrarProyectoRasgos(Connection conn, int idProyecto, String[] rasgos) throws SQLException{
        boolean resp = true;
        //Eliminamos todos los registros de individuos asocidos al idProyecto
        String sql = "DELETE FROM `proyecto_rasgo` WHERE `idproyecto`='"+idProyecto+"' ;";
        if(Conexion_MySQL.ejecutarSentencia(conn, sql))
        // registramos todos los individuos asociados al proyecto
        for (String rasgo : rasgos) {
             sql = "INSERT INTO `proyecto_rasgo` (`idproyecto`, `idrasgo`) VALUES ('"+idProyecto+"', '"+rasgo+"');";
                int ultimoID = Conexion_MySQL.ejecutarInsertId(conn, sql);
                if (ultimoID <= 0)resp = false;
        } 
        
        else return false;
        return resp;
    }
    
    /**
     * lista todos los proyectos de datos que se encuentran activos, de no encontrar ninguno retorna null
     * @return  List[proyectos] lista con los proyectos
     */
    
    public static ArrayList<proyectos> getProyectosList(Connection conn ) throws Exception{
//            Conexion_MySQL miconn = new Conexion_MySQL();
        try {
            ResultSet resp = null;
            ArrayList<proyectos> proyect = new ArrayList<>();
            String sql = "SELECT * FROM proyecto where estado = 'ACTIVO';";
            resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while (resp.next()) {
                String tituloP, descripcionP, resumenP, estadoP;
                Date fechaCreoP;
                int idProyectoP;
                tituloP = resp.getString("titulo");
                descripcionP = resp.getString("descripcion");
                resumenP = resp.getString("resumen");
                estadoP = resp.getString("estado");
                fechaCreoP = resp.getDate("fecha");
                idProyectoP = resp.getInt("idproyecto");
               proyect.add(new proyectos(tituloP, descripcionP, resumenP, estadoP, idProyectoP, fechaCreoP));
            }
//            miconn.cerrarConexcion();
            return proyect;
        } catch (SQLException ex) {
            Logger.getLogger(proyectos.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
            return new ArrayList<>();
        }
    }
    
   

    /**
     * 
     * @param idProyecto
     * @return una lista con los Individuos asociados al proyecto
     */
    public static ArrayList<Individuo> getIndividuosProyectoList(Connection conn, int idProyecto) throws Exception{
            ArrayList<Individuo> listInd = new ArrayList<>();
            String sql = "SELECT I.*, (select especie from taxonomia where idtaxonomia = I.idtaxonomia) as especie, (select nombre from localidad where idlocalidad = I.idlocalidad) as localidad FROM proyecto_individuo P, individuo I WHERE P.idproyecto = '"+idProyecto+"' and P.idindividuo = I.idindividuo ;";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
        try {
            while (resp.next()) {
                int idtaxonomia = resp.getInt("idtaxonomia");
                int idlocalidad = resp.getInt("idlocalidad");
                int idindividuo = resp.getInt("idindividuo");
                String nombre = resp.getString("nombre");
                String codigo = resp.getString("codigo");
                String descripcion = resp.getString("descripcion");
                String especie = resp.getString("especie");
                String nomblocalidad = resp.getString("localidad");
                Individuo nuevoIndi = new Individuo(idtaxonomia, idlocalidad, idindividuo, nombre, codigo, descripcion, especie, nomblocalidad);
                listInd.add(nuevoIndi);
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(proyectos.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
            return new ArrayList<>();
        }
//        miconn.cerrarConexcion();
            return listInd;
    }
    
    public static ArrayList<taxonomia> getEspecieByProyectoList(Connection conn, int idProyecto) throws Exception{
            ArrayList<taxonomia> listespecie = new ArrayList<>();
            String sql = "SELECT * from taxonomia WHERE idtaxonomia in ( select idtaxonomia from individuo where idindividuo in (select idindividuo from proyecto_individuo where idproyecto = '"+idProyecto+"'));";
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
        try {
            while (resp.next()) {
               listespecie.add( new taxonomia(resp.getString("clase"), resp.getString("subclase"), resp.getString("orden"),
                        resp.getString("familia"), resp.getString("genero"), resp.getString("especie"), resp.getString("nombre_comun"),
                        resp.getInt("idtaxonomia"),resp.getString("imagen")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(proyectos.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
            return listespecie;
    }
    
    public   ArrayList<localidad> getLocalidadProyecto (Connection conn ){
         
        try {
            ArrayList<localidad> local = new ArrayList<>();
            
            String sql = "SELECT L.idlocalidad AS idlocalidad, L.nombre as nombrelocalidad, L.descripcion as descripcionlocalidad, area, latitud, longitud, altitud, I.idindividuo as idindividuo " +
", idtaxonomia, I.nombre as nombreindividuo, I.descripcion as descripcionindividuo, codigo FROM localidad L, proyecto_individuo PI,individuo I, proyecto P " +
" where    PI.idproyecto = '"+this.idProyecto+"' and PI.idindividuo = I.idindividuo and L.idlocalidad = I.idlocalidad and P.estado = 'ACTIVO'  group by L.nombre";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while(resp.next()){
                String nombreLocalidad, descripcionLocalidad,area ; int alt;
                int idLocalidad =resp.getInt("idlocalidad");
                nombreLocalidad = resp.getString("nombrelocalidad");
                descripcionLocalidad = resp.getString("descripcionlocalidad");
                area = resp.getString("area");
                float lat = resp.getFloat("latitud");
                float lng = resp.getFloat("longitud");
                alt = resp.getInt("altitud");
                localidad nuevaLocalidad = new localidad(lat, lng, idLocalidad, nombreLocalidad, descripcionLocalidad, alt, area, "ACTIVO");
                local.add(nuevaLocalidad);
              
            }
//            miconn.cerrarConexcion();
            return local;
        } catch (Exception ex) {
            Logger.getLogger(localidad.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
    }
    

    
    public static ArrayList<Rasgo> getCaracteristicasComunesEspecieProyecto(Connection conn,  int idProyecto ) throws Exception{
        ArrayList<Rasgo> listRasgo = new ArrayList<>();
        String sql = "SELECT R.* FROM rasgos R, rasgo_especie RE, "
                + " (SELECT I.idtaxonomia as idtaxonomia FROM  individuo I , proyecto_individuo PI WHERE I.idindividuo = PI.idindividuo and PI.idproyecto = '" + idProyecto + "' group by idtaxonomia ) IP "
                + " where RE.idtaxonomia = IP.idtaxonomia and R.idrasgos = RE.idrasgo group by idrasgo order by R.nombre ASC;";
//        Conexion_MySQL miconn = new Conexion_MySQL();
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
        try {
            while(resp.next()){
                Rasgo rasgoInteres = new Rasgo(resp.getString("nombre"), resp.getString("name"),
                        resp.getString("unidad") ,resp.getString("descripcion") , resp.getString("coeficiente_vareacion"), 
                        resp.getString("tipo_rasgo"),resp.getString("nombre_columna") ,resp.getString("sigla") ,resp.getString("tipo_columna"),
                        resp.getInt("replica_minima") , resp.getInt("replica_recomendada"),resp.getInt("idrasgos") );
                listRasgo.add(rasgoInteres);
            }
        } catch (SQLException ex) {
            Logger.getLogger(proyectos.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
             return listRasgo = new ArrayList<>();
        }
//        miconn.cerrarConexcion();
        return listRasgo;
    }
    
     public static ArrayList<Rasgo> getCaracterisiticasInteresProyectoList(Connection conn, int idProyecto ) throws Exception{
         ArrayList<Rasgo> listRasgo = new ArrayList<>();
//        String sql = "SELECT * FROM proyecto_rasgo PR, rasgos R WHERE PR.idproyecto = '"+idProyecto+"' and PR.idrasgo = R.idrasgos ;";
        String sql = "SELECT R.* FROM proyecto_rasgo PR, rasgos R WHERE PR.idproyecto = '"+idProyecto+"' and R.idrasgos = PR.idrasgo ;";
//        Conexion_MySQL miconn = new Conexion_MySQL();
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
        try {
            while(resp.next()){
                Rasgo rasgoInteres = new Rasgo(resp.getString("nombre"), resp.getString("name"),
                        resp.getString("unidad") ,resp.getString("descripcion") , resp.getString("coeficiente_vareacion"), 
                        resp.getString("tipo_rasgo"),resp.getString("nombre_columna") ,resp.getString("sigla") ,resp.getString("tipo_columna"),
                        resp.getInt("replica_minima") , resp.getInt("replica_recomendada"),resp.getInt("idrasgos") );
                listRasgo.add(rasgoInteres);
            }
        } catch (SQLException ex) {
            Logger.getLogger(proyectos.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
             return listRasgo = new ArrayList<>();
        }
//        miconn.cerrarConexcion();
        return listRasgo;
    }
}
