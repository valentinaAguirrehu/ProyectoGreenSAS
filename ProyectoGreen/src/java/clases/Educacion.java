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
public class Educacion {

    private String identificacion;
    private String nivelEducativo;
    private String fechaIngresoEmpresa;
    private String fechaEtapaLectiva;
    private String fechaFinalizacionEtapaLectiva;
    private String fechaEtapaProductiva;
    private String fechaFinalizacionEtapaProductiva;
    private String fechaRetiroAnticipado;
    private String TituloAprendiz;

    public Educacion() {
    }

    public Educacion(String identificacion) {
        String cadenaSQL = "SELECT * FROM educacion WHERE identificacion = '" + identificacion + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.identificacion = identificacion;
                nivelEducativo = resultado.getString("nivelEducativo");
                fechaIngresoEmpresa = resultado.getString("fechaIngresoEmpresa");
                fechaEtapaLectiva = resultado.getString("fechaEtapaLectiva");
                fechaFinalizacionEtapaLectiva = resultado.getString("fechaFinalizacionEtapaLectiva");
                fechaEtapaProductiva = resultado.getString("fechaEtapaProductiva");
                fechaFinalizacionEtapaProductiva = resultado.getString("fechaFinalizacionEtapaProductiva");
                fechaRetiroAnticipado = resultado.getString("fechaRetiroAnticipado");
                TituloAprendiz = resultado.getString("TituloAprendiz");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar educación: " + ex.getMessage());
        } finally {
            try {
                if (resultado != null) {
                    resultado.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar ResultSet de educación: " + ex.getMessage());
            }
        }
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

    public String getNivelEducativo() {
        String resultado = nivelEducativo;
        if (nivelEducativo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNivelEducativo(String nivelEducativo) {
        this.nivelEducativo = nivelEducativo;
    }

    public String getFechaEtapaLectiva() {
        String resultado = fechaEtapaLectiva;
        if (fechaEtapaLectiva == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaEtapaLectiva(String fechaEtapaLectiva) {
        this.fechaEtapaLectiva = fechaEtapaLectiva;
    }

    public String getFechaEtapaProductiva() {
        String resultado = fechaEtapaProductiva;
        if (fechaEtapaProductiva == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaEtapaProductiva(String fechaEtapaProductiva) {
        this.fechaEtapaProductiva = fechaEtapaProductiva;
    }

    public String getTituloAprendiz() {
        String resultado = TituloAprendiz;
        if (TituloAprendiz == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTituloAprendiz(String TituloAprendiz) {
        this.TituloAprendiz = TituloAprendiz;
    }

    public String getFechaIngresoEmpresa() {
        return fechaIngresoEmpresa;
    }

    public void setFechaIngresoEmpresa(String fechaIngresoEmpresa) {
        this.fechaIngresoEmpresa = fechaIngresoEmpresa;
    }

    public String getFechaFinalizacionEtapaLectiva() {
        return fechaFinalizacionEtapaLectiva;
    }

    public void setFechaFinalizacionEtapaLectiva(String fechaFinalizacionEtapaLectiva) {
        this.fechaFinalizacionEtapaLectiva = fechaFinalizacionEtapaLectiva;
    }

    public String getFechaFinalizacionEtapaProductiva() {
        return fechaFinalizacionEtapaProductiva;
    }

    public void setFechaFinalizacionEtapaProductiva(String fechaFinalizacionEtapaProductiva) {
        this.fechaFinalizacionEtapaProductiva = fechaFinalizacionEtapaProductiva;
    }

    public String getFechaRetiroAnticipado() {
        return fechaRetiroAnticipado;
    }

    public void setFechaRetiroAnticipado(String fechaRetiroAnticipado) {
        this.fechaRetiroAnticipado = fechaRetiroAnticipado;
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
        String cadenaSQL = "INSERT INTO educacion ("
                + "identificacion, nivelEducativo, "
                + "fechaIngresoEmpresa, fechaEtapaLectiva, fechaFinalizacionEtapaLectiva, "
                + "fechaEtapaProductiva, fechaFinalizacionEtapaProductiva, fechaRetiroAnticipado, "
                + "TituloAprendiz) VALUES ('"
                + identificacion + "', '"
                + nivelEducativo + "', '"
                + (fechaIngresoEmpresa != null && !fechaIngresoEmpresa.isEmpty() ? fechaIngresoEmpresa : "NULL") + "', "
                + (fechaEtapaLectiva != null && !fechaEtapaLectiva.isEmpty() ? "'" + fechaEtapaLectiva + "'" : "NULL") + ", "
                + (fechaFinalizacionEtapaLectiva != null && !fechaFinalizacionEtapaLectiva.isEmpty() ? "'" + fechaFinalizacionEtapaLectiva + "'" : "NULL") + ", "
                + (fechaEtapaProductiva != null && !fechaEtapaProductiva.isEmpty() ? "'" + fechaEtapaProductiva + "'" : "NULL") + ", "
                + (fechaFinalizacionEtapaProductiva != null && !fechaFinalizacionEtapaProductiva.isEmpty() ? "'" + fechaFinalizacionEtapaProductiva + "'" : "NULL") + ", "
                + (fechaRetiroAnticipado != null && !fechaRetiroAnticipado.isEmpty() ? "'" + fechaRetiroAnticipado + "'" : "NULL") + ", "
                + (TituloAprendiz != null && !TituloAprendiz.isEmpty() ? "'" + TituloAprendiz + "'" : "NULL")
                + ");";

        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);
        System.out.println(cadenaSQL);

        if (!resultado) {
            System.out.println("Error: No se pudo insertar la educacion en la BD");
            return false;
        }

        return true;
    }

    public boolean modificar(String identificacionAnterior) {
        if (identificacion == null || identificacionAnterior == null) {
            System.out.println("Error: identificacion o identificacionAnterior es null.");
            return false;
        }

        String cadenaSQL = "UPDATE educacion SET "
                + "identificacion='" + identificacion + "', "
                + "nivelEducativo=" + (nivelEducativo != null ? "'" + nivelEducativo + "'" : "NULL") + ", "
                + "fechaIngresoEmpresa=" + (fechaIngresoEmpresa != null && !fechaIngresoEmpresa.isEmpty() ? "'" + fechaIngresoEmpresa + "'" : "NULL") + ", "
                + "fechaEtapaLectiva=" + (fechaEtapaLectiva != null && !fechaEtapaLectiva.isEmpty() ? "'" + fechaEtapaLectiva + "'" : "NULL") + ", "
                + "fechaFinalizacionEtapaLectiva=" + (fechaFinalizacionEtapaLectiva != null && !fechaFinalizacionEtapaLectiva.isEmpty() ? "'" + fechaFinalizacionEtapaLectiva + "'" : "NULL") + ", "
                + "fechaEtapaProductiva=" + (fechaEtapaProductiva != null && !fechaEtapaProductiva.isEmpty() ? "'" + fechaEtapaProductiva + "'" : "NULL") + ", "
                + "fechaFinalizacionEtapaProductiva=" + (fechaFinalizacionEtapaProductiva != null && !fechaFinalizacionEtapaProductiva.isEmpty() ? "'" + fechaFinalizacionEtapaProductiva + "'" : "NULL") + ", "
                + "fechaRetiroAnticipado=" + (fechaRetiroAnticipado != null && !fechaRetiroAnticipado.isEmpty() ? "'" + fechaRetiroAnticipado + "'" : "NULL") + ", "
                + "TituloAprendiz=" + (TituloAprendiz != null && !TituloAprendiz.isEmpty() ? "'" + TituloAprendiz + "'" : "NULL") + " "
                + "WHERE identificacion='" + identificacionAnterior + "'";

        System.out.println("Consulta SQL de modificación: " + cadenaSQL);
        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);

        return resultado;
    }

    public boolean eliminar() {
        String cadenaSQL = "DELETE FROM Educacion WHERE identificacion = '" + identificacion + "'";
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

        String cadenaSQL = "SELECT identificacion, nivelEducativo, fechaIngresoEmpresa, "
                + "fechaEtapaLectiva, fechaFinalizacionEtapaLectiva, fechaEtapaProductiva, "
                + "fechaFinalizacionEtapaProductiva, fechaRetiroAnticipado, TituloAprendiz "
                + "FROM educacion" + filtro + orden;

        System.out.println("Ejecutando consulta: " + cadenaSQL);
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Educacion> getListaEnObjetos(String filtro, String orden) throws SQLException {
        List<Educacion> lista = new ArrayList<>();
        try (ResultSet datos = Educacion.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    Educacion educacion = new Educacion();
                    educacion.setIdentificacion(datos.getString("identificacion"));
                    educacion.setNivelEducativo(datos.getString("nivelEducativo"));
                    educacion.setFechaIngresoEmpresa(datos.getString("fechaIngresoEmpresa"));
                    educacion.setFechaEtapaLectiva(datos.getString("fechaEtapaLectiva"));
                    educacion.setFechaFinalizacionEtapaLectiva(datos.getString("fechaFinalizacionEtapaLectiva"));
                    educacion.setFechaEtapaProductiva(datos.getString("fechaEtapaProductiva"));
                    educacion.setFechaFinalizacionEtapaProductiva(datos.getString("fechaFinalizacionEtapaProductiva"));
                    educacion.setFechaRetiroAnticipado(datos.getString("fechaRetiroAnticipado"));
                    educacion.setTituloAprendiz(datos.getString("TituloAprendiz"));

                    lista.add(educacion);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Educacion.class.getName()).log(Level.SEVERE, "Error al obtener lista de educación", e);
        }
        return lista;
    }

    public static List<String[]> getListaEnArreglosJS(String filtro, String orden) throws SQLException {
        List<String[]> lista = new ArrayList<>();
        try (ResultSet datos = Educacion.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    String[] educacion = new String[]{
                        datos.getString("identificacion"),
                        datos.getString("nivelEducativo"),
                        datos.getString("fechaIngresoEmpresa"),
                        datos.getString("fechaEtapaLectiva"),
                        datos.getString("fechaFinalizacionEtapaLectiva"),
                        datos.getString("fechaEtapaProductiva"),
                        datos.getString("fechaFinalizacionEtapaProductiva"),
                        datos.getString("fechaRetiroAnticipado"),
                        datos.getString("TituloAprendiz")
                    };
                    lista.add(educacion);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Educacion.class.getName()).log(Level.SEVERE, "Error al obtener lista de educación en arreglo JS", e);
        }
        return lista;
    }

    public static boolean esNivelEducativoPredefinido(String nivel) {
        return nivel != null && (nivel.equals("Primaria") || nivel.equals("Secundaria")
                || nivel.equals("Tecnico") || nivel.equals("Tecnologico")
                || nivel.equals("Universitario") || nivel.equals("Postgrado"));
    }

}
