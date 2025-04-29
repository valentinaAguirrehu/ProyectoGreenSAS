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
    private String numeroEntrega;
    private String jsonPrendas;

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

    public String getNumeroEntrega() {
        return numeroEntrega;
    }

    public void setNumeroEntrega(String numeroEntrega) {
        this.numeroEntrega = numeroEntrega;
    }

    public String getJsonPrendas() {
        return jsonPrendas;
    }

    public void setJsonPrendas(String jsonPrendas) {
        this.jsonPrendas = jsonPrendas;
    }

    // Métodos para base de datos
    public boolean grabar() {
        String sql = "INSERT INTO entregaDotacion (id_persona, fechaEntrega, tipoEntrega, numero_entrega) "
                + "VALUES ('" + idPersona + "', '" + fechaEntrega + "', '" + tipoEntrega + "','" + numeroEntrega + "')";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean modificar(String idAnterior) {
        String sql = "UPDATE entregaDotacion SET id_persona='" + idPersona
                + "', fechaEntrega='" + fechaEntrega
                + "', tipoEntrega='" + tipoEntrega
                + "', numero_entrega='" + numeroEntrega
                + "' WHERE id_entrega=" + idAnterior;
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
                e.setNumeroEntrega(rs.getString("numero_entrega"));
                lista.add(e);
            }
            rs.close();
        } catch (Exception ex) {
            System.out.println("Error al obtener la lista de entregas: " + ex.getMessage());
        }

        return lista;
    }

    public int contarDetalles(List<DetalleEntrega> detalles) {
        int count = 0;
        for (DetalleEntrega d : detalles) {
            if (d.getIdEntrega().equals(this.getIdEntrega())) {
                count++;
            }
        }
        return count == 0 ? 1 : count;
    }

    public boolean registrarEntregaDotacion() {
        try {
            String sql = "CALL sp_entregar_dotacion('" + this.jsonPrendas + "')";
            return ConectorBD.ejecutarQuery(sql);
        } catch (Exception e) {
            System.out.println("Error al registrar la entrega: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

}
