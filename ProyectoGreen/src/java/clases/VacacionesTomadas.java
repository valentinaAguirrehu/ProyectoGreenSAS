/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author VALEN
 */
public class VacacionesTomadas {

    private String idVacacion;
    private String idPeriodo;
    private String fechaInicio;
    private String fechaFin;
    private String diasHabiles;

    public VacacionesTomadas() {
    }

    public VacacionesTomadas(String idVacacion) {

        String sql = "SELECT id_vacacion, id_periodo, fecha_inicio, fecha_fin, dias_habiles "
                + "FROM vacacionesTomadas "
                + "WHERE id_vacacion = " + idVacacion;
        ResultSet rs = ConectorBD.consultar(sql);

        try {
            if (rs.next()) {
                this.idVacacion = rs.getString("id_vacacion");
                this.idPeriodo = rs.getString("id_periodo");
                this.fechaInicio = rs.getString("fecha_inicio");
                this.fechaFin = rs.getString("fecha_fin");
                this.diasHabiles = rs.getString("dias_habiles");
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al cargar VacacionesTomadas por ID: " + e.getMessage());
        }

    }

    public String getIdVacacion() {
        return idVacacion;
    }

    public void setIdVacacion(String idVacacion) {
        this.idVacacion = idVacacion;
    }

    public String getIdPeriodo() {
        return idPeriodo;
    }

    public void setIdPeriodo(String idPeriodo) {
        this.idPeriodo = idPeriodo;
    }

    public String getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(String fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public String getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(String fechaFin) {
        this.fechaFin = fechaFin;
    }

    public String getDiasHabiles() {
        return diasHabiles;
    }

    public void setDiasHabiles(String diasHabiles) {
        this.diasHabiles = diasHabiles;
    }

    public boolean grabar() {
        String sql = "INSERT INTO vacacionesTomadas (id_periodo, fecha_inicio, fecha_fin, dias_habiles) "
                + "VALUES ('" + idPeriodo + "', '" + fechaInicio + "', '" + fechaFin + "', " + diasHabiles + ")";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean modificar(String idAnterior) {
        String sql = "UPDATE vacacionesTomadas SET id_periodo = '" + idPeriodo + "', fecha_inicio = '" + fechaInicio
                + "', fecha_fin = '" + fechaFin + "', dias_habiles = " + diasHabiles
                + " WHERE id_vacacion = " + idAnterior;
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean eliminar(String id) {
        String sql = "DELETE FROM vacacionesTomadas WHERE id_vacacion = " + id;
        return ConectorBD.ejecutarQuery(sql);
    }

    public static ResultSet getLista() {
        String sql = "SELECT * FROM vacacionesTomadas";
        return ConectorBD.consultar(sql);
    }

    public static List<VacacionesTomadas> getListaEnObjetos(String filtro, String orden) {
        List<VacacionesTomadas> lista = new ArrayList<>();
        String sql = "SELECT * FROM vacacionesTomadas";

        if (filtro != null && !filtro.isEmpty()) {
            sql += " WHERE " + filtro;
        }
        if (orden != null && !orden.isEmpty()) {
            sql += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(sql);
        try {
            while (rs.next()) {
                VacacionesTomadas v = new VacacionesTomadas("");
                v.setIdVacacion(rs.getString("id_vacacion"));
                v.setIdPeriodo(rs.getString("id_periodo"));
                v.setFechaInicio(rs.getString("fecha_inicio"));
                v.setFechaFin(rs.getString("fecha_fin"));
                v.setDiasHabiles(rs.getString("dias_habiles"));
                lista.add(v);
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al obtener lista de VacacionesTomadas: " + e.getMessage());
        }

        return lista;
    }
}
