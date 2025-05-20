/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Mary
 */
public class Vehiculo {

    private String identificacion; //si
    private String tieneVehiculo;
    private String numeroPlacaVehiculo; //si
    private String tipoVehiculo; //si
    private String modeloVehiculo; //si
    private String linea; //si
    private String marca; //si
    private String color; //si
    private String cilindraje; //si
    private String numLicenciaTransito; //si
    private String fechaExpLicenciaTransito; //si
    private String numLicenciaConduccion; //si
    private String fechaExpConduccion; //si
    private String fechaVencimiento; //si
    private String restricciones; //si
    private String titularTrjPro; //si
    private String estado; //si

    public Vehiculo() {
    }

    public Vehiculo(String identificacion) {

        String cadenaSQL = "SELECT identificacion, tieneVehiculo, "
                + "numeroPlacaVehiculo, tipoVehiculo, modeloVehiculo, linea, marca, color, cilindraje, "
                + "numLicenciaTransito, fechaExpLicenciaTransito, numLicenciaConduccion, "
                + "fechaExpConduccion, fechaVencimiento, restricciones, titularTrjPro, estado "
                + "FROM vehiculo WHERE identificacion = '" + identificacion + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);

        try {
            if (resultado.next()) {
                this.identificacion = identificacion;
                this.tieneVehiculo = resultado.getString("tieneVehiculo");
                this.numeroPlacaVehiculo = resultado.getString("numeroPlacaVehiculo");
                this.tipoVehiculo = resultado.getString("tipoVehiculo");
                this.modeloVehiculo = resultado.getString("modeloVehiculo");
                this.linea = resultado.getString("linea");
                this.marca = resultado.getString("marca");
                this.color = resultado.getString("color");
                this.cilindraje = resultado.getString("cilindraje");
                this.numLicenciaTransito = resultado.getString("numLicenciaTransito");
                this.fechaExpLicenciaTransito = resultado.getString("fechaExpLicenciaTransito");
                this.numLicenciaConduccion = resultado.getString("numLicenciaConduccion");
                this.fechaExpConduccion = resultado.getString("fechaExpConduccion");
                this.fechaVencimiento = resultado.getString("fechaVencimiento");
                this.restricciones = resultado.getString("restricciones");
                this.titularTrjPro = resultado.getString("titularTrjPro");
                this.estado = resultado.getString("estado");

                // No estamos manejando hijos aquí, ya que son parte de la clase Persona, no Vehiculo
            }
        } catch (SQLException ex) {
            out.println("Ejecutando la consulta vehículo: " + cadenaSQL);
        } finally {
            try {
                if (resultado != null) {
                    resultado.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar ResultSet de vehículo: " + ex.getMessage());
            }
        }
    }

//    public String getTipoVehiculo() {
//        String resultado = tipoVehiculo;
//        if (tipoVehiculo == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public TipoVehiculo getTipoVehiculo() {
        return new TipoVehiculo(tipoVehiculo);
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

