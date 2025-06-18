/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Angie
 */
public class DetalleEntregaDAO {

    
    
    public List<DetalleEntrega> obtenerDetallesPorIdEntrega(String idEntrega) {
        List<DetalleEntrega> detalles = new ArrayList<>();
        ConectorBD conector = new ConectorBD();

        if (!conector.conectar()) {
            System.out.println("No se pudo conectar a la base de datos.");
            return detalles;
        }

        String sql = "SELECT * FROM detalleEntrega WHERE id_entrega = ?";
        try {
            PreparedStatement ps = conector.conexion.prepareStatement(sql);
            ps.setString(1, idEntrega);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DetalleEntrega detalle = new DetalleEntrega();
                detalle.setIdDetalleEntrega(rs.getString("id_detalle_entrega"));
                detalle.setIdEntrega(rs.getString("id_entrega"));
                detalle.setIdPrenda(rs.getString("id_prenda"));
                detalle.setTalla(rs.getString("talla"));
                detalle.setEstado(rs.getString("estado"));
                detalle.setUnidadNegocio(rs.getString("unidad_negocio"));

                detalles.add(detalle);
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            System.out.println("Error al obtener detalles de entrega: " + e.getMessage());
        } finally {
            conector.desconectar();
        }

        return detalles;
    }
}