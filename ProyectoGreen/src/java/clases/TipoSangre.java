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
public class TipoSangre {

    private String codigo;

    public TipoSangre(String codigo) {
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
        if (codigo == null) {
            return "No especificado";
        }
        switch (codigo) {
            case "O+":
                return "O+";
            case "O-":
                return "O-";
            case "A+":
                return "A+";
            case "A-":
                return "A-";
            case "B+":
                return "B+";
            case "B-":
                return "B-";
            case "AB+":
                return "AB+";
            case "AB-":
                return "AB-";
            case "O":
                return "Otro"; // esta es la opción que activa el input, no un valor personalizado
            default:
                return codigo; // 👈 aquí mostramos el valor personalizado tal cual
        }
    }

    @Override
    public String toString() {
        return getOpcion();
    }

    public String getSelectTipoSangre(String nombreCampo) {
        StringBuilder html = new StringBuilder();

        boolean esOtro = !(codigo == null
                || codigo.equals("O+") || codigo.equals("O-")
                || codigo.equals("A+") || codigo.equals("A-")
                || codigo.equals("B+") || codigo.equals("B-")
                || codigo.equals("AB+") || codigo.equals("AB-"));

        String valorSeleccionado = (codigo == null || codigo.isEmpty()) ? "" : (esOtro ? "O" : codigo);
        String valorTextoOtro = esOtro ? codigo : "";

        html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
                .append("' onchange='manejarOtro(\"").append(nombreCampo)
                .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

        // 👇 Aquí se agrega la opción "Seleccione"
        html.append(getOption("", "Seleccione", valorSeleccionado));

        html.append(getOption("O+", "O+", valorSeleccionado));
        html.append(getOption("O-", "O-", valorSeleccionado));
        html.append(getOption("A+", "A+", valorSeleccionado));
        html.append(getOption("A-", "A-", valorSeleccionado));
        html.append(getOption("B+", "B+", valorSeleccionado));
        html.append(getOption("B-", "B-", valorSeleccionado));
        html.append(getOption("AB+", "AB+", valorSeleccionado));
        html.append(getOption("AB-", "AB-", valorSeleccionado));
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
