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
 * @author Mary
 */


public class PersonaVehiculo {
    private String id;
    private String identificacionPersona;
    private String idVehiculo;

    public PersonaVehiculo() {
    }

    public PersonaVehiculo(String id) {
        this.id = id;
        String cadenaSQL = "select identificacionPersona, idVehiculo from persona_vehiculo where id='" + id + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.id = id;
                identificacionPersona = resultado.getString("identificacionPersona");
                idVehiculo = resultado.getString("idVehiculo");
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener la información de PersonaVehiculo: " + ex.getMessage());
        }
    }

    public String getId() {
        String resultado = id;
        if (id == null) resultado = "";
        return resultado;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdentificacionPersona() {
        String resultado = identificacionPersona;
        if (identificacionPersona == null) resultado = "";
        return resultado;
    }

    public void setIdentificacionPersona(String identificacionPersona) {
        this.identificacionPersona = identificacionPersona;
    }

    public String getIdVehiculo() {
        String resultado = idVehiculo;
        if (idVehiculo == null) resultado = "";
        return resultado;
    }

    public void setIdVehiculo(String idVehiculo) {
        this.idVehiculo = idVehiculo;
    }

    @Override
    public String toString() {
        return "Persona: " + identificacionPersona + ", Vehículo ID: " + idVehiculo;
    }

    public boolean grabar() {
        String cadenaSQL = "insert into persona_vehiculo(identificacionPersona, idVehiculo) "
                + "values ('" + identificacionPersona + "', '" + idVehiculo + "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar() {
        String cadenaSQL = "update persona_vehiculo set identificacionPersona='" + identificacionPersona + "', "
                + "idVehiculo='" + idVehiculo + "' "
                + "where id='" + id + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar() {
        String cadenaSQL = "delete from persona_vehiculo where id='" + id + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
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
        String cadenaSQL = "select id, identificacionPersona, idVehiculo from persona_vehiculo " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<PersonaVehiculo> getListaEnObjetos(String filtro, String orden) {
        List<PersonaVehiculo> lista = new ArrayList<>();
        ResultSet datos = PersonaVehiculo.getLista(filtro, orden);
        if (datos != null) {
            try {
                while (datos.next()) {
                    PersonaVehiculo personaVehiculo = new PersonaVehiculo();
                    personaVehiculo.setId(datos.getString("id"));
                    personaVehiculo.setIdentificacionPersona(datos.getString("identificacionPersona"));
                    personaVehiculo.setIdVehiculo(datos.getString("idVehiculo"));
                    lista.add(personaVehiculo);
                }
            } catch (SQLException ex) {
                Logger.getLogger(PersonaVehiculo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }

    public static String getListaEnOptions(String preseleccionado) {
        String lista = "";
        List<PersonaVehiculo> datos = PersonaVehiculo.getListaEnObjetos(null, "identificacionPersona");
        for (int i = 0; i < datos.size(); i++) {
            PersonaVehiculo personaVehiculo = datos.get(i);
            String auxiliar = "";
            if (preseleccionado.equals(personaVehiculo.getId())) auxiliar = " selected";
            lista += "<option value='" + personaVehiculo.getId() + "' " + auxiliar + ">" + personaVehiculo.getIdentificacionPersona() + " - " + personaVehiculo.getIdVehiculo() + "</option>";
        }
        return lista;
    }
}
