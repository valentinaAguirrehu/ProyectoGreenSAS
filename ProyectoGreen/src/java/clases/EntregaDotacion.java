package clases;

import clasesGenericas.ConectorBD;
import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EntregaDotacion {

    private String idEntrega;
    private String idPersona;
    private String fechaEntrega;
    private String tipoEntrega;
    private String numeroEntrega;
    private String responsable;
    private String observacion;
    private String jsonPrendas;

    public EntregaDotacion() {
    }

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

    public boolean modificarEntregaDotacion() {
        if (this.idEntrega == null || this.idEntrega.trim().isEmpty()) {
            System.out.println("Error: idEntrega no definido para modificar.");
            return false;
        }

        String sql = "UPDATE entregaDotacion SET id_persona = ?, fechaEntrega = ?, tipoEntrega = ?, "
                + "numero_entrega = ?, responsable = ?, observacion = ? WHERE id_entrega = ?";

        ConectorBD conector = new ConectorBD();
        if (!conector.conectar()) {
            System.out.println("No se pudo conectar a la BD.");
            return false;
        }

        try {
            PreparedStatement stmt = conector.conexion.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(idPersona));
            stmt.setDate(2, java.sql.Date.valueOf(fechaEntrega));
            stmt.setString(3, tipoEntrega);
            stmt.setInt(4, Integer.parseInt(numeroEntrega));
            stmt.setString(5, responsable);
            stmt.setString(6, observacion);
            stmt.setInt(7, Integer.parseInt(idEntrega));

            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (Exception e) {
            System.out.println("Error al modificar la entrega: " + e.getMessage());
            return false;
        } finally {
            conector.desconectar();
        }
    }

    public boolean actualizarDetalleEntrega() {
        if (this.idEntrega == null || this.jsonPrendas == null || this.jsonPrendas.trim().isEmpty()) {
            System.out.println("Error: idEntrega o jsonPrendas no definidos.");
            return false;
        }

        ConectorBD conector = new ConectorBD();
        if (!conector.conectar()) {
            System.out.println("No se pudo conectar a la BD.");
            return false;
        }

        try {
            // Paso 1: eliminar detalles existentes
            PreparedStatement deleteStmt = conector.conexion.prepareStatement("DELETE FROM detalleEntrega WHERE id_entrega = ?");
            deleteStmt.setInt(1, Integer.parseInt(this.idEntrega));
            deleteStmt.executeUpdate();

            // Paso 2: insertar nuevos detalles desde JSON
            org.json.JSONArray prendasArray = new org.json.JSONArray(this.jsonPrendas);
            String insertSql = "INSERT INTO detalleEntrega (id_entrega, id_prenda, talla, estado, unidad_negocio) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement insertStmt = conector.conexion.prepareStatement(insertSql);

            for (int i = 0; i < prendasArray.length(); i++) {
                org.json.JSONObject obj = prendasArray.getJSONObject(i);
                insertStmt.setInt(1, Integer.parseInt(this.idEntrega));
                insertStmt.setInt(2, obj.getInt("id_prenda"));
                insertStmt.setString(3, obj.getString("talla"));
                insertStmt.setString(4, obj.getString("estado"));
                insertStmt.setString(5, obj.getString("unidad_negocio"));
                insertStmt.addBatch();
            }

            insertStmt.executeBatch();
            return true;

        } catch (Exception e) {
            System.out.println("Error al actualizar detalles: " + e.getMessage());
            return false;
        } finally {
            conector.desconectar();
        }
    }

    public boolean eliminarEntregaDotacion() {
        if (this.idEntrega == null || this.idEntrega.trim().isEmpty()) {
            System.out.println("Error: idEntrega no definido para eliminar.");
            return false;
        }
        String sql = "DELETE FROM entregaDotacion WHERE id_entrega=" + idEntrega;
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
                e.setResponsable(rs.getString("responsable"));
                e.setObservacion(rs.getString("observacion"));
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
