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
public class DetalleEntrega {
    
    private String idDetalleEntrega;
    private String idEntrega;
    private String idPrenda;
    private String talla;
    private String estado;
    private String unidadNegocio;

    // Getters y Setters
    public String getIdDetalleEntrega() {
        return idDetalleEntrega;
    }

    public void setIdDetalleEntrega(String idDetalleEntrega) {
        this.idDetalleEntrega = idDetalleEntrega;
    }

    public String getIdEntrega() {
        return idEntrega;
    }

    public void setIdEntrega(String idEntrega) {
        this.idEntrega = idEntrega;
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

    // Método para insertar un nuevo detalle
    public boolean grabar() {
        String sql = "INSERT INTO detalleEntrega (id_entrega, id_prenda, talla, estado, unidad_negocio) " +
                     "VALUES ('" + idEntrega + "', '" + idPrenda + "', '" + talla + "', '" + estado + "', '" + unidadNegocio + "')";
        return ConectorBD.ejecutarQuery(sql);
    }

    // Método para modificar un detalle existente
    public boolean modificar(String idAnterior) {
        String sql = "UPDATE detalleEntrega SET id_entrega='" + idEntrega + "', id_prenda='" + idPrenda +
                     "', talla='" + talla + "', estado='" + estado + "', unidad_negocio='" + unidadNegocio +
                     "' WHERE id_detalle_entrega=" + idAnterior;
        return ConectorBD.ejecutarQuery(sql);
    }

    // Método para eliminar un detalle por su ID
    public boolean eliminar(String id) {
        String sql = "DELETE FROM detalleEntrega WHERE id_detalle_entrega=" + id;
        return ConectorBD.ejecutarQuery(sql);
    }

    // Obtener lista de detalles con filtro y orden opcionales
    public static List<DetalleEntrega> getListaEnObjetos(String filtro, String orden) {
        List<DetalleEntrega> lista = new ArrayList<>();
        String sql = "SELECT * FROM detalleEntrega";

        if (filtro != null && !filtro.isEmpty()) {
            sql += " WHERE " + filtro;
        }

        if (orden != null && !orden.isEmpty()) {
            sql += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(sql);
        try {
            while (rs.next()) {
                DetalleEntrega d = new DetalleEntrega();
                d.setIdDetalleEntrega(rs.getString("id_detalle_entrega"));
                d.setIdEntrega(rs.getString("id_entrega"));
                d.setIdPrenda(rs.getString("id_prenda"));
                d.setTalla(rs.getString("talla"));
                d.setEstado(rs.getString("estado"));
                d.setUnidadNegocio(rs.getString("unidad_negocio"));
                lista.add(d);
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al obtener la lista de detalles: " + e.getMessage());
        }

        return lista;
    }
}
