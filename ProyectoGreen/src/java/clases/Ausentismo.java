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


public class Ausentismo {
    
    // Atributos
    private String id;
    private String vacaciones;
    private String licenciaRemunerada;
    private String otrosDocumentos;
    
    // Constructores
    public Ausentismo() {
    }

    public Ausentismo(String id) {
        String consultaSQL = "select id, vacaciones, licenciaRemunerada, otrosDocumentos from asentismo where id = " + id;
        
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        
        try {
            if (resultado.next()) {
                this.id = id;
                vacaciones = resultado.getString("vacaciones");
                licenciaRemunerada = resultado.getString("licenciaRemunerada");
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

    public String getVacaciones() {
        String resultado = vacaciones;
        if (vacaciones == null) resultado = "";
        return resultado;
    }

    public void setVacaciones(String vacaciones) {
        this.vacaciones = vacaciones;
    }

    public String getLicenciaRemunerada() {
        String resultado = licenciaRemunerada;
        if (licenciaRemunerada == null) resultado = "";
        return resultado;
    }

    public void setLicenciaRemunerada(String licenciaRemunerada) {
        this.licenciaRemunerada = licenciaRemunerada;
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
        String consultaSQL = "insert into ausentismo (vacaciones, licenciaRemunerada, otrosDocumentos) VALUES ('" 
                + vacaciones + "', '" + licenciaRemunerada + "', '" + otrosDocumentos + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "update ausentismo set vacaciones = '" + vacaciones
                + "', licenciaRemunerada = '" + licenciaRemunerada
                + "', otrosDocumentos = '" + otrosDocumentos + "' where id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean eliminar() {
        String consultaSQL = "delete from ausentismo where id = " + id;
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
        String cadenaSQL = "select id , vacaciones, licenciaRemunerada, otrosDocumentos from asentismo " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }
     public static List<Ausentismo> getListaEnObjetos(String filtro, String orden) {
        List<Ausentismo> lista = new ArrayList<>();
        ResultSet datos = Ausentismo.getLista(filtro, orden); 
        if (datos != null) {
            try {
                while (datos.next()) {
                    Ausentismo ausentismo = new Ausentismo();
                    ausentismo.setId(datos.getString("id"));
                    ausentismo.setVacaciones(datos.getString("vacaciones"));
                    ausentismo.setLicenciaRemunerada(datos.getString("licenciaRemunerada"));
                    ausentismo.setOtrosDocumentos(datos.getString("otrosDocumentos"));

                    lista.add(ausentismo);
                }
            } catch (SQLException ex) {
                Logger.getLogger(Ausentismo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }
  
}
