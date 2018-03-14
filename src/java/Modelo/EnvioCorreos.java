/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author JuanCaMaBo
 */

import BD.Conexion_MySQL;
//import Bean.contenido;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EnvioCorreos {
    public String EmailMaestro =""; //es el correo que se usara para el envio automatico de correos
    public String PassEmail = "";   //Contraseña de acceso al emailMaestro
    
    public void  cargaDatosConfiguracion(){
         try {
            ResultSet rs = null;
            String SQL = "SELECT * FROM configuracion where parametro = 'EmailMaestro';";
            Connection conn = Conexion_MySQL.conectar2();
            PreparedStatement ps = conn.prepareStatement(SQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = ps.executeQuery();
            if(rs.next()){
                EmailMaestro = rs.getString("valor");
            }
            SQL = "SELECT * FROM configuracion where parametro = 'PassEmailMaestro';";
            ps = conn.prepareStatement(SQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = ps.executeQuery();
            if(rs.next()){
                PassEmail = rs.getString("valor");
            }
            conn.close();
        } catch (Exception ex) {
//            Logger.getLogger(contenido.class.getName()).log(Level.SEVERE, null, ex);
            
        }
    }
    //public boolean enviarCorreo(String de, String clave, String[] para, String mensaje, String asunto){
    public boolean enviarCorreo(String de, String clave, String para, String mensaje, String asunto){
        boolean enviado = false;
            try{
            
                String host = "smtp-mail.outlook.com";
                
                Properties prop = System.getProperties();
                
                prop.put("mail.smtp.starttls.enable","true");
                prop.put("mail.smtp.host", host);
                prop.put("mail.smtp.user",de);
                prop.put("mail.smtp.password", clave);
                prop.put("mail.smtp.port",587);
                prop.put("mail.smtp.auth","true");
                
                Session sesion = Session.getDefaultInstance(prop,null);
                
                MimeMessage message = new MimeMessage(sesion);
                
                message.setFrom(new InternetAddress(de));
                
                /*
                    
                    NOTA: para enviar correo electronico masivo
                
                    InternetAddress[] direcciones = new InternetAddress[para.length];
                    for(int i=0;i<para.length;i++){
                        direcciones[i] = new InternetAddress(para[i]);
                    }
                
                    for(int i=0;i<direcciones.length;i++){
                        message.addRecipient(Message.RecipientType.TO, direcciones[i]);
                    }
                
                */
                
                message.setRecipient(Message.RecipientType.TO, new InternetAddress(para));
                
                message.setSubject(asunto);
                message.setText(mensaje);
                
                Transport transport = sesion.getTransport("smtp");
                
                transport.connect(host,de,clave);
                
                transport.sendMessage(message, message.getAllRecipients());
                
                transport.close();
                
                enviado = true;
                
            }catch(Exception e){
                e.printStackTrace();
            }
        
        return enviado;
    }
    
    public boolean enviarCorreo(String para, String mensaje, String asunto){
        boolean enviado = false;
        cargaDatosConfiguracion();
            try{
            
                String host = "smtp-mail.outlook.com";
                Properties prop = System.getProperties();
                
                prop.put("mail.smtp.starttls.enable","true");
                prop.put("mail.smtp.host", host);
                prop.put("mail.smtp.user",EmailMaestro);
                prop.put("mail.smtp.password", PassEmail);
                prop.put("mail.smtp.port",587);
                prop.put("mail.smtp.auth","true");
                
                Session sesion = Session.getDefaultInstance(prop,null);
                
                MimeMessage message = new MimeMessage(sesion);
                
                message.setFrom(new InternetAddress(EmailMaestro));
                
                /*
                    
                    NOTA: para enviar correo electronico masivo
                
                    InternetAddress[] direcciones = new InternetAddress[para.length];
                    for(int i=0;i<para.length;i++){
                        direcciones[i] = new InternetAddress(para[i]);
                    }
                
                    for(int i=0;i<direcciones.length;i++){
                        message.addRecipient(Message.RecipientType.TO, direcciones[i]);
                    }
                
                */
                
                message.setRecipient(Message.RecipientType.TO, new InternetAddress(para));
                
                message.setSubject(asunto);
                message.setText(mensaje);
                
                Transport transport = sesion.getTransport("smtp");
                
                transport.connect(host,EmailMaestro,PassEmail);
                
                transport.sendMessage(message, message.getAllRecipients());
                
                transport.close();
                
                enviado = true;
                
            }catch(Exception e){
                e.printStackTrace();
            }
        
        return enviado;
    }
    
}
