/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Mary
 */
public class Persona {

    private String identificacion;
    private String tipo;
    private String tipoDocumento;
    private String fechaExpedicion;
    private String lugarExpedicion;
    private String nombres;
    private String apellidos;
    private String sexo;
    private String fechaNacimiento;
    private String lugarNacimiento;
    private String tipoSangre;
    private String tipoVivienda;
    private String direccion;
    private String barrio;
    private String celular;
    private String email;
    private String estadoCivil;
    private String tieneHijos;
    private List<Hijo> hijos = new ArrayList<>();
    private String idDepartamento;  // Campo virtual
    private String idMunicipio;    // Campo virtual
    private String nivelEdu;
    private String profesion;
    private String cuentaBancaria;
    private String numeroCuenta;

    public Persona() {
    }

    public Persona(String identificacion) {
        String cadenaSQL = "SELECT * FROM persona WHERE identificacion = '" + identificacion + "'";
        ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.identificacion = identificacion;
                this.hijos = new ArrayList<>();

                tipo = resultado.getString("tipo");
                tipoDocumento = resultado.getString("tipoDocumento");
                fechaExpedicion = resultado.getString("fechaExpedicion");
                lugarExpedicion = resultado.getString("lugarExpedicion");
                nombres = resultado.getString("nombres");
                apellidos = resultado.getString("apellidos");
                sexo = resultado.getString("sexo");
                fechaNacimiento = resultado.getString("fechaNacimiento");
                lugarNacimiento = resultado.getString("lugarNacimiento");
                tipoSangre = resultado.getString("tipoSangre");
                tipoVivienda = resultado.getString("tipoVivienda");
                direccion = resultado.getString("direccion");
                barrio = resultado.getString("barrio");
                celular = resultado.getString("celular");
                email = resultado.getString("email");
                estadoCivil = resultado.getString("estadoCivil");
                nivelEdu = resultado.getString("nivelEdu");
                profesion = resultado.getString("profesion");
                cuentaBancaria = resultado.getString("cuentaBancaria");
                numeroCuenta = resultado.getString("numeroCuenta");
                tieneHijos = resultado.getString("tieneHijos");

//  consutoh los hijos de las persona
                this.hijos = Hijo.obtenerHijosDePersona(identificacion);
            }
        } catch (SQLException ex) {
            System.out.println("Ejecutando consultaPersona: " + cadenaSQL);
            System.out.println("Error al consultar persona: " + ex.getMessage());
        } finally {
            try {
                if (resultado != null) {
                    resultado.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar ResultSet de persona: " + ex.getMessage());
            }
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
        String resultado = tipo;
        if (tipo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

//    public String getTipoDocumento() {
//        String resultado = tipoDocumento;
//        if (tipoDocumento == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public TipoDocumento getTipoDocumento() {
    if (tipoDocumento == null) {
        return null;
    }
    return new TipoDocumento(tipoDocumento);
}


    public void setTipoDocumento(String tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }

    public String getFechaExpedicion() {
        String resultado = fechaExpedicion;
        if (fechaExpedicion == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaExpedicion(String fechaExpedicion) {
        this.fechaExpedicion = fechaExpedicion;
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

    public String getApellidos() {
        String resultado = apellidos;
        if (apellidos == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getSexo() {
        String resultado = sexo;
        if (sexo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getFechaNacimiento() {
        String resultado = fechaNacimiento;
        if (fechaNacimiento == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getLugarNacimiento() {
        String resultado = lugarNacimiento;
        if (lugarNacimiento == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setLugarNacimiento(String lugarNacimiento) {
        this.lugarNacimiento = lugarNacimiento;

        // Separamos lugarNacimiento en los ID de departamento y municipio
        if (lugarNacimiento != null && lugarNacimiento.contains("-")) {
            String[] partes = lugarNacimiento.split("-");
            this.idDepartamento = partes[0];  // ID del departamento
            this.idMunicipio = partes[1];     // ID del municipio
        }
    }

//    public String getTipoSangre() {
//        String resultado = tipoSangre;
//        if (tipoSangre == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public TipoSangre getTipoSangre() {
        return new TipoSangre(tipoSangre);
    }

    public void setTipoSangre(String tipoSangre) {
        this.tipoSangre = tipoSangre;
    }

//    public String getTipoVivienda() {
//        String resultado = tipoVivienda;
//        if (tipoVivienda == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public TipoVivienda getTipoVivienda() {
        return new TipoVivienda(tipoVivienda);
    }

    public void setTipoVivienda(String tipoVivienda) {
        this.tipoVivienda = tipoVivienda;
    }

    public String getDireccion() {
        String resultado = direccion;
        if (direccion == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
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

    public String getBarrio() {
        String resultado = barrio;
        if (barrio == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setBarrio(String barrio) {
        this.barrio = barrio;
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

//    public String getEstadoCivil() {
//        String resultado = estadoCivil;
//        if (estadoCivil == null) {
//            resultado = "";
//        }
//        return resultado;
//    }
    public EstadoCivil getEstadoCivil() {
        return new EstadoCivil(estadoCivil);
    }

    public void setEstadoCivil(String estadoCivil) {
        this.estadoCivil = estadoCivil;
    }

    public String getNivelEdu() {
        String resultado = nivelEdu;
        if (nivelEdu == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNivelEdu(String nivelEdu) {
        this.nivelEdu = nivelEdu;
    }

    public String getProfesion() {
        String resultado = profesion;
        if (profesion == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setProfesion(String profesion) {
        this.profesion = profesion;
    }

    public String getCuentaBancaria() {
        String resultado = cuentaBancaria;
        if (cuentaBancaria == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setCuentaBancaria(String cuentaBancaria) {
        this.cuentaBancaria = cuentaBancaria;
    }

    public String getNumeroCuenta() {
        String resultado = numeroCuenta;
        if (numeroCuenta == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNumeroCuenta(String numeroCuenta) {
        this.numeroCuenta = numeroCuenta;
    }

    public boolean guardarHijos(String identificacionPersona, String datosHijos) {
        if (datosHijos == null || datosHijos.trim().isEmpty()) {
            return false;
        }

        // Reemplazar posibles comillas problemáticas en SQL
        datosHijos = datosHijos.replace("'", "''");

        String sql = "CALL guardar_hijos('" + identificacionPersona + "', '" + datosHijos + "')";
        System.out.println("Ejecutando procedimiento: " + sql);

        return ConectorBD.ejecutarQuery(sql);
    }

    public Hijo getTieneHijos() {
        return new Hijo(tieneHijos);

    }

    public void setTieneHijos(String tieneHijos) {
        this.tieneHijos = tieneHijos;
    }

    public List<Hijo> getHijos() {
        return hijos;
    }

    public void setHijos(List<Hijo> hijos) {
        this.hijos = hijos;
    }

    public List<Hijo> obtenerHijos() {
        if (this.hijos == null) {
            this.hijos = Hijo.obtenerHijosDePersona(this.identificacion);
        }

        // Sincroniza el valor de tieneHijos con la lista de hijos
        this.tieneHijos = (!this.hijos.isEmpty()) ? "S" : "N";

        return this.hijos;
    }

    public GeneroPersona getGeneroPersona() {
        return new GeneroPersona(sexo);
    }

    public void setGenero(String genero) {
        this.sexo = genero;
    }

    //  para lugarExpedicion (el campo concatenado)
    public String getLugarExpedicion() {
        return lugarExpedicion;
    }

    public void setLugarExpedicion(String lugarExpedicion) {
        this.lugarExpedicion = lugarExpedicion;

        // Separamos lugarExpedicion en los ID de departamento y municipio
        if (lugarExpedicion != null && lugarExpedicion.contains("-")) {
            String[] partes = lugarExpedicion.split("-");
            this.idDepartamento = partes[0];  // ID del departamento
            this.idMunicipio = partes[1];     // ID del municipio
        }
    }

    // Métodos para expedición
    public String getIdDepartamentoExpedicion() {
        if (lugarExpedicion != null && lugarExpedicion.contains("-")) {
            String[] partes = lugarExpedicion.split("-");
            return (partes.length > 0) ? partes[0] : "";
        }
        return "";
    }

    public void setIdDepartamentoExpedicion(String idDepartamentoExpedicion) {
        this.idDepartamento = idDepartamentoExpedicion;
    }

    public String getIdMunicipioExpedicion() {
        if (lugarExpedicion != null && lugarExpedicion.contains("-")) {
            String[] partes = lugarExpedicion.split("-");
            return (partes.length > 1) ? partes[1] : "";
        }
        return "";
    }

    public void setIdMunicipioExpedicion(String idMunicipioExpedicion) {
        this.idMunicipio = idMunicipioExpedicion;
    }

// Métodos para nacimiento
    public String getIdDepartamentoNacimiento() {
        if (lugarNacimiento != null && lugarNacimiento.contains("-")) {
            String[] partes = lugarNacimiento.split("-");
            return (partes.length > 0) ? partes[0] : "";
        }
        return "";
    }

    public void setIdDepartamentoNacimiento(String idDepartamentoNacimiento) {
        this.idDepartamento = idDepartamentoNacimiento;
    }

    public String getIdMunicipioNacimiento() {
        if (lugarNacimiento != null && lugarNacimiento.contains("-")) {
            String[] partes = lugarNacimiento.split("-");
            return (partes.length > 1) ? partes[1] : "";
        }
        return "";
    }

    public void setIdMunicipioNacimiento(String idMunicipioNacimiento) {
        this.idMunicipio = idMunicipioNacimiento;
    }

    public static boolean existeIdentificacion(String identificacion) {
        String sql = "SELECT 1 FROM persona WHERE identificacion = '" + identificacion + "' LIMIT 1";
        ResultSet rs = ConectorBD.consultar(sql);
        try {
            return rs != null && rs.next(); // Devuelve true si existe
        } catch (SQLException e) {
            System.out.println("Error al verificar existencia de identificación: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar ResultSet: " + e.getMessage());
            }
        }
        return false;
    }

    public boolean grabar() {
        // 1. Validar si ya existe la identificación
        if (Persona.existeIdentificacion(identificacion)) {
            System.out.println("Error: Ya existe una persona con la identificación " + identificacion);
            return false;
        }
        String cadenaSQL = "INSERT INTO persona ("
                + "identificacion, tipo, tipoDocumento, fechaExpedicion, lugarExpedicion, "
                + "nombres, apellidos, sexo, fechaNacimiento, lugarNacimiento, tipoSangre, "
                + "tipoVivienda, direccion, barrio, celular, email, estadoCivil, tieneHijos, "
                + "cuentaBancaria, nivelEdu, profesion, numeroCuenta) VALUES ('"
                + identificacion + "', '"
                + tipo + "', '"
                + tipoDocumento + "', "
                + (fechaExpedicion != null && !fechaExpedicion.isEmpty() ? "'" + fechaExpedicion + "'" : "NULL") + ", '"
                + lugarExpedicion + "', '"
                + nombres + "', '"
                + apellidos + "', '"
                + sexo + "', "
                + (fechaNacimiento != null && !fechaNacimiento.isEmpty() ? "'" + fechaNacimiento + "'" : "NULL") + ", '"
                + lugarNacimiento + "', '"
                + tipoSangre + "', '"
                + tipoVivienda + "', '"
                + direccion + "', '"
                + barrio + "', '"
                + celular + "', '"
                + email + "', "
                + (estadoCivil != null && !estadoCivil.isEmpty() ? "'" + estadoCivil + "'" : "NULL") + ", "
                + (tieneHijos != null && !tieneHijos.isEmpty() ? "'" + tieneHijos + "'" : "NULL") + ", "
                + (cuentaBancaria != null && !cuentaBancaria.isEmpty() ? "'" + cuentaBancaria + "'" : "NULL") + ", "
                + (nivelEdu != null && !nivelEdu.isEmpty() ? "'" + nivelEdu + "'" : "NULL") + ", "
                + (profesion != null && !profesion.isEmpty() ? "'" + profesion + "'" : "NULL") + ", "
                + (numeroCuenta != null && !numeroCuenta.isEmpty() ? "'" + numeroCuenta + "'" : "NULL")
                + ");";

        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);
        System.out.println(cadenaSQL);

        if (!resultado) {
            System.out.println("Error: No se pudo insertar la persona en la BD");
            return false;
        }

        // 2. Insertar hijos si tieneHijos = "S"
        if ("S".equals(tieneHijos) && hijos != null) {
            for (Hijo hijo : hijos) {
                if (hijo != null) {
                    boolean hijoGuardado = hijo.grabar();
                    System.out.println("Guardando hijo: " + hijo.getIdentificacion() + " - Resultado: " + hijoGuardado);

                    if (hijoGuardado && identificacion != null && hijo.getIdentificacion() != null) {
                        String relSQL = "INSERT INTO persona_hijos (identificacionPersona, identificacionHijo) "
                                + "VALUES ('" + identificacion + "', '" + hijo.getIdentificacion() + "')";
                        boolean relResultado = ConectorBD.ejecutarQuery(relSQL);
                        System.out.println("Resultado de insertar en persona_hijos: " + relResultado);
                    }
                }
            }
        }

        return true;
    }

    public boolean modificar(String identificacionAnterior) {
        if (identificacion == null || identificacionAnterior == null) {
            System.out.println("Error: clase persona identificacion o identificacionAnterior es null.");
            return false;
        }

        String cadenaSQL = "UPDATE persona SET "
                + "identificacion='" + identificacion + "', "
                + "tipo=" + (tipo != null ? "'" + tipo + "'" : "NULL") + ", "
                + "tipoDocumento=" + (tipoDocumento != null ? "'" + tipoDocumento + "'" : "NULL") + ", "
                + "fechaExpedicion=" + (fechaExpedicion != null ? "'" + fechaExpedicion + "'" : "NULL") + ", "
                + "lugarExpedicion=" + (lugarExpedicion != null ? "'" + lugarExpedicion + "'" : "NULL") + ", "
                + "nombres=" + (nombres != null ? "'" + nombres + "'" : "NULL") + ", "
                + "apellidos=" + (apellidos != null ? "'" + apellidos + "'" : "NULL") + ", "
                + "sexo=" + (sexo != null ? "'" + sexo + "'" : "NULL") + ", "
                + "fechaNacimiento=" + (fechaNacimiento != null ? "'" + fechaNacimiento + "'" : "NULL") + ", "
                + "lugarNacimiento=" + (lugarNacimiento != null ? "'" + lugarNacimiento + "'" : "NULL") + ", "
                + "tipoSangre=" + (tipoSangre != null ? "'" + tipoSangre + "'" : "NULL") + ", "
                + "tipoVivienda=" + (tipoVivienda != null ? "'" + tipoVivienda + "'" : "NULL") + ", "
                + "direccion=" + (direccion != null ? "'" + direccion + "'" : "NULL") + ", "
                + "barrio=" + (barrio != null ? "'" + barrio + "'" : "NULL") + ", "
                + "celular=" + (celular != null ? "'" + celular + "'" : "NULL") + ", "
                + "email=" + (email != null ? "'" + email + "'" : "NULL") + ", "
                + "estadoCivil=" + (estadoCivil != null ? "'" + estadoCivil + "'" : "NULL") + ", "
                + "nivelEdu=" + (nivelEdu != null ? "'" + nivelEdu + "'" : "NULL") + ", "
                + "profesion=" + (profesion != null ? "'" + profesion + "'" : "NULL") + ", "
                + "cuentaBancaria=" + (cuentaBancaria != null ? "'" + cuentaBancaria + "'" : "NULL") + ", "
                + "numeroCuenta=" + (numeroCuenta != null ? "'" + numeroCuenta + "'" : "NULL") + ", "
                + "tieneHijos=" + (tieneHijos != null ? "'" + tieneHijos + "'" : "NULL") + " "
                + "WHERE identificacion='" + identificacionAnterior + "'";
        System.out.println("Consulta SQL de modificación: " + cadenaSQL);
        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);
        System.out.println("Ejecutando consultaPersona: " + cadenaSQL);

        if (resultado) {
            ConectorBD.ejecutarQuery("DELETE FROM persona_hijos WHERE identificacionPersona = '" + identificacion + "'");

            if (hijos != null) { // Verifica que hijos no sea null
                for (Hijo hijo : hijos) {
                    if (hijo != null && hijo.grabar()) {
                        String relSQL = "INSERT INTO persona_hijos (identificacionPersona, identificacionHijo) VALUES ('" + identificacion + "', '" + hijo.getIdentificacion() + "')";
                        ConectorBD.ejecutarQuery(relSQL);
                    }
                }
            }
        }
        return resultado;
    }

    public boolean eliminar() {
        // Eliminar registros en las tablas relacionadas
        eliminarHijos();
        eliminarInformacionLaboral();
        eliminarReferencia();  // Eliminar registros de la tabla referencia

        // Finalmente, eliminar el registro en la tabla Persona
        String cadenaSQL = "DELETE FROM Persona WHERE identificacion = '" + identificacion + "'";
        ConectorBD.ejecutarQuery(cadenaSQL);

        return true; // Indicar que la eliminación fue exitosa
    }

    private void eliminarHijos() {
        // Eliminar los registros relacionados con los hijos en la tabla persona_hijos
        ConectorBD.ejecutarQuery("DELETE FROM persona_hijos WHERE identificacionPersona = '" + identificacion + "'");
    }

    private void eliminarInformacionLaboral() {
        // Eliminar los registros en la tabla informacionlaboral
        ConectorBD.ejecutarQuery("DELETE FROM informacionlaboral WHERE identificacion = '" + identificacion + "'");
    }

    private void eliminarTrabajo() {
        // Si existe una tabla trabajo, eliminar los registros relacionados
        ConectorBD.ejecutarQuery("DELETE FROM trabajo WHERE identificacion = '" + identificacion + "'");
    }

    private void eliminarReferencia() {
        // Eliminar los registros en la tabla referencia relacionados con la identificacion
        ConectorBD.ejecutarQuery("DELETE FROM referencia WHERE identificacion = '" + identificacion + "'");
    }

    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !"".equals(filtro)) {
            filtro = " WHERE " + filtro;
        } else {
            filtro = " ";
        }
        if (orden != null && !"".equals(orden)) {
            orden = " ORDER BY " + orden;
        } else {
            orden = " ";
        }

        String cadenaSQL = "SELECT identificacion, tipo, tipoDocumento, fechaExpedicion, lugarExpedicion, nombres, apellidos, sexo, fechaNacimiento, "
                + "lugarNacimiento, tipoSangre, tipoVivienda, direccion, barrio, celular, email, estadoCivil, tieneHijos, "
                + " cuentaBancaria, nivelEdu, profesion, numeroCuenta FROM persona " + filtro + orden;

        System.out.println("Ejecutando consultaPersona: " + cadenaSQL);
        return ConectorBD.consultar(cadenaSQL);
    }

    public static List<Persona> getListaEnObjetos(String filtro, String orden) throws SQLException {
        List<Persona> lista = new ArrayList<>();
        try (ResultSet datos = Persona.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    Persona persona = new Persona();
                    persona.setIdentificacion(datos.getString("identificacion"));
                    persona.setTipo(datos.getString("tipo"));
                    persona.setTipoDocumento(datos.getString("tipoDocumento"));
                    persona.setFechaExpedicion(datos.getString("fechaExpedicion"));
                    persona.setLugarExpedicion(datos.getString("lugarExpedicion"));
                    persona.setNombres(datos.getString("nombres"));
                    persona.setApellidos(datos.getString("apellidos"));
                    persona.setSexo(datos.getString("sexo"));
                    persona.setFechaNacimiento(datos.getString("fechaNacimiento"));
                    persona.setLugarNacimiento(datos.getString("lugarNacimiento"));
                    persona.setTipoSangre(datos.getString("tipoSangre"));
                    persona.setTipoVivienda(datos.getString("tipoVivienda"));
                    persona.setDireccion(datos.getString("direccion"));
                    persona.setBarrio(datos.getString("barrio"));
                    persona.setCelular(datos.getString("celular"));
                    persona.setEmail(datos.getString("email"));
                    persona.setEstadoCivil(datos.getString("estadoCivil"));
                    persona.setNivelEdu(datos.getString("nivelEdu"));
                    persona.setProfesion(datos.getString("profesion"));
                    persona.setCuentaBancaria(datos.getString("cuentaBancaria"));
                    persona.setNumeroCuenta(datos.getString("numeroCuenta"));
                    persona.setTieneHijos(datos.getString("tieneHijos"));

                    String sqlHijos = "SELECT h.* FROM hijos h "
                            + "INNER JOIN persona_hijos ph ON h.identificacion = ph.identificacionHijo "
                            + "WHERE ph.identificacionPersona = '" + persona.getIdentificacion() + "'";

                    List<Hijo> listaHijos = new ArrayList<>();
                    try (ResultSet datosHijos = ConectorBD.consultar(sqlHijos)) {
                        if (datosHijos != null) {
                            while (datosHijos.next()) {
                                Hijo hijo = new Hijo();
                                hijo.setIdentificacion(datosHijos.getString("identificacion"));
                                hijo.setTipoIden(datosHijos.getString("tipoIden"));
                                hijo.setNombres(datosHijos.getString("nombres"));
                                hijo.setFechaNacimiento(datosHijos.getString("fechaNacimiento"));
                                hijo.setNivelEscolar(datosHijos.getString("nivelEscolar"));
                                listaHijos.add(hijo);
                            }
                        }
                    }
                    persona.setHijos(listaHijos);
                    lista.add(persona);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Persona.class.getName()).log(Level.SEVERE, "Error al obtener lista de personas", e);
        }
        return lista;
    }

    public static List<String[]> getListaEnArreglosJS(String filtro, String orden) throws SQLException {
        List<String[]> lista = new ArrayList<>();
        try (ResultSet datos = Persona.getLista(filtro, orden)) {
            if (datos != null) {
                while (datos.next()) {
                    String[] persona = new String[]{
                        datos.getString("identificacion"),
                        datos.getString("tipo"),
                        datos.getString("tipoDocumento"),
                        datos.getString("fechaExpedicion"),
                        datos.getString("lugarExpedicion"),
                        datos.getString("nombres"),
                        datos.getString("apellidos"),
                        datos.getString("sexo"),
                        datos.getString("fechaNacimiento"),
                        datos.getString("lugarNacimiento"),
                        datos.getString("tipoSangre"),
                        datos.getString("tipoVivienda"),
                        datos.getString("direccion"),
                        datos.getString("barrio"),
                        datos.getString("celular"),
                        datos.getString("email"),
                        datos.getString("estadoCivil"),
                        datos.getString("tieneHijos"),
                        datos.getString("nivelEdu"),
                        datos.getString("profesion"),
                        datos.getString("cuentaBancaria"),
                        datos.getString("numeroCuenta")

                    };
                    lista.add(persona);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(Persona.class.getName()).log(Level.SEVERE, "Error al obtener lista de personas en arreglo JS", e);
        }
        return lista;
    }

    public String calcularEdad() {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate fechaNac = LocalDate.parse(this.fechaNacimiento, formatter);
            int edad = Period.between(fechaNac, LocalDate.now()).getYears();
            return edad >= 0 ? edad + " años" : "Fecha inválida";
        } catch (Exception e) {
            return "Fecha inválida";
        }
    }
    public static String getNombrePorId(String idPersona) {
    String nombreCompleto = "No encontrado";
    String sql = "SELECT nombres, apellidos FROM persona WHERE identificacion = '" + idPersona + "'";
    try {
        ResultSet rs = ConectorBD.consultar(sql);
        if (rs != null && rs.next()) {
            nombreCompleto = rs.getString("nombres") + " " + rs.getString("apellidos");
        }
    } catch (SQLException ex) {
        System.out.println("Error al obtener el nombre: " + ex.getMessage());
    }
    return nombreCompleto;
}
    
}
