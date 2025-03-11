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

/**
 *
 * @author Mary
 */

public class DocumentosDuranteContratacion {
    
    // Atributos
    private String id;
    private String preavisosProrrogas;
    private String otrosSi;
    private String sustitucionPatronal;
    private String otrosDocumentos;
    
    // Constructores
    public DocumentosDuranteContratacion() {
    }

    public DocumentosDuranteContratacion(String id) {
        String consultaSQL = "select preavisosProrrogas, otrosSi, sustitucionPatronal, otrosDocumentos from documentosDuranteContratacion where id = " + id;
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        
        try {
            if (resultado.next()) {
                this.id = id;
                preavisosProrrogas = resultado.getString("preavisosProrrogas");
                otrosSi = resultado.getString("otrosSi");
                sustitucionPatronal = resultado.getString("sustitucionPatronal");
                otrosDocumentos = resultado.getString("otrosDocumentos");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el ID: " + ex.getMessage());
        }
    }

    // Getters y Setters
    public String getId() {
        String resultado = id;
        if (id == null) resultado = "";
        return resultado;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPreavisosProrrogas() {
        String resultado = preavisosProrrogas;
        if (preavisosProrrogas == null) resultado = "";
        return resultado;
    }

    public void setPreavisosProrrogas(String preavisosProrrogas) {
        this.preavisosProrrogas = preavisosProrrogas;
    }

    public String getOtrosSi() {
        String resultado = otrosSi;
        if (otrosSi == null) resultado = "";
        return resultado;
    }

    public void setOtrosSi(String otrosSi) {
        this.otrosSi = otrosSi;
    }

    public String getSustitucionPatronal() {
        String resultado = sustitucionPatronal;
        if (sustitucionPatronal == null) resultado = "";
        return resultado;
    }

    public void setSustitucionPatronal(String sustitucionPatronal) {
        this.sustitucionPatronal = sustitucionPatronal;
    }

    public String getOtrosDocumentos() {
        String resultado = otrosDocumentos;
        if (otrosDocumentos == null) resultado = "";
        return resultado;
    }

    public void setOtrosDocumentos(String otrosDocumentos) {
        this.otrosDocumentos = otrosDocumentos;
    }

    // Métodos de Base de Datos
    public boolean grabar() {
        String consultaSQL = "insert into documentos_durante_contratacion (preavisosProrrogas, otrosSi, sustitucionPatronal, otrosDocumentos) VALUES ('" 
                + preavisosProrrogas + "', '" + otrosSi + "', '" + sustitucionPatronal + "', '" + otrosDocumentos + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "update documentos_durante_contratacion set preavisosProrrogas = '" + preavisosProrrogas
                + "', otrosSi = '" + otrosSi
                + "', sustitucionPatronal = '" + sustitucionPatronal
                + "', otrosDocumentos = '" + otrosDocumentos + "' where id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean eliminar() {
        String consultaSQL = "delete from documentos_durante_contratacion where id = " + id;
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
        String cadenaSQL = "select preavisosProrrogas, otrosSi, sustitucionPatronal, otrosDocumentos from documentosDuranteContratacion " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<DocumentosDuranteContratacion> getListaEnObjetos(String filtro, String orden) {
        List<DocumentosDuranteContratacion> lista = new ArrayList<>();
        String consultaSQL = "select * from documentos_durante_contratacion";
        if (filtro != null && !filtro.isEmpty()) consultaSQL += " where " + filtro;
        if (orden != null && !orden.isEmpty()) consultaSQL += " order by " + orden;

        ResultSet datos = ConectorBD.consultar(consultaSQL);
        try {
            while (datos.next()) {
                DocumentosDuranteContratacion doc = new DocumentosDuranteContratacion(datos.getString("id"));
                lista.add(doc);
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener la lista: " + ex.getMessage());
        }
        return lista;
    }
}
