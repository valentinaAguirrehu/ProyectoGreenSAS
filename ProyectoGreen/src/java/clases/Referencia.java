/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Mary
 */
public class Referencia {

    private String identificacion;
    private String primerRefNombre;
    private String primerRefParentezco;
    private String primerRefCelular;
    private String segundaRefNombre;
    private String segundaRefParentezco;
    private String segundaRefCelular;
    private String terceraRefNombre;
    private String terceraRefParentezco;
    private String terceraRefCelular;
    private String cuartaRefNombre;
    private String cuartaRefParentezco;
    private String cuartaRefCelular;

    
    
    
    public Referencia() {
    }

    public Referencia(String identificacion) {
        String cadenaSQL = "SELECT identificacion, "
                + "primerRefNombre, primerRefParentezco, primerRefCelular, "
                + "segundaRefNombre, segundaRefParentezco, segundaRefCelular, "
                + "terceraRefNombre, terceraRefParentezco, terceraRefCelular, "
                + "cuartaRefNombre, cuartaRefParentezco, cuartaRefCelular "
                + "FROM referencia WHERE identificacion = '" + identificacion + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.identificacion = identificacion;
                primerRefNombre = resultado.getString("primerRefNombre");
                primerRefParentezco = resultado.getString("primerRefParentezco");
                primerRefCelular = resultado.getString("primerRefCelular");
                segundaRefNombre = resultado.getString("segundaRefNombre");
                segundaRefParentezco = resultado.getString("segundaRefParentezco");
                segundaRefCelular = resultado.getString("segundaRefCelular");
                terceraRefNombre = resultado.getString("terceraRefNombre");
                terceraRefParentezco = resultado.getString("terceraRefParentezco");
                terceraRefCelular = resultado.getString("terceraRefCelular");
                cuartaRefNombre = resultado.getString("cuartaRefNombre");
                cuartaRefParentezco = resultado.getString("cuartaRefParentezco");
                cuartaRefCelular = resultado.getString("cuartaRefCelular");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar referencia: " + ex.getMessage());
        } finally {
            try {
                if (resultado != null) {
                    resultado.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar ResultSet de referencia: " + ex.getMessage());
            }
        }
    }

