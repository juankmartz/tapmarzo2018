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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author desarrolloJuan
 */
public class Rasgo {
    
    String nombre, name, unidad, descripcion,coeficienteVariacion,tiporasgo,nombre_columna,sigla,tipodato;
    int replicam, replicar, idrasgo;

    public Rasgo() {
        this.nombre = "sin_definir";
        this.name = "sin_definir";
        this.unidad = "sin_definir";
        this.descripcion = "sin_definir";
        this.coeficienteVariacion = "sin_definir";
        this.tiporasgo = "sin_definir";
        this.nombre_columna = "sin_definir";
        this.sigla = "sin_definir";
        this.tipodato = "sin_definir";
        this.replicam = 0;
        this.replicar = 0;
        this.idrasgo = 0;
    }
    

    


    public Rasgo(String nombre, String name, String unidad, String descripcion, String coeficienteVariacion, String tiporasgo, String nombre_columna, String sigla, String tipodato, int replicam, int replicar, int idrasgo) {
        this.nombre = nombre;
        this.name = name;
        this.unidad = unidad;
        this.descripcion = descripcion;
        this.coeficienteVariacion = coeficienteVariacion;
        this.tiporasgo = tiporasgo;
        this.nombre_columna = nombre_columna;
        this.sigla = sigla;
        this.tipodato = tipodato;
        this.replicam = replicam;
        this.replicar = replicar;
        this.idrasgo = idrasgo;
    }

    public String getTipodato() {
        return tipodato;
    }

    public String getNombre() {
        return nombre;
    }

    public String getName() {
        return name;
    }

