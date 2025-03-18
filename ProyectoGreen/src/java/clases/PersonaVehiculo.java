package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PersonaVehiculo {
    private int identificacionPersona;
    private String numeroPlacaVehiculo;

    public PersonaVehiculo() {}

    public PersonaVehiculo(int identificacionPersona, String numeroPlacaVehiculo) {
        this.identificacionPersona = identificacionPersona;
        this.numeroPlacaVehiculo = numeroPlacaVehiculo;
    }

    // Getters y Setters
    public int getIdentificacionPersona() {
        return identificacionPersona;
    }

    public void setIdentificacionPersona(int identificacionPersona) {
        this.identificacionPersona = identificacionPersona;
    }

    public String getNumeroPlacaVehiculo() {
        return numeroPlacaVehiculo;
    }

    public void setNumeroPlacaVehiculo(String numeroPlacaVehiculo) {
        this.numeroPlacaVehiculo = numeroPlacaVehiculo;
    }

    // Método para guardar la relación en la BD
    public boolean guardar() {
        String sql = "INSERT INTO persona_vehiculo (identificacionPersona, numeroPlacaVehiculo) VALUES ('"
                + identificacionPersona + "', '" + numeroPlacaVehiculo + "')";
        return ConectorBD.ejecutarQuery(sql);
    }

    // Método para eliminar la relación en la BD
    public boolean eliminar() {
        String sql = "DELETE FROM persona_vehiculo WHERE identificacionPersona = '" + identificacionPersona + "'";
        return ConectorBD.ejecutarQuery(sql);
    }

    // Método para actualizar la relación (cambiar vehículo de una persona)
    public boolean actualizar(String nuevaPlaca) {
        String sql = "UPDATE persona_vehiculo SET numeroPlacaVehiculo = '" + nuevaPlaca 
                     + "' WHERE identificacionPersona = '" + identificacionPersona + "'";
        return ConectorBD.ejecutarQuery(sql);
    }

    public static String obtenerVehiculoDePersona(int identificacionPersona) {
    String sql = "SELECT numeroPlacaVehiculo FROM persona_vehiculo WHERE identificacionPersona = " + identificacionPersona;
    String placa = null;
    
    try {
        ResultSet rs = ConectorBD.consultar(sql);
        if (rs.next()) {
            placa = rs.getString("numeroPlacaVehiculo");
        }
    } catch (SQLException e) {
        System.out.println("Error al obtener vehículo: " + e.getMessage());
    }
    
    return (placa != null) ? placa : "Ninguno";  // Si no hay resultado, devuelve "Ninguno"
}


    // Método para verificar si la persona ya tiene vehículo asignado
    public static boolean existeRelacion(int identificacionPersona) {
        String sql = "SELECT COUNT(*) AS total FROM persona_vehiculo WHERE identificacionPersona = " + identificacionPersona;
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
