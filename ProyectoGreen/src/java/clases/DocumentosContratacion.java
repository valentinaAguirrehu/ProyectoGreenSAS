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
public class DocumentosContratacion {
     private String id;
     private String contratoTrabajo;
     private String tratamientoDatos;
     private String autorizacionExamenesRequisas;
     private String profesiograma;
     private String induccionSST;
     private String induccionSGA;
     private String actaPausasActivas;
     private String induccionCargo;
     private String documentoSagrilaft;

    public DocumentosContratacion() {
    }

    public DocumentosContratacion(String id) {
                    String consultaSQL = "select id,contratoTrabajo,tratamientoDatos,autorizacionExamenesRequisas,profesiograma,"
                            + "induccionSST,induccionSGA,actaPausasActivas,induccionCargo,documentoSagrilaft "
                      + "from documentoContratacion where id = " + id;
              ResultSet resultado = ConectorBD.consultar(consultaSQL);  
        try {
            if (resultado.next()) {
                this.id = id;
                contratoTrabajo = resultado.getString("contratoTrabajo");
                tratamientoDatos = resultado.getString("tratamientoDatos");
                autorizacionExamenesRequisas = resultado.getString("autorizacionExamenesRequisas");
                profesiograma = resultado.getString("profesiograma");
                induccionSST = resultado.getString("induccionSST");
                induccionSGA = resultado.getString("induccionSGA");
                actaPausasActivas = resultado.getString("actaPausasActivas");
                induccionCargo = resultado.getString("induccionCargo");
                documentoSagrilaft = resultado.getString("documentoSagrilaft");
             
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

    public String getContratoTrabajo() {
        return contratoTrabajo;
    }

    public void setContratoTrabajo(String contratoTrabajo) {
        this.contratoTrabajo = contratoTrabajo;
    }

    public String getTratamientoDatos() {
        return tratamientoDatos;
    }

    public void setTratamientoDatos(String tratamientoDatos) {
        this.tratamientoDatos = tratamientoDatos;
    }

    public String getAutorizacionExamenesRequisas() {
        return autorizacionExamenesRequisas;
    }

    public void setAutorizacionExamenesRequisas(String autorizacionExamenesRequisas) {
        this.autorizacionExamenesRequisas = autorizacionExamenesRequisas;
    }

    public String getProfesiograma() {
        return profesiograma;
    }

    public void setProfesiograma(String profesiograma) {
        this.profesiograma = profesiograma;
    }

    public String getInduccionSST() {
        return induccionSST;
    }

    public void setInduccionSST(String induccionSST) {
        this.induccionSST = induccionSST;
    }

    public String getInduccionSGA() {
        return induccionSGA;
    }

    public void setInduccionSGA(String induccionSGA) {
        this.induccionSGA = induccionSGA;
    }

    public String getActaPausasActivas() {
        return actaPausasActivas;
    }

    public void setActaPausasActivas(String actaPausasActivas) {
        this.actaPausasActivas = actaPausasActivas;
    }

    public String getInduccionCargo() {
        return induccionCargo;
    }

    public void setInduccionCargo(String induccionCargo) {
        this.induccionCargo = induccionCargo;
    }

    public String getDocumentoSagrilaft() {
        return documentoSagrilaft;
    }

    public void setDocumentoSagrilaft(String documentoSagrilaft) {
        this.documentoSagrilaft = documentoSagrilaft;
    }
    
     public boolean grabar() {
        String consultaSQL = "INSERT INTO documentosContratacion (id, contratoTrabajo, tratamientoDatos, " +
                "autorizacionExamenesRequisas, profesiograma, induccionSST, induccionSGA, " +
                "actaPausasActivas, induccionCargo, documentoSagrilaft) VALUES ('" +
                id + "', '" + contratoTrabajo + "', '" + tratamientoDatos + "', '" +
                autorizacionExamenesRequisas + "', '" + profesiograma + "', '" + induccionSST + "', '" +
                induccionSGA + "', '" + actaPausasActivas + "', '" + induccionCargo + "', '" +
                documentoSagrilaft + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "UPDATE documentosContratacion SET " +
                "contratoTrabajo = '" + contratoTrabajo + "', " +
                "tratamientoDatos = '" + tratamientoDatos + "', " +
                "autorizacionExamenesRequisas = '" + autorizacionExamenesRequisas + "', " +
                "profesiograma = '" + profesiograma + "', " +
                "induccionSST = '" + induccionSST + "', " +
                "induccionSGA = '" + induccionSGA + "', " +
                "actaPausasActivas = '" + actaPausasActivas + "', " +
                "induccionCargo = '" + induccionCargo + "', " +
                "documentoSagrilaft = '" + documentoSagrilaft + "' " +
                "WHERE id = '" + id + "'";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }
     
     
    public boolean eliminar() {
        String consultaSQL = "delete from documentosContratacion where id = " + id;
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
        String cadenaSQL = "select id,contratoTrabajo,tratamientoDatos,autorizacionExamenesRequisas,profesiograma,"
                            + "induccionSST,induccionSGA,actaPausasActivas,induccionCargo,documentoSagrilaft "
                      + "from documentoContratacion " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }

  
 public static List<DocumentosContratacion> getListaEnObjetos(String filtro, String orden) {
        List<DocumentosContratacion> lista = new ArrayList<>();
        ResultSet datos = DocumentosContratacion.getLista(filtro, orden);
        if (datos != null) {
            try {
                while (datos.next()) {
                    DocumentosContratacion documentoContratacion = new DocumentosContratacion();
                    documentoContratacion.setId(datos.getString("id"));
                    documentoContratacion.setContratoTrabajo(datos.getString("contratoTrabajo"));
                    documentoContratacion.setTratamientoDatos(datos.getString("tratamientoDatos"));
                    documentoContratacion.setAutorizacionExamenesRequisas(datos.getString("autorizacionExamenesRequisas"));
                    documentoContratacion.setProfesiograma(datos.getString("profesiograma"));
                    documentoContratacion.setInduccionSST(datos.getString("induccionSST"));
                    documentoContratacion.setInduccionSGA(datos.getString("induccionSGA"));
                    documentoContratacion.setActaPausasActivas(datos.getString("actaPausasActivas"));
                    documentoContratacion.setInduccionCargo(datos.getString("induccionCargo"));
                    documentoContratacion.setDocumentoSagrilaft(datos.getString("documentoSagrilaft"));

                    lista.add(documentoContratacion);
                }
            } catch (SQLException ex) {
                Logger.getLogger(DocumentosContratacion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }


}
