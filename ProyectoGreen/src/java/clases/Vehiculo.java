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
        if (id == null) {
            id = "";
        }
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTipoVehiculo() {
        if (tipoVehiculo == null) {
            tipoVehiculo = "";
        }
        return tipoVehiculo;
    }

    public void setTipoVehiculo(String tipoVehiculo) {
        this.tipoVehiculo = tipoVehiculo;
    }

    public String getNumeroPlaca() {
        if (numeroPlaca == null) {
            numeroPlaca = "";
        }
        return tipoVehiculo;
    }

    public void setNumeroPlaca(String numeroPlaca) {
        this.numeroPlaca = numeroPlaca;
    }

    public String getModeloVehiculo() {
        if (modeloVehiculo == null) {
            modeloVehiculo = "";
        }
        return modeloVehiculo;
    }

    public void setModeloVehiculo(String modeloVehiculo) {
        this.modeloVehiculo = modeloVehiculo;
    }

    public String getLinea() {
        if (linea == null) {
            linea = "";
        }
        return linea;
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
        if (color == null) {
            color = "";
        }
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getCilindraje() {
        if (cilindraje == null) {
            cilindraje = "";
        }
        return cilindraje;
    }

    public void setCilindraje(String cilindraje) {
        this.cilindraje = cilindraje;
    }

    public String getNumLicenciaTransito() {
        if (numLicenciaTransito == null) {
            numLicenciaTransito = "";
        }
        return numLicenciaTransito;
    }

    public void setNumLicenciaTransito(String numLicenciaTransito) {
        this.numLicenciaTransito = numLicenciaTransito;
    }

    public String getFechaExpLicenciaTransito() {
        if (fechaExpLicenciaTransito == null) {
            fechaExpLicenciaTransito = "";
        }
        return fechaExpLicenciaTransito;
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

}