    public String getIdentificacion() {
        String resultado = identificacion;
        if (identificacion == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getPrimerRefNombre() {
        String resultado = primerRefNombre;
        if (primerRefNombre == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setPrimerRefNombre(String primerRefNombre) {
        this.primerRefNombre = primerRefNombre;
    }

    public String getPrimerRefParentezco() {
        String resultado = primerRefParentezco;
        if (primerRefParentezco == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setPrimerRefParentezco(String primerRefParentezco) {
        this.primerRefParentezco = primerRefParentezco;
    }

    public String getPrimerRefCelular() {
        String resultado = primerRefCelular;
        if (primerRefCelular == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setPrimerRefCelular(String primerRefCelular) {
        this.primerRefCelular = primerRefCelular;
    }

    public String getSegundaRefNombre() {
        String resultado = segundaRefNombre;
        if (segundaRefNombre == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setSegundaRefNombre(String segundaRefNombre) {
        this.segundaRefNombre = segundaRefNombre;
    }

    public String getSegundaRefParentezco() {
        String resultado = segundaRefParentezco;
        if (segundaRefParentezco == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setSegundaRefParentezco(String segundaRefParentezco) {
        this.segundaRefParentezco = segundaRefParentezco;
    }

    public String getSegundaRefCelular() {
        String resultado = segundaRefCelular;
        if (segundaRefCelular == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setSegundaRefCelular(String segundaRefCelular) {
        this.segundaRefCelular = segundaRefCelular;
    }

    public String getTerceraRefNombre() {
        String resultado = terceraRefNombre;
        if (terceraRefNombre == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTerceraRefNombre(String terceraRefNombre) {
        this.terceraRefNombre = terceraRefNombre;
    }

    public String getTerceraRefParentezco() {
        String resultado = terceraRefParentezco;
        if (terceraRefParentezco == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTerceraRefParentezco(String terceraRefParentezco) {
        this.terceraRefParentezco = terceraRefParentezco;
    }

    public String getTerceraRefCelular() {
        String resultado = terceraRefCelular;
        if (terceraRefCelular == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTerceraRefCelular(String terceraRefCelular) {
        this.terceraRefCelular = terceraRefCelular;
    }

    public String getCuartaRefNombre() {
        String resultado = cuartaRefNombre;
        if (cuartaRefNombre == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setCuartaRefNombre(String cuartaRefNombre) {
        this.cuartaRefNombre = cuartaRefNombre;
    }

    public String getCuartaRefParentezco() {
        String resultado = cuartaRefParentezco;
        if (cuartaRefParentezco == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setCuartaRefParentezco(String cuartaRefParentezco) {
        this.cuartaRefParentezco = cuartaRefParentezco;
    }

    public String getCuartaRefCelular() {
        String resultado = cuartaRefCelular;
        if (cuartaRefCelular == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setCuartaRefCelular(String cuartaRefCelular) {
        this.cuartaRefCelular = cuartaRefCelular;
    }

    public boolean grabar() {
        String cadenaSQL = "INSERT INTO referencia (identificacion, primerRefNombre, primerRefParentezco, primerRefCelular, "
                + "segundaRefNombre, segundaRefParentezco, segundaRefCelular, "
                + "terceraRefNombre, terceraRefParentezco, terceraRefCelular, "
                + "cuartaRefNombre, cuartaRefParentezco, cuartaRefCelular) VALUES ('"
                + identificacion + "', '"
                + primerRefNombre + "', '"
                + primerRefParentezco + "', '"
                + primerRefCelular + "', '"
                + segundaRefNombre + "', '"
                + segundaRefParentezco + "', '"
                + segundaRefCelular + "', "
                + (terceraRefNombre != null && !terceraRefNombre.isEmpty() ? "'" + terceraRefNombre + "'" : "NULL") + ", "
                + (terceraRefParentezco != null && !terceraRefParentezco.isEmpty() ? "'" + terceraRefParentezco + "'" : "NULL") + ", "
                + (terceraRefCelular != null && !terceraRefCelular.isEmpty() ? "'" + terceraRefCelular + "'" : "NULL") + ", "
                + (cuartaRefNombre != null && !cuartaRefNombre.isEmpty() ? "'" + cuartaRefNombre + "'" : "NULL") + ", "
                + (cuartaRefParentezco != null && !cuartaRefParentezco.isEmpty() ? "'" + cuartaRefParentezco + "'" : "NULL") + ", "
                + (cuartaRefCelular != null && !cuartaRefCelular.isEmpty() ? "'" + cuartaRefCelular + "'" : "NULL") + ");";

        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);
        System.out.println("insertar" + cadenaSQL);

        if (!resultado) {
            System.out.println("Error: No se pudo insertar la referencia en la BD");
            return false;
        }

        return true;
    }

    public boolean modificar(String identificacionAnterior) {
        if (identificacion == null || identificacionAnterior == null) {
            System.out.println("Error: identificacion o identificacionAnterior es null.");
            return false;
        }

        String cadenaSQL = "UPDATE referencia SET "
                + "identificacion='" + identificacion + "', "
                + "primerRefNombre=" + (primerRefNombre != null ? "'" + primerRefNombre + "'" : "NULL") + ", "
                + "primerRefParentezco=" + (primerRefParentezco != null ? "'" + primerRefParentezco + "'" : "NULL") + ", "
                + "primerRefCelular=" + (primerRefCelular != null ? "'" + primerRefCelular + "'" : "NULL") + ", "
                + "segundaRefNombre=" + (segundaRefNombre != null ? "'" + segundaRefNombre + "'" : "NULL") + ", "
                + "segundaRefParentezco=" + (segundaRefParentezco != null ? "'" + segundaRefParentezco + "'" : "NULL") + ", "
                + "segundaRefCelular=" + (segundaRefCelular != null ? "'" + segundaRefCelular + "'" : "NULL") + ", "
                + "terceraRefNombre=" + (terceraRefNombre != null ? "'" + terceraRefNombre + "'" : "NULL") + ", "
                + "terceraRefParentezco=" + (terceraRefParentezco != null ? "'" + terceraRefParentezco + "'" : "NULL") + ", "
                + "terceraRefCelular=" + (terceraRefCelular != null ? "'" + terceraRefCelular + "'" : "NULL") + ", "
                + "cuartaRefNombre=" + (cuartaRefNombre != null ? "'" + cuartaRefNombre + "'" : "NULL") + ", "
                + "cuartaRefParentezco=" + (cuartaRefParentezco != null ? "'" + cuartaRefParentezco + "'" : "NULL") + ", "
                + "cuartaRefCelular=" + (cuartaRefCelular != null ? "'" + cuartaRefCelular + "'" : "NULL") + " "
                + "WHERE identificacion='" + identificacionAnterior + "'";

        System.out.println("Consulta SQL de modificación: " + cadenaSQL);
                System.out.println("modificar" + cadenaSQL);

        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar() {
        String cadenaSQL = "DELETE FROM referencia WHERE identificacion = '" + identificacion + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !"".equals(filtro)) {
            filtro = " WHERE " + filtro;
        } else {
            filtro = " ";
        }
        if (orden != null && !"".equals(orden)) {
            orden = " ORDER BY " + orden;
        } else {
            orden = " ";
        }

        String cadenaSQL = "SELECT primerRefNombre, primerRefParentezco, primerRefCelular, "
                + "segundaRefNombre, segundaRefParentezco, segundaRefCelular, "
                + "terceraRefNombre, terceraRefParentezco, terceraRefCelular, "
                + "cuartaRefNombre, cuartaRefParentezco, cuartaRefCelular "
                + "FROM Referencia " + filtro + orden;

        System.out.println("Ejecutando consultaReferencia: " + cadenaSQL);
        return ConectorBD.consultar(cadenaSQL);
    }
public static Referencia getReferenciaPorIdentificacion(String identificacion) {
    Referencia referencia = null;
    String sql = "SELECT identificacion, primerRefNombre, primerRefParentezco, primerRefCelular, "
               + "segundaRefNombre, segundaRefParentezco, segundaRefCelular, "
               + "terceraRefNombre, terceraRefParentezco, terceraRefCelular, "
               + "cuartaRefNombre, cuartaRefParentezco, cuartaRefCelular "
               + "FROM referencia WHERE identificacion = " + identificacion;

    try {
        ResultSet rs = ConectorBD.consultar(sql);
        if (rs != null && rs.next()) {
            referencia = new Referencia();
            referencia.setIdentificacion(rs.getString("identificacion"));
            referencia.setPrimerRefNombre(rs.getString("primerRefNombre"));
            referencia.setPrimerRefParentezco(rs.getString("primerRefParentezco"));
            referencia.setPrimerRefCelular(rs.getString("primerRefCelular"));
            referencia.setSegundaRefNombre(rs.getString("segundaRefNombre"));
            referencia.setSegundaRefParentezco(rs.getString("segundaRefParentezco"));
            referencia.setSegundaRefCelular(rs.getString("segundaRefCelular"));
            referencia.setTerceraRefNombre(rs.getString("terceraRefNombre"));
            referencia.setTerceraRefParentezco(rs.getString("terceraRefParentezco"));
            referencia.setTerceraRefCelular(rs.getString("terceraRefCelular"));
            referencia.setCuartaRefNombre(rs.getString("cuartaRefNombre"));
            referencia.setCuartaRefParentezco(rs.getString("cuartaRefParentezco"));
            referencia.setCuartaRefCelular(rs.getString("cuartaRefCelular"));
        }
    } catch (Exception e) {
        System.out.println("❌ Error al consultar referencia: " + e.getMessage());
    }

    return referencia;
}

    public static List<Referencia> getListaEnObjetos(String filtro, String orden) throws SQLException {
        List<Referencia> lista = new ArrayList<>();
        try (ResultSet datos = Referencia.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    Referencia referencia = new Referencia();
                    referencia.setIdentificacion(datos.getString("identificacion"));
                    referencia.setPrimerRefNombre(datos.getString("primerRefNombre"));
                    referencia.setPrimerRefParentezco(datos.getString("primerRefParentezco"));
                    referencia.setPrimerRefCelular(datos.getString("primerRefCelular"));
                    referencia.setSegundaRefNombre(datos.getString("segundaRefNombre"));
                    referencia.setSegundaRefParentezco(datos.getString("segundaRefParentezco"));
                    referencia.setSegundaRefCelular(datos.getString("segundaRefCelular"));
                    referencia.setTerceraRefNombre(datos.getString("terceraRefNombre"));
                    referencia.setTerceraRefParentezco(datos.getString("terceraRefParentezco"));
                    referencia.setTerceraRefCelular(datos.getString("terceraRefCelular"));
                    referencia.setCuartaRefNombre(datos.getString("cuartaRefNombre"));
                    referencia.setCuartaRefParentezco(datos.getString("cuartaRefParentezco"));
                    referencia.setCuartaRefCelular(datos.getString("cuartaRefCelular"));

                    lista.add(referencia);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Educacion.class.getName()).log(Level.SEVERE, "Error al obtener lista de educación", e);
        }
        return lista;
    }

    public static List<String[]> getListaEnArreglosJS(String filtro, String orden) throws SQLException {
        List<String[]> lista = new ArrayList<>();
        try (ResultSet datos = Referencia.getLista(filtro, orden)) {  // Asegúrate de que la consulta se haga en la tabla correcta
            if (datos != null) {
                while (datos.next()) {
                    String[] persona = new String[]{
                        datos.getString("identificacion"),
                        datos.getString("primerRefNombre"),
                        datos.getString("primerRefParentezco"),
                        datos.getString("primerRefCelular"),
                        datos.getString("segundaRefNombre"),
                        datos.getString("segundaRefParentezco"),
                        datos.getString("segundaRefCelular"),
                        datos.getString("terceraRefNombre"),
                        datos.getString("terceraRefParentezco"),
                        datos.getString("terceraRefCelular"),
                        datos.getString("cuartaRefNombre"),
                        datos.getString("cuartaRefParentezco"),
                        datos.getString("cuartaRefCelular")
                    };
                    lista.add(persona);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Referencia.class.getName()).log(Level.SEVERE, "Error al obtener lista de personas en arreglo JS", e);
        }
        return lista;
    }
}
