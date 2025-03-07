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
 * @author Mary
 */


public class HistoriaLaboral {
    
    // Atributos
    private String id;
    private String identificacionPersona;
    private String idDocumentoIdentificacion; 
    private String idHojaDeVida;
    private String idDocumentoContratacion;
    private String idAfiliaciones;
    private String idDuranteContratacion;
    private String idAusentismos;
    private String idFinalizarContratacion;
    private String idDocumentosSST_SGA;
    private String observaciones;
    
    // Constructores
    public HistoriaLaboral() {
    }

    public HistoriaLaboral(String id) {
        String consultaSQL = "select identificacionPersona, idDocumentoIdentificacion, idHojaDeVida, "
                + "idDocumentoContratacion, idAfiliaciones, idDuranteContratacion, idAusentismos, "
                + "idFinalizarContratacion, idDocumentosSST_SGA, observaciones "
                + "from historia_laboral where id = " + id;
        
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        
        try {
            if (resultado.next()) {
                this.id = id;
                identificacionPersona = resultado.getString("identificacionPersona");
                idDocumentoIdentificacion = resultado.getString("idDocumentoIdentificacion");
                idHojaDeVida = resultado.getString("idHojaDeVida");
                idDocumentoContratacion = resultado.getString("idDocumentoContratacion");
                idAfiliaciones = resultado.getString("idAfiliaciones");
                idDuranteContratacion = resultado.getString("idDuranteContratacion");
                idAusentismos = resultado.getString("idAusentismos");
                idFinalizarContratacion = resultado.getString("idFinalizarContratacion");
                idDocumentosSST_SGA = resultado.getString("idDocumentosSST_SGA");
                observaciones = resultado.getString("observaciones");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el ID: " + ex.getMessage());
        }
    }

    // Getters y Setters
    public String getId() {
        String resultado=id;
        if(id==null) resultado="";
        return resultado;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdentificacionPersona() {
    String resultado=identificacionPersona;
        if(identificacionPersona==null) resultado="";
        return resultado;
    }

    public void setIdentificacionPersona(String identificacionPersona) {
        this.identificacionPersona = identificacionPersona;
    }

    public String getIdDocumentoIdentificacion() {
       String resultado=idDocumentoIdentificacion;
        if(idDocumentoIdentificacion==null) resultado="";
        return resultado;
    }

    public void setIdDocumentoIdentificacion(String idDocumentoIdentificacion) {
        this.idDocumentoIdentificacion = idDocumentoIdentificacion;
    }

    public String getIdHojaDeVida() {
         String resultado=idHojaDeVida;
        if(idHojaDeVida==null) resultado="";
        return resultado;
    }

    public void setIdHojaDeVida(String idHojaDeVida) {
        this.idHojaDeVida = idHojaDeVida;
    }

    public String getIdDocumentoContratacion() {
       String resultado=idDocumentoContratacion;
        if(idDocumentoContratacion==null) resultado="";
        return resultado;
    }

    public void setIdDocumentoContratacion(String idDocumentoContratacion) {
        this.idDocumentoContratacion = idDocumentoContratacion;
    }

    public String getIdAfiliaciones() {
        String resultado=idAfiliaciones;
        if(idAfiliaciones==null) resultado="";
        return resultado;
    }

    public void setIdAfiliaciones(String idAfiliaciones) {
        this.idAfiliaciones = idAfiliaciones;
    }

    public String getIdDuranteContratacion() {
       String resultado=idDuranteContratacion;
        if(idDuranteContratacion==null) resultado="";
        return resultado;
    }

    public void setIdDuranteContratacion(String idDuranteContratacion) {
        this.idDuranteContratacion = idDuranteContratacion;
    }

    public String getIdAusentismos() {
      String resultado=idAusentismos;
        if(idAusentismos==null) resultado="";
        return resultado;
    }

    public void setIdAusentismos(String idAusentismos) {
        this.idAusentismos = idAusentismos;
    }

    public String getIdFinalizarContratacion() {
       String resultado=idFinalizarContratacion;
        if(idFinalizarContratacion==null) resultado="";
        return resultado;
    }

    public void setIdFinalizarContratacion(String idFinalizarContratacion) {
        this.idFinalizarContratacion = idFinalizarContratacion;
    }

    public String getIdDocumentosSST_SGA() {
      String resultado=idDocumentosSST_SGA;
        if(idDocumentosSST_SGA==null) resultado="";
        return resultado;
    }

    public void setIdDocumentosSST_SGA(String idDocumentosSST_SGA) {
        this.idDocumentosSST_SGA = idDocumentosSST_SGA;
    }

    public String getObservaciones() {
      String resultado=observaciones;
        if(observaciones==null) resultado="";
        return resultado;
    }


    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    // Métodos de Base de Datos
    public boolean grabar() {
        String consultaSQL = "insert into historia_laboral (identificacionPersona, idDocumentoIdentificacion, idHojaDeVida, "
                + "idDocumentoContratacion, idAfiliaciones, idDuranteContratacion, idAusentismos, "
                + "idFinalizarContratacion, idDocumentosSST_SGA, observaciones) VALUES ('"
                + identificacionPersona + "', '" + idDocumentoIdentificacion + "', '" + idHojaDeVida + "', '"
                + idDocumentoContratacion + "', '" + idAfiliaciones + "', '" + idDuranteContratacion + "', '"
                + idAusentismos + "', '" + idFinalizarContratacion + "', '" + idDocumentosSST_SGA + "', '"
                + observaciones + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "update historia_laboral set identificacionPersona = '" + identificacionPersona
                + "', idDocumentoIdentificacion = '" + idDocumentoIdentificacion + "', idHojaDeVida = '" + idHojaDeVida
                + "', idDocumentoContratacion = '" + idDocumentoContratacion + "', idAfiliaciones = '" + idAfiliaciones
                + "', idDuranteContratacion = '" + idDuranteContratacion + "', idAusentismos = '" + idAusentismos
                + "', idFinalizarContratacion = '" + idFinalizarContratacion + "', idDocumentosSST_SGA = '" + idDocumentosSST_SGA
                + "', observaciones = '" + observaciones + "' where id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean eliminar() {
        String consultaSQL = "delete from historia_laboral where id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public static List<HistoriaLaboral> getListaEnObjetos(String filtro, String orden) {
        List<HistoriaLaboral> lista = new ArrayList<>();
        String consultaSQL = "select * from historia_laboral";
        if (filtro != null && !filtro.isEmpty()) consultaSQL += " where " + filtro;
        if (orden != null && !orden.isEmpty()) consultaSQL += " order by " + orden;

        ResultSet datos = ConectorBD.consultar(consultaSQL);
        try {
            while (datos.next()) {
                HistoriaLaboral historia = new HistoriaLaboral(datos.getString("id"));
                lista.add(historia);
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener la lista: " + ex.getMessage());
        }
        return lista;
    }
}
