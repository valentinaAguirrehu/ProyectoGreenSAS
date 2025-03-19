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


public class PersonaHijo {
    private int identificacionPersona;
    private int identificacionHijo;

    public PersonaHijo() {}

    public PersonaHijo(int identificacionPersona, int identificacionHijo) {
        this.identificacionPersona = identificacionPersona;
        this.identificacionHijo = identificacionHijo;
    }

    // Getters y Setters
    public int getIdentificacionPersona() {
        return identificacionPersona;
    }

    public void setIdentificacionPersona(int identificacionPersona) {
        this.identificacionPersona = identificacionPersona;
    }

    public int getIdentificacionHijo() {
        return identificacionHijo;
    }

    public void setIdentificacionHijo(int identificacionHijo) {
        this.identificacionHijo = identificacionHijo;
    }

    // Método para guardar la relación en la BD
    public boolean guardar() {
        String sql = "INSERT INTO persona_hijos (identificacion, identificacionH) VALUES (" 
                     + identificacionPersona + ", " + identificacionHijo + ")";
        return ConectorBD.ejecutarQuery(sql);
    }

    // Método para eliminar la relación en la BD
    public boolean eliminar() {
        String sql = "DELETE FROM persona_hijos WHERE identificacion = " + identificacionPersona 
                     + " AND identificacionH = " + identificacionHijo;
        return ConectorBD.ejecutarQuery(sql);
    }

    // Método para obtener todos los hijos de una persona
    public static List<Integer> obtenerHijosDePersona(int identificacionPersona) {
        String sql = "SELECT identificacionH FROM persona_hijos WHERE identificacion = " + identificacionPersona;
        List<Integer> hijos = new ArrayList<>();

        try {
            ResultSet rs = ConectorBD.consultar(sql);
            while (rs.next()) {
                hijos.add(rs.getInt("identificacionH"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener hijos: " + e.getMessage());
        }
        
        return hijos;
    }

    // Método para verificar si una persona ya tiene un hijo registrado
    public static boolean existeRelacion(int identificacionPersona, int identificacionHijo) {
        String sql = "SELECT COUNT(*) AS total FROM persona_hijos WHERE identificacion = " 
                     + identificacionPersona + " AND identificacionH = " + identificacionHijo;

        try {
            ResultSet rs = ConectorBD.consultar(sql);
            if (rs.next()) {
                return rs.getInt("total") > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
}
