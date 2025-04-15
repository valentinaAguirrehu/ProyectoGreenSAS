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
public class TipoPrenda {

    private String id;
    private String nombre;

    public TipoPrenda() {
    }

    public TipoPrenda(String id) {
        String cadenaSQL = "select id,nombre from tipoPrenda where id=" + id;
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);

        try {
            if (resultado.next()) {
                this.id = id;
                nombre = resultado.getString("nombre");
            }

        } catch (Exception e) {
            System.out.println("np");
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public static List<TipoPrenda> getListaEnObjetos() {
        List<TipoPrenda> lista = new ArrayList<>();
        String sql = "SELECT id, nombre FROM tipoPrenda ORDER BY nombre";
        ResultSet rs = ConectorBD.consultar(sql);

        try {
            while (rs.next()) {
                TipoPrenda tipo = new TipoPrenda();
                tipo.setId(rs.getString("id"));
                tipo.setNombre(rs.getString("nombre"));
                lista.add(tipo);
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error al obtener lista de tipoPrenda: " + e.getMessage());
        }

        return lista;
    }
}
