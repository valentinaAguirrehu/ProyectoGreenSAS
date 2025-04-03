package clases;

import clasesGenericas.ConectorBD;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class Departamento {
    private String id;
    private String nombre;

    public Departamento() {
    }

    public Departamento(String id) {
        String cadenaSQL = "SELECT nombre FROM departamento WHERE id=" + id; 
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.id = id;
                this.nombre = resultado.getString("nombre");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el id: " + ex.getMessage());
        }
    }

 public String getId() {
        String resultado=id;
        if(id==null) resultado="";
        return resultado;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        String resultado=nombre;
        if(nombre==null) resultado="";
        return resultado;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @Override
    public String toString() {
        return nombre;
    }
    
    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !filtro.isEmpty()) {
            filtro = " WHERE " + filtro;
        } else {
            filtro = " ";
        }
        if (orden != null && !orden.isEmpty()) {
            orden = " ORDER BY " + orden;
        } else {
            orden = " ";
        }
        String cadenaSQL = "SELECT id, nombre FROM departamento " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Departamento> getListaEnObjetos(String filtro, String orden) {
        List<Departamento> lista = new ArrayList<>();
        ResultSet datos = Departamento.getLista(filtro, orden);
        if (datos != null) {
            try {
                while (datos.next()) {
                    Departamento departamento = new Departamento();
                    departamento.setId(datos.getString("id"));
                    departamento.setNombre(datos.getString("nombre"));
                    lista.add(departamento);
                }
            } catch (SQLException ex) {
                Logger.getLogger(Departamento.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lista;
    }
    
public static String getListaEnOptions(String preseleccionado) {
    String lista = "<option value='' disabled selected>Selecciona un Departamento</option>";  // Iniciar la cadena vacía
    List<Departamento> datos = Departamento.getListaEnObjetos(null, "nombre ASC");

    for (Departamento departamento : datos) {
        String auxiliar = "";
        // Asegúrate de que la comparación sea válida
        if (preseleccionado != null && preseleccionado.equals(String.valueOf(departamento.getId()))) {
            auxiliar = " selected";
        }
       lista += "<option value='" + departamento.getId() + "'" + auxiliar + ">" 
               + departamento.getNombre() + "</option>";
    }
    return  lista;
   }

}


