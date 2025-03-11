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
public class FinalizarContratacion {
    private String id;
    private String liquidacion;

    public FinalizarContratacion() {
    }

    public FinalizarContratacion(String id) {
             String consultaSQL = "select id, liquidacion from finalizarContratacion where id = " + id;
        
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        
        try {
            if (resultado.next()) {
                this.id = id;
                liquidacion = resultado.getString("liquidacion");
             
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

    public String getLiquidacion() {
        return liquidacion;
    }

    public void setLiquidacion(String liquidacion) {
        this.liquidacion = liquidacion;
    }
    
    public boolean grabar() {
        String consultaSQL = "INSERT INTO finalizar_contratacion (id, liquidacion) VALUES ('" +
                id + "', '" + liquidacion + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "UPDATE finalizar_contratacion SET " +
                "liquidacion = '" + liquidacion + "' " +
                "WHERE id = '" + id + "'";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }
    
       public boolean eliminar() {
        String consultaSQL = "delete from finalizarDocumentos where id = " + id;
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
        String cadenaSQL = "select id, liquidacion from finalizarContratacion " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }

    
    public static List<FinalizarContratacion> getListaEnObjetos(String filtro, String orden) {
        List<FinalizarContratacion> lista = new ArrayList<>();
        ResultSet datos = FinalizarContratacion.getLista(filtro, orden); // Asumiendo que tienes un método getLista en FinalizarContratacion
        if (datos != null) {
            try {
                while (datos.next()) {
                    FinalizarContratacion finalizarContratacion = new FinalizarContratacion();
                    finalizarContratacion.setId(datos.getString("id"));
                    finalizarContratacion.setLiquidacion(datos.getString("liquidacion"));

                    lista.add(finalizarContratacion);
                }
            } catch (SQLException ex) {
                Logger.getLogger(FinalizarContratacion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }

}
