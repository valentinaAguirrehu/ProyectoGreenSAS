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

public class HojaDeVida {
    
    // Atributos
    private String id;
    private String hojaDeVida;
    private String documentoVehiculo;
    
    // Constructores
    public HojaDeVida() {
    }

    public HojaDeVida(String id) {
        String consultaSQL = "select hojaDeVida, documentoVehiculo from hoja_de_vida where id = " + id;
        
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
        String consultaSQL = "insert into hoja_de_vida (hojaDeVida, documentoVehiculo) VALUES ('" 
                + hojaDeVida + "', '" + documentoVehiculo + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "update hoja_de_vida set hojaDeVida = '" + hojaDeVida
                + "', documentoVehiculo = '" + documentoVehiculo + "' where id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean eliminar() {
        String consultaSQL = "delete from hoja_de_vida where id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public static List<HojaDeVida> getListaEnObjetos(String filtro, String orden) {
        List<HojaDeVida> lista = new ArrayList<>();
        String consultaSQL = "select * from hoja_de_vida";
        if (filtro != null && !filtro.isEmpty()) consultaSQL += " where " + filtro;
        if (orden != null && !orden.isEmpty()) consultaSQL += " order by " + orden;

        ResultSet datos = ConectorBD.consultar(consultaSQL);
        try {
            while (datos.next()) {
                HojaDeVida hoja = new HojaDeVida(datos.getString("id"));
                lista.add(hoja);
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener la lista: " + ex.getMessage());
        }
        return lista;
    }
}
