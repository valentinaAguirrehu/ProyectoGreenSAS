/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;


import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Mary 
 */

public class Hijos {
    private String id;
    private String nombre;
    private String fechaNacimiento;

    public Hijos() {
    }

    public Hijos(String id) {
        this.id = id;
        String cadenaSQL = "select nombre, fechaNacimiento from hijos where id='" + id + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.id = id;
                nombre = resultado.getString("nombre");
                fechaNacimiento = resultado.getString("fechaNacimiento");
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener la información del hijo: " + ex.getMessage());
        }
    }

    public String getId() {
        String resultado = id;
        if (id == null) resultado = "";
        return resultado;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        String resultado = nombre;
        if (nombre == null) resultado = "";
        return resultado;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getFechaNacimiento() {
        String resultado = fechaNacimiento;
        if (fechaNacimiento == null) resultado = "";
        return resultado;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    @Override
    public String toString() {
        return nombre;
    }

    public boolean grabar() {
        String cadenaSQL = "insert into hijos(nombre, fechaNacimiento) "
                + "values ('" + nombre + "', '" + fechaNacimiento + "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar() {
        String cadenaSQL = "update hijos set nombre='" + nombre + "', "
                + "fechaNacimiento='" + fechaNacimiento + "' "
                + "where id='" + id + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar() {
        String cadenaSQL = "delete from hijos where id='" + id + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !filtro.trim().isEmpty()) {
            filtro = " where " + filtro;
        } else {
            filtro = "";
        }
        if (orden != null && !orden.trim().isEmpty()) {
            orden = " order by " + orden;
        } else {
            orden = "";
        }
        String cadenaSQL = "select id, nombre, fechaNacimiento from hijos " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Hijos> getListaEnObjetos(String filtro, String orden) {
        List<Hijos> lista = new ArrayList<>();
        ResultSet datos = Hijos.getLista(filtro, orden);
        if (datos != null) {
            try {
                while (datos.next()) {
                    Hijos hijo = new Hijos();
                    hijo.setId(datos.getString("id"));
                    hijo.setNombre(datos.getString("nombre"));
                    hijo.setFechaNacimiento(datos.getString("fechaNacimiento"));
                    lista.add(hijo);
                }
            } catch (SQLException ex) {
                Logger.getLogger(Hijos.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }

    public static String getListaEnOptions(String preseleccionado) {
        String lista = "";
        List<Hijos> datos = Hijos.getListaEnObjetos(null, "nombre");
        for (int i = 0; i < datos.size(); i++) {
            Hijos hijo = datos.get(i);
            String auxiliar = "";
            if (preseleccionado.equals(hijo.getId())) auxiliar = " selected";
            lista += "<option value='" + hijo.getId() + "' " + auxiliar + ">" + hijo.getNombre() + "</option>";
        }
        return lista;
    }
}
