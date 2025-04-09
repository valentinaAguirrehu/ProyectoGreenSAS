/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Angie
 */
public class DevolucionDotacion {
    
    private String idDevolucion;
    private String idPersona;
    private String fechaDevolucion;
    private String tipoEntrega;

    public DevolucionDotacion() {
    }

    public DevolucionDotacion(String idDevolucion) {
        String sql = "SELECT * FROM devolucionDotacion WHERE id_devolucion = " + idDevolucion;
        ResultSet rs = ConectorBD.consultar(sql);

        try {
            if (rs.next()) {
                this.idDevolucion = idDevolucion;
                this.idPersona = rs.getString("id_persona");
                this.fechaDevolucion = rs.getString("fecha_devolucion");
                this.tipoEntrega = rs.getString("tipo_entrega");
            }
        } catch (Exception e) {
            System.out.println("Error cargando devolución: " + e.getMessage());
        }
    }

    public String getIdDevolucion() {
        return idDevolucion;
    }

    public void setIdDevolucion(String idDevolucion) {
        this.idDevolucion = idDevolucion;
    }

    public String getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(String idPersona) {
        this.idPersona = idPersona;
    }

    public String getFechaDevolucion() {
        return fechaDevolucion;
    }

    public void setFechaDevolucion(String fechaDevolucion) {
        this.fechaDevolucion = fechaDevolucion;
    }

    public String getTipoEntrega() {
        return tipoEntrega;
    }

    public void setTipoEntrega(String tipoEntrega) {
        this.tipoEntrega = tipoEntrega;
    }

    public boolean grabar() {
        String sql = "INSERT INTO devolucionDotacion (id_persona, fecha_devolucion, tipo_entrega) "
                   + "VALUES ('" + idPersona + "', '" + fechaDevolucion + "', '" + tipoEntrega + "')";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean modificar(String idAnterior) {
        String sql = "UPDATE devolucionDotacion SET "
                   + "id_persona = '" + idPersona + "', "
                   + "fecha_devolucion = '" + fechaDevolucion + "', "
                   + "tipo_entrega = '" + tipoEntrega + "' "
                   + "WHERE id_devolucion = " + idAnterior;
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean eliminar(String id) {
        String sql = "DELETE FROM devolucionDotacion WHERE id_devolucion = " + id;
        return ConectorBD.ejecutarQuery(sql);
    }

    public static List<DevolucionDotacion> getListaEnObjetos(String filtro, String orden) {
        List<DevolucionDotacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM devolucionDotacion";

        if (filtro != null && !filtro.isEmpty()) {
            sql += " WHERE " + filtro;
        }

        if (orden != null && !orden.isEmpty()) {
            sql += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(sql);

        try {
            while (rs.next()) {
                DevolucionDotacion d = new DevolucionDotacion();
                d.setIdDevolucion(rs.getString("id_devolucion"));
                d.setIdPersona(rs.getString("id_persona"));
                d.setFechaDevolucion(rs.getString("fecha_devolucion"));
                d.setTipoEntrega(rs.getString("tipo_entrega"));
                lista.add(d);
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al obtener lista de devoluciones: " + e.getMessage());
        }

        return lista;
    }
}
