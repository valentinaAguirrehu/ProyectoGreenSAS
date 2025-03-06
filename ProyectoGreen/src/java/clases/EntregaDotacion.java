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
public class EntregaDotacion {
    private String id;
    private String identificacionPersona;
    private String idDotacion;
    private String fechaEntrega;
    private String fechaProxEntrega;
    private String prenda;
    private String estacion;
    private String talla;

    public EntregaDotacion() {
    }

    
    public EntregaDotacion(String id) {
        String cadenaSQL = "select id,identificacionPersona,fechaEntrega,fechaProxEntrega,prenda,estacion,talla from EntregaDotacion where id=" + id;
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);

        try {
            if (resultado.next()) {
                this.id = id;
                identificacionPersona = resultado.getString("identificacionPersona");
                idDotacion = resultado.getString("idDotacion");
                fechaEntrega = resultado.getString("fechaEntrega");
                fechaProxEntrega = resultado.getString("fechaProxEntrega");
                prenda = resultado.getString("prenda");
                estacion = resultado.getString("estacion");
                talla = resultado.getString("talla");
               
            }

        } catch (Exception e) {
            System.out.println("np");
        }
    }

    public String getId() {
    if (id == null) {
            id = "";
        }
        return  id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getIdentificacionPersona() {
      if (identificacionPersona == null) {
            identificacionPersona = "";
        }
        return  identificacionPersona;
    }

    public void setIdentificacionPersona(String identificacionPersona) {
        this.identificacionPersona = identificacionPersona;
    }

    public String getIdDotacion() {
         if (idDotacion == null) {
            idDotacion = "";
        }
        return  idDotacion;
    }

    public void setIdDotacion(String idDotacion) {
        this.idDotacion = idDotacion;
    }

    public String getFechaEntrega() {
      if (fechaEntrega== null) {
            fechaEntrega = "";
        }
        return  fechaEntrega;
    }

    public void setFechaEntrega(String fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
    }

    public String getFechaProxEntrega() {
         if (fechaProxEntrega== null) {
            fechaProxEntrega = "";
        }
        return  fechaProxEntrega;
    }

    public void setFechaProxEntrega(String fechaProxEntrega) {
        this.fechaProxEntrega = fechaProxEntrega;
    }

    public String getPrenda() {
        if (prenda == null) {
            prenda = "";
        }
        return  prenda;
    }

    public void setPrenda(String prenda) {
        this.prenda = prenda;
    }

    public String getEstacion() {
         if (estacion == null) {
            estacion = "";
        }
        return  estacion;
    }

    public void setEstacion(String estacion) {
        this.estacion = estacion;
    }

    public String getTalla() {
        if (talla == null) {
            talla = "";
        }
        return  talla;
    }

    public void setTalla(String talla) {
        this.talla = talla;
    }
    
  
    
     public boolean grabar() {
        String cadenaSQL = "insert into entregaDotacion (id, identificacionPersona,idDotacion,fechaEntrega,fechaProxEntrega,prenda,estacion,talla) "
                + "values('" + id + "','" + identificacionPersona + "','" + idDotacion  + fechaEntrega + "','" + fechaProxEntrega + "','" + prenda + "','" + estacion + "','" + talla  + "','" +  "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar(String idAnterior) {
        String cadenaSQL = "update entregaDotacion set id='" + id + "',identificacionPersona='" + identificacionPersona + "',idDotacion='" + idDotacion + "',fechaEntrega='" + fechaEntrega + "',fechaProxEntrega='" +fechaProxEntrega+"',prenda='"+prenda+"',estacion='"+estacion+"',talla='"+talla+"' "
                + "where id=" + idAnterior;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar(String identificacion) {
        String cadenaSQL = "delete from entregaDotacion where id=" + id;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

       public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !filtro.equals(filtro)) {
            filtro = " where " + filtro;
        } else {
            filtro = " ";
        }
        if (orden != null && !orden.equals(orden)) {
            orden = " order by  " + orden;
        } else {
            orden = " ";
        }
        String cadenaSQL = "select id,identificacionPersona,fechaEntrega,fechaProxEntrega,prenda,estacion,talla from entregaDotacion " + filtro + orden;

        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<EntregaDotacion> getListaEnObjetos(String filtro, String orden) {
        List<EntregaDotacion> lista = new ArrayList<>();
        ResultSet datos = EntregaDotacion.getLista(filtro, orden);
        if (datos != null) {
            try {
                while (datos.next()) {
                     EntregaDotacion entregaDotacion= new EntregaDotacion();
                     entregaDotacion .setId(datos.getString("id"));
                     entregaDotacion .setIdentificacionPersona(datos.getString("identificacionPersona"));
                     entregaDotacion.setFechaEntrega(datos.getString("identificacionPersona"));
                     entregaDotacion .setFechaProxEntrega(datos.getString("identificacionPersona"));
                     entregaDotacion .setPrenda(datos.getString("prenda"));
                     entregaDotacion .setEstacion(datos.getString("estacion"));
                     entregaDotacion .setTalla(datos.getString("talla"));
                     
                    lista.add(entregaDotacion);
                }
            } catch (SQLException ex) {
                Logger.getLogger(EntregaDotacion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }
    
}