    public String getUnidad() {
        return unidad;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getCoeficienteVariacion() {
        return coeficienteVariacion;
    }

    public String getTiporasgo() {
        return tiporasgo;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setUnidad(String unidad) {
        this.unidad = unidad;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setCoeficienteVariacion(String coeficienteVariacion) {
        this.coeficienteVariacion = coeficienteVariacion;
    }

    public void setTiporasgo(String tiporasgo) {
        this.tiporasgo = tiporasgo;
    }

    public void setNombre_columna(String nombre_columna) {
        this.nombre_columna = nombre_columna;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public void setTipodato(String tipodato) {
        this.tipodato = tipodato;
    }

    public void setReplicam(int replicam) {
        this.replicam = replicam;
    }

    public void setReplicar(int replicar) {
        this.replicar = replicar;
    }

    public void setIdrasgo(int idrasgo) {
        this.idrasgo = idrasgo;
    }

    public String getNombre_columna() {
        return nombre_columna;
    }

    public String getSigla() {
        return sigla;
    }

    public int getReplicam() {
        return replicam;
    }

    public int getReplicar() {
        return replicar;
    }

    public int getIdrasgo() {
        return idrasgo;
    }
    
    /**
     * 
     * @param nombre
     * @param name
     * @param unidad
     * @param descripcion
     * @param replicam
     * @param replicar
     * @param nombreColumna
     * @param tipoDato
     * @return -1 cuando no se logro realizar el registro del rasgo, y si es satisfactorio retornara el IDRASGO (Int) del nuevo registro
     */
    public static int registrarRasgo(Connection conn, String nombre, String name, String unidad, String descripcion, int replicam, int replicar, String nombreColumna, String tipoDato) {
            int idRasgo = -1;
        try {
            String tipoColumna = "FLOAT(10,4)";
            if(tipoDato.equals("texto")) tipoColumna = "VARCHAR(50)";
            String sql = "ALTER TABLE `medicion`" +
                    " ADD COLUMN `"+nombreColumna+"` "+tipoColumna+" NULL ;";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            if(Conexion_MySQL.ejecutarSentencia(conn,sql)) {
                sql="INSERT INTO `rasgos` (`nombre`,`descripcion`, `unidad`, `replica_minima`, `replica_recomendada`,  `name`, `nombre_columna` ) "
                        + "VALUES ('"+nombre+"','"+descripcion+"', '"+unidad+"', '"+replicam+"', '"+replicar+"', '"+name+"', '"+nombreColumna+"');";
                idRasgo = Conexion_MySQL.ejecutarInsertId(conn,sql);
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return idRasgo;

    }
     public static int registrarRasgo(Connection conn, String nombre, String name, String unidad, String descripcion, String nombreColumna, String tipoDato, String tipoRasgo, String sigla) {
            int idRasgo = -1;
        try {
            String tipoColumna = "FLOAT(10,4)";
            if(tipoDato.equals("texto")) tipoColumna = "VARCHAR(70)";
            String sql = "ALTER TABLE `medicion`" +
                    " ADD COLUMN `"+nombreColumna+"` "+tipoColumna+" NULL ;";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            if(Conexion_MySQL.ejecutarSentencia(conn, sql)) {
                sql="INSERT INTO `rasgos` (`nombre`,`descripcion`, `unidad`,  `name`, `nombre_columna`, tipo_rasgo, tipo_columna, sigla) "
                        + "VALUES ('"+nombre+"','"+descripcion+"', '"+unidad+"',  '"+name+"', '"+nombreColumna+"', '"+tipoRasgo+"', '"+tipoColumna+"', '"+sigla+"');";
                idRasgo = Conexion_MySQL.ejecutarInsertId(conn, sql);
            }
//            miconn.cerrarConexcion();
        } catch (Exception ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return idRasgo;

    }
    
//    public static int registrarRasgoCompleto(String nombre, String name, String unidad,  String descripcion,String coeficienteVariacion,
//            String tipoRasgo,  int replicam, int replicar, String nombreColumna, String tipoDato) {
//        int idlocal = -1;
//        String tipoColumna = "FLOAT(10,4)";
//        if(tipoDato.equals("text")) tipoColumna = "VARCHAR(50)";
//        String sql = "ALTER TABLE `medicion`" +
//              " ADD COLUMN `"+nombreColumna+"` "+tipoColumna+" NULL ;";
//        if(Conexion_MySQL.ejecutarSentencia(sql)) {
//            sql="INSERT INTO `rasgos` (`nombre`,`descripcion`, `unidad`, `replica_minima`, `replica_recomendada`,  `name`, `nombre_columna`,"
//                    + "`coeficiente_vareacion`,`tipo_rasgo`,`sigla`,`tipo_columna` ) "
//                + "VALUES ('"+nombre+"','"+descripcion+"', '"+unidad+"', '"+replicam+"', '"+replicar+"', '"+name+"', '"+nombreColumna+"', "
//                    + "'"+coeficienteVariacion+"','"+tipoRasgo+"','"+sigla+"','"+tipoDato+"');";
//        idlocal = Conexion_MySQL.ejecutarInsertId(sql);
//        }
//        return idlocal;
//    }coeficienteVariacion, String tipoRasgo,
    public static int registrarRasgoCompleto(Connection conn, String nombre, String name, String unidad,String sigla,  String descripcion,
              int replicam, int replicar, String nombreColumna, String tipoDato) {
            int idRasgo = -1;
        try {
            String tipoColumna = "FLOAT(10,4)";
            if(tipoDato.equals("text")) tipoColumna = "VARCHAR(50)";
            String sql = "ALTER TABLE `medicion`" +
                    " ADD COLUMN `"+nombreColumna+"` "+tipoColumna+" NULL ;";

            if(Conexion_MySQL.ejecutarSentencia(conn, sql)) {
                sql="INSERT INTO `rasgos` (`nombre`,`descripcion`, `unidad`, `replica_minima`, `replica_recomendada`,  `name`, `nombre_columna`,"
                        + "`sigla`,`tipo_columna` ) "
                        + "VALUES ('"+nombre+"','"+descripcion+"', '"+unidad+"', '"+replicam+"', '"+replicar+"', '"+name+"', '"+nombreColumna+"', "
                        + "'"+sigla+"','"+tipoColumna+"');";
                idRasgo = Conexion_MySQL.ejecutarInsertId(conn, sql);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
        }
        
            return idRasgo;
    }
    
    public static boolean existeNombreColumna(Connection conn, String nombreColumna) throws Exception{
        try {
            String sql = "select count(nombre_columna) as contador from rasgos where nombre_columna = '"+nombreColumna+"';";
            boolean existe = false;
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            if (resp.next()) {
                if (resp.getInt("contador") > 0) {
                    existe = true;
                }
            }
//            miconn.cerrarConexcion();
            return existe;
        } catch (SQLException ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
            return true;
        }
    }
//    public static ResultSet getRasgos(){
//        try {
//            String sql = "SELECT * FROM rasgos ;";
//            Conexion_MySQL miconn = new Conexion_MySQL();
//            ResultSet resp = miconn.ejecutarConsulta(sql);
//            return resp;
//        } catch (Exception ex) {
//            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
//            return null;
//        }
//    }
    
    public static Rasgo getRasgosPorID(Connection conn,String idrasgo) throws Exception{
        Rasgo miRasgo = null;
        Float idrasgoBuscar = Float.parseFloat(idrasgo);
        int intIdRasgo = idrasgoBuscar.intValue();
        String sql = "SELECT * FROM rasgos WHERE idrasgos = '"+intIdRasgo+"';";
//        Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
        try {
            if(resp.next()){ 
                String nombreColumn = resp.getString("nombre_columna");
                miRasgo = new Rasgo(resp.getString("nombre"),resp.getString("name") ,
                    resp.getString("unidad"),resp.getString("descripcion") , resp.getString("coeficiente_vareacion"),
                    resp.getString("tipo_rasgo"),nombreColumn ,resp.getString("sigla") ,
                    resp.getString("tipo_columna"), resp.getInt("replica_minima"), resp.getInt("replica_recomendada"),resp.getInt("idrasgos") );
            }
        } catch (SQLException ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Exception al buscar Rasgo segun idrasgos \n "+ ex);
            System.out.println(sql);
        }
//        miconn.cerrarConexcion();
        return miRasgo;
    }
    public static ArrayList<Rasgo> getRasgosList(Connection conn) throws Exception{
        ArrayList<Rasgo> listRasgo = new ArrayList<>();
        String sql = "SELECT * FROM rasgos ;";
//        Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
        try {
            while(resp.next()){
                Rasgo mirasgo  = new Rasgo(resp.getString("nombre"),resp.getString("name") ,resp.getString("unidad") ,resp.getString("descripcion") , 
                        resp.getString("coeficiente_vareacion"),resp.getString("tipo_rasgo") , 
                        resp.getString("nombre_columna"), resp.getString("sigla"),resp.getString("tipo_columna") ,
                        resp.getInt("replica_minima") , resp.getInt("replica_recomendada"),resp.getInt("idrasgos") );
                listRasgo.add(mirasgo);
            }
//            miconn.cerrarConexcion();
        } catch (SQLException ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
            return listRasgo;
    }
    
    public static ArrayList<Rasgo> getRasgosListOrdenByTipo(Connection conn) throws Exception{
        ArrayList<Rasgo> listRasgo = new ArrayList<>();
        String sql = "SELECT * FROM rasgos order by tipo_rasgo;";
//        Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
        try {
            while(resp.next()){
                Rasgo mirasgo  = new Rasgo(resp.getString("nombre"),resp.getString("name") ,resp.getString("unidad") ,resp.getString("descripcion") , 
                        resp.getString("coeficiente_vareacion"),resp.getString("tipo_rasgo") , 
                        resp.getString("nombre_columna"), resp.getString("sigla"),resp.getString("tipo_columna") ,
                        resp.getInt("replica_minima") , resp.getInt("replica_recomendada"),resp.getInt("idrasgos") );
                listRasgo.add(mirasgo);
            }
//            miconn.cerrarConexcion();
        } catch (SQLException ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
            return listRasgo;
    }
    
    public static ArrayList<Rasgo> getRasgosList(Connection conn, String [] listaIdRasgos) throws Exception{
        ArrayList<Rasgo> listRasgo = new ArrayList<>();
        String sql = "SELECT * FROM rasgos WHERE idrasgos in ( xxxRasgoxxx ) ;";
        String xxxIdRasgoxxx = "";
        for(String idrasgo : listaIdRasgos){
            xxxIdRasgoxxx += " '"+idrasgo+"' ,";
        }
        xxxIdRasgoxxx = xxxIdRasgoxxx.substring(0, xxxIdRasgoxxx.length()-1);
        sql = sql.replace("xxxRasgoxxx", xxxIdRasgoxxx);
//        Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
        try {
            while(resp.next()){
                Rasgo mirasgo  = new Rasgo(resp.getString("nombre"),resp.getString("name") ,resp.getString("unidad") ,resp.getString("descripcion") , 
                        resp.getString("coeficiente_vareacion"),resp.getString("tipo_rasgo") , 
                        resp.getString("nombre_columna"), resp.getString("sigla"),resp.getString("tipo_columna") ,
                        resp.getInt("replica_minima") , resp.getInt("replica_recomendada"),resp.getInt("idrasgos") );
                listRasgo.add(mirasgo);
            }
//            miconn.cerrarConexcion();
        } catch (SQLException ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
            return listRasgo;
    }
    
    public static ArrayList<Rasgo> getRasgosListPorIdEspecie(Connection conn, int idTaxonomia) throws Exception{
        ArrayList<Rasgo> listRasgo = new ArrayList<>();
        String sql = "SELECT R.* FROM rasgos R, rasgo_especie RE Where RE.idtaxonomia = '"+idTaxonomia+"' and R.idrasgos = RE.idrasgo;";
//        Conexion_MySQL miconn = new Conexion_MySQL();    
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
        try {
            while(resp.next()){
                Rasgo mirasgo  = new Rasgo(resp.getString("nombre"),resp.getString("name") ,resp.getString("unidad") ,resp.getString("descripcion") , 
                        resp.getString("coeficiente_vareacion"),resp.getString("tipo_rasgo") , 
                        resp.getString("nombre_columna"), resp.getString("sigla"),resp.getString("tipo_columna") ,
                        resp.getInt("replica_minima") , resp.getInt("replica_recomendada"),resp.getInt("idrasgos") );
                listRasgo.add(mirasgo);
            }
//            miconn.cerrarConexcion();
        } catch (SQLException ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
            return listRasgo;
    }
    
    public static ArrayList<Rasgo> getRasgosListPorCriterio(Connection conn, String criterio) throws Exception{
        ArrayList<Rasgo> listRasgo = new ArrayList<>();
        String sql = "SELECT * FROM rasgos  where nombre like '%"+criterio+"%' or name like '%"+criterio+"%' or idrasgos like '"+criterio+"%' or sigla like '"+criterio+"%'";
//        String sql = "SELECT * FROM rasgos  where CONCAT(nombre,' ', name,' ', idrasgos,' ', sigla) like '"+criterio+"%'";
//        Conexion_MySQL miconn = new Conexion_MySQL();    
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
        try {
            while(resp.next()){
                Rasgo mirasgo  = new Rasgo(resp.getString("nombre"),resp.getString("name") ,resp.getString("unidad") ,resp.getString("descripcion") , 
                        resp.getString("coeficiente_vareacion"),resp.getString("tipo_rasgo") , 
                        resp.getString("nombre_columna"), resp.getString("sigla"),resp.getString("tipo_columna") ,
                        resp.getInt("replica_minima") , resp.getInt("replica_recomendada"),resp.getInt("idrasgos") );
                listRasgo.add(mirasgo);
            }
//            miconn.cerrarConexcion();
        } catch (SQLException ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
            return listRasgo;
    }
    
    
    public static ArrayList<Rasgo> getRasgosComunesByListIndividuos(Connection conn, String [] idIndividuos) throws Exception{
        ArrayList<Rasgo> listRasgo = new ArrayList<>();
        String sql = "select idtaxonomia from individuo where idindividuo in ( XXXRemplazoXXX ) group by idtaxonomia;";
        String remplazo = "";
        for(String idIndividuo: idIndividuos){
            remplazo += "'"+idIndividuo+"',";
        }
        if(remplazo.substring(remplazo.length()-1,remplazo.length()).equals(",")) remplazo = remplazo.substring(0,remplazo.length()-1);
        sql = sql.replace("XXXRemplazoXXX", remplazo);
//        Conexion_MySQL conn = new Conexion_MySQL();
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
        ArrayList<String> idEspecie = new ArrayList<>();
        while (resp.next()) {
           idEspecie.add(resp.getString("idtaxonomia"));
        }
        
        for(int i = 0; i< idEspecie.size() ; i++){
            String valor = idEspecie.get(i);
            if(i == 0)sql = "SELECT idrasgo FROM rasgo_especie where idtaxonomia = '"+valor+"' XXremplazoXX ";
            else{
                sql = sql.replace("XXremplazoXX"," and idrasgo in ( SELECT idrasgo FROM rasgo_especie where idtaxonomia = '"+valor+"' XXremplazoXX )" );
            }
            if(i+1 < idEspecie.size()){
                
            }else{
                sql = sql.replace("XXremplazoXX", "");
            }
        }
        resp = null;
        resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
        while(resp.next()){
            listRasgo.add(Rasgo.getRasgosPorID(conn,resp.getString("idrasgo")));
        }
//        conn.cerrarConexcion();
//        System.out.println("sentencia busqueda *********************************");
//        System.out.println(sql);
//        System.out.println("sentencia busqueda fin *****************************");
        return listRasgo;
    }
    
    public static ArrayList<Rasgo> getRasgosComunesbyIdEspecie(Connection conn, String [] ListEspecie) throws Exception{
        ArrayList<Rasgo> listRasgo = new ArrayList<>();
        String sql = "select idtaxonomia from individuo where idindividuo in ( XXXRemplazoXXX ) group by idtaxonomia;";
        
        ArrayList<String> idEspecie = new ArrayList<>();
        for(String idesp : ListEspecie){
            idEspecie.add(idesp);
        }
        for(int i = 0; i< idEspecie.size() ; i++){
            String valor = idEspecie.get(i);
            if(i == 0)sql = "SELECT idrasgo FROM rasgo_especie where idtaxonomia = '"+valor+"' XXremplazoXX ";
            else{
                sql = sql.replace("XXremplazoXX"," and idrasgo in ( SELECT idrasgo FROM rasgo_especie where idtaxonomia = '"+valor+"' XXremplazoXX )" );
            }
            if(i+1 < idEspecie.size()){
                
            }else{
                sql = sql.replace("XXremplazoXX", "");
            }
        }
        ResultSet resp = null;
        resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
        while(resp.next()){
            listRasgo.add(Rasgo.getRasgosPorID(conn,resp.getString("idrasgo")));
        }
//        conn.cerrarConexcion();
//        System.out.println("sentencia busqueda *********************************");
//        System.out.println(sql);
//        System.out.println("sentencia busqueda fin *****************************");
        return listRasgo;
    }
    
//    public static ResultSet getRasgosEspecie( int idespecie) throws Exception{
//        String sql = "SELECT * FROM rasgo_especie WHERE idtaxonomia='"+idespecie+"';";
//        Conexion_MySQL miconn = new Conexion_MySQL();    
//        ResultSet resp = miconn.ejecutarConsulta(sql);
//            return resp;
//    }
    /**
     * Lista los rasgos asociados a una especie, colocando como Key el idRasgo y en Value el idtaxonomia
     * @param idespecie
     * @return HashMap Integer (idRasgo), String (nombre)
     * @throws Exception 
     */
    public static HashMap<Integer, String> getRasgosEspecieHashMap(Connection conn, int idespecie) throws Exception{
        String sql = "SELECT * FROM rasgo_especie WHERE idtaxonomia='"+idespecie+"';";
        HashMap<Integer, String> listRasgos = new HashMap<>();
//        Conexion_MySQL conn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
        try {
            while(resp.next()){
                Integer id_Rasgo = resp.getInt("idrasgo");
                String id_Especie = resp.getString("idtaxonomia");
                listRasgos.put(id_Rasgo, id_Especie);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
        }
//        conn.cerrarConexcion();
            return listRasgos;
    }
    
    public static int registroCaracteristicaEspecie(Connection conn, int idEspecie, int idRasgo){      
        String sql =  "INSERT INTO `rasgo_especie` (`idtaxonomia`, `idrasgo`) "
                + " VALUES ('"+idEspecie+"', '"+idRasgo+"');";
        int ultimoID = Conexion_MySQL.ejecutarInsertId(conn, sql);
        return ultimoID;
    }
    
    public static boolean registroCaracteristicaEspecieRagos(Connection conn,int idEspecie, String[] Rasgos){
        try {
            if(Rasgos == null) return false;
            boolean resp = true;
            String sql = "DELETE FROM `rasgo_especie` WHERE `idtaxonomia`='"+idEspecie+"' ;";
            Conexion_MySQL.ejecutarSentencia(conn, sql);
            for(String idrasgo: Rasgos){
                int idRasgo = Integer.valueOf(idrasgo);
                sql = " INSERT INTO `rasgo_especie` (`idtaxonomia`, `idrasgo`) "
                        + "VALUES ('"+idEspecie+"', '"+idRasgo+"');";
                int ultimoID = Conexion_MySQL.ejecutarInsertId(conn, sql);
                if (ultimoID <= 0)resp = false;
            }
            return resp;
        } catch (SQLException ex) {
            Logger.getLogger(Rasgo.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    public static boolean limpiarRasgosEspecie(Connection conn,int idEspecie) throws Exception{
         String sql = "DELETE FROM `rasgo_especie` WHERE `idtaxonomia`='"+idEspecie+"';";
//         Conexion_MySQL miconn = new Conexion_MySQL();
         return Conexion_MySQL.ejecutarSentencia(conn, sql);
    }
    public static boolean desasociarRasgodelasEspecies(Connection conn, int idRasgo) throws Exception{
         String sql = "DELETE FROM `rasgo_especie` WHERE  idrasgo = '"+idRasgo+"'; ";
//         Conexion_MySQL miconn = new Conexion_MySQL();
         return Conexion_MySQL.ejecutarSentencia(conn, sql);
    }
    public static ResultSet conteoRasgosByTipoRasgo(Connection conn) throws Exception{
         String sql = "select count(idrasgos) as total, tipo_rasgo from rasgos group by tipo_rasgo desc; ";
//         Conexion_MySQL miconn = new Conexion_MySQL();
         return Conexion_MySQL.ejecutarConsulta(conn, sql);
    }
}
