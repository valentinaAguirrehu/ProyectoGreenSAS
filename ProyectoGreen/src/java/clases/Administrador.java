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
public class Administrador {

    private String identificacion;
    private String tipo;
    private String nombres;
    private String celular;
    private String email;
    private String clave;
    private String estado;

    public Administrador() {
    }

    public Administrador(String identificacion) {
        String cadenaSQL = "SELECT identificacion, tipo, nombres, celular, email, clave, estado FROM administrador where identificacion = '" + identificacion + "'";

        ResultSet resultado = ConectorBD.consultar(cadenaSQL);

        try {
            if (resultado.next()) {
                this.identificacion = identificacion;
                tipo = resultado.getString("tipo");
                nombres = resultado.getString("nombres");
                celular = resultado.getString("celular");
                email = resultado.getString("email");
                clave = resultado.getString("clave");
                estado = resultado.getString("estado");
            }
        } catch (Exception e) {
            System.out.println("Error al consultar Administrador: " + e.getMessage());
        }
    }

    public String getIdentificacion() {
        String resultado = identificacion;
        if (identificacion == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getTipo() {
    if (tipo == null || tipo.trim().isEmpty()) {
        tipo = "U";
    }
    return tipo;
}

    public void setTipo(String tipo) {
        if (tipo == null || tipo.trim().isEmpty()) {
            this.tipo = "U";
        } else {
            this.tipo = tipo;
        }
    }

    public String getNombres() {
        String resultado = nombres;
        if (nombres == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getCelular() {
        String resultado = celular;
        if (celular == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public String getEmail() {
        String resultado = email;
        if (email == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getClave() {
        if (clave == null || clave.trim().isEmpty()) {
            clave = (identificacion != null) ? identificacion : "";
        }

        if (clave.length() < 32) {
            return "md5('" + clave + "')";
        } else {
            return "'" + clave + "'";
        }
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getEstado() {
        String resultado = estado;
        if (estado == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    @Override
    public String toString() {

        String datos = "";
        if (identificacion != null) {
            datos = identificacion + " - " + nombres;
        }
        return datos;
    }

    public boolean grabar() {
        String cadenaSQL = "INSERT INTO administrador (identificacion, tipo, nombres, celular, email, clave, estado) "
                + "VALUES ('" + identificacion + "', '" + tipo + "', '" + nombres + "', '" + celular + "', '" + email + "', '" + clave + "', '" + estado + "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar(String identificacionAnterior) {
        String cadenaSQL = "UPDATE administrador SET identificacion='" + identificacion + "', "
                + "tipo='" + tipo + "', "
                + "nombres='" + nombres + "', "
                + "celular='" + celular + "', "
                + "email='" + email + "', "
                + "clave=" + clave + ", " 
                + "estado='" + estado + "' "
                + "WHERE identificacion=" + identificacionAnterior;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean eliminar() {
        String cadenaSQL = "DELETE FROM administrador WHERE identificacion='" + identificacion + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !"".equals(filtro)) {
            filtro = " where " + filtro;
        } else {
            filtro = " ";
        }
        if (orden != null && !"".equals(orden)) {
            orden = " order by " + orden;
        } else {
            orden = " ";
        }
        String cadenaSQL = "SELECT identificacion, tipo, nombres, celular, email, clave, estado FROM administrador " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Administrador> getListaEnObjetos(String filtro, String orden) {
        List<Administrador> lista = new ArrayList<>();
        ResultSet datos = Administrador.getLista(filtro, orden);
        if (datos != null) {
            try {
                while (datos.next()) {
                    Administrador administrador = new Administrador();
                    administrador.setIdentificacion(datos.getString("identificacion"));
                    administrador.setTipo(datos.getString("tipo"));
                    administrador.setNombres(datos.getString("nombres"));
                    administrador.setCelular(datos.getString("celular"));
                    administrador.setEmail(datos.getString("email"));
                    administrador.setClave(datos.getString("clave"));
                    administrador.setEstado(datos.getString("estado"));
                    lista.add(administrador);
                }
            } catch (SQLException ex) {
                Logger.getLogger(Administrador.class.getName()).log(Level.SEVERE, "Error al obtener la lista de administradores", ex);
            }
        }
        return lista;
    }

}
