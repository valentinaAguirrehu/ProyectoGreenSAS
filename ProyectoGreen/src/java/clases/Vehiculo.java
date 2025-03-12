/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.Connection;
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
public class Vehiculo {

    private String id;
    private String tipoVehiculo;
    private String numeroPlaca;
    private String modeloVehiculo;
    private String linea;
    private String ano;
    private String color;
    private String cilindraje;
    private String numLicenciaTransito;
    private String fechaExpLicenciaTransito;

    public Vehiculo() {
    }

    public Vehiculo(String id) {
        String cadenaSQL = "select id, tipoVehiculo, numeroPLaca, modeloVehiculo, linea, ano, color, cilindraje,"
                + " numLicenciaTransito, fechaExpLicenciaTransito from vehiculo where id=" + id;
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.id = id;
                tipoVehiculo = resultado.getString("tipoVehiculo");
                numeroPlaca = resultado.getString("numeroPlaca");
                modeloVehiculo = resultado.getString("modeloVehiculo");
                linea = resultado.getString("linea");
                ano = resultado.getString("ano");
                color = resultado.getString("color");
                cilindraje = resultado.getString("cilindraje");
                numLicenciaTransito = resultado.getString("numLicenciaTransito");
                fechaExpLicenciaTransito = resultado.getString("fechaExpLicenciaTransito");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar la identificacion" + ex.getMessage());
        }
    }

    public String getId() {
        String resultado = id;
        if (id == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTipoVehiculo() {
        String resultado = tipoVehiculo;
        if (tipoVehiculo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTipoVehiculo(String tipoVehiculo) {
        this.tipoVehiculo = tipoVehiculo;
    }

    public String getNumeroPlaca() {
        String resultado = numeroPlaca;
        if (numeroPlaca == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNumeroPlaca(String numeroPlaca) {
        this.numeroPlaca = numeroPlaca;
    }

    public String getModeloVehiculo() {
        String resultado = modeloVehiculo;
        if (modeloVehiculo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setModeloVehiculo(String modeloVehiculo) {
        this.modeloVehiculo = modeloVehiculo;
    }

    public String getLinea() {
        String resultado = linea;
        if (linea == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setLinea(String linea) {
        this.linea = linea;
    }

    public String getAno() {
        if (ano == null) {
            ano = "";
        }
        return ano;
    }

    public void setAno(String ano) {
        this.ano = ano;
    }

    public String getColor() {
        String resultado = color;
        if (color == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getCilindraje() {
        String resultado = cilindraje;
        if (cilindraje == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setCilindraje(String cilindraje) {
        this.cilindraje = cilindraje;
    }

    public String getNumLicenciaTransito() {
        String resultado = numLicenciaTransito;
        if (numLicenciaTransito == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNumLicenciaTransito(String numLicenciaTransito) {
        this.numLicenciaTransito = numLicenciaTransito;
    }

    public String getFechaExpLicenciaTransito() {
        String resultado = fechaExpLicenciaTransito;
        if (fechaExpLicenciaTransito == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaExpLicenciaTransito(String fechaExpLicenciaTransito) {
        this.fechaExpLicenciaTransito = fechaExpLicenciaTransito;
    }

    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !"".equals(filtro)) {
            filtro = " WHERE " + filtro;
        } else {
            filtro = " ";
        }
        if (orden != null && !"".equals(orden)) {
            orden = " ORDER BY " + orden;
        } else {
            orden = " ";
        }

        String cadenaSQL = "SELECT id, tipoVehiculo, numeroPlaca, modeloVehiculo, linea, ano, color, cilindraje, "
                + "numLicenciaTransito, fechaExpLicenciaTransito FROM vehiculo" + filtro + orden;

        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Vehiculo> getListaEnObjetos(String filtro, String orden) {
        List<Vehiculo> lista = new ArrayList<>();
        ResultSet datos = Vehiculo.getLista(filtro, orden);

        if (datos != null) {
            try {
                while (datos.next()) {
                    Vehiculo vehiculo = new Vehiculo();
                    vehiculo.setId(datos.getString("id"));
                    vehiculo.setTipoVehiculo(datos.getString("tipoVehiculo"));
                    vehiculo.setNumeroPlaca(datos.getString("numeroPlaca"));
                    vehiculo.setModeloVehiculo(datos.getString("modeloVehiculo"));
                    vehiculo.setLinea(datos.getString("linea"));
                    vehiculo.setAno(datos.getString("ano"));
                    vehiculo.setColor(datos.getString("color"));
                    vehiculo.setCilindraje(datos.getString("cilindraje"));
                    vehiculo.setNumLicenciaTransito(datos.getString("numLicenciaTransito"));
                    vehiculo.setFechaExpLicenciaTransito(datos.getString("fechaExpLicenciaTransito"));
                    lista.add(vehiculo);
                }
            } catch (SQLException ex) {
                Logger.getLogger(Vehiculo.class.getName()).log(Level.SEVERE, "Error al obtener lista de vehículos", ex);
            }
        }

        return lista;
    }

    public static String getListaEnOptions(String preseleccionado) {
        StringBuilder lista = new StringBuilder();
        List<Vehiculo> datos = getListaEnObjetos(null, "modeloVehiculo");

        for (Vehiculo vehiculo : datos) {
            String auxiliar = "";
            if (preseleccionado != null && preseleccionado.equals(vehiculo.getId())) {
                auxiliar = " selected";
            }
            lista.append("<option value='").append(vehiculo.getId()).append("'").append(auxiliar).append(">")
                    .append(vehiculo.getModeloVehiculo()).append(" - ").append(vehiculo.getNumeroPlaca())
                    .append("</option>");
        }
        return lista.toString();
    }

    
            
            
            public Vehiculo getVehiculoPorIdentificacion(String identificacion) {
    List<Vehiculo> vehiculos = Vehiculo.getListaEnObjetos("identificacion = '" + identificacion + "'", "");
    return vehiculos.isEmpty() ? null : vehiculos.get(0); // Retorna el primer vehículo encontrado o null si no hay
}

    public static Vehiculo getVehiculoPorIdentificacion(String identificacion) {
    Vehiculo vehiculo = null;
    String query = "SELECT * FROM vehiculo WHERE identificacion = ?";
    
    try (Connection con = Conexion.getConexion();
         PreparedStatement ps = con.prepareStatement(query)) {
        ps.setString(1, identificacion);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            vehiculo = new Vehiculo();
            vehiculo.setTipoVehiculo(rs.getString("tipoVehiculo"));
            vehiculo.setNumeroPlaca(rs.getString("numeroPlaca"));
            vehiculo.setModelo(rs.getString("modelo"));
            vehiculo.setLinea(rs.getString("linea"));
            vehiculo.setAno(rs.getInt("ano"));
            vehiculo.setColor(rs.getString("color"));
            vehiculo.setCilindraje(rs.getString("cilindraje"));
            vehiculo.setNumLicenciaTransito(rs.getString("numLicenciaTransito"));
            vehiculo.setFechaExpLicenciaTransito(rs.getString("fechaExpLicenciaTransito"));
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    
    return vehiculo;
}

}
