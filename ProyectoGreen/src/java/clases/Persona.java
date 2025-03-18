/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import clasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
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
    private String tallaCamisa;
    private String tallaChaqueta;
    private String tallaPantalon;
    private String tallaCalzado;
    private String tieneVehiculo;
    private String numLicenciaConduccion;
    private String fechaExpConduccion;
    private String fechaVencimiento;
    private String restricciones;
    private String estado;
    private String idVehiculo;

    public Persona() {
    }

    public Persona(String identificacion) {
        String cadenaSQL = "SELECT tipo, idCargo, tipoDocumento, fechaExpedicion, "
                + "lugarExpedicion, nombres, apellidos, sexo, fechaNacimiento, lugarNacimiento, tipoSangre, "
                + "tipoVivienda, direccion, barrio, email, nivelEducativo, eps, estadoCivil, fechaIngreso, "
                + "fechaRetiro, fechaEtapaLectiva, fechaEtapaProductiva, unidadNegocio, centroCostos, "
                + "establecimiento, area, tipoCargo, cuentaBancaria, numeroCuenta, salario, primerRefNombre, "
                + "primerRefParentezco, primerRefCelular, segundaRefNombre, segundaRefParentezco, segundaRefCelular, "
                + "tieneHijos, tallaCamisa, tallaChaqueta, tallaPantalon, tallaCalzado, tieneVehiculo, "
                + "numLicenciaConduccion, fechaExpConduccion, fechaVencimiento, restricciones,  estado, "
                + " idVehiculo FROM persona WHERE identificacion = '" + identificacion + "'";
              ResultSet resultado = ConectorBD.consultar(cadenaSQL);
        try {
            if (resultado.next()) {
                this.identificacion = identificacion;
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
                salario = resultado.getString("salario");
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
                numLicenciaConduccion = resultado.getString("numLicenciaConduccion");
                fechaExpConduccion = resultado.getString("fechaExpConduccion");
                fechaVencimiento = resultado.getString("fechaVencimiento");
                restricciones = resultado.getString("restricciones");
                estado = resultado.getString("estado");
                idVehiculo = resultado.getString("idVehiculo");
            }
        } catch (SQLException ex) {
            System.out.println("Error al consultar la identificacion" + ex.getMessage());
        }
    }

    public String getIdentificacion() {
        String resultado = identificacion;
        if (identificacion == null)   resultado = "";
        return resultado;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getTipo() {
        String resultado=tipo;
        if(tipo==null) resultado="";
        return resultado;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getIdCargo() {
 String resultado=idCargo;
        if(idCargo==null) resultado="";
        return resultado;    }

    public void setIdCargo(String idCargo) {
        this.idCargo = idCargo;
    }

    public String getTipoDocumento() {
 String resultado=tipoDocumento;
        if(tipoDocumento==null) resultado="";
        return resultado;    }

    public void setTipoDocumento(String tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }

    public String getFechaExpedicion() {
 String resultado=fechaExpedicion;
        if(fechaExpedicion==null) resultado="";
        return resultado;    }

    public void setFechaExpedicion(String fechaExpedicion) {
        this.fechaExpedicion = fechaExpedicion;
    }

    public String getLugarExpedicion() {
 String resultado=lugarExpedicion;
        if(lugarExpedicion==null) resultado="";
        return resultado;    }

    public void setLugarExpedicion(String lugarExpedicion) {
        this.lugarExpedicion = lugarExpedicion;
    }

    public String getNombres() {
        String resultado = nombres;
        if (nombres == null) resultado = "";
        return resultado;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
 String resultado=apellidos;
        if(apellidos==null) resultado="";
        return resultado;    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getSexo() {
 String resultado=sexo;
        if(sexo==null) resultado="";
        return resultado;    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getFechaNacimiento() {
 String resultado=fechaNacimiento;
        if(fechaNacimiento==null) resultado="";
        return resultado;    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getLugarNacimiento() {
 String resultado=lugarNacimiento;
        if(lugarNacimiento==null) resultado="";
        return resultado;    }

    public void setLugarNacimiento(String lugarNacimiento) {
        this.lugarNacimiento = lugarNacimiento;
    }

    public String getTipoSangre() {
 String resultado=tipoSangre;
        if(tipoSangre==null) resultado="";
        return resultado;    }

    public void setTipoSangre(String tipoSangre) {
        this.tipoSangre = tipoSangre;
    }

    public String getTipoVivienda() {
 String resultado=tipoVivienda;
        if(tipoVivienda==null) resultado="";
        return resultado;    }

    public void setTipoVivienda(String tipoVivienda) {
        this.tipoVivienda = tipoVivienda;
    }

    public String getDireccion() {
 String resultado=direccion;
        if(direccion==null) resultado="";
        return resultado;    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getBarrio() {
 String resultado=barrio;
        if(barrio==null) resultado="";
        return resultado;    }

    public void setBarrio(String barrio) {
        this.barrio = barrio;
    }

    public String getEmail() {
        String resultado=email;
        if(email==null) resultado="";
        return resultado;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNivelEducativo() {
 String resultado=nivelEducativo;
        if(nivelEducativo==null) resultado="";
        return resultado;    }

    public void setNivelEducativo(String nivelEducativo) {
        this.nivelEducativo = nivelEducativo;
    }

    public String getEps() {
 String resultado=eps;
        if(eps==null) resultado="";
        return resultado;    }

    public void setEps(String eps) {
        this.eps = eps;
    }

    public String getEstadoCivil() {
 String resultado=estadoCivil;
        if(estadoCivil==null) resultado="";
        return resultado;    }

    public void setEstadoCivil(String estadoCivil) {
        this.estadoCivil = estadoCivil;
    }

    public String getFechaIngreso() {
 String resultado=fechaIngreso;
        if(fechaIngreso==null) resultado="";
        return resultado;    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public String getFechaRetiro() {
 String resultado=fechaIngreso;
        if(fechaIngreso==null) resultado="";
        return resultado;    }

    public void setFechaRetiro(String fechaRetiro) {
        this.fechaRetiro = fechaRetiro;
    }

    public String getFechaEtapaLectiva() {
 String resultado=fechaEtapaLectiva;
        if(fechaEtapaLectiva==null) resultado="";
        return resultado;    }

    public void setFechaEtapaLectiva(String fechaEtapaLectiva) {
        this.fechaEtapaLectiva = fechaEtapaLectiva;
    }

    public String getFechaEtapaProductiva() {
 String resultado=fechaEtapaProductiva;
        if(fechaEtapaProductiva==null) resultado="";
        return resultado;    }

    public void setFechaEtapaProductiva(String fechaEtapaProductiva) {
        this.fechaEtapaProductiva = fechaEtapaProductiva;
    }

    public String getUnidadNegocio() {
 String resultado=unidadNegocio;
        if(unidadNegocio==null) resultado="";
        return resultado;    }

    public void setUnidadNegocio(String unidadNegocio) {
        this.unidadNegocio = unidadNegocio;
    }

    public String getCentroCostos() {
 String resultado=centroCostos;
        if(centroCostos==null) resultado="";
        return resultado;    }

    public void setCentroCostos(String centroCostos) {
        this.centroCostos = centroCostos;
    }

    public String getEstablecimiento() {
        String resultado=establecimiento;
        if(establecimiento==null) resultado="";
        return resultado;
    }

    public void setEstablecimiento(String establecimiento) {
        this.establecimiento = establecimiento;
    }

    public String getArea() {
 String resultado=area;
        if(area==null) resultado="";
        return resultado;    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getTipoCargo() {
 String resultado=tipoCargo;
        if(tipoCargo==null) resultado="";
        return resultado;    }

    public void setTipoCargo(String tipoCargo) {
        this.tipoCargo = tipoCargo;
    }

    public String getCuentaBancaria() {
 String resultado=cuentaBancaria;
        if(cuentaBancaria==null) resultado="";
        return resultado;    }

    public void setCuentaBancaria(String cuentaBancaria) {
        this.cuentaBancaria = cuentaBancaria;
    }

    public String getNumeroCuenta() {
 String resultado=numeroCuenta;
        if(numeroCuenta==null) resultado="";
        return resultado;    }

    public void setNumeroCuenta(String numeroCuenta) {
        this.numeroCuenta = numeroCuenta;
    }

    public String getSalario() {
 String resultado=salario;
        if(salario==null) resultado="";
        return resultado;    }

    public void setSalario(String salario) {
        this.salario = salario;
    }

    public String getPrimerRefNombre() {
 String resultado=primerRefNombre;
        if(primerRefNombre==null) resultado="";
        return resultado;    }

    public void setPrimerRefNombre(String primerRefNombre) {
        this.primerRefNombre = primerRefNombre;
    }

    public String getPrimerRefParentezco() {
 String resultado=primerRefParentezco;
        if(primerRefParentezco==null) resultado="";
        return resultado;    }

    public void setPrimerRefParentezco(String primerRefParentezco) {
        this.primerRefParentezco = primerRefParentezco;
    }

    public String getPrimerRefCelular() {
 String resultado=primerRefCelular;
        if(primerRefCelular==null) resultado="";
        return resultado;    }

    public void setPrimerRefCelular(String primerRefCelular) {
        this.primerRefCelular = primerRefCelular;
    }

    public String getSegundaRefNombre() {
 String resultado=segundaRefNombre;
        if(segundaRefNombre==null) resultado="";
        return resultado;    }

    public void setSegundaRefNombre(String segundaRefNombre) {
        this.segundaRefNombre = segundaRefNombre;
    }

    public String getSegundaRefParentezco() {
 String resultado=segundaRefParentezco;
        if(segundaRefParentezco==null) resultado="";
        return resultado;    }

    public void setSegundaRefParentezco(String segundaRefParentezco) {
        this.segundaRefParentezco = segundaRefParentezco;
    }

    public String getSegundaRefCelular() {
 String resultado=segundaRefCelular;
        if(segundaRefCelular==null) resultado="";
        return resultado;    }

    public void setSegundaRefCelular(String segundaRefCelular) {
        this.segundaRefCelular = segundaRefCelular;
    }

    public String getTieneHijos() {
 String resultado=tieneHijos;
        if(tieneHijos==null) resultado="";
        return resultado;    }

    public void setTieneHijos(String tieneHijos) {
        this.tieneHijos = tieneHijos;
    }

    public String getTallaCamisa() {
 String resultado=tallaCamisa;
        if(tallaCamisa==null) resultado="";
        return resultado;    }

    public void setTallaCamisa(String tallaCamisa) {
        this.tallaCamisa = tallaCamisa;
    }

    public String getTallaChaqueta() {
 String resultado=tallaChaqueta;
        if(tallaCamisa==null) resultado="";
        return resultado;    }

    public void setTallaChaqueta(String tallaChaqueta) {
        this.tallaChaqueta = tallaChaqueta;
    }

    public String getTallaPantalon() {
 String resultado=tallaPantalon;
        if(tallaPantalon==null) resultado="";
        return resultado;    }

    public void setTallaPantalon(String tallaPantalon) {
        this.tallaPantalon = tallaPantalon;
    }

    public String getTallaCalzado() {
 String resultado=tallaCalzado;
        if(tallaCalzado==null) resultado="";
        return resultado;    }

    public void setTallaCalzado(String tallaCalzado) {
        this.tallaCalzado = tallaCalzado;
    }

    public String getTieneVehiculo() {
 String resultado=tieneVehiculo;
        if(tieneVehiculo==null) resultado="";
        return resultado;    }

    public void setTieneVehiculo(String tieneVehiculo) {
        this.tieneVehiculo = tieneVehiculo;
    }

    public String getNumLicenciaConduccion() {
 String resultado=numLicenciaConduccion;
        if(numLicenciaConduccion==null) resultado="";
        return resultado;    }

    public void setNumLicenciaConduccion(String numLicenciaConduccion) {
        this.numLicenciaConduccion = numLicenciaConduccion;
    }

    public String getFechaExpConduccion() {
 String resultado=fechaExpConduccion;
        if(fechaExpConduccion==null) resultado="";
        return resultado;    }

    public void setFechaExpConduccion(String fechaExpConduccion) {
        this.fechaExpConduccion = fechaExpConduccion;
    }

    public String getFechaVencimiento() {
 String resultado=fechaVencimiento;
        if(fechaVencimiento==null) resultado="";
        return resultado;    }

    public void setFechaVencimiento(String fechaVencimiento) {
        this.fechaVencimiento = fechaVencimiento;
    }

    public String getRestricciones() {
 String resultado=restricciones;
        if(restricciones==null) resultado="";
        return resultado;    }

    public void setRestricciones(String restricciones) {
        this.restricciones = restricciones;
    }


    public String getEstado() {
 String resultado=estado;
        if(estado==null) resultado="";
        return resultado;    }

    public void setEstado(String estado) {
        this.estado = estado;
    }


    public String getIdVehiculo() {
 String resultado=idVehiculo;
        if(idVehiculo==null) resultado="";
        return resultado;    }

    public void setIdVehiculo(String idVehiculo) {
        this.idVehiculo = idVehiculo;
    }

    public GeneroPersona getGeneroPersona() {
        return new GeneroPersona(sexo);
    }

    @Override
    public String toString() {

        String datos = "";
        if (identificacion != null) {
            datos = identificacion + " - " + nombres;
        }
        return datos;
    }

    public int getEdad() {
        LocalDate fechaNacimiento = LocalDate.parse(this.getFechaNacimiento());
        LocalDate fechaActual = LocalDate.now();
        return Period.between(fechaNacimiento, fechaActual).getYears();
    }

   public boolean grabar() {
    String cadenaSQL = "INSERT INTO Persona (identificacion, tipo, idCargo, tipoDocumento, fechaExpedicion, lugarExpedicion, nombres, apellidos, sexo, fechaNacimiento, lugarNacimiento, tipoSangre, tipoVivienda, direccion, barrio, email, nivelEducativo, eps, estadoCivil, fechaIngreso, fechaRetiro, fechaEtapaLectiva, fechaEtapaProductiva, unidadNegocio, centroCostos, establecimiento, area, tipoCargo, cuentaBancaria, numeroCuenta, salario, primerRefNombre, primerRefParentezco, primerRefCelular, segundaRefNombre, segundaRefParentezco, segundaRefCelular, tieneHijos, tallaCamisa, tallaChaqueta, tallaPantalon, tallaCalzado, tieneVehiculo, numLicenciaConduccion, fechaExpConduccion, fechaVencimiento, restricciones, estado, idVehiculo) " +
                    "VALUES ('" + identificacion + "', '" + tipo + "', '" + idCargo + "', '" + tipoDocumento + "', " + (fechaExpedicion != null ? "'" + fechaExpedicion + "'" : "NULL") + ", '" + lugarExpedicion + "', '" + nombres + "', '" + apellidos + "', '" + sexo + "', " + (fechaNacimiento != null ? "'" + fechaNacimiento + "'" : "NULL") + ", '" + lugarNacimiento + "', '" + tipoSangre + "', '" + tipoVivienda + "', '" + direccion + "', '" + barrio + "', '" + email + "', '" + nivelEducativo + "', '" + eps + "', '" + estadoCivil + "', " + (fechaIngreso != null ? "'" + fechaIngreso + "'" : "NULL") + ", " + (fechaRetiro != null ? "'" + fechaRetiro + "'" : "NULL") + ", " + (fechaEtapaLectiva != null ? "'" + fechaEtapaLectiva + "'" : "NULL") + ", " + (fechaEtapaProductiva != null ? "'" + fechaEtapaProductiva + "'" : "NULL") + ", '" + unidadNegocio + "', '" + centroCostos + "', '" + establecimiento + "', '" + area + "', '" + tipoCargo + "', '" + cuentaBancaria + "', '" + numeroCuenta + "', '" + salario + "', '" + primerRefNombre + "', '" + primerRefParentezco + "', '" + primerRefCelular + "', '" + segundaRefNombre + "', '" + segundaRefParentezco + "', '" + segundaRefCelular + "', '" + tieneHijos + "', " + (tallaCamisa != null ? "'" + tallaCamisa + "'" : "NULL") + ", " + (tallaChaqueta != null ? "'" + tallaChaqueta + "'" : "NULL") + ", " + (tallaPantalon != null ? "'" + tallaPantalon + "'" : "NULL") + ", " + (tallaCalzado != null ? "'" + tallaCalzado + "'" : "NULL") + ", '" + tieneVehiculo + "', " + (numLicenciaConduccion != null ? "'" + numLicenciaConduccion + "'" : "NULL") + ", " + (fechaExpConduccion != null ? "'" + fechaExpConduccion + "'" : "NULL") + ", " + (fechaVencimiento != null ? "'" + fechaVencimiento + "'" : "NULL") + ", " + (restricciones != null ? "'" + restricciones + "'" : "NULL") + ", " + (estado != null ? "'" + estado + "'" : "NULL") + ", " + (idVehiculo != null ? "'" + idVehiculo + "'" : "NULL") + ")";
    return ConectorBD.ejecutarQuery(cadenaSQL);
}


   public boolean modificar(String identificacionAnterior) {
    String cadenaSQL = "UPDATE Persona SET identificacion='" + identificacion + "', tipo='" + tipo + "', idCargo='" + idCargo + "', tipoDocumento='" + tipoDocumento + "', fechaExpedicion=" + (fechaExpedicion != null ? "'" + fechaExpedicion + "'" : "NULL") + ", " +
                   "lugarExpedicion='" + lugarExpedicion + "', nombres='" + nombres + "', apellidos='" + apellidos + "', sexo='" + sexo + "', fechaNacimiento=" + (fechaNacimiento != null ? "'" + fechaNacimiento + "'" : "NULL") + ", lugarNacimiento='" + lugarNacimiento + "', " +
                   "tipoSangre='" + tipoSangre + "', tipoVivienda='" + tipoVivienda + "', direccion='" + direccion + "', barrio='" + barrio + "', email='" + email + "', nivelEducativo='" + nivelEducativo + "', eps='" + eps + "', " +
                   "estadoCivil='" + estadoCivil + "', fechaIngreso=" + (fechaIngreso != null ? "'" + fechaIngreso + "'" : "NULL") + ", fechaRetiro=" + (fechaRetiro != null ? "'" + fechaRetiro + "'" : "NULL") + ", fechaEtapaLectiva=" + (fechaEtapaLectiva != null ? "'" + fechaEtapaLectiva + "'" : "NULL") + ", fechaEtapaProductiva=" + (fechaEtapaProductiva != null ? "'" + fechaEtapaProductiva + "'" : "NULL") + ", " +
                   "unidadNegocio='" + unidadNegocio + "', centroCostos='" + centroCostos + "', establecimiento='" + establecimiento + "', area='" + area + "', tipoCargo='" + tipoCargo + "', cuentaBancaria='" + cuentaBancaria + "', " +
                   "numeroCuenta='" + numeroCuenta + "', salario='" + salario + "', primerRefNombre='" + primerRefNombre + "', primerRefParentezco='" + primerRefParentezco + "', primerRefCelular='" + primerRefCelular + "', " +
                   "segundaRefNombre='" + segundaRefNombre + "', segundaRefParentezco='" + segundaRefParentezco + "', segundaRefCelular='" + segundaRefCelular + "', tieneHijos='" + tieneHijos + "', tallaCamisa='" + tallaCamisa + "', " +
                   "tallaChaqueta='" + tallaChaqueta + "', tallaPantalon='" + tallaPantalon + "', tallaCalzado='" + tallaCalzado + "', tieneVehiculo='" + tieneVehiculo + "', numLicenciaConduccion=" + (numLicenciaConduccion != null ? "'" + numLicenciaConduccion + "'" : "NULL") + ", " +
                   "fechaExpConduccion=" + (fechaExpConduccion != null ? "'" + fechaExpConduccion + "'" : "NULL") + ", fechaVencimiento=" + (fechaVencimiento != null ? "'" + fechaVencimiento + "'" : "NULL") + ", restricciones=" + (restricciones != null ? "'" + restricciones + "'" : "NULL") + ", estado=" + (estado != null ? "'" + estado + "'" : "NULL") + ", idVehiculo=" + (idVehiculo != null ? "'" + idVehiculo + "'" : "NULL") + " " +
                   "WHERE identificacion='" + identificacionAnterior + "'";

    return ConectorBD.ejecutarQuery(cadenaSQL);
}


    public boolean eliminar() {
        String cadenaSQL = "delete from Persona where identificacion=" + identificacion;
        return ConectorBD.ejecutarQuery(cadenaSQL);
    }

    public static ResultSet getLista(String filtro, String orden) {
        if (filtro != null && !"".equals(filtro)) {
            filtro = " where " + filtro;
        } else {
            filtro = " ";
        }
        if (orden != null && !"".equals(orden)) {
            orden = " order by  " + orden;
        } else {
            orden = " ";

        }
        String cadenaSQL = "select identificacion, tipo, idCargo, tipoDocumento, fechaExpedicion, lugarExpedicion, nombres, apellidos, sexo, fechaNacimiento, lugarNacimiento, tipoSangre, tipoVivienda, direccion, barrio, email, nivelEducativo, eps, estadoCivil, fechaIngreso, fechaRetiro, fechaEtapaLectiva, fechaEtapaProductiva, unidadNegocio, centroCostos, establecimiento, area, tipoCargo, cuentaBancaria, numeroCuenta, salario, primerRefNombre, primerRefParentezco, primerRefCelular, segundaRefNombre, segundaRefParentezco, segundaRefCelular, tieneHijos, tallaCamisa, tallaChaqueta, tallaPantalon, tallaCalzado, tieneVehiculo, numLicenciaConduccion, fechaExpConduccion, fechaVencimiento, restricciones, estado,  idVehiculo from persona " + filtro + orden;
        return ConectorBD.consultar(cadenaSQL);
    }
    public static List<Persona> getListaEnObjetos(String filtro, String orden) {
        List<Persona> lista = new ArrayList<>(); 
        ResultSet datos = Persona.getLista(filtro, orden); 
        if (datos != null) {
            try {
                // Recorrer los resultados y crear objetos de categoría
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
                persona.setPrimerRefNombre(datos.getString("primerRefNombre"));
                persona.setPrimerRefParentezco(datos.getString("primerRefParentezco"));
                persona.setPrimerRefCelular(datos.getString("primerRefCelular"));
                persona.setSegundaRefNombre(datos.getString("segundaRefNombre"));
                persona.setSegundaRefParentezco(datos.getString("segundaRefParentezco"));
                persona.setSegundaRefCelular(datos.getString("segundaRefCelular"));
                persona.setTieneHijos(datos.getString("tieneHijos"));
                persona.setTallaCamisa(datos.getString("tallaCamisa"));
                persona.setTallaChaqueta(datos.getString("tallaChaqueta"));
                persona.setTallaPantalon(datos.getString("tallaPantalon"));
                persona.setTallaCalzado(datos.getString("tallaCalzado"));
                persona.setTieneVehiculo(datos.getString("tieneVehiculo"));
                persona.setNumLicenciaConduccion(datos.getString("numLicenciaConduccion"));
                persona.setFechaExpConduccion(datos.getString("fechaExpConduccion"));
                persona.setFechaVencimiento(datos.getString("fechaVencimiento"));
                persona.setRestricciones(datos.getString("restricciones"));
                persona.setEstado(datos.getString("estado"));
                persona.setIdVehiculo(datos.getString("idVehiculo"));
                lista.add(persona);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Persona.class.getName()).log(Level.SEVERE, "Error al obtener la lista de personas", ex);
        }
    }
    return lista;
}
    

}