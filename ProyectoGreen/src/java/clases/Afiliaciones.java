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
 * @author VALEN
 */
public class Afiliaciones {
    private String id;
    private String eps;
    private String arl;
    private String fdp;
    private String ccf;

    public Afiliaciones() {
    }

    public Afiliaciones(String id) {
        String consultaSQL = "SELECT id, eps, arl, fdp, ccf FROM afiliaciones WHERE id = " + id;
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        try {
            if (resultado.next()) {
                this.id = id;
                eps = resultado.getString("eps");
                arl = resultado.getString("arl");
                fdp = resultado.getString("fdp");
                ccf = resultado.getString("ccf");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el ID: " + ex.getMessage());
        }
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEps() {
        return eps;
    }

    public void setEps(String eps) {
        this.eps = eps;
    }

    public String getArl() {
        return arl;
    }

    public void setArl(String arl) {
        this.arl = arl;
    }

    public String getFdp() {
        return fdp;
    }

    public void setFdp(String fdp) {
        this.fdp = fdp;
    }

    public String getCcf() {
        return ccf;
    }

    public void setCcf(String ccf) {
        this.ccf = ccf;
    }
    
    
     public boolean grabar() {
        String consultaSQL = "INSERT INTO afiliaciones (id, eps, arl, fdp, ccf) VALUES ('" +
                id + "', '" + eps + "', '" + arl + "', '" + fdp + "', '" + ccf + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "UPDATE afiliaciones SET " +
                "eps = '" + eps + "', " +
                "arl = '" + arl + "', " +
                "fdp = '" + fdp + "', " +
                "ccf = '" + ccf + "' " +
                "WHERE id = '" + id + "'";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }
    
        public boolean eliminar() {
        String consultaSQL = "delete from afiliaciones where id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
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
        String cadenaSQL = "SELECT id, eps, arl, fdp, ccf FROM afiliaciones " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }
      public static List<Afiliaciones> getListaEnObjetos(String filtro, String orden) {
        List<Afiliaciones> lista = new ArrayList<>();
        ResultSet datos = Afiliaciones.getLista(filtro, orden); // Asumiendo que tienes un método getLista en Afiliaciones
        if (datos != null) {
            try {
                while (datos.next()) {
                    Afiliaciones afiliacion = new Afiliaciones();
                    afiliacion.setId(datos.getString("id"));
                    afiliacion.setEps(datos.getString("eps"));
                    afiliacion.setArl(datos.getString("arl"));
                    afiliacion.setFdp(datos.getString("fdp"));
                    afiliacion.setCcf(datos.getString("ccf"));

                    lista.add(afiliacion);
                }
            } catch (SQLException ex) {
                Logger.getLogger(Afiliaciones.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }

}
