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
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Mary
 */
public class Persona {

private String identificacion;
private String tipo;
private String idCargo;
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
private String nivelEducativo;
private String eps;
private String estadoCivil;
private String fechaIngreso;
private String fechaRetiro;
private String fechaEtapaLectiva;
private String fechaEtapaProductiva;
private String unidadNegocio;
private String centroCostos;
private String establecimiento;
private String area;
private String tipoCargo;
private String cuentaBancaria;
private String numeroCuenta;
private String salario;
private String primerRefNombre;
private String primerRefParentezco;
private String primerRefCelular;
private String segundaRefNombre;
private String segundaRefParentezco;
private String segundaRefCelular;
private String tieneHijos;
private List<Hijo> hijos = new ArrayList<>();
private String tallaCamisa;
private String tallaChaqueta;
private String tallaPantalon;
private String tallaCalzado;
private String tieneVehiculo;
private String numeroPlacaVehiculo;
private String tipoVehiculo;
private String modeloVehiculo;
private String linea;
private String ano;
private String color;
private String cilindraje;
private String numLicenciaTransito;
private String fechaExpLicenciaTransito;
private String numLicenciaConduccion;
private String fechaExpConduccion;
private String fechaVencimiento;
private String restricciones;
private String estado;


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
                idCargo = resultado.getString("idCargo");
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
                nivelEducativo = resultado.getString("nivelEducativo");
                eps = resultado.getString("eps");
                estadoCivil = resultado.getString("estadoCivil");
                fechaIngreso = resultado.getString("fechaIngreso");
                fechaRetiro = resultado.getString("fechaRetiro");
                fechaEtapaLectiva = resultado.getString("fechaEtapaLectiva");
                fechaEtapaProductiva = resultado.getString("fechaEtapaProductiva");
                unidadNegocio = resultado.getString("unidadNegocio");
                centroCostos = resultado.getString("centroCostos");
                establecimiento = resultado.getString("establecimiento");
                area = resultado.getString("area");
                tipoCargo = resultado.getString("tipoCargo");
                cuentaBancaria = resultado.getString("cuentaBancaria");
                numeroCuenta = resultado.getString("numeroCuenta");
                salario = resultado.getBigDecimal("salario").toString();
                primerRefNombre = resultado.getString("primerRefNombre");
                primerRefParentezco = resultado.getString("primerRefParentezco");
                primerRefCelular = resultado.getString("primerRefCelular");
                segundaRefNombre = resultado.getString("segundaRefNombre");
                segundaRefParentezco = resultado.getString("segundaRefParentezco");
                segundaRefCelular = resultado.getString("segundaRefCelular");
                tieneHijos = resultado.getString("tieneHijos");
                tallaCamisa = resultado.getString("tallaCamisa");
                tallaChaqueta = resultado.getString("tallaChaqueta");
                tallaPantalon = resultado.getString("tallaPantalon");
                tallaCalzado = resultado.getString("tallaCalzado");
                tieneVehiculo = resultado.getString("tieneVehiculo");
                numeroPlacaVehiculo = resultado.getString("numeroPlacaVehiculo");
                tipoVehiculo = resultado.getString("tipoVehiculo");
                modeloVehiculo = resultado.getString("modeloVehiculo");
                linea = resultado.getString("linea");
                ano = resultado.getString("ano");
                color = resultado.getString("color");
                cilindraje = resultado.getString("cilindraje");
                numLicenciaTransito = resultado.getString("numLicenciaTransito");
                fechaExpLicenciaTransito = resultado.getString("fechaExpLicenciaTransito");
                numLicenciaConduccion = resultado.getString("numLicenciaConduccion");
                fechaExpConduccion = resultado.getString("fechaExpConduccion");
                fechaVencimiento = resultado.getString("fechaVencimiento");
                restricciones = resultado.getString("restricciones");
                estado = resultado.getString("estado");

