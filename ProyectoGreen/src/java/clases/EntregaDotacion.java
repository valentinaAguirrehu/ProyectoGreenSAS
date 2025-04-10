package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EntregaDotacion {
    
    private String idEntrega;
    private String idPersona;
    private String fechaEntrega;
    private String tipoEntrega;

    // Getters y Setters
    public String getIdEntrega() {
        return idEntrega;
    }

    public void setIdEntrega(String idEntrega) {
        this.idEntrega = idEntrega;
    }

    public String getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(String idPersona) {
        this.idPersona = idPersona;
    }

    public String getFechaEntrega() {
        return fechaEntrega;
    }

    public void setFechaEntrega(String fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
    }

    public String getTipoEntrega() {
        return tipoEntrega;
    }

    public void setTipoEntrega(String tipoEntrega) {
        this.tipoEntrega = tipoEntrega;
    }

    // Métodos para base de datos
    public boolean grabar() {
        String sql = "INSERT INTO entregaDotacion (id_persona, fechaEntrega, tipoEntrega) " +
                     "VALUES ('" + idPersona + "', '" + fechaEntrega + "', '" + tipoEntrega + "')";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean modificar(String idAnterior) {
        String sql = "UPDATE entregaDotacion SET id_persona='" + idPersona + 
                     "', fechaEntrega='" + fechaEntrega + 
                     "', tipoEntrega='" + tipoEntrega + 
                     "' WHERE id_entrega=" + idAnterior;
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean eliminar(String id) {
        String sql = "DELETE FROM entregaDotacion WHERE id_entrega=" + id;
        return ConectorBD.ejecutarQuery(sql);
    }

    public static List<EntregaDotacion> getListaEnObjetos(String filtro, String orden) {
        List<EntregaDotacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM entregaDotacion";

        if (filtro != null && !filtro.isEmpty()) {
            sql += " WHERE " + filtro;
        }
        if (orden != null && !orden.isEmpty()) {
            sql += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(sql);
        try {
            while (rs.next()) {
                EntregaDotacion e = new EntregaDotacion();
                e.setIdEntrega(rs.getString("id_entrega"));
                e.setIdPersona(rs.getString("id_persona"));
                e.setFechaEntrega(rs.getString("fechaEntrega"));
                e.setTipoEntrega(rs.getString("tipoEntrega"));
                lista.add(e);
            }
            rs.close();
        } catch (Exception ex) {
            System.out.println("Error al obtener la lista de entregas: " + ex.getMessage());
        }

        return lista;
    }
}
