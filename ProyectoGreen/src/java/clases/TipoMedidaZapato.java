package clases;

/**
 *
 * @author Mary
 */
public class TipoMedidaZapato {

    private String codigo;

    public TipoMedidaZapato(String codigo) {
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
            if ("O".equals(codigo)) return "Otro";
            return codigo; // Por si alguien pone "36.5", etc.
        }
    }

    @Override
    public String toString() {
        return getOpcion();
    }

    public String getSelectTipoMedidaZapato(String nombreCampo) {
        StringBuilder html = new StringBuilder();

        // Solo tallas válidas del 34 al 40
        boolean esOtro = !(codigo != null && codigo.matches("^(34|35|36|37|38|39|40)$"));

        String valorSeleccionado = (codigo == null || codigo.isEmpty()) ? "" : (esOtro ? "O" : codigo);
        String valorTextoOtro = esOtro ? (codigo == null ? "" : codigo) : "";

        // Inicio del <select>
        html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
            .append("' onchange='manejarOtro(\"").append(nombreCampo)
            .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

        // Opción por defecto
        html.append(getOption("", "Seleccione", valorSeleccionado));

        // Tallas numéricas de 34 a 40 (de 1 en 1)
        for (int i = 34; i <= 40; i++) {
            html.append(getOption(String.valueOf(i), String.valueOf(i), valorSeleccionado));
        }

        // Opción "Otro"
        html.append(getOption("O", "Otro", valorSeleccionado));

        // Fin del <select>
        html.append("</select>");

        // Campo visible para "Otro"
        html.append("<input type='text' id='").append(nombreCampo).append("Otro' ")
            .append("value='").append(valorTextoOtro).append("' ")
            .append("style='display:").append(esOtro ? "inline-block" : "none").append(";' ")
            .append("placeholder='Especifique...' />");

        // Campo oculto con el valor final a enviar
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
