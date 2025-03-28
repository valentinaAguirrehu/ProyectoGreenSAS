
package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author VALEN
 */
public class DetallesHistoria {
     private String id;
     private String idPersona;
     private String tipo;
     private String nombreDocumento;
     private String documentoPDF;

    public DetallesHistoria() {
    }

     
    
    public DetallesHistoria(String id) {
               String consultaSQL = "select idPersona,tipo, nombreDocumento, documentoPDF from detallesHistoria where id = " + id;
        ResultSet resultado = ConectorBD.consultar(consultaSQL);
        
        try {
            if (resultado.next()) {
                this.id = id;
                idPersona = resultado.getString("idPersona");
                tipo = resultado.getString("tipo");
                nombreDocumento = resultado.getString("nombreDocumento");
                documentoPDF = resultado.getString("documentoPdf");
                
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar el ID: " + ex.getMessage());
        }
    
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(String idPersona) {
        this.idPersona = idPersona;
    }

    public String getNombreDocumento() {
        return nombreDocumento;
    }

    public void setNombreDocumento(String nombreDocumento) {
        this.nombreDocumento = nombreDocumento;
    }

    public String getDocumentoPDF() {
        return documentoPDF;
    }

    public void setDocumentoPDF(String documentoPDF) {
        this.documentoPDF = documentoPDF;
    }
     public boolean grabar() {
        String consultaSQL = "INSERT INTO detallesHistoria (idPersona,tipo, nombreDocumento, documentoPDF) VALUES ('"
                + idPersona + "', '" + tipo + "', '" + nombreDocumento + "', '" + documentoPDF + "')";
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean modificar() {
        String consultaSQL = "UPDATE detallesHistoria SET idPersona = '" + idPersona
                + "',tipo='" + tipo
                + "', nombreDocumento = '" + nombreDocumento
                + "', documentoPDF = '" + documentoPDF + "' WHERE id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public boolean eliminar() {
        String consultaSQL = "DELETE FROM detallesHistoria WHERE id = " + id;
        return ConectorBD.ejecutarQuery(consultaSQL);
    }

    public static ResultSet getLista(String filtro, String orden) {
    if (filtro != null && filtro != "") {
        filtro = " WHERE " + filtro;
    } else {
        filtro = " ";
    }
    if (orden != null && orden != "") {
        orden = " ORDER BY " + orden;
    } else {
        orden = " ";
    }
    String cadenaSQL = "SELECT id, idPersona, tipo, nombreDocumento, documentoPDF FROM detallesHistoria" + filtro + orden;
    return ConectorBD.consultar(cadenaSQL);
}

public static List<DetallesHistoria> getListaEnObjetos(String filtro, String orden) {
    List<DetallesHistoria> lista = new ArrayList<>();
    ResultSet datos = DetallesHistoria.getLista(filtro, orden);
    if (datos != null) {
        try {
            while (datos.next()) {
                DetallesHistoria detallesHistoria = new DetallesHistoria();
                detallesHistoria.setId(datos.getString("id")); // Asegúrate de usar el nombre correcto de la columna
                detallesHistoria.setIdPersona(datos.getString("idPersona")); // Usa el tipo adecuado
                detallesHistoria.setTipo(datos.getString("tipo"));
                detallesHistoria.setNombreDocumento(datos.getString("nombreDocumento"));
                detallesHistoria.setDocumentoPDF(datos.getString("documentoPDF"));
                lista.add(detallesHistoria);
            }
        } catch (SQLException ex) {
            System.out.println("error al crear los registros de varios documentos");
        }
    }
    return lista;
}
}

     
