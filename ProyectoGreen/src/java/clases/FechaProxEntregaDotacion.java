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
public class FechaProxEntregaDotacion {

    private String id;
    private String fecha_admin;
    private String fecha_operativo;

    public FechaProxEntregaDotacion() {
    }

    public FechaProxEntregaDotacion(String id) {
        String cadenaSQL = "select id,fecha_admin,fecha_operativo from fechaProximaEntregaGeneral where id=" + id;
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);

        try {
            if (resultado.next()) {
                this.id = id;
                fecha_admin = resultado.getString("fecha_admin");
                fecha_operativo = resultado.getString("fecha_operativo");
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

    public String getFecha_admin() {
        return fecha_admin;
    }

    public void setFecha_admin(String fecha_admin) {
        this.fecha_admin = fecha_admin;
    }

    public String getFecha_operativo() {
        return fecha_operativo;
    }

    public void setFecha_operativo(String fecha_operativo) {
        this.fecha_operativo = fecha_operativo;
    }

    public boolean modificar(String idAnterior) {
        String cadenaSQL = "UPDATE fechaProximaEntregaGeneral SET id='" + id
                + "', fecha_admin='" + fecha_admin + "', fecha_operativo='" + fecha_operativo + "'"
                + " WHERE id=" + idAnterior;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static String obtenerUltimaFechaAdmin() {
        String sql = "SELECT fecha_admin FROM fechaProximaEntregaGeneral WHERE fecha_admin IS NOT NULL ORDER BY id DESC LIMIT 1";
        ResultSet rs = ConectorBD.consultar(sql);
        try {
            if (rs.next()) {
                return rs.getString("fecha_admin");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String obtenerUltimaFechaOperativo() {
        String sql = "SELECT fecha_operativo FROM fechaProximaEntregaGeneral WHERE fecha_operativo IS NOT NULL ORDER BY id DESC LIMIT 1";
        ResultSet rs = ConectorBD.consultar(sql);
        try {
            if (rs.next()) {
                return rs.getString("fecha_operativo");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
