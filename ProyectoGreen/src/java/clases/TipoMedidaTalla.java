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
public class TipoMedidaTalla {

    private String codigo;

    public TipoMedidaTalla(String codigo) {
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
        String opcion = null;
        switch (codigo) {
            case "XS":
                opcion = "XS";
                break;
            case "S":
                opcion = "S";
                break;
            case "M":
                opcion = "M";
                break;
            case "L":
                opcion = "L";
                break;
            case "XL":
                opcion = "XL";
                break;
            case "XXL":
                opcion = "XXL";
                break;
            case "O":
                opcion = "Otro";
                break;
            default:
                opcion = "No aplica";
                break;
        }
        return opcion;
    }

    @Override
    public String toString() {
        return getOpcion();
    }

    public String getSelectTipoMedidaTalla(String nombreCampo) {
        StringBuilder html = new StringBuilder();

        boolean esOtro = !(codigo != null && (codigo.equals("XS") || codigo.equals("S")
                || codigo.equals("M") || codigo.equals("L")
                || codigo.equals("XL") || codigo.equals("XXL")));

        String valorSeleccionado = (codigo == null || codigo.isEmpty()) ? "" : (esOtro ? "O" : codigo);
        String valorTextoOtro = esOtro ? codigo : "";

        html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
                .append("' onchange='manejarOtro(\"").append(nombreCampo)
                .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

        // ✅ Opción por defecto: "Seleccione"
        html.append(getOption("", "Seleccione", valorSeleccionado));

        html.append(getOption("XS", "XS", valorSeleccionado));
        html.append(getOption("S", "S", valorSeleccionado));
        html.append(getOption("M", "M", valorSeleccionado));
        html.append(getOption("L", "L", valorSeleccionado));
        html.append(getOption("XL", "XL", valorSeleccionado));
        html.append(getOption("XXL", "XXL", valorSeleccionado));
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
