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
public class InventarioDotacion {

    private String idInventario;
    private String idPrenda;
    private String talla;
    private String cantidad;
    private String estado;
    private String unidadNegocio;
    private String fechaIngreso;
    private String jsonPrendas;

    // Getters y Setters
    public String getIdInventario() {
        return idInventario;
    }

    public void setIdInventario(String idInventario) {
        this.idInventario = idInventario;
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

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
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

    public String getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public void setJsonPrendas(String jsonPrendas) {
        this.jsonPrendas = jsonPrendas;
    }

    // Métodos para base de datos
    public boolean grabar() {
        String sql = "INSERT INTO inventarioDotacion (id_prenda, talla, cantidad, estado, unidad_negocio, fecha_ingreso) "
                + "VALUES ('" + idPrenda + "', '" + talla + "', " + cantidad + ", '" + estado + "', '" + unidadNegocio + "', '" + fechaIngreso + "')";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean modificar(String idAnterior) {
        String sql = "UPDATE inventarioDotacion SET id_prenda='" + idPrenda + "', talla='" + talla + "', cantidad=" + cantidad
                + ", estado='" + estado + "', unidad_negocio='" + unidadNegocio + "', fecha_ingreso='" + fechaIngreso
                + "' WHERE id_inventario=" + idAnterior;
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean eliminar(String id) {
        String sql = "DELETE FROM inventarioDotacion WHERE id_inventario=" + id;
        return ConectorBD.ejecutarQuery(sql);
    }

    public static List<InventarioDotacion> getListaEnObjetos(String filtro, String orden) {
        List<InventarioDotacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM inventarioDotacion";

        if (filtro != null && !filtro.isEmpty()) {
            sql += " WHERE " + filtro;
        }
        if (orden != null && !orden.isEmpty()) {
            sql += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(sql);
        try {
            while (rs.next()) {
                InventarioDotacion i = new InventarioDotacion();
                i.setIdInventario(rs.getString("id_inventario"));
                i.setIdPrenda(rs.getString("id_prenda"));
                i.setTalla(rs.getString("talla"));
                i.setCantidad(rs.getString("cantidad"));
                i.setEstado(rs.getString("estado"));
                i.setUnidadNegocio(rs.getString("unidad_negocio"));
                i.setFechaIngreso(rs.getString("fecha_ingreso"));
                lista.add(i);
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al obtener la lista: " + e.getMessage());
        }

        return lista;
    }

    public boolean agregarPrendasMultiples() {
    try {
        // Llamada al procedimiento con el JSON generado en el JSP
        String sql = "CALL agregar_prendas_multiples('" + this.jsonPrendas + "')";
        return ConectorBD.ejecutarQuery(sql);
    } catch (Exception e) {
        System.out.println("Error al agregar prendas: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}

}
