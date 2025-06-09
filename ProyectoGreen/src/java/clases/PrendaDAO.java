/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Angie
 */
public class PrendaDAO {
    
    public static Prenda getPorId(String idPrenda) {
        Prenda prenda = null;
        ConectorBD conector = new ConectorBD();

        if (!conector.conectar()) {
            System.out.println("No se pudo conectar para obtener la prenda.");
            return null;
        }

        String sql = "SELECT p.id_prenda, p.nombre, p.id_tipo_prenda, tp.nombre AS nombre_tipo " +
                     "FROM prenda p JOIN tipoPrenda tp ON p.id_tipo_prenda = tp.id_tipo_prenda " +
                     "WHERE p.id_prenda = ?";

        try {
            PreparedStatement ps = conector.conexion.prepareStatement(sql); 
            ps.setString(1, idPrenda);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                prenda = new Prenda();
                prenda.setIdPrenda(rs.getString("id_prenda"));
                prenda.setNombre(rs.getString("nombre"));
                prenda.setIdTipoPrenda(rs.getString("id_tipo_prenda"));
                prenda.setNombreTipoPrenda(rs.getString("nombre_tipo"));
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            System.out.println("Error al buscar prenda por ID: " + e.getMessage());
        } finally {
            conector.desconectar();
        }

        return prenda;
    }
}