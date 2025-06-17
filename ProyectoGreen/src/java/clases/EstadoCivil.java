package clases;

public class EstadoCivil {

    private String codigo;

    public EstadoCivil(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return (codigo == null) ? "" : codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getOpcion() {
        if (codigo == null || codigo.trim().isEmpty()) {
            return "No aplica";
        }
        switch (codigo) {
            case "S":
                return "Soltero(a)";
            case "C":
                return "Casado(a)";
            case "D":
                return "Divorciado(a)";
            case "V":
                return "Viudo(a)";
            case "U":
                return "Unión libre";
            case "O":
                return "Otro"; // activa el input de "Especifique..."
            default:
                return codigo;  // si es personalizado, mostrarlo tal cual
        }
    }

    @Override
    public String toString() {
        return getOpcion();
    }

    public String getSelectEstadoCivil(String nombreCampo) {
        StringBuilder html = new StringBuilder();

        String valorCodigo = (codigo == null) ? "" : codigo.trim();

        // Validar si es otro valor personalizado
        boolean esOtro = !(valorCodigo.equals("S") || valorCodigo.equals("C")
                || valorCodigo.equals("D") || valorCodigo.equals("V")
                || valorCodigo.equals("U") || valorCodigo.equals("O") || valorCodigo.isEmpty());

        String valorSeleccionado = valorCodigo.isEmpty() ? "" : (esOtro ? "O" : valorCodigo);
        String valorTextoOtro = esOtro ? valorCodigo : "";

        html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
                .append("' onchange='manejarOtro(\"").append(nombreCampo)
                .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

        html.append(getOption("", "Seleccione", valorSeleccionado));
        html.append(getOption("S", "Soltero(a)", valorSeleccionado));
        html.append(getOption("C", "Casado(a)", valorSeleccionado));
        html.append(getOption("D", "Divorciado(a)", valorSeleccionado));
        html.append(getOption("V", "Viudo(a)", valorSeleccionado));
        html.append(getOption("U", "Unión libre", valorSeleccionado));
        html.append(getOption("O", "Otro", valorSeleccionado));

        html.append("</select>");

        html.append("<input type='text' id='").append(nombreCampo).append("Otro' ")
                .append("value='").append(valorTextoOtro).append("' ")
                .append("style='display:").append(esOtro ? "inline-block" : "none").append(";' ")
                .append("placeholder='Especifique...' />");

        html.append("<input type='hidden' name='").append(nombreCampo).append("Final' ")
                .append("id='").append(nombreCampo).append("Final' ")
                .append("value='").append(valorCodigo).append("' />");

        return html.toString();
    }

    private String getOption(String valor, String texto, String seleccionado) {
        boolean selected = valor.equals(seleccionado);
        return "<option value='" + valor + "'" + (selected ? " selected" : "") + ">" + texto + "</option>";
    }
}
