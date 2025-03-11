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
public class PersonaHijos {
     private String id;
     private String identificacionPersona;
     private String idHijos;

    public PersonaHijos() {
    }

    public PersonaHijos(String id) {
        String cadenaSQL = "select id,identificacionPersona,idHijos from personaHijos where id=" + id;
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);

        try {
            if (resultado.next()) {
                this.id = id;
                identificacionPersona = resultado.getString("identificacionPersona");
                idHijos = resultado.getString("idHijos");
               
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

    public String getIdHijos() {
        if (idHijos == null) {
            idHijos = "";
        }
        return  idHijos;
    }

    public void setIdHijos(String idHijos) {
        this.idHijos = idHijos;
    }
     
     public boolean grabar() {
        String cadenaSQL = "insert into personaHijos (id, identificacionPersona, idHijos) "
                + "values('" + id + "','" + identificacionPersona + "','" + idHijos  + "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar(String idAnterior) {
        String cadenaSQL = "update personaHijos set id='" + id + "',identificacionPersona='" + identificacionPersona + "',idHijos='" + idHijos + "' "
                + "where id=" + idAnterior;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar(String identificacion) {
        String cadenaSQL = "delete from  personaHijos where id=" + id;
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
        String cadenaSQL = "select id,identificacionPersona,idHijos from personaHijos" + filtro + orden;

        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<PersonaHijos> getListaEnObjetos(String filtro, String orden) {
        List<PersonaHijos> lista = new ArrayList<>();
        ResultSet datos = PersonaHijos.getLista(filtro, orden);
        if (datos != null) {
            try {
                while (datos.next()) {
                    PersonaHijos personaHijos = new PersonaHijos();
                    personaHijos .setId(datos.getString("id"));
                    personaHijos .setIdentificacionPersona(datos.getString("identificacionPersona"));
                    personaHijos .setIdHijos(datos.getString("idHijos"));
                    lista.add(personaHijos );
                }
            } catch (SQLException ex) {
                Logger.getLogger(PersonaHijos.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }
    
}
