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
    private String numeroDevolucion;
    private String tipoEntrega;
    private String jsonPrendas;

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
                this.numeroDevolucion = rs.getString("numero_devolucion");
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

    public String getNumeroDevolucion() {
        return numeroDevolucion;
    }

    public void setNumeroDevolucion(String numeroDevolucion) {
        this.numeroDevolucion = numeroDevolucion;
    }

    public String getJsonPrendas() {
        return jsonPrendas;
    }

    public void setJsonPrendas(String jsonPrendas) {
        this.jsonPrendas = jsonPrendas;
    }

    public boolean grabar() {
        String sql = "INSERT INTO devolucionDotacion (id_persona, fecha_devolucion, numero_devolucion, tipo_entrega) "
                + "VALUES ('" + idPersona + "', '" + fechaDevolucion + "', '" + numeroDevolucion + "',  '" + tipoEntrega + "')";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean modificar(String idAnterior) {
        String sql = "UPDATE devolucionDotacion SET "
                + "id_persona = '" + idPersona + "', "
                + "fecha_devolucion = '" + fechaDevolucion + "', "
                + "numero_devolucion = '" + numeroDevolucion + "', "
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
                d.setNumeroDevolucion(rs.getString("numero_devolucion"));
                lista.add(d);
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al obtener lista de devoluciones: " + e.getMessage());
        }

        return lista;
    }

    public int contarDetalles(List<DetalleDevolucion> detalles) {
        int count = 0;
        for (DetalleDevolucion d : detalles) {
            if (d.getIdDevolucion().equals(this.getIdDevolucion())) {
                count++;
            }
        }
        return count == 0 ? 1 : count;
    }

    public boolean registrarDevolucionDotacion() {
        try {
            String sql = "CALL sp_devolver_dotacion('" + this.jsonPrendas + "')";
            return ConectorBD.ejecutarQuery(sql);
        } catch (Exception e) {
            System.out.println("Error al registrar la devolución: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

}