    public String getMarca() {
        String resultado = marca;
        if (marca == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setMarca(String marca) {
        this.marca = marca;
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
            resultado = null;
        }
        return resultado;
    }

    public void setFechaExpLicenciaTransito(String fechaExpLicenciaTransito) {
        this.fechaExpLicenciaTransito = fechaExpLicenciaTransito;
    }

    public String getIdentificacion() {
        String resultado = identificacion;
        if (identificacion == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getTieneVehiculo() {
        return tieneVehiculo;
    }

    public void setTipoVehiculo(String tipoVehiculo) {
        this.tipoVehiculo = tipoVehiculo;
    }

    public void setTieneVehiculo(String tieneVehiculo) {
        this.tieneVehiculo = tieneVehiculo;
    }

    public String getNumLicenciaConduccion() {
        String resultado = numLicenciaConduccion;
        if (numLicenciaConduccion == null) {
            resultado = null;
        }
        return resultado;
    }

    public void setNumLicenciaConduccion(String numLicenciaConduccion) {
        this.numLicenciaConduccion = numLicenciaConduccion;
    }

    public String getFechaExpConduccion() {
        String resultado = fechaExpConduccion;
        if (fechaExpConduccion == null) {
            resultado = null;
        }
        return resultado;
    }

    public void setFechaExpConduccion(String fechaExpConduccion) {
        this.fechaExpConduccion = fechaExpConduccion;
    }

    public String getFechaVencimiento() {
        String resultado = fechaVencimiento;
        if (fechaVencimiento == null) {
            resultado = null;
        }
        return resultado;
    }

    public void setFechaVencimiento(String fechaVencimiento) {
        this.fechaVencimiento = fechaVencimiento;
    }

    public String getRestricciones() {
        String resultado = restricciones;
        if (restricciones == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setRestricciones(String restricciones) {
        this.restricciones = restricciones;
    }

    public String getTitularTrjPro() {
        String resultado = titularTrjPro;
        if (titularTrjPro == null) {
            resultado = "";
        }
        return resultado;
    }

//    public String getEstado() {
//        return estado;
//    }
    public EstadoV getEstadoV() {
        return new EstadoV(estado);
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public void setTitularTrjPro(String titularTrjPro) {
        this.titularTrjPro = titularTrjPro;
    }

    public String getNumeroPlacaVehiculo() {
        String resultado = numeroPlacaVehiculo;
        if (numeroPlacaVehiculo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNumeroPlacaVehiculo(String numeroPlacaVehiculo) {
        this.numeroPlacaVehiculo = numeroPlacaVehiculo;
    }

    @Override
    public String toString() {

        String datos = "";
        if (identificacion != null) {
            datos = identificacion;
        }
        return datos;
    }

    public boolean grabar() {
        String cadenaSQL = "INSERT INTO vehiculo ("
                + "identificacion, numeroPlacaVehiculo, tipoVehiculo, modeloVehiculo, linea, marca, color, cilindraje, "
                + "numLicenciaTransito, fechaExpLicenciaTransito, numLicenciaConduccion, fechaExpConduccion, "
                + "fechaVencimiento, restricciones, titularTrjPro, estado) VALUES ('"
                + identificacion + "', '"
                + (numeroPlacaVehiculo != null && !numeroPlacaVehiculo.isEmpty() ? numeroPlacaVehiculo : "NULL") + "', '"
                + (tipoVehiculo != null && !tipoVehiculo.isEmpty() ? tipoVehiculo : "NULL") + "', '"
                + (modeloVehiculo != null && !modeloVehiculo.isEmpty() ? modeloVehiculo : "NULL") + "', '"
                + (linea != null && !linea.isEmpty() ? linea : "NULL") + "', '"
                + (marca != null && !marca.isEmpty() ? marca : "NULL") + "', '"
                + (color != null && !color.isEmpty() ? color : "NULL") + "', "
                + (cilindraje != null && !cilindraje.isEmpty() ? cilindraje : "NULL") + ", '"
                + (numLicenciaTransito != null && !numLicenciaTransito.isEmpty() ? numLicenciaTransito : "NULL") + "', '"
                + (fechaExpLicenciaTransito != null && !fechaExpLicenciaTransito.isEmpty() ? fechaExpLicenciaTransito : "NULL") + "', '"
                + (numLicenciaConduccion != null && !numLicenciaConduccion.isEmpty() ? numLicenciaConduccion : "NULL") + "', '"
                + (fechaExpConduccion != null && !fechaExpConduccion.isEmpty() ? fechaExpConduccion : "NULL") + "', '"
                + (fechaVencimiento != null && !fechaVencimiento.isEmpty() ? fechaVencimiento : "NULL") + "', '"
                + (restricciones != null && !restricciones.isEmpty() ? restricciones : "NULL") + "', '"
                + (titularTrjPro != null && !titularTrjPro.isEmpty() ? titularTrjPro : "NULL") + "', '"
                + (estado != null && !estado.isEmpty() ? estado : "NULL") + "');";

        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);
        System.out.println(cadenaSQL);

        if (!resultado) {
            System.out.println("Error: No se pudo insertar el vehículo en la BD");
            return false;
        }

        return true;
    }

    public boolean modificar(String numeroPlacaVehiculoAnterior) {
        if (numeroPlacaVehiculo == null || numeroPlacaVehiculoAnterior == null) {
            System.out.println("Error: numeroPlacaVehiculo o numeroPlacaVehiculoAnterior es null.");
            return false;
        }

        String cadenaSQL = "UPDATE vehiculo SET "
                + "numeroPlacaVehiculo='" + numeroPlacaVehiculo + "', "
                + "tipoVehiculo=" + (tipoVehiculo != null ? "'" + tipoVehiculo + "'" : "NULL") + ", "
                + "modeloVehiculo=" + (modeloVehiculo != null ? "'" + modeloVehiculo + "'" : "NULL") + ", "
                + "linea=" + (linea != null ? "'" + linea + "'" : "NULL") + ", "
                + "marca=" + (marca != null ? "'" + marca + "'" : "NULL") + ", "
                + "color=" + (color != null ? "'" + color + "'" : "NULL") + ", "
                + "cilindraje=" + (cilindraje != null ? "'" + cilindraje + "'" : "NULL") + ", "
                + "numLicenciaTransito=" + (numLicenciaTransito != null ? "'" + numLicenciaTransito + "'" : "NULL") + ", "
                + "fechaExpLicenciaTransito=" + (fechaExpLicenciaTransito != null && !fechaExpLicenciaTransito.trim().isEmpty() ? "'" + fechaExpLicenciaTransito + "'" : "NULL") + ", "
                + "numLicenciaConduccion=" + (numLicenciaConduccion != null ? "'" + numLicenciaConduccion + "'" : "NULL") + ", "
                + "fechaExpConduccion=" + (fechaExpConduccion != null && !fechaExpConduccion.trim().isEmpty() ? "'" + fechaExpConduccion + "'" : "NULL") + ", "
                + "fechaVencimiento=" + (fechaVencimiento != null && !fechaVencimiento.trim().isEmpty() ? "'" + fechaVencimiento + "'" : "NULL") + ", "
                + "restricciones=" + (restricciones != null ? "'" + restricciones + "'" : "NULL") + ", "
                + "titularTrjPro=" + (titularTrjPro != null ? "'" + titularTrjPro + "'" : "NULL") + ", "
                + "estado=" + (estado != null ? "'" + estado + "'" : "NULL") + " "
                + "WHERE numeroPlacaVehiculo='" + numeroPlacaVehiculoAnterior + "'";

        System.out.println("Consulta SQL de modificación: " + cadenaSQL);
        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);

        return resultado;
    }

    public boolean eliminar() {
        // Eliminar relaciones adicionales (si las hubiera, como en persona_hijos, aunque no aplica para vehiculo)
        // ConectorBD.ejecutarQuery("DELETE FROM vehiculo_relacion WHERE numeroPlacaVehiculo = '" + numeroPlacaVehiculo + "'");

        String cadenaSQL = "DELETE FROM vehiculo WHERE numeroPlacaVehiculo = '" + numeroPlacaVehiculo + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
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

        String cadenaSQL = "SELECT numeroPlacaVehiculo, tipoVehiculo, modeloVehiculo, "
                + "linea, marca, color, cilindraje, numLicenciaTransito, fechaExpLicenciaTransito, "
                + "numLicenciaConduccion, fechaExpConduccion, fechaVencimiento, restricciones, titularTrjPro, estado "
                + "FROM vehiculo " + filtro + orden;

        System.out.println("Ejecutando consulta: " + cadenaSQL);
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Vehiculo> getListaEnObjetos(String filtro, String orden) throws SQLException {
        List<Vehiculo> lista = new ArrayList<>();
        try (ResultSet datos = Vehiculo.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    Vehiculo vehiculo = new Vehiculo();
                    vehiculo.setIdentificacion(datos.getString("identificacion"));
                    vehiculo.setTieneVehiculo(datos.getString("tieneVehiculo"));
                    vehiculo.setNumeroPlacaVehiculo(datos.getString("numeroPlacaVehiculo"));
                    vehiculo.setTipoVehiculo(datos.getString("tipoVehiculo"));
                    vehiculo.setModeloVehiculo(datos.getString("modeloVehiculo"));
                    vehiculo.setLinea(datos.getString("linea"));
                    vehiculo.setMarca(datos.getString("marca"));
                    vehiculo.setColor(datos.getString("color"));
                    vehiculo.setCilindraje(datos.getString("cilindraje"));
                    vehiculo.setNumLicenciaTransito(datos.getString("numLicenciaTransito"));
                    vehiculo.setFechaExpLicenciaTransito(datos.getString("fechaExpLicenciaTransito"));
                    vehiculo.setNumLicenciaConduccion(datos.getString("numLicenciaConduccion"));
                    vehiculo.setFechaExpConduccion(datos.getString("fechaExpConduccion"));
                    vehiculo.setFechaVencimiento(datos.getString("fechaVencimiento"));
                    vehiculo.setRestricciones(datos.getString("restricciones"));
                    vehiculo.setTitularTrjPro(datos.getString("titularTrjPro"));
                    vehiculo.setEstado(datos.getString("estado"));

                    lista.add(vehiculo);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Vehiculo.class.getName()).log(Level.SEVERE, "Error al obtener lista de vehículos", e);
        }
        return lista;
    }

    public static List<String[]> getListaEnArreglosJS(String filtro, String orden) throws SQLException {
        List<String[]> lista = new ArrayList<>();
        try (ResultSet datos = Vehiculo.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    String[] vehiculo = new String[]{
                        datos.getString("identificacion"),
                        datos.getString("tieneVehiculo"),
                        datos.getString("numeroPlacaVehiculo"),
                        datos.getString("tipoVehiculo"),
                        datos.getString("modeloVehiculo"),
                        datos.getString("linea"),
                        datos.getString("marca"),
                        datos.getString("color"),
                        datos.getString("cilindraje"),
                        datos.getString("numLicenciaTransito"),
                        datos.getString("fechaExpLicenciaTransito"),
                        datos.getString("numLicenciaConduccion"),
                        datos.getString("fechaExpConduccion"),
                        datos.getString("fechaVencimiento"),
                        datos.getString("restricciones"),
                        datos.getString("titularTrjPro"),
                        datos.getString("estado")
                    };
                    lista.add(vehiculo);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Vehiculo.class.getName()).log(Level.SEVERE, "Error al obtener lista de vehículos en arreglo JS", e);
        }
        return lista;
    }

    public static Vehiculo getVehiculoPorIdentificacion(String identificacion) {
        Vehiculo vehiculo = null;
        String sql = "SELECT identificacion, tieneVehiculo, numeroPlacaVehiculo, tipoVehiculo, modeloVehiculo, "
                + "linea, marca, color, cilindraje, numLicenciaTransito, fechaExpLicenciaTransito, "
                + "numLicenciaConduccion, fechaExpConduccion, fechaVencimiento, restricciones, titularTrjPro, estado "
                + "FROM vehiculo WHERE identificacion = " + identificacion;

        try {
            ResultSet rs = ConectorBD.consultar(sql);
            if (rs != null && rs.next()) {
                vehiculo = new Vehiculo();
                vehiculo.setIdentificacion(rs.getString("identificacion"));
                vehiculo.setTieneVehiculo(rs.getString("tieneVehiculo"));
                vehiculo.setNumeroPlacaVehiculo(rs.getString("numeroPlacaVehiculo"));
                vehiculo.setTipoVehiculo(rs.getString("tipoVehiculo"));
                vehiculo.setModeloVehiculo(rs.getString("modeloVehiculo"));
                vehiculo.setLinea(rs.getString("linea"));
                vehiculo.setMarca(rs.getString("marca"));
                vehiculo.setColor(rs.getString("color"));
                vehiculo.setCilindraje(rs.getString("cilindraje"));
                vehiculo.setNumLicenciaTransito(rs.getString("numLicenciaTransito"));
                vehiculo.setFechaExpLicenciaTransito(rs.getString("fechaExpLicenciaTransito"));
                vehiculo.setNumLicenciaConduccion(rs.getString("numLicenciaConduccion"));
                vehiculo.setFechaExpConduccion(rs.getString("fechaExpConduccion"));
                vehiculo.setFechaVencimiento(rs.getString("fechaVencimiento"));
                vehiculo.setRestricciones(rs.getString("restricciones"));
                vehiculo.setEstado(rs.getString("estado"));
            }
        } catch (Exception e) {
            System.out.println("❌ Error al consultar vehículo: " + e.getMessage());
        }

        return vehiculo;
    }

}
