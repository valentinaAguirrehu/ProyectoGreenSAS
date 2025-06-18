/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Angie
 */
public class EntregaDotacionDAO {
    
     public EntregaDotacion obtenerEntregaPorId(int idEntrega) {
        EntregaDotacion entrega = null;

        String sql = "SELECT * FROM entregaDotacion WHERE id_entrega = " + idEntrega;
        ResultSet rs = ConectorBD.consultar(sql);

        try {
            if (rs != null && rs.next()) {
                entrega = new EntregaDotacion();
                entrega.setIdEntrega(rs.getString("id_entrega"));
                entrega.setIdPersona(rs.getString("id_persona"));
                entrega.setFechaEntrega(rs.getString("fechaEntrega"));
                entrega.setTipoEntrega(rs.getString("tipoEntrega"));
                entrega.setResponsable(rs.getString("responsable"));
                entrega.setObservacion(rs.getString("observacion"));
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener entrega por ID: " + ex.getMessage());
        }

        return entrega;
    }

    // Si deseas agregar más métodos como insertar, actualizar o eliminar, también se pueden adaptar a tu clase ConectorBD
}