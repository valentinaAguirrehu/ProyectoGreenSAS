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
    private String identificacionPersona;
        private String nombreCargo;
    private String observaciones;
    private String numCaja;
    private String numCarpeta;


    public Retirados() {
    }

    public Retirados(String id) {
        String consultaSQL = "SELECT id, identificacionPersona, observaciones, numCaja, numCarpeta, nombreCargo "
                + "FROM retirados WHERE id = '" + id + "'";

        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        try {
            if (resultado.next()) {
                this.id = id;
                this.identificacionPersona = resultado.getString("identificacionPersona");
                this.nombreCargo = resultado.getString("nombreCargo");
                this.observaciones = resultado.getString("observaciones");
                this.numCaja = resultado.getString("numCaja");
                this.numCarpeta = resultado.getString("numCarpeta");
                
            }
            resultado.close(); // Cierra el ResultSet
        } catch (SQLException ex) {
            System.out.println("Error al consultar el ID: " + ex.getMessage());
        }
    }

    public String getId() {
        return id;
    }

    public String getIdentificacionPersona() {
        String resultado = identificacionPersona;
        if (identificacionPersona == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setIdentificacionPersona(String identificacionPersona) {
        this.identificacionPersona = identificacionPersona;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getObservaciones() {
        String resultado = observaciones;
        if (observaciones == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getNumCaja() {
        String resultado = numCaja;
        if (numCaja == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNumCaja(String numCaja) {
        this.numCaja = numCaja;
    }

    public String getNumCarpeta() {
        String resultado = numCarpeta;
        if (numCarpeta == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNumCarpeta(String numCarpeta) {
        this.numCarpeta = numCarpeta;
    }

    public String getNombreCargo() {
        String resultado = nombreCargo;
        if (nombreCargo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNombreCargo(String nombreCargo) {
        this.nombreCargo = nombreCargo;
    }

    @Override
    public String toString() {
        return id + " - " + identificacionPersona + " - " + nombreCargo + " - " + observaciones;
    }

    public boolean grabar() {
        String consultaSQL = "INSERT INTO retirados (identificacionPersona, nombreCargo, observaciones, numCaja, numCarpeta) VALUES ('"
                + identificacionPersona + "', '" + nombreCargo + "', '" + observaciones + "', '" + numCaja + "', '" + numCarpeta + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "UPDATE retirados SET identificacionPersona = '" + identificacionPersona
                + "', nombreCargo = '" + nombreCargo
                + "', observaciones = '" + observaciones
                + "', numCaja = '" + numCaja
                + "', numCarpeta = '" + numCarpeta
                + "' WHERE id = '" + id + "'";

        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean eliminar() {
        String cadenaSQL = "delete from retirados where id=" + id;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static ResultSet getLista(String filtro, String orden) {
        // Manejo seguro de los filtros y ordenamientos
        filtro = (filtro != null && !filtro.trim().isEmpty()) ? " AND " + filtro : "";
        orden = (orden != null && !orden.trim().isEmpty()) ? " ORDER BY " + orden : "";

        // Consulta SQL optimizada
        String cadenaSQL = "SELECT "
                + "r.id, r.identificacionPersona, r.observaciones, r.numCaja, r.numCarpeta, "
                + "p.identificacion, p.nombres, p.apellidos, p.establecimiento, "
                + "p.fechaIngreso, p.fechaRetiro, "
                + "COALESCE(c.nombre, 'Sin cargo') AS nombreCargo "
                + // Si no hay cargo, muestra 'Sin cargo'
                "FROM retirados r "
                + "JOIN persona p ON r.identificacionPersona = p.identificacion "
                + "LEFT JOIN cargo c ON p.idCargo = c.id "
                + "WHERE p.tipo = 'R' AND r.identificacionPersona IS NOT NULL "
                + filtro + orden;

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
                    retirado.setIdentificacionPersona(datos.getString("identificacionPersona"));
                      retirado.setNombreCargo(datos.getString("nombreCargo"));
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
