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
    private String observaciones;
    private String numCaja;
    private String numCarpeta;

    public Retirados() {
    }

    public Retirados(String id) {
        String cadenaSQL = "SELECT id, identificacionPersona, observaciones, numCaja, numCarpeta "
                + "FROM retirados WHERE identificacionPersona = '" + id + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.id = resultado.getString("id");
                this.identificacionPersona = resultado.getString("identificacionPersona");
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
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdentificacionPersona() {
        return identificacionPersona == null ? "" : identificacionPersona;
    }

    public void setIdentificacionPersona(String identificacionPersona) {
        this.identificacionPersona = identificacionPersona;
    }

    public String getObservaciones() {
        return observaciones == null ? "" : observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getNumCaja() {
        return numCaja == null ? "" : numCaja;
    }

    public void setNumCaja(String numCaja) {
        this.numCaja = numCaja;
    }

    public String getNumCarpeta() {
        return numCarpeta == null ? "" : numCarpeta;
    }

    public void setNumCarpeta(String numCarpeta) {
        this.numCarpeta = numCarpeta;
    }

    @Override
    public String toString() {
        return id + "  " + identificacionPersona;
    }

    public boolean grabar() {
        String cadenaSQL = "INSERT INTO retirados (identificacionPersona, observaciones, numCaja, numCarpeta) VALUES ('"
                + identificacionPersona + "', '" + observaciones + "', '" + numCaja + "', '" + numCarpeta + "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar(String idAnterior) {
        String cadenaSQL = "UPDATE retirados SET identificacionPersona = '" + identificacionPersona
                + "', observaciones = '" + observaciones
                + "', numCaja = '" + numCaja
                + "', numCarpeta = '" + numCarpeta
                + "' WHERE id = '" + idAnterior + "'";

        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar(String id) {
        String cadenaSQL = "DELETE FROM retirados WHERE id = " + id;
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
                + "r.id, r.identificacionPersona, r.observaciones, r.numCaja, r.numCarpeta, "
                + "p.identificacion, p.nombres, p.apellidos, p.establecimiento, "
                + "p.fechaIngreso, p.fechaRetiro "
                + "FROM retirados r "
                + "JOIN persona p ON r.identificacionPersona = p.identificacion "
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
                    .append(retirado.getIdentificacionPersona()).append("</option>");
        }
        return lista.toString();
    }
}
