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
 * @author VALEN
 */

public class DiaFamilia {

    private String idDiaFamilia;
    private String identificacionPersona1; 
    private String diaDisfrutado;
    private String cartaFamilia;
    private String observacion;

    public DiaFamilia() {
    }

    public DiaFamilia(String idDiaFamilia) {
        String consultaSQL = "SELECT * FROM diaFamilia WHERE idDiaFamilia = '" + idDiaFamilia + "'";
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        try {
            if (resultado.next()) {
                this.idDiaFamilia = idDiaFamilia;
                identificacionPersona1 = resultado.getString("identificacionPersona1"); // CAMBIO AQUÍ
                diaDisfrutado = resultado.getString("diaDisfrutado");
                cartaFamilia = resultado.getString("cartaFamilia");
                observacion = resultado.getString("observacion");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar DiaFamilia: " + ex.getMessage());
        }
    }

    public String getIdDiaFamilia() {
        return idDiaFamilia;
    }

    public void setIdDiaFamilia(String idDiaFamilia) {
        this.idDiaFamilia = idDiaFamilia;
    }

    public String getIdentificacionPersona1() {
        return identificacionPersona1;
    }

    public void setIdentificacionPersona1(String identificacionPersona1) {
        this.identificacionPersona1 = identificacionPersona1;
    }

    public String getDiaDisfrutado() {
        return diaDisfrutado;
    }

    public void setDiaDisfrutado(String diaDisfrutado) {
        this.diaDisfrutado = diaDisfrutado;
    }

    public String getCartaFamilia() {
        return cartaFamilia;
    }

    public void setCartaFamilia(String cartaFamilia) {
        this.cartaFamilia = cartaFamilia;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public boolean grabar() {
        String consultaSQL = "INSERT INTO diaFamilia (identificacionPersona1, diaDisfrutado, cartaFamilia, observacion) VALUES (" // CAMBIO AQUÍ
                + "'" + identificacionPersona1 + "', "
                + (diaDisfrutado != null ? "'" + diaDisfrutado + "'" : "NULL") + ", "
                + (cartaFamilia != null ? "'" + cartaFamilia + "'" : "NULL") + ", "
                + (observacion != null ? "'" + observacion + "'" : "NULL") + ")";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar(String idAnterior) {
        String consultaSQL = "UPDATE diaFamilia SET "
                + "identificacionPersona1 = '" + identificacionPersona1 + "', " // CAMBIO AQUÍ
                + "diaDisfrutado = " + (diaDisfrutado != null ? "'" + diaDisfrutado + "'" : "NULL") + ", "
                + "cartaFamilia = " + (cartaFamilia != null ? "'" + cartaFamilia + "'" : "NULL") + ", "
                + "observacion = " + (observacion != null ? "'" + observacion + "'" : "NULL") + " "
                + "WHERE idDiaFamilia = '" + idAnterior + "'";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean eliminar(String idDiaFamilia) {
        String consultaSQL = "DELETE FROM diaFamilia WHERE idDiaFamilia = '" + idDiaFamilia + "'";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }


    public static ResultSet getLista() {
        String consultaSQL = "SELECT df.*, p.nombres, p.apellidos FROM diaFamilia df "
                + "JOIN persona p ON df.identificacionPersona1 = p.identificacion"; // CAMBIO AQUÍ
        return ConectorBD.consultar(consultaSQL);
    }

    public static List<DiaFamilia> getListaEnObjetos(String filtro, String orden) {
        List<DiaFamilia> lista = new ArrayList<>();
        String consultaSQL = "SELECT * FROM diaFamilia";

        if (filtro != null && !filtro.isEmpty()) {
            consultaSQL += " WHERE " + filtro;
        }
        if (orden != null && !orden.isEmpty()) {
            consultaSQL += " ORDER BY " + orden;
        }

        ResultSet rs = ConectorBD.consultar(consultaSQL);
        try {
            while (rs != null && rs.next()) {
                DiaFamilia df = new DiaFamilia();
                df.setIdDiaFamilia(rs.getString("idDiaFamilia"));
                df.setIdentificacionPersona1(rs.getString("identificacionPersona1")); 
                df.setDiaDisfrutado(rs.getString("diaDisfrutado"));
                df.setCartaFamilia(rs.getString("cartaFamilia"));
                df.setObservacion(rs.getString("observacion"));
                lista.add(df);
            }
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener lista de días de familia: " + ex.getMessage());
        }

        return lista;
    }
}
