/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

/**
 *
 * @author desarrolloJuan
 */
import BD.Conexion_MySQL;
import Modelo.Configuracion;
import Modelo.Individuo;
import Modelo.Rasgo;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

public class ManejoFicheros {

    public static String crearArchivoExcelP(Connection conn, String nombreArchivo, String[] titulos, String[][] contenido) {
        String hoja = "Hoja_1";
        String rutaArchivo = Configuracion.getValorConfiguracion(conn,"RUTA_ARCHIVO");
        rutaArchivo = rutaArchivo + "\\" + nombreArchivo + ".xlsx";
        XSSFWorkbook libro = new XSSFWorkbook();
        XSSFSheet hoja1 = libro.createSheet(hoja);
        //cabecera de la hoja de excel
        String[] header = new String[]{"Código", "Producto", "Precio", "Unidades"};

        //contenido de la hoja de excel
        String[][] document = new String[][]{
            {"AP150", "ACCESS POINT TP-LINK TL-WA901ND 450Mbps Wireless N 1RJ45 10-100 3Ant.", "112.00", "50"},
            {"RTP150", "ROUTER TP-LINK TL-WR940ND 10-100Mbpps LAN WAN 2.4 - 2.4835Ghz", "19.60", "25"},
            {"TRT300", "TARJETA DE RED TPLINK TL-WN881ND 300Mpbs Wire-N PCI-Exp.", "10.68", "15"},
            {"TRT300", "DE RED TPLINK TL-WN881ND 300Mpbs Wire-N PCI-Exp.", "10.68", "15"},
            {"TR0", "DE RED TPLINK TL-WN881ND 300Mpbs Wire-N PCI-Exp.", "10.68", "15"}
        };

        //poner negrita a la cabecera
        CellStyle style = libro.createCellStyle();
        Font font = libro.createFont();
        font.setBold(true);
        style.setFont(font);
        //generar los datos para el documento
        for (int i = 0; i <= document.length; i++) {
            XSSFRow row = hoja1.createRow(i);//se crea las filas
            for (int j = 0; j < header.length; j++) {
                if (i == 0) {//para la cabecera
                    XSSFCell cell = row.createCell(j);//se crea las celdas para la cabecera, junto con la posición
                    cell.setCellStyle(style); // se añade el style crea anteriormente 
                    cell.setCellValue(header[j]);//se añade el contenido					
                } else {//para el contenido
                    XSSFCell cell = row.createCell(j);//se crea las celdas para la contenido, junto con la posición
                    cell.setCellValue(document[i - 1][j]); //se añade el contenido
                }
            }
        }
        File file;
        file = new File(rutaArchivo);
        try (FileOutputStream fileOuS = new FileOutputStream(file)) {
            if (file.exists()) {// si el archivo existe se elimina
                file.delete();
                System.out.println("Archivo eliminado");
            }
            libro.write(fileOuS);
            fileOuS.flush();
            fileOuS.close();
            System.out.println("Archivo Creado");

        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return "";
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
        return rutaArchivo;
    }

    public static String crearArchivoExcelMasivosMediciones(Connection conn,String nombreArchivo, String[] titulos) throws Exception {
//    public static String crearArchivoExcelMasivosMediciones(String nombreArchivo, String[] titulos, String[][] contenido) {
        ArrayList <Rasgo> listaRasgos = new ArrayList();
        for(String rasgoID : titulos){
            listaRasgos.add(Rasgo.getRasgosPorID(conn,rasgoID));
        }
        String hoja = "Hoja_1";
        String rutaArchivo = Configuracion.getValorConfiguracion(conn,"RUTA_ARCHIVO");
        rutaArchivo = rutaArchivo + "\\" + nombreArchivo + ".xlsx";
        XSSFWorkbook libro = new XSSFWorkbook();
        XSSFSheet hoja1 = libro.createSheet(hoja);
        //cabecera de la hoja de excel
        //poner negrita a la cabecera
        CellStyle style0 = libro.createCellStyle();
        CellStyle style1 = libro.createCellStyle();
        Font font0 = libro.createFont();
        font0.setColor(HSSFColor.WHITE.index);
        style0.setFont(font0);
//        font.setFontHeight(new Short("300"));
        Font font = libro.createFont();
        font.setBold(true);
        style1.setFont(font);
        style1.setBorderTop(BorderStyle.MEDIUM);
        style1.setBorderBottom(BorderStyle.MEDIUM);
        
            XSSFRow row0 = hoja1.createRow(0);//se crea las filas
            XSSFRow row1 = hoja1.createRow(1);//se crea las filas
            XSSFCell cell = row1.createCell(0);
            cell.setCellStyle(style1); 
            cell.setCellValue("Fecha ");
            cell = row1.createCell(1);
            cell.setCellStyle(style1); 
            cell.setCellValue("Hora (hh:mm:ss)");
            cell = row1.createCell(2);
            cell.setCellStyle(style1); 
            cell.setCellValue("Individuo");
//            agregando ceros en los primeras casillas que iran vacias
        cell = row0.createCell(0);
        cell.setCellValue("dd/mm/yyyy"); //formato de la fecha
        cell = row0.createCell(1); 
        cell.setCellValue("24H"); // formato de la hora
        cell = row0.createCell(2);
        cell.setCellValue("int"); //formato del codigo individuo
            row0.setRowStyle(style0);
            
            for (int j = 0; j < listaRasgos.size(); j++) {
                    cell = row0.createCell(j+3);//se crea las celdas para la cabecera, junto con la posición
                    cell.setCellStyle(style0); // se añade el style crea anteriormente 
                    cell.setCellValue(listaRasgos.get(j).getIdrasgo());//se añade el contenido
                    cell = row1.createCell(j+3);
                    cell.setCellStyle(style1);
                    cell.setCellValue(listaRasgos.get(j).getSigla()+" ("+listaRasgos.get(j).getUnidad()+") ");//se añade el contenido
            }

        File file;
        file = new File(rutaArchivo);
        try (FileOutputStream fileOuS = new FileOutputStream(file)) {
            if (file.exists()) {// si el archivo existe se elimina
                file.delete();
                System.out.println("Archivo eliminado");
            }
            libro.write(fileOuS);
            fileOuS.flush();
            fileOuS.close();
            System.out.println("Archivo Creado");

        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return "";
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
        return rutaArchivo;
    }

    public  static void leeerArchivoExcel(){
        String nombreArchivo = "Inventario.xlsx";
		String rutaArchivo = "C:\\Ficheros-Excel\\" + nombreArchivo;
		String hoja = "Hoja1";

		try (FileInputStream file = new FileInputStream(new File(rutaArchivo))) {
			// leer archivo excel
			XSSFWorkbook worbook = new XSSFWorkbook(file);
			//obtener la hoja que se va leer
			XSSFSheet sheet = worbook.getSheetAt(0);
			//obtener todas las filas de la hoja excel
			Iterator<Row> rowIterator = sheet.iterator();

			Row row;
			// se recorre cada fila hasta el final
			while (rowIterator.hasNext()) {
				row = rowIterator.next();
				//se obtiene las celdas por fila
				Iterator<Cell> cellIterator = row.cellIterator();
				Cell cell;
				//se recorre cada celda
				while (cellIterator.hasNext()) {
					// se obtiene la celda en específico y se la imprime
					cell = cellIterator.next();
					System.out.print(cell.getStringCellValue()+" | ");
				}
				System.out.println();
			}
		} catch (Exception e) {
			e.getMessage();
		}
    }
    
    public static String leerArchivoExcelPrueba(){
        String nombreArchivo = "formatoMasivo.xlsx";
//		String rutaArchivo = "C:\\Ficheros-Excel\\" + nombreArchivo;
		String rutaArchivo = "C:\\Users\\desarrolloJuan\\Documents\\NetBeansProjects\\proyect2\\web\\Arcivos\\temporal\\" + nombreArchivo;
		String hoja = "Hoja1";
String miTabla = "";
		try (FileInputStream file = new FileInputStream(new File(rutaArchivo))) {
			// leer archivo excel
			XSSFWorkbook worbook = new XSSFWorkbook(file);
			//obtener la hoja que se va leer
			XSSFSheet sheet = worbook.getSheetAt(0);
			//obtener todas las filas de la hoja excel
			Iterator<Row> rowIterator = sheet.iterator();

			Row row;
			// se recorre cada fila hasta el final
                        miTabla = "<table class=\"table\"><tbody>";
			while (rowIterator.hasNext()) {
				row = rowIterator.next();
				//se obtiene las celdas por fila
				Iterator<Cell> cellIterator = row.cellIterator();
				Cell cell;
                                miTabla = miTabla +"<tr>";
				//se recorre cada celda
				while (cellIterator.hasNext()) {
                                    miTabla = miTabla +"<td>";
					// se obtiene la celda en específico y se la imprime  
                                    cell = cellIterator.next();
                                    System.out.print(" (" + cell.getCellType()+ ") ");
                                    if (cell.getCellType() == 0) {
                                        System.out.print(cell.getNumericCellValue() + " | ");
                                        miTabla = miTabla + cell.getNumericCellValue();
                                    } else {
                                        if (cell.getCellType() == 1) {
                                            System.out.print(cell.getStringCellValue() + " | ");
                                            miTabla = miTabla + cell.getStringCellValue();
                                        }else{
                                            System.out.print(" | ");
                                        }
                                    }
                                       
                                        miTabla = miTabla +"</td>";

				}
                                miTabla = miTabla +"</tr>";
				System.out.println();
			}
                        miTabla = miTabla +"</tbody></table>";
                        return miTabla;
		} catch (Exception e) {
			e.getMessage();
                        return miTabla;
                        
		
		}
    }
    
    public static int[] leerMasivoClima(Connection conn, File fileClima) {
        int[] datosResgistrados = {0, 0, 0};//{exitosos, num datos, fallidos}
//        String values = " ( ";
        String campos = " ( ";
        String sql = "";
        try (FileInputStream file = new FileInputStream(fileClima)) {
            // leer archivo excel
            XSSFWorkbook worbook = new XSSFWorkbook(file);
            //obtener la hoja que se va leer
            XSSFSheet sheet = worbook.getSheetAt(0);
            //obtener todas las filas de la hoja excel
            Iterator<Row> rowIterator = sheet.iterator();

            Row row;
            // se recorre cada fila hasta el final
             while (rowIterator.hasNext()) {
                String values = " ( ";
                row = rowIterator.next();
                int posicionRow = row.getRowNum();
                
                //se obtiene las celdas por fila
                Iterator<Cell> cellIterator = row.cellIterator();
                Cell cell;
                //se recorre cada celda
                int tempNumValues = 0;
                if (posicionRow != 0) 
                {//saltamos la primera row ya que continen los titulos de la tabla
                    while (cellIterator.hasNext()) {
                        
                        // se obtiene la celda en específico y se la imprime  
                        cell = cellIterator.next();

                        int posicioncolumn = cell.getColumnIndex();

//                        System.out.print(" (" + cell.getCellType() + ") ");
                        switch (posicioncolumn) {
                            case 0: {
                                values = values + "'" + cell.getNumericCellValue() + "',";
//                                System.out.print(cell.getNumericCellValue() + " | ");
                                tempNumValues++;
                            }
                            break;
                            case 1: {
                                Date fecha = cell.getDateCellValue();
                                java.sql.Date sqlDate = new java.sql.Date(fecha.getTime());
                                values =values + "'" + sqlDate.toString() +"',";
                                System.out.print(cell.getDateCellValue()+ " | ");
                                tempNumValues++;
                            }break;
                            case 2: {
                                switch (cell.getCellType()) {

                                    case 0:
                                        values =values+ "'" + cell.getNumericCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    case 1:
                                        values =values+ "'" + cell.getStringCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    default:
//                                        System.out.println();
                                        break;
                                }
                            }
                            break;
                            default: {
                                switch (cell.getCellType()) {

                                    case 0:
//                                        System.out.print(cell.getNumericCellValue() + " | ");
                                        values =values+ "'" + cell.getNumericCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    case 1:
//                                        System.out.print(cell.getStringCellValue() + " | ");
                                        values =values+ "'" + cell.getStringCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    default:
//                                        System.out.println();
                                        
                                        break;
                                }

                            }
                            break;
                        }
                    }
                }
//                System.out.println();
                values = values.substring(0, values.length() - 1)+" ) ";
                if(!values.replace(" ","").equals("()")){
//                    System.out.println("valores a ingresar : "+values);
                    campos = "(`idlocalidad`, `fecha`, `hora`, `temp`, `temp_max`, `temp_min`, `humedad`, `lluvia`, `radiacion` )";
                    sql = sql + "INSERT INTO `clima` "+campos+" VALUES "+values+";";
                    int ultimoId = Conexion_MySQL.ejecutarInsertId(conn, sql);
                    if(ultimoId>0){
                        datosResgistrados[0] ++;
                        datosResgistrados[1] = datosResgistrados[1] + tempNumValues;
                    }else datosResgistrados[2]++;
                }
            }
            
            
        } catch (Exception e) {
            e.getMessage();

        }
        return datosResgistrados;
    }
    
    public static int[] leerMasivoMediciones(Connection conn, File fileMasivoMedicion) {
            int[] datosResgistrados = {0, 0, 0};
        try {
            String campos = " ( fecha, hora, idindividuo,";
            String sql = "";
            Map<String, Integer> mapIndividuos = new HashMap<String, Integer>();
            mapIndividuos = Individuo.obtenerTodosIndividuosMapt(conn);
            try (FileInputStream file = new FileInputStream(fileMasivoMedicion)) {
                // leer archivo excel
                XSSFWorkbook worbook = new XSSFWorkbook(file);
                //obtener la hoja que se va leer
                XSSFSheet sheet = worbook.getSheetAt(0);
                //obtener todas las filas de la hoja excel
                Iterator<Row> rowIterator = sheet.iterator();
                Row row;
                if (rowIterator.hasNext()) {//leer primer renglon del archivo donde se contiene los idrasgo
                    row = rowIterator.next();
                    for(Cell cell : row){
                        int  indexCol = cell.getColumnIndex();
                        if( indexCol>2 ){
                            String idrasgo = "" + cell.getNumericCellValue();
                            Rasgo mirasgo = new Rasgo();
                            if(!idrasgo.equals("")) mirasgo = Rasgo.getRasgosPorID(conn, idrasgo);
                            if(mirasgo.getIdrasgo()>0)campos = campos +" `"+mirasgo.getNombre_columna()+"`,";
                        }
                    }
                    campos = campos.substring(0,campos.length()-1)+" ) ";
                }
                if (rowIterator.hasNext()) rowIterator.next();// saltando segundo renglon donde se presentar los titulos de la tabla
                
                // se recorre cada fila hasta el final de los datos a registrar
                while (rowIterator.hasNext()) {
                    String values = " ( ";
                    row = rowIterator.next();
                    int posicionRow = row.getRowNum();
                    //se obtiene las celdas por fila
                    Iterator<Cell> cellIterator = row.cellIterator();
                    Cell cell;
                    //se recorre cada celda
                    int tempNumValues = 0;
                    while (cellIterator.hasNext()) {
                        // se obtiene la celda en específico
                        cell = cellIterator.next();
                        int posicioncolumn = cell.getColumnIndex();
                        
                        switch (posicioncolumn) {
                            case 0: {//leemos la fecha
                                Date fecha = cell.getDateCellValue();
                                java.sql.Date sqlDate = new java.sql.Date(fecha.getTime());
                                values = values + "'" + sqlDate.toString() + "',";
                                System.out.print(cell.getDateCellValue() + " | ");
                                tempNumValues++;
                            }break;
                            case 1: {// leemos la Hora
                                switch (cell.getCellType()) {
                                    case 1:
                                        values = values + "'" + cell.getStringCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    default:
                                        values = values + "'23:59:59',"; //valor de la hora cuando falla la lectura
                                        break;
                                }
                            }break;
                            case 2: { //leemos el codigo del individuo
                                int codigof = (int) cell.getNumericCellValue();
                                values = values + "'" + mapIndividuos.get(String.valueOf(codigof)) + "',";
                                System.out.print(mapIndividuos.get(String.valueOf(codigof)) + " | ");
                                tempNumValues++;
                            }break;
                            default: { //lesctura de los datos generales para cada rasgo
                                switch (cell.getCellType()) {
                                    case 0:
                                        System.out.print(cell.getNumericCellValue() + " | ");
                                        values = values + "'" + cell.getNumericCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    case 1:
                                        System.out.print(cell.getStringCellValue() + " | ");
                                        values = values + "'" + cell.getStringCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    default:
                                        System.out.println("Typo de dato desconocido celda:[ "+cell.getRowIndex()+", "+cell.getColumnIndex()+" ]");
                                        break;
                                }
                                
                            }
                            break;
                        }
                    }
                    System.out.println();
                    values = values.substring(0, values.length() - 1) + " ) ";
                    if (!values.replace(" ", "").equals("()") && !campos.replace(" ", "").equals("()")) {
//                    System.out.println("valores a ingresar : " + values);
//                    System.out.println("Campos a ingresar : " + campos);

sql = "INSERT INTO `medicion` " + campos + " VALUES " + values + ";";
System.out.println("sentencia : " + sql);
int ultimoId = Conexion_MySQL.ejecutarInsertId(conn,sql);
    datosResgistrados[0]++; //numero de registros procesados
if (ultimoId > 0) {
    datosResgistrados[1] ++; //numero de registros exitosos
//    datosResgistrados[1] = datosResgistrados[1] + tempNumValues;
}else datosResgistrados[2]++; //numero de registros fallidos
                    }
                }
            }
            catch (Exception e) {
                e.getMessage();
                System.out.println("Ha ocurrido una exception : "+e.getMessage());
            }
            return datosResgistrados;
        } 
        catch (Exception ex) {
            Logger.getLogger(ManejoFicheros.class.getName()).log(Level.SEVERE, null, ex);
            return datosResgistrados;
        }
    }
    
    public static File guardarArchivoServidor(HttpServletRequest request) {
        boolean exito = false;
        Connection conn = (Connection)request.getSession().getAttribute("connMySql");
        File file = null;
        int maxFileSize = 50000 * 1024;//50Mb maximo
        int maxMemSize = 50000 * 1024;

        String filePath = Configuracion.getValorConfiguracion(conn,"RUTA_ARCHIVO") + "\\";

        // Verify the content type
        if (request.getContentLength() > 0) {
            String contentType = request.getContentType();
            if ((contentType.indexOf("multipart/form-data") >= 0)) {

                DiskFileItemFactory factory = new DiskFileItemFactory();
                // maximum size that will be stored in memory
                factory.setSizeThreshold(maxMemSize);
                // Location to save data that is larger than maxMemSize.
                factory.setRepository(new File("c:\\temp"));

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);
                // maximum file size to be uploaded.
                upload.setSizeMax(maxFileSize);
                try {
                    // Parse the request to get file items.
                    List fileItems = upload.parseRequest(new ServletRequestContext(request));

                    // Process the uploaded file items
                    Iterator i = fileItems.iterator();

                    while (i.hasNext()) {
                        FileItem fi = (FileItem) i.next();
                        if (!fi.isFormField()) {
                            // Get the uploaded file parameters
//                            String fileName = fi.getFieldName()+"_"+Conexion_MySQL.obtenerFechaActualMySQL();
                            String fileName = fi.getName();
                            boolean isInMemory = fi.isInMemory();
                            long sizeInBytes = fi.getSize();
                            // Write the file
                            if (fileName.lastIndexOf("\\") >= 0) {
                                file = new File(filePath
                                        + fileName.substring(fileName.lastIndexOf("\\")));
                            } else {
                                file = new File(filePath
                                        + fileName.substring(fileName.lastIndexOf("\\") + 1));
                            }
                            fi.write(file);
                            out.println("Uploaded Filename: " + filePath
                                    + fileName + "<br>");
                        }
                    }
                    exito = true;
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            } else {
                /*No se logro cargar el Archivo*/
                exito = false;
            }
        }
        return file;
    }
    
    public static File guardarArchivoServidorRutaDestino(HttpServletRequest request, String filePath) {
        boolean exito = false;
        Connection conn = (Connection)request.getSession().getAttribute("connMySql");
        File file = null;
        int maxFileSize = 50000 * 1024;//50Mb maximo
        int maxMemSize = 50000 * 1024;

//        String filePath = Configuracion.getValorConfiguracion(conn,"RUTA_ARCHIVO") + "\\";

        // Verify the content type
        if (request.getContentLength() > 0) {
            String contentType = request.getContentType();
            if ((contentType.indexOf("multipart/form-data") >= 0)) {

                DiskFileItemFactory factory = new DiskFileItemFactory();
                // maximum size that will be stored in memory
                factory.setSizeThreshold(maxMemSize);
                // Location to save data that is larger than maxMemSize.
                factory.setRepository(new File("c:\\temp"));

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);
                // maximum file size to be uploaded.
                upload.setSizeMax(maxFileSize);
                try {
                    // Parse the request to get file items.
                    List fileItems = upload.parseRequest(new ServletRequestContext(request));

                    // Process the uploaded file items
                    Iterator i = fileItems.iterator();

                    while (i.hasNext()) {
                        FileItem fi = (FileItem) i.next();
                        if (!fi.isFormField()) {
                            // Get the uploaded file parameters
//                            String fileName = fi.getFieldName()+"_"+Conexion_MySQL.obtenerFechaActualMySQL();
                            String fileName = fi.getName();
                            boolean isInMemory = fi.isInMemory();
                            long sizeInBytes = fi.getSize();
                            // Write the file
                            if (fileName.lastIndexOf("\\") >= 0) {
                                file = new File(filePath
                                        + fileName.substring(fileName.lastIndexOf("\\")));
                            } else {
                                file = new File(filePath
                                        + fileName.substring(fileName.lastIndexOf("\\") + 1));
                            }
                            fi.write(file);
                            out.println("Uploaded Filename: " + filePath
                                    + fileName + "<br>");
                        }
                    }
                    exito = true;
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            } else {
                /*No se logro cargar el Archivo*/
                exito = false;
            }
        }
        return file;
    }
    
    public static File guardarArchivoServidor(HttpServletRequest request, String rutaGuardar, String nombreImagen) {
        boolean exito = false;
        File file = null;
        int maxFileSize = 50000 * 1024;//50Mb maximo
        int maxMemSize = 50000 * 1024;

        String filePath = rutaGuardar+ "\\";

        // Verify the content type
        if (request.getContentLength() > 0) {
            String contentType = request.getContentType();
            if ((contentType.indexOf("multipart/form-data") >= 0)) {

                DiskFileItemFactory factory = new DiskFileItemFactory();
                // maximum size that will be stored in memory
                factory.setSizeThreshold(maxMemSize);
                // Location to save data that is larger than maxMemSize.
                factory.setRepository(new File("c:\\temp"));

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);
                // maximum file size to be uploaded.
                upload.setSizeMax(maxFileSize);
                try {
                    // Parse the request to get file items.
                    List fileItems = upload.parseRequest(new ServletRequestContext(request));

                    // Process the uploaded file items
                    Iterator i = fileItems.iterator();

                    while (i.hasNext()) {
                        FileItem fi = (FileItem) i.next();
                        if (!fi.isFormField()) {
                            // Get the uploaded file parameters
//                            String fileName = fi.getFieldName()+"_"+Conexion_MySQL.obtenerFechaActualMySQL();
                            String fileName = fi.getName();
                            boolean isInMemory = fi.isInMemory();
                            long sizeInBytes = fi.getSize();
                            // Write the file
                            if (fileName.lastIndexOf("\\") >= 0) {
                                file = new File(filePath
                                        + fileName.substring(fileName.lastIndexOf("\\")));
                            } else {
                                file = new File(filePath
                                        + fileName.substring(fileName.lastIndexOf("\\") + 1));
                            }
                            fi.write(file);
                            out.println("Uploaded Filename: " + filePath
                                    + nombreImagen + "<br>");
                        }
                    }
                    exito = true;
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            } else {
                /*No se logro cargar el Archivo*/
                exito = false;
            }
        }
        return file;
    }
    
     public static int[] leerMasivoRasgos(Connection conn, File fileClima) {
        int[] datosResgistrados = {0, 0, 0};//{exitosos, num datos, fallidos}
//        String values = " ( ";
        String campos = " ( ";
        String sql = "";
        try (FileInputStream file = new FileInputStream(fileClima)) {
            // leer archivo excel
            XSSFWorkbook worbook = new XSSFWorkbook(file);
            //obtener la hoja que se va leer
            XSSFSheet sheet = worbook.getSheetAt(0);
            //obtener todas las filas de la hoja excel
            Iterator<Row> rowIterator = sheet.iterator();

            Row row;
            // se recorre cada fila hasta el final
             while (rowIterator.hasNext()) {
                String values = " ( ";
                row = rowIterator.next();
                int posicionRow = row.getRowNum();
                
                //se obtiene las celdas por fila
                Iterator<Cell> cellIterator = row.cellIterator();
                Cell cell;
                //se recorre cada celda
                int tempNumValues = 0;
                if (posicionRow != 0) 
                {//saltamos la primera row ya que continen los titulos de la tabla
                    while (cellIterator.hasNext()) {
                        
                        // se obtiene la celda en específico y se la imprime  
                        cell = cellIterator.next();

                        int posicioncolumn = cell.getColumnIndex();

//                        System.out.print(" (" + cell.getCellType() + ") ");
                        switch (posicioncolumn) {
                            case 0: {
                                values = values + "'" + cell.getNumericCellValue() + "',";
//                                System.out.print(cell.getNumericCellValue() + " | ");
                                tempNumValues++;
                            }
                            break;
                            case 1: {
                                Date fecha = cell.getDateCellValue();
                                java.sql.Date sqlDate = new java.sql.Date(fecha.getTime());
                                values =values + "'" + sqlDate.toString() +"',";
                                System.out.print(cell.getDateCellValue()+ " | ");
                                tempNumValues++;
                            }break;
                            case 2: {
                                switch (cell.getCellType()) {

                                    case 0:
                                        values =values+ "'" + cell.getNumericCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    case 1:
                                        values =values+ "'" + cell.getStringCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    default:
//                                        System.out.println();
                                        break;
                                }
                            }
                            break;
                            default: {
                                switch (cell.getCellType()) {

                                    case 0:
//                                        System.out.print(cell.getNumericCellValue() + " | ");
                                        values =values+ "'" + cell.getNumericCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    case 1:
//                                        System.out.print(cell.getStringCellValue() + " | ");
                                        values =values+ "'" + cell.getStringCellValue() + "',";
                                        tempNumValues++;
                                        break;
                                    default:
//                                        System.out.println();
                                        
                                        break;
                                }

                            }
                            break;
                        }
                    }
                }
//                System.out.println();
                values = values.substring(0, values.length() - 1)+" ) ";
                if(!values.replace(" ","").equals("()")){
//                    System.out.println("valores a ingresar : "+values);
                    campos = "(`idlocalidad`, `fecha`, `hora`, `temp`, `temp_max`, `temp_min`, `humedad`, `lluvia`, `radiacion` )";
                    sql = sql + "INSERT INTO `clima` "+campos+" VALUES "+values+";";
                    int ultimoId = Conexion_MySQL.ejecutarInsertId(conn, sql);
                    if(ultimoId>0){
                        datosResgistrados[0] ++;
                        datosResgistrados[1] = datosResgistrados[1] + tempNumValues;
                    }else datosResgistrados[2]++;
                }
            }
            
            
        } catch (Exception e) {
            e.getMessage();

        }
        return datosResgistrados;
    }
    
}
