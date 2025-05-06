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
public class DetalleDevolucion {
    private String idDetalleDevolucion;
    private String idDevolucion;
    private String idPrenda;
    private String talla;
    private String estado;
    private String unidadNegocio;

    public DetalleDevolucion() {
    }

    public DetalleDevolucion(String idDetalleDevolucion) {
        String sql = "SELECT * FROM detalleDevolucion WHERE id_detalle_devolucion = " + idDetalleDevolucion;
        ResultSet rs = ConectorBD.consultar(sql);

        try {
            if (rs.next()) {
                this.idDetalleDevolucion = idDetalleDevolucion;
                this.idDevolucion = rs.getString("id_devolucion");
                this.idPrenda = rs.getString("id_prenda");
                this.talla = rs.getString("talla");
                this.estado = rs.getString("estado");
                this.unidadNegocio = rs.getString("unidad_negocio");
            }
        } catch (Exception e) {
            System.out.println("Error cargando detalle de devolución: " + e.getMessage());
        }
    }

    public String getIdDetalleDevolucion() {
        return idDetalleDevolucion;
    }

    public void setIdDetalleDevolucion(String idDetalleDevolucion) {
        this.idDetalleDevolucion = idDetalleDevolucion;
    }

    public String getIdDevolucion() {
        return idDevolucion;
    }

    public void setIdDevolucion(String idDevolucion) {
        this.idDevolucion = idDevolucion;
    }

    public String getIdPrenda() {
        return idPrenda;
    }

    public void setIdPrenda(String idPrenda) {
        this.idPrenda = idPrenda;
    }

    public String getTalla() {
        return talla;
    }

    public void setTalla(String talla) {
        this.talla = talla;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getUnidadNegocio() {
        return unidadNegocio;
    }

    public void setUnidadNegocio(String unidadNegocio) {
        this.unidadNegocio = unidadNegocio;
    }

    public boolean grabar() {
        String sql = "INSERT INTO detalleDevolucion (id_devolucion, id_prenda, talla, estado, unidad_negocio) "
                   + "VALUES ('" + idDevolucion + "', '" + idPrenda + "', '" + talla + "', '" + estado + "', '" + unidadNegocio + "')";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean modificar(String idAnterior) {
        String sql = "UPDATE detalleDevolucion SET "
                   + "id_devolucion = '" + idDevolucion + "', "
                   + "id_prenda = '" + idPrenda + "', "
                   + "talla = '" + talla + "', "
                   + "estado = '" + estado + "', "
                   + "unidad_negocio = '" + unidadNegocio + "' "
                   + "WHERE id_detalle_devolucion = " + idAnterior;
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean eliminar(String id) {
        String sql = "DELETE FROM detalleDevolucion WHERE id_detalle_devolucion = " + id;
        return ConectorBD.ejecutarQuery(sql);
    }

    public static List<DetalleDevolucion> getListaEnObjetos(String filtro, String orden) {
        List<DetalleDevolucion> lista = new ArrayList<>();
        String sql = "SELECT * FROM detalleDevolucion";

        if (filtro != null && !filtro.isEmpty()) {
            sql += " WHERE " + filtro;
        }

        if (orden != null && !orden.isEmpty()) {
            sql += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(sql);

        try {
            while (rs.next()) {
                DetalleDevolucion d = new DetalleDevolucion();
                d.setIdDetalleDevolucion(rs.getString("id_detalle_devolucion"));
                d.setIdDevolucion(rs.getString("id_devolucion"));
                d.setIdPrenda(rs.getString("id_prenda"));
                d.setTalla(rs.getString("talla"));
                d.setEstado(rs.getString("estado"));
                d.setUnidadNegocio(rs.getString("unidad_negocio"));
                lista.add(d);
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al obtener lista de detalles de devolución: " + e.getMessage());
        }

        return lista;
    }
}
