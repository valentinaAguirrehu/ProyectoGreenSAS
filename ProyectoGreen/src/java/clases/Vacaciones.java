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
public class Vacaciones {

    private String id;
    private String idPersona;
    private String observacion;
    private String estado;

    public Vacaciones() {
    }

    public Vacaciones(String id) {
        String sql = "SELECT id, idPersona, observacion, estado "
                + "FROM vacaciones "
                + "WHERE id = " + id;

        ResultSet rs = ConectorBD.consultar(sql);

        try {
            if (rs.next()) {
                this.id = rs.getString("id");
                this.idPersona = rs.getString("idPersona");
                this.observacion = rs.getString("observacion");
                this.estado = rs.getString("estado");
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al cargar Vacaciones por ID: " + e.getMessage());
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(String idPersona) {
        this.idPersona = idPersona;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public boolean grabar() {
        String sql = "INSERT INTO vacaciones (idPersona, observacion, estado) VALUES ('" + idPersona + "', '" + observacion + "', '" + estado + "')";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean modificar(String idAnterior) {
        String sql = "UPDATE vacaciones SET id = " + id + ", idPersona = '" + idPersona + "', observacion = '" + observacion + "', estado = '" + estado + "'"
                + " WHERE id = " + idAnterior;
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean eliminar(String id) {
        String sql = "DELETE FROM vacaciones WHERE id = " + id;
        return ConectorBD.ejecutarQuery(sql);
    }

    public static ResultSet getLista() {
        String sql = "SELECT v.id, v.idPersona, v.observacion, v.estado, p.nombres, p.apellidos, p.fechaIngreso "
                + "FROM vacaciones v "
                + "JOIN persona p ON v.idPersona = p.identificacion";
        return ConectorBD.consultar(sql);
    }

    public static List<Vacaciones> getListaEnObjetos(String filtro, String orden) {
        List<Vacaciones> lista = new ArrayList<>();
        String sql = "SELECT v.id, v.idPersona, v.observacion, v.estado "
                + "FROM vacaciones v ";

        if (filtro != null && !filtro.isEmpty()) {
            sql += " WHERE " + filtro;
        }
        if (orden != null && !orden.isEmpty()) {
            sql += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(sql);
        try {
            while (rs.next()) {
                Vacaciones v = new Vacaciones("");
                v.setId(rs.getString("id"));
                v.setIdPersona(rs.getString("idPersona"));
                v.setObservacion(rs.getString("observacion"));
                v.setEstado(rs.getString("estado"));
                lista.add(v);
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al obtener lista de vacaciones: " + e.getMessage());
        }

        return lista;
    }

}
