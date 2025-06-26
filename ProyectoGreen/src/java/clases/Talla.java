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
public class Talla {

    private String identificacion;
    private String tallaCamisa;
    private String tallaChaqueta;
    private String tallaO;
    private String tallaPantalon;
    private String tallaCalzado;
    private String tallaGuantes;
    private String tallaBuzo;

    public Talla() {
    }

    public Talla(String identificacion) {
        String cadenaSQL = "SELECT * FROM talla WHERE identificacion = '" + identificacion + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.identificacion = identificacion;
                tallaCamisa = resultado.getString("tallaCamisa");
                tallaChaqueta = resultado.getString("tallaChaqueta");
                tallaO = resultado.getString("tallaO");
                tallaPantalon = resultado.getString("tallaPantalon");
                tallaCalzado = resultado.getString("tallaCalzado");
                tallaGuantes = resultado.getString("tallaGuantes");
                tallaBuzo = resultado.getString("tallaBuzo");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar talla: " + ex.getMessage());
        } finally {
            try {
                if (resultado != null) {
                    resultado.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar ResultSet de talla: " + ex.getMessage());
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

//    public String getTallaCamisa() {
//        String resultado = tallaCamisa;
//        if (tallaCamisa == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public TipoMedidaTalla getTallaCamisa() {
        return new TipoMedidaTalla(tallaCamisa);
    }

    public void setTallaCamisa(String tallaCamisa) {
        this.tallaCamisa = tallaCamisa;
    }

//    public String getTallaChaqueta() {
//        String resultado = tallaChaqueta;
//        if (tallaChaqueta == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public TipoMedidaTalla getTallaChaqueta() {
        return new TipoMedidaTalla(tallaChaqueta);
    }

    public void setTallaChaqueta(String tallaChaqueta) {
        this.tallaChaqueta = tallaChaqueta;
    }

//    public String getTallaPantalon() {
//        String resultado = tallaPantalon;
//        if (tallaPantalon == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public TipoMedidaTallaNumerica getTallaPantalon() {
        return new TipoMedidaTallaNumerica(tallaPantalon);
    }

    public void setTallaPantalon(String tallaPantalon) {
        this.tallaPantalon = tallaPantalon;
    }

//    public String getTallaCalzado() {
//        String resultado = tallaCalzado;
//        if (tallaCalzado == null) {
//            resultado = null;
//        }
//        return resultado;
//    }
    public TipoMedidaZapato getTallaCalzado() {
        return new TipoMedidaZapato(tallaCalzado);
    }

    public void setTallaCalzado(String tallaCalzado) {
        this.tallaCalzado = tallaCalzado;
    }

//    public String getTallaGuantes() {
//        String resultado = tallaGuantes;
//        if (tallaGuantes == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public TipoMedidaTalla getTallaGuantes() {
        return new TipoMedidaTalla(tallaGuantes);
    }

    public void setTallaGuantes(String tallaGuantes) {
        this.tallaGuantes = tallaGuantes;
    }

//    public String getTallaBuzo() {
//        String resultado = tallaBuzo;
//        if (tallaBuzo == null) {
////            resultado = "";
//        }
//        return resultado;
//    }
    public TipoMedidaTalla getTallaBuzo() {
        return new TipoMedidaTalla(tallaBuzo);
    }

    public void setTallaBuzo(String tallaBuzo) {
        this.tallaBuzo = tallaBuzo;
    }

