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
    private String identificacion;
    private String observaciones;
    private String numCaja;
    private String numCarpeta;

    public Retirados() {
    }

    public Retirados(String id) {
        String cadenaSQL = "SELECT id, identificacion, observaciones, numCaja, numCarpeta "
                + "FROM retirados WHERE identificacion = '" + id + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.id = resultado.getString("id");
                this.identificacion = resultado.getString("identificacion");
                this.observaciones = resultado.getString("observaciones");
                this.numCaja = resultado.getString("numCaja");
                this.numCarpeta = resultado.getString("numCarpeta");

            } else {
                System.out.println("No se encontraron datos para el ID: " + id);
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el ID: " + ex.getMessage());
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
    
    public String getIdentificacion() {
     if (identificacion == null) {
            identificacion = "";
        }
        return  identificacion;
    }

    
    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getObservaciones() {
     if (observaciones == null) {
            observaciones = "";
        }
        return  observaciones;
    }
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getNumCaja() {
     if (numCaja == null) {
            numCaja = "";
        }
        return  numCaja;
    }
    
    public void setNumCaja(String numCaja) {
        this.numCaja = numCaja;
    }

    public String getNumCarpeta() {
     if (numCarpeta == null) {
            numCarpeta = "";
        }
        return  numCarpeta;
    }

    public void setNumCarpeta(String numCarpeta) {
        this.numCarpeta = numCarpeta;
    }

    @Override
    public String toString() {
        return id + "  " + identificacion;
    }

    public boolean grabar() {
        String cadenaSQL = "INSERT INTO retirados (identificacion, observaciones, numCaja, numCarpeta) VALUES ('"
                + identificacion + "', '" + observaciones + "', '" + numCaja + "', '" + numCarpeta + "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar(String idAnterior) {
        String cadenaSQL = "UPDATE retirados SET identificacion = '" + identificacion
                + "', observaciones = '" + observaciones
                + "', numCaja = '" + numCaja
                + "', numCarpeta = '" + numCarpeta
                + "' WHERE identificacion = '" + idAnterior + "'";

        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar(String id) {
        String cadenaSQL = "DELETE FROM retirados WHERE identificacion = " + id;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !filtro.equals(filtro)) {
            filtro = " WHERE " + filtro;
        } else {
            filtro = " ";
        }
        if (orden != null && !orden.equals(orden)) {
            orden = " ORDER BY " + orden;
        } else {
            orden = " ";
        }

        String cadenaSQL = "SELECT "
                + "r.id, r.identificacion, r.observaciones, r.numCaja, r.numCarpeta, "
                + "p.identificacion, p.nombres, p.apellidos, p.establecimiento, "
                + "p.fechaIngreso, p.fechaRetiro "
                + "FROM retirados r "
                + "JOIN persona p ON r.identificacion = p.identificacion "
                + "WHERE p.tipo = 'R' AND r.identificacion IS NOT NULL "
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
                    retirado.setIdentificacion(datos.getString("identificacion"));
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

    public static String getListaEnOptions(String preseleccionado) {
        StringBuilder lista = new StringBuilder();
        List<Retirados> datos = getListaEnObjetos(null, "nombre"); // Se ordena por nombre o el campo que prefieras

        for (Retirados retirado : datos) {
            String auxiliar = "";
            if (preseleccionado != null && preseleccionado.equals(retirado.getId())) {
                auxiliar = " selected";
            }
            lista.append("<option value='").append(retirado.getId()).append("'")
                    .append(auxiliar).append(">") 
                    .append(retirado.getIdentificacion()).append("</option>");
        }
        return lista.toString();
    }
}
