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
public class PeriodoLaboral {

    private String idPeriodo;
    private String idColaborador;
    private String fechaInicio;
    private String fechaFin;
    private String vacacionesDisponibles;
    private String vacacionesTomadas;

    public PeriodoLaboral() {
    }

    public PeriodoLaboral(String idPeriodo) {
        String sql = "SELECT id_periodo, id_colaborador, fecha_inicio, fecha_fin, vacaciones_disponibles, vacaciones_tomadas "
                + "FROM periodoLaboral "
                + "WHERE id_periodo = " + idPeriodo;

        ResultSet rs = ConectorBD.consultar(sql);

        try {
            if (rs.next()) {
                this.idPeriodo = rs.getString("id_periodo");
                this.idColaborador = rs.getString("id_colaborador");
                this.fechaInicio = rs.getString("fecha_inicio");
                this.fechaFin = rs.getString("fecha_fin");
                this.vacacionesDisponibles = rs.getString("vacaciones_disponibles");
                this.vacacionesTomadas = rs.getString("vacaciones_tomadas");
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al cargar PeriodoLaboral por IdPerido: " + e.getMessage());
        }

    }

    public String getIdPeriodo() {
        return idPeriodo;
    }

    public void setIdPeriodo(String idPeriodo) {
        this.idPeriodo = idPeriodo;
    }

    public String getIdColaborador() {
        return idColaborador;
    }

    public void setIdColaborador(String idColaborador) {
        this.idColaborador = idColaborador;
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

    public String getVacacionesDisponibles() {
        return vacacionesDisponibles;
    }

    public void setVacacionesDisponibles(String vacacionesDisponibles) {
        this.vacacionesDisponibles = vacacionesDisponibles;
    }

    public String getVacacionesTomadas() {
        return vacacionesTomadas;
    }

    public void setVacacionesTomadas(String vacacionesTomadas) {
        this.vacacionesTomadas = vacacionesTomadas;
    }

    public boolean grabar() {
        String sql = "INSERT INTO periodoLaboral (id_colaborador, fecha_inicio, fecha_fin, vacaciones_disponibles, vacaciones_tomadas) "
                + "VALUES ('" + idColaborador + "', '" + fechaInicio + "', '" + fechaFin + "', " + vacacionesDisponibles + ", " + vacacionesTomadas + ")";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean modificar(String idAnterior) {
        String sql = "UPDATE periodoLaboral SET id_colaborador = '" + idColaborador + "', fecha_inicio = '" + fechaInicio
                + "', fecha_fin = '" + fechaFin + "', vacaciones_disponibles = " + vacacionesDisponibles
                + ", vacaciones_tomadas = " + vacacionesTomadas + " WHERE id_periodo = " + idAnterior;
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean eliminar(String id) {
        String sql = "DELETE FROM periodoLaboral WHERE id_periodo = " + id;
        return ConectorBD.ejecutarQuery(sql);
    }

    public static ResultSet getLista() {
        String sql = "SELECT * FROM periodoLaboral";
        return ConectorBD.consultar(sql);
    }

    public static List<PeriodoLaboral> getListaEnObjetos(String filtro, String orden) {
        List<PeriodoLaboral> lista = new ArrayList<>();
        String sql = "SELECT * FROM periodoLaboral";

        if (filtro != null && !filtro.isEmpty()) {
            sql += " WHERE " + filtro;
        }
        if (orden != null && !orden.isEmpty()) {
            sql += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(sql);
        try {
            while (rs.next()) {
                PeriodoLaboral p = new PeriodoLaboral("");
                p.setIdPeriodo(rs.getString("id_periodo"));
                p.setIdColaborador(rs.getString("id_colaborador"));
                p.setFechaInicio(rs.getString("fecha_inicio"));
                p.setFechaFin(rs.getString("fecha_fin"));
                p.setVacacionesDisponibles(rs.getString("vacaciones_disponibles"));
                p.setVacacionesTomadas(rs.getString("vacaciones_tomadas"));
                lista.add(p);
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al obtener lista de PeriodoLaboral: " + e.getMessage());
        }

        return lista;
    }

}
