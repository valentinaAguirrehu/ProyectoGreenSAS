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
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class Hijo {

    private String identificacion;
    private String nombres;
    private String fechaNacimiento;
    private String codigo;

    /**
     *
     * @author Mary
     */
    public Hijo() {
    }

    public Hijo(String identificacion) {
        String cadenaSQL = "SELECT identificacion, nombres, fechaNacimiento FROM hijos WHERE identificacion='" + identificacion + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.identificacion = resultado.getString("identificacion");
                this.nombres = resultado.getString("nombres");
                this.fechaNacimiento = resultado.getString("fechaNacimiento");
                this.codigo = "N"; // Evitar NullPointerException
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el hijo: " + ex.getMessage());
        }
    }

      public String calcularEdad() {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate fechaNac = LocalDate.parse(this.fechaNacimiento, formatter);
            int edad = Period.between(fechaNac, LocalDate.now()).getYears();
            return edad >= 0 ? edad + " años" : "Fecha inválida";
        } catch (Exception e) {
            return "Fecha inválida";
        }
    }
    
    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getCodigo() {
        return (codigo == null) ? "" : codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getOpcion() {
        switch (codigo) {
            case "S":
                return "Sí";
            case "N":
                return "No";
            default:
                return "No Especificado";
        }
    }

    @Override
    public String toString() {
        return getOpcion();
    }

    public String getRadioButtons() {
        if (codigo == null || codigo.isEmpty()) {
            codigo = "N";
        }
        return (codigo.equals("S"))
                ? "<input type='radio' name='tieneHijos' value='S' checked onclick='mostrarHijos()'>Sí"
                + "<input type='radio' name='tieneHijos' value='N' onclick='mostrarHijos()'>No"
                : "<input type='radio' name='tieneHijos' value='S' onclick='mostrarHijos()'>Sí"
                + "<input type='radio' name='tieneHijos' value='N' checked onclick='mostrarHijos()'>No";
    }

    public boolean grabar() {
    String sql = "INSERT INTO hijos (identificacion, nombres, fechaNacimiento) VALUES ("
            + "'" + identificacion + "', "
            + "'" + nombres + "', "
            + "'" + fechaNacimiento + "')";

    System.out.println("SQL para insertar hijo: " + sql);
    return ConectorBD.ejecutarQuery(sql);
}


    public boolean modificar(String identificacionHijoAnterior) {
        String cadenaSQL = "UPDATE hijos SET nombres = '" + nombres + "', fechaNacimiento = '" + fechaNacimiento + "' "
                + "WHERE identificacion = '" + identificacionHijoAnterior + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static boolean eliminarPorIdentificacion(String identificacion) {
        String sqlRelacion = "DELETE FROM persona_hijos WHERE identificacionHijo = '" + identificacion + "'";
        boolean relacionEliminada = ConectorBD.ejecutarQuery(sqlRelacion);
        if (relacionEliminada) {
            String sqlHijo = "DELETE FROM hijos WHERE identificacion = '" + identificacion + "'";
            return ConectorBD.ejecutarQuery(sqlHijo);
        }
        return false;
    }

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
                    datos.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar ResultSet: " + ex.getMessage());
            }
        }
        return lista;
    }
}