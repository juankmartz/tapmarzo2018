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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author desarrolloJuan
 */
public class taxonomia {

    String clase, subclase, orden, familia, genero, especie, nombreComun;
    int idespecie;
    String imagen;

    public taxonomia(int idespecie) {
        this.idespecie = idespecie;
    }

    public taxonomia(String clase, String subclase, String orden, String familia, String genero, String especie, String nombreComun, int idespecie, String imagen) {
        this.clase = clase;
        this.subclase = subclase;
        this.orden = orden;
        this.familia = familia;
        this.genero = genero;
        this.especie = especie;
        this.nombreComun = nombreComun;
        this.idespecie = idespecie;
        this.imagen = imagen;
    }

//    public byte[] getImagen() {
//        byte[] buffer = null;
//        try {
//            Blob bin = this.imagen;
//            if (bin != null) {
//                InputStream inStream = bin.getBinaryStream();
//                int size = (int) bin.length();
//                buffer = new byte[size];
//                int length = -1;
//                int k = 0;
//                try {
//                    inStream.read(buffer, 0, size);
//                } catch (IOException ex) {
//                    ex.printStackTrace();
//                }
//            }
//        } catch (Exception ex) {
//            return null;
//        } 
//        return buffer;
//    }

    public String getImagen() {
        return imagen;
    }

    public String getClase() {
        return clase;
    }

    public String getSubclase() {
        return subclase;
    }

    public String getOrden() {
        return orden;
    }

    public String getFamilia() {
        return familia;
    }

    public String getGenero() {
        return genero;
    }

    public String getEspecie() {
        return especie;
    }

    public String getNombreComun() {
        return nombreComun;
    }

    public int getIdespecie() {
        return idespecie;
    }

    public static int registrarEspecie(Connection conn, String clase, String subclase, String orden, String familia, String genero, String especie, String nombreComun) {
        String sql = "INSERT INTO `taxonomia` (`clase`, `subclase`, `orden`, `familia`, `genero`, `especie`, `nombre_comun`) "
                + "VALUES ('" + clase + "', '" + subclase + "', '" + orden + "', '" + familia + "', '" + genero + "', '" + especie + "', '" + nombreComun + "');";
        int idNuevoEspecie = 0;
        idNuevoEspecie = Conexion_MySQL.ejecutarInsertId(conn,sql);
        return idNuevoEspecie;
    }

