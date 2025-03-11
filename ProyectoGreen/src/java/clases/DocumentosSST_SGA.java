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
public class DocumentosSST_SGA {
     private String id;
     private String reInduccion;
     private String emo;
     private String otrosDocumentos;

    public DocumentosSST_SGA() {
    }

    public DocumentosSST_SGA(String id) {
           String consultaSQL = "select id,reInduccion,emo,otrosDocumentos from documentosSST_SGA where id = " + id;
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        try {
            if (resultado.next()) {
                this.id = id;
                reInduccion = resultado.getString("reInduccion");
                emo = resultado.getString("emo");
                otrosDocumentos = resultado.getString("otrosDocumentos");

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

    public String getReInduccion() {
        return reInduccion;
    }

    public void setReInduccion(String reInduccion) {
        this.reInduccion = reInduccion;
    }

    public String getEmo() {
        return emo;
    }

    public void setEmo(String emo) {
        this.emo = emo;
    }

    public String getOtrosDocumentos() {
        return otrosDocumentos;
    }

    public void setOtrosDocumentos(String otrosDocumentos) {
        this.otrosDocumentos = otrosDocumentos;
    }
     
     
      public boolean grabar() {
        String consultaSQL = "INSERT INTO documentos_sst_sga (id, reInduccion, emo, otrosDocumentos) VALUES ('" +
                id + "', '" + reInduccion + "', '" + emo + "', '" + otrosDocumentos + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "UPDATE documentos_sst_sga SET " +
                "reInduccion = '" + reInduccion + "', " +
                "emo = '" + emo + "', " +
                "otrosDocumentos = '" + otrosDocumentos + "' " +
                "WHERE id = '" + id + "'";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }
    public boolean eliminar() {
        String consultaSQL = "delete from documentosSST_SGA where id = " + id;
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
        String cadenaSQL = "select id,reInduccion,emo,otrosDocumentos from documentosSST_SGA " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }
    
     public static List<DocumentosSST_SGA> getListaEnObjetos(String filtro, String orden) {
        List<DocumentosSST_SGA> lista = new ArrayList<>();
        ResultSet datos = DocumentosSST_SGA.getLista(filtro, orden); 
        if (datos != null) {
            try {
                while (datos.next()) {
                    DocumentosSST_SGA documentoSST_SGA = new DocumentosSST_SGA();
                    documentoSST_SGA.setId(datos.getString("id"));
                    documentoSST_SGA.setReInduccion(datos.getString("reInduccion"));
                    documentoSST_SGA.setEmo(datos.getString("emo"));
                    documentoSST_SGA.setOtrosDocumentos(datos.getString("otrosDocumentos"));

                    lista.add(documentoSST_SGA);
                }
            } catch (SQLException ex) {
                Logger.getLogger(DocumentosSST_SGA.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
     }
}