//    public String getTallaO() {
//        String resultado = tallaO;
//        if (tallaO == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public TipoMedidaTalla getTallaO() {
        return new TipoMedidaTalla(tallaO);
    }

    public void setTallaO(String tallaO) {
        this.tallaO = tallaO;
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
        String cadenaSQL = "INSERT INTO talla (identificacion, tallaCamisa, tallaChaqueta, tallaO, tallaPantalon, "
                + "tallaCalzado, tallaGuantes, tallaBuzo) VALUES ("
                + identificacion + ", '"
                + tallaCamisa + "', '"
                + tallaChaqueta + "', '"
                + tallaO + "', '"
                + tallaPantalon + "', '"
                + tallaCalzado + "', '"
                + tallaGuantes + "', '"
                + tallaBuzo + "');";

        out.println(cadenaSQL);
        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);

        if (!resultado) {
            System.out.println("Error: No se pudo insertar la talla en la BD");
            return false;
        }

        return true;
    }

    public boolean modificar(String identificacionAnterior) {
        if (identificacion == null || identificacionAnterior == null) {
            System.out.println("Error: identificacion o identificacionAnterior es null.");
            return false;
        }

        String cadenaSQL = "UPDATE talla SET "
                + "identificacion='" + identificacion + "', "
                + "tallaCamisa=" + (tallaCamisa != null ? "'" + tallaCamisa + "'" : "NULL") + ", "
                + "tallaChaqueta=" + (tallaChaqueta != null ? "'" + tallaChaqueta + "'" : "NULL") + ", "
                + "tallaO=" + (tallaO != null ? "'" + tallaO + "'" : "NULL") + ", "
                // aquí quitamos las comillas para enteros
                + "tallaPantalon=" + (tallaPantalon != null ? "'" + tallaPantalon + "'" : "NULL") + ", "
                + "tallaCalzado=" + (tallaCalzado != null ? "'" + tallaCalzado + "'" : "NULL") + ", "
                + "tallaGuantes=" + (tallaGuantes != null ? "'" + tallaGuantes + "'" : "NULL") + ", "
                + "tallaBuzo=" + (tallaBuzo != null ? "'" + tallaBuzo + "'" : "NULL") + " "
                + "WHERE identificacion='" + identificacionAnterior + "'";

        System.out.println("Consulta SQL de modificación: " + cadenaSQL);
        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);

        return resultado;
    }

    public boolean eliminar() {
        String cadenaSQL = "DELETE FROM talla WHERE identificacion = '" + identificacion + "'";

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

        String cadenaSQL = "SELECT identificacion, tallaCamisa, tallaChaqueta, tallaO, tallaPantalon, tallaCalzado, tallaGuantes, tallaBuzo FROM talla " + filtro + orden;

        System.out.println("Ejecutando consulta: " + cadenaSQL);
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Talla> getListaEnObjetos(String filtro, String orden) throws SQLException {
        List<Talla> lista = new ArrayList<>();
        try (ResultSet datos = Talla.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    Talla talla = new Talla();
                    talla.setIdentificacion(datos.getString("identificacion"));
                    talla.setTallaCamisa(datos.getString("tallaCamisa"));
                    talla.setTallaChaqueta(datos.getString("tallaChaqueta"));
                    talla.setTallaO(datos.getString("tallaO"));
                    talla.setTallaPantalon(datos.getString("tallaPantalon"));
                    talla.setTallaCalzado(datos.getString("tallaCalzado"));
                    talla.setTallaGuantes(datos.getString("tallaGuantes"));
                    talla.setTallaBuzo(datos.getString("tallaBuzo"));

                    lista.add(talla);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Talla.class.getName()).log(Level.SEVERE, "Error al obtener lista de tallas", e);
        }
        return lista;
    }

    public static Talla getTallaPorIdentificacion(String identificacion) {
        Talla talla = null;
        String sql = "SELECT identificacion, tallaCamisa, tallaChaqueta, tallaO, tallaPantalon, tallaCalzado, tallaGuantes, tallaBuzo "
                + "FROM talla WHERE identificacion = " + identificacion;

        try {
            ResultSet rs = ConectorBD.consultar(sql);
            if (rs != null && rs.next()) {
                talla = new Talla();
                talla.setIdentificacion(rs.getString("identificacion"));
                talla.setTallaCamisa(rs.getString("tallaCamisa"));
                talla.setTallaChaqueta(rs.getString("tallaChaqueta"));
                talla.setTallaO(rs.getString("tallaO"));
                talla.setTallaPantalon(rs.getString("tallaPantalon"));
                talla.setTallaCalzado(rs.getString("tallaCalzado"));
                talla.setTallaGuantes(rs.getString("tallaGuantes"));
                talla.setTallaBuzo(rs.getString("tallaBuzo"));
            }
        } catch (Exception e) {
            System.out.println("❌ Error al consultar las tallas: " + e.getMessage());
        }

        return talla;
    }

    public static List<String[]> getListaEnArreglosJS(String filtro, String orden) throws SQLException {
        List<String[]> lista = new ArrayList<>();
        try (ResultSet datos = Talla.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    String[] talla = new String[]{
                        datos.getString("identificacion"),
                        datos.getString("tallaCamisa"),
                        datos.getString("tallaChaqueta"),
                        datos.getString("tallaO"),
                        datos.getString("tallaPantalon"),
                        datos.getString("tallaCalzado"),
                        datos.getString("tallaGuantes"),
                        datos.getString("tallaBuzo")
                    };
                    lista.add(talla);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Talla.class.getName()).log(Level.SEVERE, "Error al obtener lista de tallas en arreglo JS", e);
        }
        return lista;
    }

}