     public static boolean actualizarImagenByIdEspecie(Connection conn, int IdEspecie , String rutaImagen) {
         boolean exito = false;
         String sql = "UPDATE `taxonomia` SET `imagen` = '"+rutaImagen.replace("\\", "\\\\")+"' WHERE `idtaxonomia` = '"+IdEspecie+"';";
        
        try {
            exito = Conexion_MySQL.ejecutarSentencia(conn,sql);
        } 
        catch (SQLException ex) {
            Logger.getLogger(taxonomia.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        return exito;
    }
     
    public static ArrayList<taxonomia> getEspeciesList(Connection conn ) throws Exception {
        try {
            ArrayList<taxonomia> listTax = new ArrayList<>();
            String sql = "SELECT * FROM taxonomia;";
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while (resp.next()) {
//                Blob bin = resp.getBlob("imagen");
                listTax.add(new taxonomia(resp.getString("clase"), resp.getString("subclase"), resp.getString("orden"),
                        resp.getString("familia"), resp.getString("genero"), resp.getString("especie"), resp.getString("nombre_comun"),
                        resp.getInt("idtaxonomia"), resp.getString("imagen")));
            }
            return listTax;
        } catch (SQLException ex) {
            Logger.getLogger(taxonomia.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
    }

    public static ArrayList<taxonomia> getEspeciesList(Connection conn, String[] listIdTaxonomia) throws Exception {
        try {
            ArrayList<taxonomia> listTax = new ArrayList<>();
            String sql = "SELECT * FROM taxonomia WHERE idtaxonomia in ( xxIdTaxonomiaXX );";
            String xxIdTaxonomia = "";
            for (String idTax : listIdTaxonomia) {
                xxIdTaxonomia += " '" + idTax + "' ,";
            }
            xxIdTaxonomia = xxIdTaxonomia.substring(0, xxIdTaxonomia.length() - 1);
            sql = sql.replace("xxIdTaxonomiaXX", xxIdTaxonomia);
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
            while (resp.next()) {
                listTax.add(new taxonomia(resp.getString("clase"), resp.getString("subclase"), resp.getString("orden"),
                        resp.getString("familia"), resp.getString("genero"), resp.getString("especie"), resp.getString("nombre_comun"),
                        resp.getInt("idtaxonomia"),resp.getString("imagen")));
            }
            return listTax;
        } catch (SQLException ex) {
            Logger.getLogger(taxonomia.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
    }
    
    public static ArrayList<taxonomia> getEspeciesListByNombre(Connection conn, String nombreEspecie) throws Exception {
        try {
            ArrayList<taxonomia> listTax = new ArrayList<>();
            String sql = "SELECT * FROM taxonomia where especie = '"+nombreEspecie+"';";
            
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
            while (resp.next()) {
                listTax.add(new taxonomia(resp.getString("clase"), resp.getString("subclase"), resp.getString("orden"),
                        resp.getString("familia"), resp.getString("genero"), resp.getString("especie"), resp.getString("nombre_comun"),
                        resp.getInt("idtaxonomia"),resp.getString("imagen")));
            }
            return listTax;
        } catch (SQLException ex) {
            Logger.getLogger(taxonomia.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
    }

    public static ArrayList<taxonomia> getEspeciesListByLocalidad(Connection conn, String[] listIdLocalidad) throws Exception {
        try {
            ArrayList<taxonomia> listTax = new ArrayList<>();
            String sql = "select * from taxonomia where idtaxonomia in (select idtaxonomia from  individuo where idlocalidad in ( xxxIdLocalidadesxxx )) ;";
            String xxIdLocalides = "";
            for (String idLocal : listIdLocalidad) {
                xxIdLocalides += " '" + idLocal + "' ,";
            }
            xxIdLocalides = xxIdLocalides.substring(0, xxIdLocalides.length() - 1);
            sql = sql.replace("xxxIdLocalidadesxxx", xxIdLocalides);
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while (resp.next()) {
                listTax.add(new taxonomia(resp.getString("clase"), resp.getString("subclase"), resp.getString("orden"),
                        resp.getString("familia"), resp.getString("genero"), resp.getString("especie"), resp.getString("nombre_comun"),
                        resp.getInt("idtaxonomia"),resp.getString("imagen")));
            }
            return listTax;
        } catch (SQLException ex) {
            Logger.getLogger(taxonomia.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
    }

    public static ArrayList<taxonomia> getEspeciesListPorListRasgo(Connection conn, String[] rasgos) throws Exception {
        try {
            ArrayList<taxonomia> listTax = new ArrayList<>();

            String sql = "SELECT T.* FROM taxonomia T, (  xxxRasgosxxx ) U WHERE T.idtaxonomia = U.idtaxonomia ;";
            String xxxRasgos = "";
            for (String idrasgo : rasgos) {
                xxxRasgos += " (select idtaxonomia from rasgo_especie  where idrasgo = '" + idrasgo + "' ) union";
            }
            xxxRasgos = xxxRasgos.substring(0, xxxRasgos.length() - 5);//eliminamos  el ultimo 'union'
            sql = sql.replace("xxxRasgosxxx", xxxRasgos);
//            Conexion_MySQL miconn = new Conexion_MySQL();
            ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while (resp.next()) {
                listTax.add(new taxonomia(resp.getString("clase"), resp.getString("subclase"), resp.getString("orden"),
                        resp.getString("familia"), resp.getString("genero"), resp.getString("especie"), resp.getString("nombre_comun"),
                        resp.getInt("idtaxonomia"),resp.getString("imagen")));
            }
            return listTax;
        } catch (SQLException ex) {
            Logger.getLogger(taxonomia.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<>();
        }
    }

}
