/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
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
public class Vehiculo {

    private String numeroPlaca;
    private String tipoVehiculo;
    private String modeloVehiculo;
    private String linea;
    private String ano;
    private String color;
    private String cilindraje;
    private String numLicenciaTransito;
    private String fechaExpLicenciaTransito;

    public Vehiculo() {
    }

    public Vehiculo(String numeroPlaca) {
        String cadenaSQL = "SELECT numeroPlaca, tipoVehiculo, modeloVehiculo, linea, ano, color, cilindraje, "
                + "numLicenciaTransito, fechaExpLicenciaTransito FROM vehiculo WHERE numeroPlaca='" + numeroPlaca + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.numeroPlaca = resultado.getString("numeroPlaca");
                tipoVehiculo = resultado.getString("tipoVehiculo");
                modeloVehiculo = resultado.getString("modeloVehiculo");
                linea = resultado.getString("linea");
                ano = resultado.getString("ano");
                color = resultado.getString("color");
                cilindraje = resultado.getString("cilindraje");
                numLicenciaTransito = resultado.getString("numLicenciaTransito");
                fechaExpLicenciaTransito = resultado.getString("fechaExpLicenciaTransito");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el vehículo: " + ex.getMessage());
        }
    }

    public String getNumeroPlaca() {
        return (numeroPlaca == null) ? "" : numeroPlaca;
    }

    public void setNumeroPlaca(String numeroPlaca) {
        this.numeroPlaca = numeroPlaca;
    }

    public String getTipoVehiculo() {
        return (tipoVehiculo == null) ? "" : tipoVehiculo;
    }

    public void setTipoVehiculo(String tipoVehiculo) {
        this.tipoVehiculo = tipoVehiculo;
    }

    public String getModeloVehiculo() {
        return (modeloVehiculo == null) ? "" : modeloVehiculo;
    }

    public void setModeloVehiculo(String modeloVehiculo) {
        this.modeloVehiculo = modeloVehiculo;
    }

    public String getLinea() {
        return (linea == null) ? "" : linea;
    }

    public void setLinea(String linea) {
        this.linea = linea;
    }

    public String getAno() {
        return (ano == null) ? "" : ano;
    }

    public void setAno(String ano) {
        this.ano = ano;
    }

    public String getColor() {
        return (color == null) ? "" : color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getCilindraje() {
        return (cilindraje == null) ? "" : cilindraje;
    }

    public void setCilindraje(String cilindraje) {
        this.cilindraje = cilindraje;
    }

    public String getNumLicenciaTransito() {
        return (numLicenciaTransito == null) ? "" : numLicenciaTransito;
    }

    public void setNumLicenciaTransito(String numLicenciaTransito) {
        this.numLicenciaTransito = numLicenciaTransito;
    }

    public String getFechaExpLicenciaTransito() {
        return (fechaExpLicenciaTransito == null) ? "" : fechaExpLicenciaTransito;
    }

    public void setFechaExpLicenciaTransito(String fechaExpLicenciaTransito) {
        this.fechaExpLicenciaTransito = fechaExpLicenciaTransito;
    }

    public boolean grabar() {
        String cadenaSQL = "INSERT INTO vehiculo (numeroPlaca, tipoVehiculo, modeloVehiculo, linea, ano, color, cilindraje, numLicenciaTransito, fechaExpLicenciaTransito) "
                + "VALUES ('" + numeroPlaca + "', '" + tipoVehiculo + "', '" + modeloVehiculo + "', '" + linea + "', '" + ano + "', '" + color + "', '" + cilindraje + "', '" + numLicenciaTransito + "', '" + fechaExpLicenciaTransito + "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar(String numeroPlacaAnterior) {
        String cadenaSQL = "UPDATE vehiculo SET "
                + "numeroPlaca = '" + numeroPlaca + "', "
                + "tipoVehiculo = '" + tipoVehiculo + "', "
                + "modeloVehiculo = '" + modeloVehiculo + "', "
                + "linea = '" + linea + "', "
                + "ano = '" + ano + "', "
                + "color = '" + color + "', "
                + "cilindraje = '" + cilindraje + "', "
                + "numLicenciaTransito = '" + numLicenciaTransito + "', "
                + "fechaExpLicenciaTransito = '" + fechaExpLicenciaTransito + "' "
                + "WHERE numeroPlaca = '" + numeroPlacaAnterior + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static boolean eliminarPorPlaca(String placa) {
        // Primero eliminamos la relación en persona_vehiculo
        String sqlRelacion = "DELETE FROM persona_vehiculo WHERE numeroPlacaVehiculo = '" + placa + "'";
        boolean relacionEliminada = ConectorBD.ejecutarQuery(sqlRelacion);

        if (relacionEliminada) {
            // Ahora eliminamos el vehículo
            String sqlVehiculo = "DELETE FROM vehiculo WHERE numeroPlaca = '" + placa + "'";
            return ConectorBD.ejecutarQuery(sqlVehiculo);
        }

        return false; // No se pudo eliminar la relación, entonces no eliminamos el vehículo
    }

    public static List<Vehiculo> getListaEnObjetos(String filtro, String orden) {
        List<Vehiculo> lista = new ArrayList<>();
        String cadenaSQL = "SELECT * FROM vehiculo";
        if (filtro != null && !filtro.isEmpty()) {
            cadenaSQL += " WHERE " + filtro;
        }
        if (orden != null && !orden.isEmpty()) {
            cadenaSQL += " ORDER BY " + orden;
        }

        ResultSet datos = ConectorBD.consultar(cadenaSQL);
        try {
            while (datos.next()) {
                Vehiculo vehiculo = new Vehiculo();
                vehiculo.setNumeroPlaca(datos.getString("numeroPlaca"));
                vehiculo.setTipoVehiculo(datos.getString("tipoVehiculo"));
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
            Logger.getLogger(Vehiculo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    public static Vehiculo obtenerPorPlaca(String numeroPlaca) {
        Vehiculo vehiculo = null;
        String sql = "SELECT * FROM vehiculo WHERE numeroPlaca = '" + numeroPlaca + "'";
        ResultSet rs = ConectorBD.consultar(sql);
        try {
            if (rs.next()) {
                vehiculo = new Vehiculo();
                vehiculo.setNumeroPlaca(rs.getString("numeroPlaca"));
                vehiculo.setTipoVehiculo(rs.getString("tipoVehiculo"));
                vehiculo.setModeloVehiculo(rs.getString("modeloVehiculo"));
                vehiculo.setLinea(rs.getString("linea"));
                vehiculo.setAno(rs.getString("ano"));
                vehiculo.setColor(rs.getString("color"));
                vehiculo.setCilindraje(rs.getString("cilindraje"));
                vehiculo.setNumLicenciaTransito(rs.getString("numLicenciaTransito"));
                vehiculo.setFechaExpLicenciaTransito(rs.getString("fechaExpLicenciaTransito"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Vehiculo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vehiculo;
    }

    public Vehiculo getVehiculoPorIdentificacion(String identificacion) {
        List<Vehiculo> vehiculos = Vehiculo.getListaEnObjetos("identificacion = '" + identificacion + "'", "");
        return vehiculos.isEmpty() ? null : vehiculos.get(0); // Retorna el primer vehículo encontrado o null si no hay
    }
}
