/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;

/**
 *
 * @author Angie
 */
public class Prenda {
    private String idPrenda;
    private String nombre;
    private String idTipoPrenda;

    public Prenda() {
    }

    public Prenda(String idPrenda) {
        String sql = "SELECT id_prenda, nombre, id_tipo_prenda FROM prenda WHERE id_prenda = " + idPrenda;
        ResultSet rs = ConectorBD.consultar(sql);

        try {
            if (rs.next()) {
                this.idPrenda = rs.getString("id_prenda");
                this.nombre = rs.getString("nombre");
                this.idTipoPrenda = rs.getString("id_tipo_prenda");
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al cargar Prenda por ID: " + e.getMessage());
        }
    }

    // Getters y Setters
    public String getIdPrenda() {
        return idPrenda;
    }

    public void setIdPrenda(String idPrenda) {
        this.idPrenda = idPrenda;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getIdTipoPrenda() {
        return idTipoPrenda;
    }

    public void setIdTipoPrenda(String idTipoPrenda) {
        this.idTipoPrenda = idTipoPrenda;
    }

    // Método para guardar una nueva prenda
     public boolean grabar() {
        String sql = "INSERT INTO prenda (nombre, id_tipo_prenda) VALUES ('" + nombre + "', " + idTipoPrenda + ")";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean modificar(String idAnterior) {
        String sql = "UPDATE prenda SET id_prenda = " + idPrenda + ", nombre = '" + nombre + "', id_tipo_prenda = " + idTipoPrenda +
                     " WHERE id_prenda = " + idAnterior;
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean eliminar(String id) {
        String sql = "DELETE FROM prenda WHERE id_prenda = " + id;
        return ConectorBD.ejecutarQuery(sql);
    }
    
    // Método para listar todas las prendas
    public static ResultSet getLista() {
    String cadenaSQL = "SELECT * FROM prenda";
    return ConectorBD.consultar(cadenaSQL);
}

    // Método para obtener todas las prendas
    public static java.util.List<Prenda> getListaEnObjetos(String filtro, String orden) {
        java.util.List<Prenda> lista = new java.util.ArrayList<>();
        String sql = "SELECT id_prenda, nombre, id_tipo_prenda FROM prenda";

        if (filtro != null && !filtro.isEmpty()) {
            sql += " WHERE " + filtro;
        }

        if (orden != null && !orden.isEmpty()) {
            sql += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(sql);

        try {
            while (rs.next()) {
                Prenda p = new Prenda();
                p.setIdPrenda(rs.getString("id_prenda"));
                p.setNombre(rs.getString("nombre"));
                p.setIdTipoPrenda(rs.getString("id_tipo_prenda"));
                lista.add(p);
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al obtener lista de prendas: " + e.getMessage());
        }

        return lista;
    }
}