/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
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
 * @author Angie
 */
public class Cargo {
    
    private String id;
    private String nombre;
    private String codigoCargo;
    private String descripcion;
 

    public Cargo() {
    }

    public Cargo(String id)  {    
        String cadenaSQL = "select id,nombre,codigoCargo,descripcion from cargo where id=" + id;
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);

        try {
            if (resultado.next()) {
                this.id = id;
                nombre = resultado.getString("nombre");
                codigoCargo = resultado.getString("codigoCargo");
                descripcion = resultado.getString("descripcion");
               
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

    public String getNombre() {
     if (nombre == null) {
            nombre = "";
        }
        return  nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCodigoCargo() {
   if (codigoCargo == null) {
            codigoCargo = "";
        }
        return  codigoCargo;
    }

    public void setCodigoCargo(String codigoCargo) {
        this.codigoCargo = codigoCargo;
    }

    public String getDescripcion() {
     if (descripcion == null) {
            descripcion = "";
        }
        return  descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
     public String toString(){
     return nombre+ " " +codigoCargo;
 }


    public boolean grabar() {
        String cadenaSQL = "insert into cargo (nombre, codigoCargo, descripcion) "
                + "values('" + nombre + "','" + codigoCargo + "','" + descripcion + "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar(String idAnterior) {
        String cadenaSQL = "update cargo set id='" + id + "',nombre='" + nombre + "',codigoCargo='" + codigoCargo + "',descripcion='" + descripcion + "' "
                + "where id=" + idAnterior;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar(String id) {
        String cadenaSQL = "delete from cargo where id=" + id;
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
        String cadenaSQL = "select id,nombre,codigoCargo,descripcion from cargo" + filtro + orden;

        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Cargo> getListaEnObjetos(String filtro, String orden) {
        List<Cargo> lista = new ArrayList<>();
        ResultSet datos = Cargo.getLista(filtro, orden);
        if (datos != null) {
            try {
                while (datos.next()) {
                    Cargo cargo= new Cargo();
                    cargo.setId(datos.getString("id"));
                    cargo.setNombre(datos.getString("nombre"));
                    cargo.setCodigoCargo(datos.getString("codigoCargo"));
                    cargo.setDescripcion(datos.getString("descripcion"));
                    lista.add(cargo);
                }
            } catch (SQLException ex) {
                Logger.getLogger(Cargo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }
 
    public static String getListaEnOptions(String preseleccionado) {
    StringBuilder lista = new StringBuilder();
    List<Cargo> datos = getListaEnObjetos(null, "nombre"); // Ordenado por nombre

    for (Cargo cargo : datos) {
        String auxiliar = "";
        if (preseleccionado != null && preseleccionado.equals(cargo.getId())) {
            auxiliar = " selected";
        }
        lista.append("<option value='").append(cargo.getId()).append("'")
             .append(auxiliar).append(">")
             .append(cargo.getNombre()).append(" (").append(cargo.getCodigoCargo()).append(")</option>");
    }
    return lista.toString();
}
public static String getCargoPersona(String identificacionPersona) {
    String sql = "SELECT c.nombre FROM cargo c " +
                 "JOIN persona p ON p.idCargo = c.id " +
                 "WHERE p.identificacion = '" + identificacionPersona + "'";

    try {
        ResultSet rs = ConectorBD.consultar(sql); // Asegúrate de usar el método correcto
        if (rs.next()) {
            return rs.getString("nombre"); // Devuelve solo el nombre del cargo
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return "Sin cargo"; // Si no tiene cargo, devuelve un mensaje por defecto
}
}