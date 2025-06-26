package clases;

/**
 *
 * @author Mary
 */
public class Area { 

    private String codigo;

    public Area(String codigo) {
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
            case "C1": opcion = "Gerenciales"; break;
            case "C2": opcion = "Directivos"; break;
            case "C3": opcion = "Administrativos"; break;
            case "C4": opcion = "Operativos"; break;
            case "C5": opcion = "Otros"; break;
            case "NA": opcion = "Seleccionar"; break;
            default: opcion = "No aplica"; break;
        }
        return opcion;
    }

    @Override
    public String toString() {
        return (codigo != null) ? getOpcion() : "No aplica";
    }

    public String getSelectArea(String nombreCampo) {
        StringBuilder html = new StringBuilder();
        html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo).append("'>");

        // Opción por defecto
        html.append(getOption("NA", "Seleccionar", codigo));
        html.append(getOption("C1", "Gerenciales", codigo));
        html.append(getOption("C2", "Directivos", codigo));
        html.append(getOption("C3", "Administrativos", codigo));
        html.append(getOption("C4", "Operativos", codigo));
        html.append(getOption("C5", "Otros", codigo));

        html.append("</select>");
        return html.toString();
    }

    private String getOption(String valor, String texto, String seleccionado) {
        String selected = (valor != null && valor.equals(seleccionado)) ? " selected" : "";
        return "<option value='" + valor + "'" + selected + ">" + texto + "</option>";
    }
}
