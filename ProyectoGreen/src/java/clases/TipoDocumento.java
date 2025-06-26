package clases;

public class TipoDocumento {

    private String codigo;

    public TipoDocumento(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return (codigo != null) ? codigo : "";
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getOpcion() {
        switch (codigo) {
            case "C": return "Cédula de Ciudadanía";
            case "T": return "Tarjeta de Identidad";
            case "E": return "Cédula de Extranjería";
            case "P": return "Permiso Temporal";
            case "O": return "Otro";
            default: return "No Especificado";
        }
    }

    @Override
    public String toString() {
        return getOpcion();
    }

    public String getSelectTipoDocumento(String nombreCampo) {
        StringBuilder html = new StringBuilder();

        boolean esOtro = !(codigo == null ||
                codigo.equals("C") || codigo.equals("E") ||
                codigo.equals("T") || codigo.equals("P"));

        String valorSeleccionado = esOtro ? "O" : (codigo != null ? codigo : "");
        String valorTextoOtro = esOtro ? codigo : "";

        html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
            .append("' onchange='manejarOtro(\"").append(nombreCampo)
            .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

        // Nueva línea: opción "Seleccionar..."
        html.append(getOption("", "Seleccionar...", valorSeleccionado));

        html.append(getOption("C", "Cédula de Ciudadanía", valorSeleccionado));
        html.append(getOption("T", "Tarjeta de Identidad", valorSeleccionado));
        html.append(getOption("E", "Cédula de Extranjería", valorSeleccionado));
        html.append(getOption("P", "Permiso Temporal", valorSeleccionado));
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
