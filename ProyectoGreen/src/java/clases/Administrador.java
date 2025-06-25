/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
    private String pLeer;
    private String pEditar;
    private String pAgregar;
    private String pEliminar;
    private String pDescargar;
    private String estado;

    private static String esc(String v) {
        return (v == null) ? "" : v.replace("'", "''");
    }

    public Administrador() {
    }

    public Administrador(String identificacion) {
        this.identificacion = identificacion; 

        String sql = "SELECT * FROM administrador WHERE identificacion = '" + esc(identificacion) + "'";
        ResultSet rs = ConectorBD.consultar(sql);
        try {
            if (rs.next()) {
                tipo = rs.getString("tipo");
                nombres = rs.getString("nombres");
                celular = rs.getString("celular");
                email = rs.getString("email");
                clave = rs.getString("clave");
                pLeer = rs.getString("pLeer");
                pEditar = rs.getString("pEditar");
                pAgregar = rs.getString("pAgregar");
                pEliminar = rs.getString("pEliminar");
                pDescargar = rs.getString("pDescargar");
                estado = rs.getString("estado");
            }
        } catch (SQLException e) {
            Logger.getLogger(Administrador.class.getName())
                    .log(Level.SEVERE, "Error al consultar Administrador", e);
        }
    }

    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getpLeer() {
        return pLeer;
    }

    public void setpLeer(String pLeer) {
        this.pLeer = pLeer;
    }

    public String getpEditar() {
        return pEditar;
    }

    public void setpEditar(String pEditar) {
        this.pEditar = pEditar;
    }

    public String getpAgregar() {
        return pAgregar;
    }

    public void setpAgregar(String pAgregar) {
        this.pAgregar = pAgregar;
    }

    public String getpEliminar() {
        return pEliminar;
    }

    public void setpEliminar(String pEliminar) {
        this.pEliminar = pEliminar;
    }

    public String getpDescargar() {
        return pDescargar;
    }

    public void setpDescargar(String pDescargar) {
        this.pDescargar = pDescargar;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public boolean grabar() {
        String cadenaSQL = "INSERT INTO administrador (identificacion, tipo, nombres, celular, email, clave, pLeer, pEditar, pAgregar, pEliminar, pDescargar, estado) "
                + "VALUES ('" + esc(identificacion) + "', '" + esc(tipo) + "', '" + esc(nombres) + "', '" + esc(celular) + "', '" + esc(email) + "', '"
                + esc(clave) + "', '" + esc(pLeer) + "', '" + esc(pEditar) + "', '" + esc(pAgregar) + "', '" + esc(pEliminar) + "', '"
                + esc(pDescargar) + "', '" + esc(estado) + "')";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public boolean modificar(String identificacionAnterior) {
        String sql = "UPDATE administrador SET "
                + "identificacion='" + esc(identificacion) + "', "
                + "tipo='" + esc(tipo) + "', "
                + "nombres='" + esc(nombres) + "', "
                + "celular='" + esc(celular) + "', "
                + "email='" + esc(email) + "', "
                + "clave='" + esc(clave) + "', "
                + "pLeer='" + esc(pLeer) + "', "
                + "pEditar='" + esc(pEditar) + "', "
                + "pAgregar='" + esc(pAgregar) + "', "
                + "pEliminar='" + esc(pEliminar) + "', "
                + "pDescargar='" + esc(pDescargar) + "', "
                + "estado='" + esc(estado) + "' "
                + "WHERE identificacion='" + esc(identificacionAnterior) + "'";
        return ConectorBD.ejecutarQuery(sql);
    }

    public boolean eliminar() {
        String cadenaSQL = "DELETE FROM administrador WHERE identificacion='" + esc(identificacion) + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !filtro.trim().isEmpty()) {
            filtro = " WHERE " + filtro;
        } else {
            filtro = "";
        }
        if (orden != null && !orden.trim().isEmpty()) {
            orden = " ORDER BY " + orden;
        } else {
            orden = "";
        }
        String cadenaSQL = "SELECT identificacion, tipo, nombres, celular, email, clave, pLeer, pEditar, pAgregar, pEliminar, pDescargar, estado "
                + "FROM administrador" + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Administrador> getListaEnObjetos(String filtro, String orden) {
        List<Administrador> lista = new ArrayList<>();
        ResultSet datos = getLista(filtro, orden);
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
                    administrador.setpLeer(datos.getString("pLeer"));
                    administrador.setpEditar(datos.getString("pEditar"));
                    administrador.setpAgregar(datos.getString("pAgregar"));
                    administrador.setpEliminar(datos.getString("pEliminar"));
                    administrador.setpDescargar(datos.getString("pDescargar"));
                    administrador.setEstado(datos.getString("estado"));
                    lista.add(administrador);
                }
            } catch (SQLException ex) {
                Logger.getLogger(Administrador.class.getName()).log(Level.SEVERE, "Error al obtener la lista de administradores", ex);
            }
        }
        return lista;
    }

    public static Administrador validar(String identificacion, String clave) {
        Administrador administrador = null;
        String query = "identificacion='" + esc(identificacion) + "' and clave=";

        if (clave.length() == 32 && clave.matches("[a-fA-F0-9]+")) {
            query += "'" + esc(clave) + "'";
        } else {
            query += "md5('" + esc(clave) + "')";
        }

        List<Administrador> lista = getListaEnObjetos(query, null);
        if (!lista.isEmpty()) {
            administrador = lista.get(0);
        }
        return administrador;
    }

    private String encriptarMD5(String clave) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(clave.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al encriptar la clave en MD5", e);
        }
    }
}
