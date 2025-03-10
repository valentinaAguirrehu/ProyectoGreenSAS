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

public class HojaDeVida {
    
    // Atributos
    private String id;
    private String hojaDeVida;
    private String documentoVehiculo;
    
    // Constructores
    public HojaDeVida() {
    }

    public HojaDeVida(String id) {
        String consultaSQL = "select hojaDeVida, documentoVehiculo from hojaDeVida where id = " + id;
        
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        
        try {
            if (resultado.next()) {
                this.id = id;
                hojaDeVida = resultado.getString("hojaDeVida");
                documentoVehiculo = resultado.getString("documentoVehiculo");
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

    public String getHojaDeVida() {
        String resultado = hojaDeVida;
        if (hojaDeVida == null) resultado = "";
        return resultado;
    }

    public void setHojaDeVida(String hojaDeVida) {
        this.hojaDeVida = hojaDeVida;
    }

    public String getDocumentoVehiculo() {
        String resultado = documentoVehiculo;
        if (documentoVehiculo == null) resultado = "";
        return resultado;
    }

    public void setDocumentoVehiculo(String documentoVehiculo) {
        this.documentoVehiculo = documentoVehiculo;
    }

    // Métodos de Base de Datos
    public boolean grabar() {
        String consultaSQL = "insert into hojaDeVida (hojaDeVida, documentoVehiculo) VALUES ('" 
                + hojaDeVida + "', '" + documentoVehiculo + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "update hojaDeVida set hojaDeVida = '" + hojaDeVida
                + "', documentoVehiculo = '" + documentoVehiculo + "' where id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean eliminar() {
        String consultaSQL = "delete from hojaDeVida where id = " + id;
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
        String cadenaSQL = "select hojaDeVida, documentoVehiculo from hojaDeVida" + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }
 public static List<HojaDeVida> getListaEnObjetos(String filtro, String orden) {
        List<HojaDeVida> lista = new ArrayList<>();
        ResultSet datos = HojaDeVida.getLista(filtro, orden); 
        if (datos != null) {
            try {
                while (datos.next()) {
                    HojaDeVida hojaDeVidaObj = new HojaDeVida();
                    hojaDeVidaObj.setId(datos.getString("id"));
                    hojaDeVidaObj.setHojaDeVida(datos.getString("hojaDeVida"));
                    hojaDeVidaObj.setDocumentoVehiculo(datos.getString("documentoVehiculo"));

                    lista.add(hojaDeVidaObj);
                }
            } catch (SQLException ex) {
                Logger.getLogger(HojaDeVida.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }
}
