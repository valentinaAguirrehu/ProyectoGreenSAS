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

public class TipoMedidaTallaNumerica {

    private String codigo;

    public TipoMedidaTallaNumerica(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return (codigo == null) ? "" : codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getOpcion() {
        if (codigo == null) return "No especificado";

        try {
            int talla = Integer.parseInt(codigo);
            return String.valueOf(talla);
        } catch (NumberFormatException e) {
            if (codigo.equals("O")) return "Otro";
            return codigo; // por si alguien pone "27.5", etc.
        }
    }

    @Override
    public String toString() {
        return getOpcion();
    }

    public String getSelectTipoMedidaTalla(String nombreCampo) {
        StringBuilder html = new StringBuilder();

        boolean esOtro = !(codigo != null && codigo.matches("^(6|8|10|12|14|16|18|20|22|24|26|28|30|32|34|36|38|40)$"));
        String valorSeleccionado = esOtro ? "O" : codigo;
String valorTextoOtro = esOtro ? (codigo == null ? "" : codigo) : "";

        html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
            .append("' onchange='manejarOtro(\"").append(nombreCampo)
            .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

        for (int i = 6; i <= 40; i += 2) {
            html.append(getOption(String.valueOf(i), String.valueOf(i), valorSeleccionado));
        }

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
