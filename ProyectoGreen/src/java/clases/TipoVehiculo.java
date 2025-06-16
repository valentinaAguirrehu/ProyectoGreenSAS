package clases;

/**
 *
 * @author Mary
 */
public class TipoVehiculo {

    private String codigo;

    public TipoVehiculo(String codigo) {
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
        case "S": return "Soltero(a)";
        case "C": return "Casado(a)";
        case "D": return "Divorciado(a)";
        case "V": return "Viudo(a)";
        case "U": return "Unión libre";
        case "O": return "Otro"; // seleccionó explícitamente "Otro"
        default: return codigo; // personalizado: mostrar tal como lo ingresó
    }
}

    @Override
    public String toString() {
        return getOpcion();
    }

  public String getSelectTipoVehiculo(String nombreCampo) {
    StringBuilder html = new StringBuilder();

    // Verifica si es otro tipo no estándar
    boolean esOtro = (codigo != null && 
                     !codigo.equals("A") && 
                     !codigo.equals("M") && 
                     !codigo.equals("O") && 
                     !codigo.trim().isEmpty());

    // Preselecciona "Seleccione" si no hay código
    String valorSeleccionado;
    if (codigo == null || codigo.trim().isEmpty()) {
        valorSeleccionado = ""; // Selecciona "Seleccione"
    } else if (esOtro) {
        valorSeleccionado = "O"; // Marca como "Otro"
    } else {
        valorSeleccionado = codigo; // Usa el valor normal
    }

    // Valor para mostrar en el input si es otro
    String valorTextoOtro = esOtro ? codigo : "";

    html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
        .append("' onchange='manejarOtro(\"").append(nombreCampo)
        .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

    // Opciones del select
    html.append(getOption("", "Seleccione", valorSeleccionado));
    html.append(getOption("M", "Motocicleta", valorSeleccionado));
    html.append(getOption("A", "Automovil", valorSeleccionado));
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
    String selected = valor.equals(seleccionado) ? " selected" : "";
    return "<option value='" + valor + "'" + selected + ">" + texto + "</option>";
}
}