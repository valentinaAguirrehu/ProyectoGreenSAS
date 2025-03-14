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
public class Retirados {
    
    private String id;
    private String idPersona;
    private String observaciones;
    private String numCaja;
    private String numCarpeta;
   

    public Retirados() {
    }

    public Retirados(String id) {
           String consultaSQL = "select id,idPersona,observaciones,numCaja,numCarpeta "
                + "from documentoIdentidad where id = " + id;
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        try {
            if (resultado.next()) {
                this.id = id;
                idPersona = resultado.getString("idPersona");
                observaciones = resultado.getString("observaciones");
                numCaja = resultado.getString("numCaja");
                numCarpeta = resultado.getString("numCarpeta");

            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el ID: " + ex.getMessage());
        }
    }

    public String getId() {
        return id;
    }

    public String getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(String idPersona) {
        this.idPersona = idPersona;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getNumCaja() {
        return numCaja;
    }

    public void setNumCaja(String numCaja) {
        this.numCaja = numCaja;
    }

    public String getNumCarpeta() {
        return numCarpeta;
    }

    public void setNumCarpeta(String numCarpeta) {
        this.numCarpeta = numCarpeta;
    }
    
    
    
    public boolean grabar() { 
        String consultaSQL = "INSERT INTO retirados (id, idPersona,observaciones, numCaja, numCarpeta) VALUES ('"
                + id + "','" + idPersona + "', '" + observaciones + "', '" + numCaja + "', '" + numCarpeta + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

   public boolean modificar() {
    String consultaSQL = "UPDATE retirados SET idPersona = '" + idPersona + 
                         "', observaciones = '" + observaciones + 
                         "', numCaja = '" + numCaja + 
                         "', numCarpeta = '" + numCarpeta + 
                         "' WHERE id = '" + id + "'";
    return ConectorBD.ejecutarQuery(consultaSQL);
}

    public boolean eliminar() {
       String cadenaSQL = "delete from persona where id=" + id;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }
public static ResultSet getLista(String filtro, String orden) {
    if (filtro != null && !filtro.trim().isEmpty()) {
        filtro = " AND " + filtro;  // Se usa AND en lugar de WHERE porque ya hay un WHERE en la consulta
    } else {
        filtro = "";
    }
    if (orden != null && !orden.trim().isEmpty()) {
        orden = " ORDER BY " + orden;
    } else {
        orden = "";
    }
    
    // Se une con la tabla persona para filtrar solo los de tipo 'R'
    String cadenaSQL = "SELECT r.id, r.idPersona, r.observaciones, r.numCaja, r.numCarpeta "
                     + "FROM retirados r "
                     + "JOIN persona p ON r.idPersona = p.identificacion " // Se usa identificacion en persona
                     + "WHERE p.tipo = 'R' " // Filtra solo personas con tipo 'R'
                     + filtro
                     + orden;

    return ConectorBD.consultar(cadenaSQL);
}


    public static List<Retirados> getListaEnObjetos(String filtro, String orden) {
        List<Retirados> lista = new ArrayList<>();
        ResultSet datos = Retirados.getLista(filtro, orden);
        if (datos != null) {
            try {
                while (datos.next()) {
                    Retirados retirado = new Retirados();
                    retirado.setId(datos.getString("id"));
                    retirado.setIdPersona(datos.getString("idPersona"));
                    retirado.setObservaciones(datos.getString("observaciones"));
                    retirado.setNumCaja(datos.getString("numCaja"));
                    retirado.setNumCarpeta(datos.getString("numCarpeta"));

                    lista.add(retirado);
                }
            } catch (SQLException ex) {
                Logger.getLogger(Retirados.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }
    
    
}
