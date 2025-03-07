/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;

/**
 *
 * @author Angie
 */
public class Dotacion {

    private String id;
    private String fechaIngreso;
    private String observaciones;
    private String prenda;
    private String estacion;
    private String talla;
    private String estado;
    private String cantidadExistente;

    public Dotacion() {
    }

    public Dotacion(String id) {
        String cadenaSQL = "select id, fechaIngreso, observaciones, prenda, estacion, talla, estado, cantidadExistente from dotacion where id=" + id;
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.id = id;
                fechaIngreso = resultado.getString("fechaIngreso");
                observaciones = resultado.getString("observaciones");
                prenda = resultado.getString("prenda");
                estacion = resultado.getString("estacion");
                talla = resultado.getString("talla");
                estado = resultado.getString("estado");
                cantidadExistente = resultado.getString("cantidadExistente");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar la identificacion" + ex.getMessage());
        }
    }

    public String getId() {
        if (id == null) {
            id = "";
        }
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFechaIngreso() {
        if (fechaIngreso == null) {
            fechaIngreso = "";
        }
        return fechaIngreso;
    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public String getObservaciones() {
        if (observaciones == null) {
            observaciones = "";
        }
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getPrenda() {
        if (prenda == null) {
            prenda = "";
        }
        return prenda;
    }

    public void setPrenda(String prenda) {
        this.prenda = prenda;
    }

    public String getEstacion() {
        if (estacion == null) {
            estacion = "";
        }
        return estacion;
    }

    public void setEstacion(String estacion) {
        this.estacion = estacion;
    }

    public String getTalla() {
        if (talla == null) {
            talla = "";
        }
        return talla;
    }

    public void setTalla(String talla) {
        this.talla = talla;
    }

    public String getEstado() {
        if (estado == null) {
            estado = "";
        }
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCantidadExistente() {
        if (cantidadExistente == null) {
            cantidadExistente = "";
        }
        return cantidadExistente;
    }

    public void setCantidadExistente(String cantidadExistente) {
        this.cantidadExistente = cantidadExistente;
    }

    @Override
    public String toString() {

        String datos = "";
        if (id != null) {
            datos = id + " - " + prenda;
        }
        return datos;
    }

    public boolean grabar() {
        String cadenaSQL = "insert into dotacion(id, fechaIngreso, observaciones, prenda, estacion, talla, estado, cantidadExistente) "
                + "values ('" + id + "', '" + fechaIngreso + "', '" + observaciones + "', '" + prenda + "', '" + estacion + "', '" + talla + "', '" + estado + "', '" + cantidadExistente + "')";

        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar(String idAnterior) {
        String cadenaSQL = "update dotacion set id='" + id + "', fechaIngreso='" + fechaIngreso + "', observaciones='" + observaciones + "', prenda='" + prenda + "', estacion='" + estacion + "', talla='" + talla + "', estado='" + estado + "', cantidadExistente='" + cantidadExistente + "' "
                + "where id='" + idAnterior + "'";

        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar() {
        String cadenaSQL = "delete from dotacion where id=" + id;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !"".equals(filtro)) {
            filtro = " where " + filtro;
        } else {
            filtro = " ";
        }
        if (orden != null && !"".equals(orden)) {
            orden = " order by " + orden;
        } else {
            orden = " ";
        }

        String cadenaSQL = "SELECT id, fechaIngreso, observaciones, prenda, estacion, talla, estado, cantidadExistente FROM dotacion" + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }

}
