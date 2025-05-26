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
    private String numeroDevolucion;
    private String responsable;
    private String observacion;
    private String jsonPrendas;

    public DevolucionDotacion() {
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

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public String getJsonPrendas() {
        return jsonPrendas;
    }

    public void setJsonPrendas(String jsonPrendas) {
        this.jsonPrendas = jsonPrendas;
    }

   public boolean modificarDevolucionDotacion() {
        if (this.idDevolucion == null || this.idDevolucion.trim().isEmpty()) {
            System.out.println("Error: idDevolucion no definido para modificar.");
            return false;
        }

        String sql = "UPDATE devolucionDotacion SET id_persona='" + idPersona
                + "', fecha_devolucion='" + fechaDevolucion
                + "', tipo_entrega='" + tipoEntrega
                + "', numero_devolucion='" + numeroDevolucion
                + "', responsable='" + responsable
                + "', observacion='" + observacion
                + "' WHERE id_devolucion=" + idDevolucion;

        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean eliminarDevolucionDotacion() {
        if (this.idDevolucion == null || this.idDevolucion.trim().isEmpty()) {
            System.out.println("Error: idDevolucion no definido para eliminar.");
            return false;
        }

        String eliminarPrincipal = "DELETE FROM devolucionDotacion WHERE id_devolucion=" + idDevolucion;

        boolean principalOk = ConectorBD.ejecutarQuery(eliminarPrincipal);

        return principalOk;
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
                d.setResponsable(rs.getString("responsable"));
                d.setObservacion(rs.getString("observacion"));
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
