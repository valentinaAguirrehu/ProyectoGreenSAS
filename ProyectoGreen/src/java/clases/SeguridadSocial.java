/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import static java.lang.System.out;
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
public class SeguridadSocial {

    private String identificacion;
    private String eps;
    private String arl;
    private String fondoPensiones;
    private String fondoCesantias;

    public SeguridadSocial() {
    }

    public SeguridadSocial(String identificacion) {
        String cadenaSQL = "SELECT * FROM seguridadSocial WHERE identificacion = '" + identificacion + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.identificacion = identificacion;
                eps = resultado.getString("eps");
                fondoPensiones = resultado.getString("fondoPensiones");
                fondoCesantias = resultado.getString("fondoCesantias");
                arl = resultado.getString("arl");

            }
        } catch (SQLException ex) {
                    out.println("Ejecutando consultaSeguridadSocial: " + cadenaSQL);
        } finally {
            try {
                if (resultado != null) {
                    resultado.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar ResultSet de seguridadSocial: " + ex.getMessage());
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

//    public String getEps() {
//        String resultado = eps;
//        if (eps == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public Eps getEps() {
        return new Eps(eps);
    }

    public void setEps(String eps) {
        this.eps = eps;
    }

//    public String getFondoPensiones() {
//        String resultado = fondoPensiones;
//        if (fondoPensiones == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public FondoPensiones getFondoPensiones() {
        return new FondoPensiones(fondoPensiones);
    }

    public void setFondoPensiones(String fondoPensiones) {
        this.fondoPensiones = fondoPensiones;
    }

//    public String getFondoCesantias() {
//        String resultado = fondoCesantias;
//        if (fondoCesantias == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public FondoCesantias getFondoCesantias() {
        return new FondoCesantias(fondoCesantias);
    }

    public void setFondoCesantias(String fondoCesantias) {
        this.fondoCesantias = fondoCesantias;
    }

//    public String getArl() {
//        String resultado = arl;
//        if (arl == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public Arl getArl() {
        return new Arl(arl);
    }

    public void setArl(String arl) {
        this.arl = arl;
    }

    @Override
    public String toString() {

        String datos = "";
        if (identificacion != null) {
            datos = identificacion;
        }
        return datos;
    }

    public boolean grabar() {
        String cadenaSQL = "INSERT INTO seguridadSocial ("
                + "identificacion, eps, fondoPensiones, fondoCesantias, arl) VALUES ('"
                + identificacion + "', '" + eps + "', '"
                + fondoPensiones + "', '" + fondoCesantias + "', '"
                + arl + "');";

        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);
        System.out.println(cadenaSQL);

        if (!resultado) {
            System.out.println("Error: No se pudo insertar la seguridadSocial en la BD");
            return false;
        }

        return true;
    }

    public boolean modificar(String identificacionAnterior) {
        if (identificacion == null || identificacionAnterior == null) {
            System.out.println("Error: identificacion o identificacionAnterior es null.");
            return false;
        }

        String cadenaSQL = "UPDATE seguridadSocial SET "
                + "identificacion='" + identificacion + "', "
                + "eps=" + (eps != null ? "'" + eps + "'" : "NULL") + ", "
                + "fondoPensiones=" + (fondoPensiones != null ? "'" + fondoPensiones + "'" : "NULL") + ", "
                + "fondoCesantias=" + (fondoCesantias != null ? "'" + fondoCesantias + "'" : "NULL") + ", "
                + "arl=" + (arl != null ? "'" + arl + "'" : "NULL") + " "
                + "WHERE identificacion='" + identificacionAnterior + "'";

        System.out.println("SQL MODIFICAR: " + cadenaSQL);
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar() {
        String cadenaSQL = "DELETE FROM seguridadSocial WHERE identificacion = '" + identificacion + "'";
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

        String cadenaSQL = "SELECT identificacion, eps, fondoPensiones, fondoCesantias, arl FROM seguridadSocial"
                + filtro + orden;

        System.out.println("Ejecutando consulta: " + cadenaSQL);
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<SeguridadSocial> getListaEnObjetos(String filtro, String orden) throws SQLException {
        List<SeguridadSocial> lista = new ArrayList<>();
        try (ResultSet datos = SeguridadSocial.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    SeguridadSocial seguridadSocial = new SeguridadSocial();
                    seguridadSocial.setIdentificacion(datos.getString("identificacion"));
                    seguridadSocial.setEps(datos.getString("eps"));
                    seguridadSocial.setFondoPensiones(datos.getString("fondoPensiones"));
                    seguridadSocial.setFondoCesantias(datos.getString("fondoCesantias"));
                    seguridadSocial.setArl(datos.getString("arl"));

                    lista.add(seguridadSocial);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(SeguridadSocial.class.getName()).log(Level.SEVERE, "Error al obtener lista de seguridad social", e);
        }
        return lista;
    }

    public static List<String[]> getListaEnArreglosJS(String filtro, String orden) throws SQLException {
        List<String[]> lista = new ArrayList<>();
        try (ResultSet datos = SeguridadSocial.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    String[] seguridadSocial = new String[]{
                        datos.getString("identificacion"),
                        datos.getString("eps"),
                        datos.getString("fondoPensiones"),
                        datos.getString("fondoCesantias"),
                        datos.getString("arl")
                    };
                    lista.add(seguridadSocial);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(SeguridadSocial.class.getName()).log(Level.SEVERE, "Error al obtener lista de seguridadSocial en arreglo JS", e);
        }
        return lista;
    }

    public static SeguridadSocial getSeguridadSocialPorIdentificacion(String identificacion) {
        SeguridadSocial seguridadSocial = null;
        String sql = "SELECT identificacion, eps, fondoPensiones, fondoCesantias, arl FROM seguridadSocial WHERE identificacion = '" + identificacion + "'";

        try {
            // Ejecutamos la consulta usando el método ConectorBD.consultar
            ResultSet rs = ConectorBD.consultar(sql);
            if (rs != null && rs.next()) {
                seguridadSocial = new SeguridadSocial();
                seguridadSocial.setIdentificacion(rs.getString("identificacion"));
                seguridadSocial.setEps(rs.getString("eps"));
                seguridadSocial.setFondoPensiones(rs.getString("fondoPensiones"));
                seguridadSocial.setFondoCesantias(rs.getString("fondoCesantias"));
                seguridadSocial.setArl(rs.getString("arl"));
            }
        } catch (Exception e) {
            System.out.println("❌ Error al consultar seguridad social por identificacion: " + e.getMessage());
        }

        return seguridadSocial;
    }

}
