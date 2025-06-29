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
        if (this.idEntrega == null || this.jsonPrendas == null || this.jsonPrendas.trim().isEmpty()) {
            System.out.println("Error: Faltan datos obligatorios para modificar la entrega.");
            return false;
        }

        ConectorBD conector = new ConectorBD();
        if (!conector.conectar()) {
            System.out.println("No se pudo conectar a la BD.");
            return false;
        }

        try {
            String sql = "CALL modificar_entrega_dotacion(?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conector.conexion.prepareStatement(sql);
            stmt.setString(1, this.idEntrega);
            stmt.setString(2, this.idPersona);
            stmt.setDate(3, java.sql.Date.valueOf(this.fechaEntrega));
            stmt.setString(4, this.tipoEntrega);
            stmt.setString(5, this.responsable);
            stmt.setString(6, this.observacion != null ? this.observacion : "");
            stmt.setString(7, this.jsonPrendas);

            stmt.execute();
            stmt.close();
            return true;

        } catch (Exception e) {
            System.out.println("Error al modificar la entrega con procedimiento: " + e.getMessage());
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

    public static List<DetalleEntrega> getDetallesConEstadoNueva() {
        List<DetalleEntrega> lista = new ArrayList<>();

        String sql = "SELECT ed.id_entrega, ed.id_persona, ed.fechaEntrega, ed.tipoEntrega, ed.numero_entrega, "
                + "ed.responsable, ed.observacion, "
                + "de.id_detalle_entrega, de.id_prenda, de.talla, de.estado, de.unidad_negocio "
                + "FROM entregaDotacion ed "
                + "INNER JOIN detalleEntrega de ON ed.id_entrega = de.id_entrega "
                + "WHERE de.estado IN ('Nueva', 'Usada')";

        ResultSet rs = ConectorBD.consultar(sql);

        try {
            while (rs.next()) {
                EntregaDotacion entrega = new EntregaDotacion();
                entrega.setIdEntrega(rs.getString("id_entrega"));
                entrega.setIdPersona(rs.getString("id_persona"));
                entrega.setFechaEntrega(rs.getString("fechaEntrega"));
                entrega.setTipoEntrega(rs.getString("tipoEntrega"));
                entrega.setNumeroEntrega(rs.getString("numero_entrega"));
                entrega.setResponsable(rs.getString("responsable"));
                entrega.setObservacion(rs.getString("observacion"));

                DetalleEntrega detalle = new DetalleEntrega();
                detalle.setIdDetalleEntrega(rs.getString("id_detalle_entrega"));
                detalle.setIdEntrega(rs.getString("id_entrega"));
                detalle.setIdPrenda(rs.getString("id_prenda"));
                detalle.setTalla(rs.getString("talla"));
                detalle.setEstado(rs.getString("estado"));
                detalle.setUnidadNegocio(rs.getString("unidad_negocio"));

                detalle.setEntrega(entrega); // ✅ Estás vinculando el objeto EntregaDotacion aquí

                lista.add(detalle);
            }
            rs.close();
        } catch (Exception ex) {
            System.out.println("Error en getDetallesConEstadoNueva(): " + ex.getMessage());
        }

        return lista;
    }

    public static List<DetalleEntrega> getDetallesFiltrados(String anio, String unidad, String estado, String tipoEntrega) {
        List<DetalleEntrega> lista = new ArrayList<>();
        String sql = "SELECT ed.id_entrega, ed.id_persona, ed.fechaEntrega, ed.tipoEntrega, ed.numero_entrega, "
                + "ed.responsable, ed.observacion, "
                + "de.id_detalle_entrega, de.id_prenda, de.talla, de.estado, de.unidad_negocio "
                + "FROM entregaDotacion ed "
                + "INNER JOIN detalleEntrega de ON ed.id_entrega = de.id_entrega WHERE 1=1 ";

        if (anio != null && !anio.isEmpty()) {
            sql += "AND ed.fechaEntrega LIKE '" + anio + "%' ";
        }
        if (unidad != null && !unidad.isEmpty()) {
            sql += "AND de.unidad_negocio LIKE '%" + unidad + "%' ";
        }
        if (estado != null && !estado.isEmpty()) {
            sql += "AND de.estado = '" + estado + "' ";
        }
        if (tipoEntrega != null && !tipoEntrega.isEmpty()) {
            sql += "AND ed.tipoEntrega LIKE '%" + tipoEntrega + "%' ";
        }

        ResultSet rs = ConectorBD.consultar(sql);

        try {
            while (rs.next()) {
                EntregaDotacion entrega = new EntregaDotacion();
                entrega.setIdEntrega(rs.getString("id_entrega"));
                entrega.setIdPersona(rs.getString("id_persona"));
                entrega.setFechaEntrega(rs.getString("fechaEntrega"));
                entrega.setTipoEntrega(rs.getString("tipoEntrega"));
                entrega.setNumeroEntrega(rs.getString("numero_entrega"));
                entrega.setResponsable(rs.getString("responsable"));
                entrega.setObservacion(rs.getString("observacion"));

                DetalleEntrega detalle = new DetalleEntrega();
                detalle.setIdDetalleEntrega(rs.getString("id_detalle_entrega"));
                detalle.setIdEntrega(rs.getString("id_entrega"));
                detalle.setIdPrenda(rs.getString("id_prenda"));
                detalle.setTalla(rs.getString("talla"));
                detalle.setEstado(rs.getString("estado"));
                detalle.setUnidadNegocio(rs.getString("unidad_negocio"));

                detalle.setEntrega(entrega);
                lista.add(detalle);
            }
            rs.close();
        } catch (Exception ex) {
            System.out.println("Error en getDetallesFiltrados(): " + ex.getMessage());
        }

        return lista;
    }
    

}
