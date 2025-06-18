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
public class TipoVivienda {

    private String codigo;

    public TipoVivienda(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        String resultado = codigo;
        if (codigo == null) {
            resultado = "";
        }
        return resultado;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getOpcion() {
        if (codigo == null || codigo.trim().isEmpty()) {
            return "No aplica";
        }
        switch (codigo) {
            case "P":
                return "Propia";
            case "A":
                return "Arriendo";
            case "F":
                return "Familiar";
            case "T":
                return "Antricres";
            case "O":
                return "Otro"; // Esto activa el input, pero no es un valor personalizado
            default:
                return codigo; // 👉 Mostrar tal cual lo que se escribió
        }
    }

    @Override
    public String toString() {
        return getOpcion();
    }

    public String getSelectTipoVivienda(String nombreCampo) {
        StringBuilder html = new StringBuilder();

        boolean esOtro = !(codigo == null
                || codigo.equals("P") || codigo.equals("A")
                || codigo.equals("F") || codigo.equals("T"));

        String valorSeleccionado = (codigo == null || codigo.isEmpty()) ? "" : (esOtro ? "O" : codigo);
        String valorTextoOtro = esOtro ? codigo : "";

        html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
                .append("' onchange='manejarOtro(\"").append(nombreCampo)
                .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

        // 👇 Agregar opción "Seleccione"
        html.append(getOption("", "Seleccione", valorSeleccionado));

        html.append(getOption("P", "Propia", valorSeleccionado));
        html.append(getOption("A", "Arriendo", valorSeleccionado));
        html.append(getOption("F", "Familiar", valorSeleccionado));
        html.append(getOption("T", "Antricres", valorSeleccionado));
        html.append(getOption("O", "Otro", valorSeleccionado));

        html.append("</select>");

        html.append("<input type='text' id='").append(nombreCampo).append("Otro' ")
                .append("value='").append(valorTextoOtro).append("' ")
                .append("style='display:").append(esOtro ? "inline-block" : "none").append(";' ")
                .append("placeholder='Especifique...' />");

        html.append("<input type='hidden' name='").append(nombreCampo).append("Final' ")
                .append("id='").append(nombreCampo).append("Final' ")
                .append("value='").append(codigo == null ? "" : codigo).append("' />");

        return html.toString();
    }

    private String getOption(String valor, String texto, String seleccionado) {
        String selected = (valor != null && valor.equals(seleccionado)) ? " selected" : "";
        return "<option value='" + valor + "'" + selected + ">" + texto + "</option>";
    }

}
