/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

/**
 *
 * @author Mary
 */
public class LugarTrabajo {

    private String codigo;

    public LugarTrabajo(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return codigo == null ? "" : codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getOpcion() {
        String opcion;
        switch (codigo) {
            case "E1": opcion = "EDS Juanambu"; break;
            case "E2": opcion = "EDS Terminal Americano"; break;
            case "E3": opcion = "EDS Puente"; break;
            case "E4": opcion = "EDS Cano Bajo"; break;

            case "R1": opcion = "RPS Avenida"; break;
            case "R2": opcion = "RPS Principal"; break;
            case "R3": opcion = "RPS Centro"; break;
            case "R4": opcion = "RPS Unicentro"; break;
            case "R5": opcion = "RPS Centro de Procesos"; break;
            case "R6": opcion = "RPS Teleoperaciones"; break;

            default: opcion = "No Especificado"; break;
        }
        return opcion;
    }

    @Override
    public String toString() {
        return getOpcion();
    }

    public String getSelectLugarTrabajo(String nombreCampo) {
        StringBuilder html = new StringBuilder();
        html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo).append("'>");

        html.append(getOption("E1", "EDS Juanambu", codigo));
        html.append(getOption("E2", "EDS Terminal Americano", codigo));
        html.append(getOption("E3", "EDS Puente", codigo));
        html.append(getOption("E4", "EDS Cano Bajo", codigo));

        html.append(getOption("R1", "RPS Avenida", codigo));
        html.append(getOption("R2", "RPS Principal", codigo));
        html.append(getOption("R3", "RPS Centro", codigo));
        html.append(getOption("R4", "RPS Unicentro", codigo));
        html.append(getOption("R5", "RPS Centro de Procesos", codigo));
        html.append(getOption("R6", "RPS Teleoperaciones", codigo));

        html.append("</select>");
        return html.toString();
    }

    private String getOption(String valor, String texto, String seleccionado) {
        String selected = (valor != null && valor.equals(seleccionado)) ? " selected" : "";
        return "<option value='" + valor + "'" + selected + ">" + texto + "</option>";
    }
}