                //  consutoh los hijos de las persona
                this.hijos = Hijo.obtenerHijosDePersona(identificacion);
            }
        } catch (SQLException ex) {
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

    
    public String getTipoVehiculo() {
      String resultado = tipoVehiculo;
        if (tipoVehiculo == null) {
            resultado = "";
        }
        return resultado;
    }

   

    public String getModeloVehiculo() {
    String resultado = modeloVehiculo;
        if (modeloVehiculo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setModeloVehiculo(String modeloVehiculo) {
        this.modeloVehiculo = modeloVehiculo;
    }

    public String getLinea() {
    String resultado = linea;
        if (linea == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setLinea(String linea) {
        this.linea = linea;
    }

    public String getAno() {
        String resultado = ano;
        if (ano == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setAno(String ano) {
        this.ano = ano;
    }

    public String getColor() {
   String resultado = color;
        if (color == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getCilindraje() {
      String resultado = cilindraje;
        if (cilindraje == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setCilindraje(String cilindraje) {
        this.cilindraje = cilindraje;
    }

    public String getNumLicenciaTransito() {
    String resultado = numLicenciaTransito;
        if (numLicenciaTransito == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNumLicenciaTransito(String numLicenciaTransito) {
        this.numLicenciaTransito = numLicenciaTransito;
    }

    public String getFechaExpLicenciaTransito() {
       String resultado = fechaExpLicenciaTransito;
        if (fechaExpLicenciaTransito == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaExpLicenciaTransito(String fechaExpLicenciaTransito) {
        this.fechaExpLicenciaTransito = fechaExpLicenciaTransito;
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

    public String getIdCargo() {
        String resultado = idCargo;
        if (idCargo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setIdCargo(String idCargo) {
        this.idCargo = idCargo;
    }

    public String getTipoDocumento() {
        String resultado = tipoDocumento;
        if (tipoDocumento == null) {
            resultado = "";
        }
        return resultado;
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

    public String getLugarExpedicion() {
        String resultado = lugarExpedicion;
        if (lugarExpedicion == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setLugarExpedicion(String lugarExpedicion) {
        this.lugarExpedicion = lugarExpedicion;
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
    }

    public String getTipoSangre() {
        String resultado = tipoSangre;
        if (tipoSangre == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTipoSangre(String tipoSangre) {
        this.tipoSangre = tipoSangre;
    }

    public String getTipoVivienda() {
        String resultado = tipoVivienda;
        if (tipoVivienda == null) {
            resultado = "";
        }
        return resultado;
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

    public String getNivelEducativo() {
        String resultado = nivelEducativo;
        if (nivelEducativo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNivelEducativo(String nivelEducativo) {
        this.nivelEducativo = nivelEducativo;
    }

    public String getEps() {
        String resultado = eps;
        if (eps == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setEps(String eps) {
        this.eps = eps;
    }

    public String getEstadoCivil() {
        String resultado = estadoCivil;
        if (estadoCivil == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setEstadoCivil(String estadoCivil) {
        this.estadoCivil = estadoCivil;
    }

    public String getFechaIngreso() {
        String resultado = fechaIngreso;
        if (fechaIngreso == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public String getFechaRetiro() {
        String resultado = fechaRetiro;
        if (fechaRetiro == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaRetiro(String fechaRetiro) {
        this.fechaRetiro = fechaRetiro;
    }

    public String getFechaEtapaLectiva() {
        String resultado = fechaEtapaLectiva;
        if (fechaEtapaLectiva == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaEtapaLectiva(String fechaEtapaLectiva) {
        this.fechaEtapaLectiva = fechaEtapaLectiva;
    }

    public String getFechaEtapaProductiva() {
        String resultado = fechaEtapaProductiva;
        if (fechaEtapaProductiva == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaEtapaProductiva(String fechaEtapaProductiva) {
        this.fechaEtapaProductiva = fechaEtapaProductiva;
    }

    public String getUnidadNegocio() {
        String resultado = unidadNegocio;
        if (unidadNegocio == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setUnidadNegocio(String unidadNegocio) {
        this.unidadNegocio = unidadNegocio;
    }

    public String getCentroCostos() {
        String resultado = centroCostos;
        if (centroCostos == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setCentroCostos(String centroCostos) {
        this.centroCostos = centroCostos;
    }

    public String getEstablecimiento() {
        String resultado = establecimiento;
        if (establecimiento == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setEstablecimiento(String establecimiento) {
        this.establecimiento = establecimiento;
    }

    public String getArea() {
        String resultado = area;
        if (area == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getTipoCargo() {
        String resultado = tipoCargo;
        if (tipoCargo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTipoCargo(String tipoCargo) {
        this.tipoCargo = tipoCargo;
    }

    public String getCuentaBancaria() {
        String resultado = cuentaBancaria;
        if (cuentaBancaria == null) {
            resultado = "";
        }
        return resultado;
    }

    public String getTieneVehiculo() {
        return tieneVehiculo;
    }

    public void setTipoVehiculo(String tipoVehiculo) {
        this.tipoVehiculo = tipoVehiculo;
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

    public String getSalario() {
        String resultado = salario;
        if (salario == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setSalario(String salario) {
        this.salario = salario;
    }

    public String getPrimerRefNombre() {
        String resultado = primerRefNombre;
        if (primerRefNombre == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setPrimerRefNombre(String primerRefNombre) {
        this.primerRefNombre = primerRefNombre;
    }

    public String getPrimerRefParentezco() {
        String resultado = primerRefParentezco;
        if (primerRefParentezco == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setPrimerRefParentezco(String primerRefParentezco) {
        this.primerRefParentezco = primerRefParentezco;
    }

    public String getPrimerRefCelular() {
        String resultado = primerRefCelular;
        if (primerRefCelular == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setPrimerRefCelular(String primerRefCelular) {
        this.primerRefCelular = primerRefCelular;
    }

    public String getSegundaRefNombre() {
        String resultado = segundaRefNombre;
        if (segundaRefNombre == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setSegundaRefNombre(String segundaRefNombre) {
        this.segundaRefNombre = segundaRefNombre;
    }

    public String getSegundaRefParentezco() {
        String resultado = segundaRefParentezco;
        if (segundaRefParentezco == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setSegundaRefParentezco(String segundaRefParentezco) {
        this.segundaRefParentezco = segundaRefParentezco;
    }

    public String getSegundaRefCelular() {
        String resultado = segundaRefCelular;
        if (segundaRefCelular == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setSegundaRefCelular(String segundaRefCelular) {
        this.segundaRefCelular = segundaRefCelular;
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

    public String getTallaCamisa() {
        String resultado = tallaCamisa;
        if (tallaCamisa == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTallaCamisa(String tallaCamisa) {
        this.tallaCamisa = tallaCamisa;
    }

    public String getTallaChaqueta() {
        String resultado = tallaChaqueta;
        if (tallaChaqueta == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTallaChaqueta(String tallaChaqueta) {
        this.tallaChaqueta = tallaChaqueta;
    }

    public String getTallaPantalon() {
        String resultado = tallaPantalon;
        if (tallaPantalon == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTallaPantalon(String tallaPantalon) {
        this.tallaPantalon = tallaPantalon;
    }

    public String getTallaCalzado() {
        String resultado = tallaCalzado;
        if (tallaCalzado == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setTallaCalzado(String tallaCalzado) {
        this.tallaCalzado = tallaCalzado;
    }

    public void setTieneVehiculo(String tieneVehiculo) {
        this.tieneVehiculo = tieneVehiculo;
    }

    public String getNumLicenciaConduccion() {
        String resultado = numLicenciaConduccion;
        if (numLicenciaConduccion == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNumLicenciaConduccion(String numLicenciaConduccion) {
        this.numLicenciaConduccion = numLicenciaConduccion;
    }

    public String getFechaExpConduccion() {
        String resultado = fechaExpConduccion;
        if (fechaExpConduccion == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaExpConduccion(String fechaExpConduccion) {
        this.fechaExpConduccion = fechaExpConduccion;
    }

    public String getFechaVencimiento() {
        String resultado = fechaVencimiento;
        if (fechaVencimiento == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaVencimiento(String fechaVencimiento) {
        this.fechaVencimiento = fechaVencimiento;
    }

    public String getRestricciones() {
        String resultado = restricciones;
        if (restricciones == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setRestricciones(String restricciones) {
        this.restricciones = restricciones;
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

    public String getNumeroPlacaVehiculo() {
        String resultado = numeroPlacaVehiculo;
        if (numeroPlacaVehiculo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setNumeroPlacaVehiculo(String numeroPlacaVehiculo) {
        this.numeroPlacaVehiculo = numeroPlacaVehiculo;
    }

    public GeneroPersona getGeneroPersona() {
        return new GeneroPersona(sexo);
    }

    public void setGenero(String genero) {
        this.sexo = genero;
    }

    @Override
    public String toString() {

        String datos = "";
        if (identificacion != null) {
            datos = identificacion + " - " + nombres;
        }
        return datos;
    }

    //public int getEdad() {
    //  LocalDate fechaNacimiento = LocalDate.parse(this.getFechaNacimiento());
    //  LocalDate fechaActual = LocalDate.now();
    //  return Period.between(fechaNacimiento, fechaActual).getYears();
    //}
    public int getEdad() {
        if (fechaNacimiento == null || fechaNacimiento.isEmpty()) {
            return 0; // O un valor por defecto
        }
        try {
            LocalDate fechaNac = LocalDate.parse(fechaNacimiento);
            return Period.between(fechaNac, LocalDate.now()).getYears();
        } catch (DateTimeParseException e) {
            return 0;
        }
    }

public boolean grabar() {
    // 1. Insertar persona con los datos del vehículo incluidos
    String cadenaSQL = "INSERT INTO persona ("
            + "identificacion, tipo, idCargo, tipoDocumento, fechaExpedicion, lugarExpedicion, nombres, apellidos, "
            + "sexo, fechaNacimiento, lugarNacimiento, tipoSangre, tipoVivienda, direccion, barrio, celular, email, "
            + "nivelEducativo, eps, estadoCivil, fechaIngreso, fechaRetiro, fechaEtapaLectiva, fechaEtapaProductiva, "
            + "unidadNegocio, centroCostos, establecimiento, area, tipoCargo, cuentaBancaria, numeroCuenta, salario, "
            + "primerRefNombre, primerRefParentezco, primerRefCelular, segundaRefNombre, segundaRefParentezco, segundaRefCelular, "
            + "tieneHijos, tallaCamisa, tallaChaqueta, tallaPantalon, tallaCalzado, tieneVehiculo, numLicenciaConduccion, "
            + "fechaExpConduccion, fechaVencimiento, restricciones, estado, "
            + "numeroPlacaVehiculo, tipoVehiculo, modeloVehiculo, linea, ano, color, cilindraje, numLicenciaTransito, fechaExpLicenciaTransito) "
            + "VALUES ('" + identificacion + "', '" + tipo + "', " + (idCargo != null ? idCargo : "NULL") + ", '" + tipoDocumento + "', "
            + (fechaExpedicion != null ? "'" + fechaExpedicion + "'" : "NULL") + ", '" + lugarExpedicion + "', '" + nombres + "', '" + apellidos + "', '"
            + sexo + "', " + (fechaNacimiento != null ? "'" + fechaNacimiento + "'" : "NULL") + ", '" + lugarNacimiento + "', '" + tipoSangre + "', '"
            + tipoVivienda + "', '" + direccion + "', '" + barrio + "', '" + celular + "', '" + email + "', '" + nivelEducativo + "', '" + eps + "', '"
            + estadoCivil + "', " + (fechaIngreso != null ? "'" + fechaIngreso + "'" : "NULL") + ", "
            + (fechaRetiro != null ? "'" + fechaRetiro + "'" : "NULL") + ", " + (fechaEtapaLectiva != null ? "'" + fechaEtapaLectiva + "'" : "NULL") + ", "
            + (fechaEtapaProductiva != null ? "'" + fechaEtapaProductiva + "'" : "NULL") + ", '" + unidadNegocio + "', " + centroCostos + ", '"
            + establecimiento + "', '" + area + "', '" + tipoCargo + "', '" + cuentaBancaria + "', '" + numeroCuenta + "', " + salario + ", '"
            + primerRefNombre + "', '" + primerRefParentezco + "', '" + primerRefCelular + "', '" + segundaRefNombre + "', '" + segundaRefParentezco + "', '"
            + segundaRefCelular + "', '" + (tieneHijos != null ? tieneHijos : "N") + "', '" + tallaCamisa + "', '" + tallaChaqueta + "', " + tallaPantalon + ", " + tallaCalzado + ", '"
            + (tieneVehiculo != null ? tieneVehiculo : "N") + "', '" + numLicenciaConduccion + "', "
            + (fechaExpConduccion != null ? "'" + fechaExpConduccion + "'" : "NULL") + ", "
            + (fechaVencimiento != null ? "'" + fechaVencimiento + "'" : "NULL") + ", '" + restricciones + "', '" + estado + "', "
            + (numeroPlacaVehiculo != null ? "'" + numeroPlacaVehiculo + "'" : "NULL") + ", "
            + (tipoVehiculo != null ? "'" + tipoVehiculo + "'" : "NULL") + ", "
            + (modeloVehiculo != null ? "'" + modeloVehiculo + "'" : "NULL") + ", "
            + (linea != null ? "'" + linea + "'" : "NULL") + ", "
            + (ano != null ? "'" + ano + "'" : "NULL") + ", "
            + (color != null ? "'" + color + "'" : "NULL") + ", "
            + (cilindraje != null ? "'" + cilindraje + "'" : "NULL") + ", "
            + (numLicenciaTransito != null ? "'" + numLicenciaTransito + "'" : "NULL") + ", "
            + (fechaExpLicenciaTransito != null ? "'" + fechaExpLicenciaTransito + "'" : "NULL") + ")";

    System.out.println("Cadena SQL: " + cadenaSQL);

    boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);

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
            System.out.println("Error: identificacion o identificacionAnterior es null.");
            return false;
        }

        String cadenaSQL = "UPDATE persona SET "
                + "identificacion='" + identificacion + "', "
                + "tipo=" + (tipo != null ? "'" + tipo + "'" : "NULL") + ", "
                + "idCargo=" + idCargo + ", "
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
                + "nivelEducativo=" + (nivelEducativo != null ? "'" + nivelEducativo + "'" : "NULL") + ", "
                + "eps=" + (eps != null ? "'" + eps + "'" : "NULL") + ", "
                + "estadoCivil=" + (estadoCivil != null ? "'" + estadoCivil + "'" : "NULL") + ", "
                + "salario=" + salario + ", "
                + "tieneHijos=" + (tieneHijos != null ? "'" + tieneHijos + "'" : "NULL") + ", "
                + "estado=" + (estado != null ? "'" + estado + "'" : "NULL") + " "
                + "WHERE identificacion='" + identificacionAnterior + "'";
        
        System.out.println("Consulta SQL de modificación: " + cadenaSQL);
        boolean resultado = ConectorBD.ejecutarQuery(cadenaSQL);

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
        ConectorBD.ejecutarQuery("DELETE FROM persona_hijos WHERE identificacionPersona = '" + identificacion + "'");

        String cadenaSQL = "DELETE FROM Persona WHERE identificacion = '" + identificacion + "'";
        return ConectorBD.ejecutarQuery(cadenaSQL);
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
        
        String cadenaSQL = "SELECT identificacion, tipo, idCargo, tipoDocumento, fechaExpedicion, lugarExpedicion, nombres, apellidos, sexo, fechaNacimiento, " +
                "lugarNacimiento, tipoSangre, tipoVivienda, direccion, barrio, celular, email, nivelEducativo, eps, estadoCivil, fechaIngreso, fechaRetiro, fechaEtapaLectiva, " +
                "fechaEtapaProductiva, unidadNegocio, centroCostos, establecimiento, area, tipoCargo, cuentaBancaria, numeroCuenta, salario, primerRefNombre, primerRefParentezco, " +
                "primerRefCelular, segundaRefNombre, segundaRefParentezco, segundaRefCelular, tieneHijos, tallaCamisa, tallaChaqueta, tallaPantalon, tallaCalzado, tieneVehiculo, " +
                "numeroPlacaVehiculo, tipoVehiculo, modeloVehiculo, linea, ano, color, cilindraje, numLicenciaTransito, fechaExpLicenciaTransito, numLicenciaConduccion, " +
                "fechaExpConduccion, fechaVencimiento, restricciones, estado FROM persona " + filtro + orden;

        System.out.println("Ejecutando consulta: " + cadenaSQL);
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
                    persona.setIdCargo(datos.getString("idCargo"));
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
                    persona.setNivelEducativo(datos.getString("nivelEducativo"));
                    persona.setEps(datos.getString("eps"));
                    persona.setEstadoCivil(datos.getString("estadoCivil"));
                    persona.setFechaIngreso(datos.getString("fechaIngreso"));
                    persona.setFechaRetiro(datos.getString("fechaRetiro"));
                    persona.setFechaEtapaLectiva(datos.getString("fechaEtapaLectiva"));
                    persona.setFechaEtapaProductiva(datos.getString("fechaEtapaProductiva"));
                    persona.setUnidadNegocio(datos.getString("unidadNegocio"));
                    persona.setCentroCostos(datos.getString("centroCostos"));
                    persona.setEstablecimiento(datos.getString("establecimiento"));
                    persona.setArea(datos.getString("area"));
                    persona.setTipoCargo(datos.getString("tipoCargo"));
                    persona.setCuentaBancaria(datos.getString("cuentaBancaria"));
                    persona.setNumeroCuenta(datos.getString("numeroCuenta"));
                    persona.setSalario(datos.getString("salario"));
                    persona.setTieneHijos(datos.getString("tieneHijos"));
                    persona.setTieneVehiculo(datos.getString("tieneVehiculo"));
                    persona.setEstado(datos.getString("estado"));
                    
                    String sqlHijos = "SELECT h.* FROM hijos h "
                            + "INNER JOIN persona_hijos ph ON h.identificacion = ph.identificacionHijo "
                            + "WHERE ph.identificacionPersona = '" + persona.getIdentificacion() + "'";
                    
                    List<Hijo> listaHijos = new ArrayList<>();
                    try (ResultSet datosHijos = ConectorBD.consultar(sqlHijos)) {
                        if (datosHijos != null) {
                            while (datosHijos.next()) {
                                Hijo hijo = new Hijo();
                                hijo.setIdentificacion(datosHijos.getString("identificacion"));
                                hijo.setNombres(datosHijos.getString("nombres"));
                                hijo.setFechaNacimiento(datosHijos.getString("fechaNacimiento"));
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
}
