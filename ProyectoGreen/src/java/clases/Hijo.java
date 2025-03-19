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
/**
 *
 * @author Mary 
 */



public class Hijo {
    private String identificacion;
    private String nombres;
    private String fechaNacimiento;

    public Hijo() {}

    public Hijo(String identificacion) {
        String cadenaSQL = "SELECT identificacion, nombres, apellidos, fechaNacimiento FROM hijos WHERE identificacion='" + identificacion + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.identificacion = resultado.getString("identificacion");
                this.nombres = resultado.getString("nombres");
                this.fechaNacimiento = resultado.getString("fechaNacimiento");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el hijo: " + ex.getMessage());
        }
    }

    // Métodos getter y setter
    public String getIdentificacion() { return identificacion; }
    public void setIdentificacion(String identificacion) { this.identificacion = identificacion; }
    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }
    public String getFechaNacimiento() { return fechaNacimiento; }
    public void setFechaNacimiento(String fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }

    // Grabar hijo en la base de datos
    public boolean grabar() {
        String cadenaSQL = "INSERT INTO hijos (identificacion, nombres,  fechaNacimiento) "
                + "VALUES ('" + identificacion + "', '" + nombres + "',  '" + fechaNacimiento + "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    // Modificar un hijo existente
    public boolean modificar(String identificacionHijoAnterior) {
        String cadenaSQL = "UPDATE hijos SET nombres = '" + nombres + "', "
                + " fechaNacimiento = '" + fechaNacimiento + "' "
                + "WHERE identificacionHijoAnterior = '" + identificacionHijoAnterior + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    // Eliminar un hijo y su relación con la persona
    public static boolean eliminarPorIdentificacion(String identificacion) {
        String sqlRelacion = "DELETE FROM persona_hijos WHERE identificacionHijo = '" + identificacion + "'";
        boolean relacionEliminada = ConectorBD.ejecutarQuery(sqlRelacion);

        if (relacionEliminada) {
            String sqlHijo = "DELETE FROM hijos WHERE identificacion = '" + identificacion + "'";
            return ConectorBD.ejecutarQuery(sqlHijo);
        }
        return false;
    }

    // Obtener lista de hijos por filtros
    public static List<Hijo> getListaEnObjetos(String filtro, String orden) {
        List<Hijo> lista = new ArrayList<>();
        String cadenaSQL = "SELECT * FROM hijos";
        if (filtro != null && !filtro.isEmpty()) {
            cadenaSQL += " WHERE " + filtro;
        }
        if (orden != null && !orden.isEmpty()) {
            cadenaSQL += " ORDER BY " + orden;
        }

        ResultSet datos = ConectorBD.consultar(cadenaSQL);
        try {
            while (datos.next()) {
                Hijo hijo = new Hijo();
                hijo.setIdentificacion(datos.getString("identificacion"));
                hijo.setNombres(datos.getString("nombres"));
                hijo.setFechaNacimiento(datos.getString("fechaNacimiento"));
                lista.add(hijo);
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener lista de hijos: " + ex.getMessage());
        }
        return lista;
    }

    // Obtener los hijos de una persona
    public static List<Hijo> obtenerHijosDePersona(String identificacionPersona) {
    List<Hijo> lista = new ArrayList<>();
    String sqlHijos = "SELECT h.* FROM hijos h "
                    + "JOIN persona_hijos ph ON h.identificacion = ph.identificacionHijo "
                    + "WHERE ph.identificacionPersona = '" + identificacionPersona + "'";

    ResultSet datos = ConectorBD.consultar(sqlHijos);

    if (datos == null) {
        System.out.println("No se pudo obtener los hijos de la persona. Consulta: " + sqlHijos);
        return lista;
    }

    try {
        while (datos.next()) {
            Hijo hijo = new Hijo();
            hijo.setIdentificacion(datos.getString("identificacion"));
            hijo.setNombres(datos.getString("nombres"));
            hijo.setFechaNacimiento(datos.getString("fechaNacimiento"));
            lista.add(hijo);
        }
    } catch (SQLException ex) {
        System.out.println("Error al obtener los hijos de la persona: " + ex.getMessage());
    } finally {
        try {
            if (datos != null) {
                datos.close(); // Cerrar ResultSet
            }
        } catch (SQLException ex) {
            System.out.println("Error al cerrar ResultSet: " + ex.getMessage());
        }
    }
    return lista;
} }