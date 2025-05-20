/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Mary
 */
public class InformacionLaboral {

    private String identificacion;
    private String fechaIngreso;
    private String fechaIngresoTemporal;
    private String fechaRetiro;
    private String unidadNegocio;
    private String centroCostos;
    private String establecimiento;
    private String area;
    private String salario;
    private String estado;
    private String fechaTerPriContrato;
    private String establecimientoSeleccionado;

    public InformacionLaboral() {
    }

   public InformacionLaboral(String identificacion) {
    String cadenaSQL = "SELECT identificacion, fechaIngreso, fechaIngresoTemporal, fechaRetiro, unidadNegocio, centroCostos, establecimiento, area, salario, estado, fechaTerPriContrato, establecimientoSeleccionado FROM informacionLaboral WHERE identificacion = " + identificacion;
    ResultSet resultado = ConectorBD.consultar(cadenaSQL);
    try {
        if (resultado != null && resultado.next()) {
            this.identificacion = identificacion;
            fechaIngreso = resultado.getString("fechaIngreso");
            fechaIngresoTemporal = resultado.getString("fechaIngresoTemporal");
            fechaRetiro = resultado.getString("fechaRetiro");
            unidadNegocio = resultado.getString("unidadNegocio");
            centroCostos = resultado.getString("centroCostos");
            establecimiento = resultado.getString("establecimiento");
            area = resultado.getString("area");
            salario = resultado.getString("salario");
            estado = resultado.getString("estado");
            fechaTerPriContrato = resultado.getString("fechaTerPriContrato");
            establecimientoSeleccionado = resultado.getString("establecimientoSeleccionado");
        } else {
            System.out.println("⚠️ No se encontró información laboral para identificación: " + identificacion);
        }
        System.out.println("Consulta ejecutada: " + cadenaSQL);
    } catch (SQLException ex) {
        System.out.println("❌ Error al consultar informacionLaboral: " + ex.getMessage());
    } finally {
        try {
            if (resultado != null) {
                resultado.close();
            }
        } catch (SQLException ex) {
            System.out.println("Error al cerrar ResultSet de informacionLaboral: " + ex.getMessage());
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

    public String getFechaIngresoTemporal() {
        String resultado = fechaIngresoTemporal;
        if (fechaIngresoTemporal == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaIngresoTemporal(String fechaIngresoTemporal) {
        this.fechaIngresoTemporal = fechaIngresoTemporal;
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

        // Imprimir el valor de area para depuración
        //System.out.println("Valor de 'area' en getArea(): " + resultado);
        //return resultado;
    }

    public void setArea(String area) {
        this.area = area;

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

    public String getFechaTerPriContrato() {
        String resultado = fechaTerPriContrato;
        if (fechaTerPriContrato == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setFechaTerPriContrato(String fechaTerPriContrato) {
        this.fechaTerPriContrato = fechaTerPriContrato;
    }

    @Override
    public String toString() {
        return getIdentificacion();
    }

    public String getListaDesplegableEstablecimientos(String establecimientoSeleccionado) {
        StringBuilder lista = new StringBuilder();

        // Lista de establecimientos
        String[] establecimientos = {
            "Avenida", "Principal", "Centro", "Unicentro",
            "Centro de Procesos", "Teleoperaciones", "Juanambu", "Terminal Americano",
            "Puente", "Cano Bajo", "GreenField"
        };

        lista.append("<select name='establecimiento' id='establecimiento' required>");
        lista.append("<option value=''>Seleccione...</option>");

        // Recorrer la lista de establecimientos y marcar el seleccionado
        for (String est : establecimientos) {
            // Si el establecimiento coincide con el valor seleccionado, lo marcamos como 'selected'
            String selected = (establecimientoSeleccionado != null && establecimientoSeleccionado.equals(est)) ? "selected" : "";
            lista.append("<option value='").append(est).append("' ").append(selected).append(">").append(est).append("</option>");
        }

        lista.append("</select>");

        return lista.toString();
    }

    public boolean grabar() {
    boolean exito = false;
    String cadenaSQL = "INSERT INTO informacionLaboral (identificacion, fechaIngreso, fechaIngresoTemporal, fechaRetiro, unidadNegocio, centroCostos, establecimiento, area, salario, estado, fechaTerPriContrato) VALUES ("
        + (identificacion != null && !identificacion.isEmpty() ? "'" + identificacion + "'" : "NULL") + ", "
        + (fechaIngreso != null && !fechaIngreso.isEmpty() ? "'" + fechaIngreso + "'" : "NULL") + ", "
        + (fechaIngresoTemporal != null && !fechaIngresoTemporal.isEmpty() ? "'" + fechaIngresoTemporal + "'" : "NULL") + ", "
        + (fechaRetiro != null && !fechaRetiro.isEmpty() ? "'" + fechaRetiro + "'" : "NULL") + ", "
        + (unidadNegocio != null && !unidadNegocio.isEmpty() ? "'" + unidadNegocio + "'" : "NULL") + ", "
        + (centroCostos != null && !centroCostos.isEmpty() ? "'" + centroCostos + "'" : "NULL") + ", "
        + (establecimiento != null && !establecimiento.isEmpty() ? "'" + establecimiento + "'" : "NULL") + ", "
        + (area != null && !area.isEmpty() ? "'" + area + "'" : "NULL") + ", "
        + salario + ", "
        + (estado != null && !estado.isEmpty() ? "'" + estado + "'" : "NULL") + ", "
        + (fechaTerPriContrato != null && !fechaTerPriContrato.isEmpty() ? "'" + fechaTerPriContrato + "'" : "NULL") + ")";
    exito = ConectorBD.ejecutarQuery(cadenaSQL);
    return exito;

}


 public boolean modificar(String identificacionAnterior) {
    if (identificacion == null || identificacionAnterior == null) {
        System.out.println("Error: claseInfoLaboral identificacion o identificacionAnterior es null.");
        return false;
    }

    // Construir la consulta SQL de modificación
    String cadenaSQL = "UPDATE informacionLaboral SET "
            + "identificacion='" + identificacion + "', "
            + "fechaIngreso=" + (fechaIngreso != null && !fechaIngreso.isEmpty() ? "'" + fechaIngreso + "'" : "NULL") + ", "
            + "fechaIngresoTemporal=" + (fechaIngresoTemporal != null && !fechaIngresoTemporal.isEmpty() ? "'" + fechaIngresoTemporal + "'" : "NULL") + ", "
            + "fechaRetiro=" + (fechaRetiro != null && !fechaRetiro.isEmpty() ? "'" + fechaRetiro + "'" : "NULL") + ", "
            + "unidadNegocio=" + (unidadNegocio != null && !unidadNegocio.isEmpty() ? "'" + unidadNegocio + "'" : "NULL") + ", "
            + "centroCostos=" + (centroCostos != null && !centroCostos.isEmpty() ? "'" + centroCostos + "'" : "NULL") + ", "
            + "establecimiento=" + (establecimiento != null && !establecimiento.isEmpty() ? "'" + establecimiento + "'" : "NULL") + ", "
            + "area=" + (area != null && !area.isEmpty() ? "'" + area + "'" : "NULL") + ", "
            + "salario=" + (salario != null && !salario.isEmpty() ? "'" + salario + "'" : "NULL") + ", "
            + "estado=" + (estado != null && !estado.isEmpty() ? "'" + estado + "'" : "NULL") + ", "
            + "fechaTerPriContrato=" + (fechaTerPriContrato != null && !fechaTerPriContrato.isEmpty() ? "'" + fechaTerPriContrato + "'" : "NULL") + " "
            + "WHERE identificacion='" + identificacionAnterior + "'";

    System.out.println("Consulta SQL de modificación: " + cadenaSQL);
    return ConectorBD.ejecutarQuery(cadenaSQL);
}



    public boolean eliminar() {
        String cadenaSQL = "DELETE FROM informacionLaboral WHERE identificacion = '" + identificacion + "'";
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

        String cadenaSQL = "SELECT identificacion, fechaIngreso, fechaIngresoTemporal, fechaRetiro, unidadNegocio, centroCostos, establecimiento, area, salario, estado, fechaTerPriContrato"
                + "FROM informacionLaboral " + filtro + orden;

        System.out.println("Ejecutando consulta: " + cadenaSQL);
        return ConectorBD.consultar(cadenaSQL);
    }

   public static InformacionLaboral getInformacionPorIdentificacion(String identificacion) {
    InformacionLaboral info = null;
    String sql = "SELECT identificacion, fechaIngreso, fechaIngresoTemporal, fechaRetiro, unidadNegocio, centroCostos, establecimiento, area, salario, estado, fechaTerPriContrato FROM informacionLaboral WHERE identificacion = " + identificacion;
    
    try {
        ResultSet rs = ConectorBD.consultar(sql);
        if (rs != null && rs.next()) {
            info = new InformacionLaboral();
            info.setIdentificacion(rs.getString("identificacion"));
            info.setFechaIngreso(rs.getString("fechaIngreso"));
            info.setFechaIngresoTemporal(rs.getString("fechaIngresoTemporal"));
            info.setFechaRetiro(rs.getString("fechaRetiro"));
            info.setUnidadNegocio(rs.getString("unidadNegocio"));
            info.setCentroCostos(rs.getString("centroCostos"));
            info.setEstablecimiento(rs.getString("establecimiento"));
            info.setArea(rs.getString("area"));
            info.setSalario(rs.getString("salario"));
            info.setEstado(rs.getString("estado"));
            info.setFechaTerPriContrato(rs.getString("fechaTerPriContrato"));
        }
    } catch (Exception e) {
        System.out.println("❌ Error al consultar informacion laboral: " + e.getMessage());
    }

    return info;
}

public static String getFechaIngresoPersona(String identificacionPersona) {
    String sql = "SELECT fechaIngreso FROM informacionLaboral WHERE identificacion = '" + identificacionPersona + "'";


    try {
        ResultSet rs = ConectorBD.consultar(sql);
        if (rs.next()) {
            return rs.getString("fechaIngreso"); // Devuelve la fecha directamente
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return ""; // Si no tiene fecha, devuelve cadena vacía
}


    public String getSelectEstablecimientos() {
        String[] establecimientos = {
            "Avenida", "Principal", "Centro", "Unicentro",
            "Centro de Procesos", "Teleoperaciones", "Juanambu",
            "Terminal Americano", "Puente", "Cano Bajo", "GreenField"
        };

        StringBuilder html = new StringBuilder();
        html.append("<select name=\"establecimiento\" id=\"establecimiento\" onchange=\"precargarUnidadNegocio()\" required>");
        html.append("<option value=\"\">Seleccione...</option>");

        for (String est : establecimientos) {
            html.append("<option value=\"").append(est).append("\"");
            if (est.equals(establecimientoSeleccionado)) {
                html.append(" selected");
            }
            html.append(">").append(est).append("</option>");
        }

        html.append("</select>");
        return html.toString();
    }

    public String getSelectCentroCostos() {
        String[] opciones = {"23", "33", "43", "53", "63", "214", "224", "234", "244", "294", "295"};
        StringBuilder select = new StringBuilder();

        select.append("<select name='centroCostos' required>");
        select.append("<option value='' " + (centroCostos == null || centroCostos.isEmpty() ? "selected" : "") + ">Seleccione...</option>");

        for (String opcion : opciones) {
            if (opcion.equals(centroCostos)) {
                select.append("<option value='").append(opcion).append("' selected>").append(opcion).append("</option>");
            } else {
                select.append("<option value='").append(opcion).append("'>").append(opcion).append("</option>");
            }
        }

        select.append("</select>");
        return select.toString();
    }

    public static boolean esAreaPredefinida(String area) {
        return area != null && (area.equalsIgnoreCase("Linea Media")
                || area.equalsIgnoreCase("Linea Directiva")
                || area.equalsIgnoreCase("Administrativo")
                || area.equalsIgnoreCase("Operativo"));
    }

}



