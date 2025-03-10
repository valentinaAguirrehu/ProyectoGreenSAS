/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VALEN
 */
public class DocumentoIdentificacion {
     private String id;
     private String documentoIdentificacion;

        public DocumentoIdentificacion() {
    }
      
    public DocumentoIdentificacion(String id) {
              String consultaSQL = "select id,documentoIdentificacion "
                      + "from documentoIdentificacion where id = " + id;
              ResultSet resultado = ConectorBD.consultar(consultaSQL);  
        try {
            if (resultado.next()) {
                this.id = id;
                documentoIdentificacion = resultado.getString("documentoIdentificacion");
             
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el ID: " + ex.getMessage());
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDocumentoIdentificacion() {
        return documentoIdentificacion;
    }

    public void setDocumentoIdentificacion(String documentoIdentificacion) {
        this.documentoIdentificacion = documentoIdentificacion;
    }
         public boolean grabar() {
        String consultaSQL = "insert into documentoIdentificacion (id, documentoIdentificacion, VALUES ('"
                + id + "', '" + documentoIdentificacion + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }
             public boolean modificar() {
        String consultaSQL = "update documentoIdentificacion set id = '" + id
                + "', documentoIdentificacion = '" + documentoIdentificacion + "' where id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }
     
     
    public boolean eliminar() {
        String consultaSQL = "delete from documentoIdentificacion where id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }
    
    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !filtro.trim().isEmpty()) {
            filtro = " where " + filtro;
        } else {
            filtro = "";
        }
        if (orden != null && !orden.trim().isEmpty()) {
            orden = " order by " + orden;
        } else {
            orden = "";
        }
        String cadenaSQL = "select id,documentoIdentificacion from documentoIdentificacion " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<DocumentoIdentificacion> getListaEnObjetos(String filtro, String orden) {
        List<DocumentoIdentificacion> lista = new ArrayList<>();
        ResultSet datos = DocumentoIdentificacion.getLista(filtro, orden);
        if (datos != null) {
            try {
                while (datos.next()) {
                    DocumentoIdentificacion documentoIdentificacion = new DocumentoIdentificacion();
                    documentoIdentificacion.setId(datos.getString("id"));
                    documentoIdentificacion.setDocumentoIdentificacion(datos.getString("documentoIdentificacion"));
                
                    lista.add(documentoIdentificacion);
                }
            } catch (SQLException ex) {
                Logger.getLogger(DocumentoIdentificacion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }
}
