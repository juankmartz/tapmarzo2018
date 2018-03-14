/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import BD.Conexion_MySQL;
import java.sql.Connection;
import java.sql.Time;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.scene.chart.PieChart;

/**
 *
 * @author desarrolloJuan
 */
public class Clima {
    Date fecha;
    Time hora;
    float tempOut,hiTemp,lowTemp,outHum,rain,solarRad;
    int idClima, idLocalidad;

    public Clima(Date fecha, Time hora, float tempOut, float hiTemp, float lowTemp, float outHum, float rain, float solarRad) {
        this.fecha = fecha;
        this.hora = hora;
        this.tempOut = tempOut;
        this.hiTemp = hiTemp;
        this.lowTemp = lowTemp;
        this.outHum = outHum;
        this.rain = rain;
        this.solarRad = solarRad;
    }
    
    public Clima(Date fecha, Time hora, float tempOut, float hiTemp, float lowTemp, float outHum, float rain, float solarRad, int idClima, int idLocalidad) {
        this.fecha = fecha;
        this.hora = hora;
        this.tempOut = tempOut;
        this.hiTemp = hiTemp;
        this.lowTemp = lowTemp;
        this.outHum = outHum;
        this.rain = rain;
        this.solarRad = solarRad;
        this.idClima = idClima;
        this.idLocalidad = idLocalidad;
    }

    public Date getFecha() {
        return fecha;
    }

    public Time getHora() {
        return hora;
    }

    public float getTempOut() {
        return tempOut;
    }

    public float getHiTemp() {
        return hiTemp;
    }

    public float getLowTemp() {
        return lowTemp;
    }

    public float getOutHum() {
        return outHum;
    }

    public float getRain() {
        return rain;
    }

    public float getSolarRad() {
        return solarRad;
    }

    public int getIdClima() {
        return idClima;
    }
    
    public static ArrayList<Clima> obtenerDatosClimaTodos(Connection conn) throws Exception{
        ArrayList<Clima> climaDatos = new ArrayList<>();
        String sql = "SELECT * FROM clima";
//        Conexion_MySQL miconn = new Conexion_MySQL();
        ResultSet resp = Conexion_MySQL.ejecutarConsulta(conn,sql);
        try {
           while(resp.next()){
               climaDatos.add(new Clima(resp.getDate("fecha"), resp.getTime("hora"),resp.getFloat("temp")
                       ,resp.getFloat("temp_max"),resp.getFloat("temp_min"),resp.getFloat("humedad")
                       ,resp.getFloat("lluvia"),resp.getInt("radiacion"),resp.getInt("idclima")
                       ,resp.getInt("idlocalidad")));
           }
        } catch (SQLException ex) {
            Logger.getLogger(Medicion.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
           return climaDatos = new ArrayList<>();
        }
//        miconn.cerrarConexcion();
        return climaDatos;
    }
    
    public static ArrayList<Clima> getPromedioClimaIdLocalidad(Connection conn, int _idLocalidad) throws Exception{
//        Conexion_MySQL miconn = new Conexion_MySQL();
        try {
            ArrayList<Clima> promedioClima = new ArrayList<>();
            String sql = "SELECT fecha, idlocalidad, idclima, hora, avg(temp) as temp, avg(temp_max) as temp_max,avg(temp_min) as temp_min ,"
                    + " avg(humedad) as humedad, avg(lluvia) as lluvia,avg(radiacion) as radiacion "
                    + " FROM clima where idlocalidad = '"+_idLocalidad+"' group by  year(fecha), month(fecha) asc order by fecha asc ;";
            ResultSet res = Conexion_MySQL.ejecutarConsulta(conn, sql);
            while(res.next()){       
                promedioClima.add(new Clima(res.getDate("fecha"),res.getTime("hora") ,res.getFloat("temp")
                        ,res.getFloat("temp_max") , res.getFloat("temp_min"),
                        res.getFloat("humedad"), res.getFloat("lluvia"), res.getFloat("radiacion"), res.getInt("idclima"), res.getInt("idlocalidad")));
                        }
//            miconn.cerrarConexcion();
            return promedioClima;
        } 
        catch (SQLException ex) {
            Logger.getLogger(Clima.class.getName()).log(Level.SEVERE, null, ex);
//            miconn.cerrarConexcion();
            return new ArrayList<>();
        }
       
    }
            
}
