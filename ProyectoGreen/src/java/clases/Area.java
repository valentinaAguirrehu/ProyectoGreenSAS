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
            case "C1": opcion = "Contabilidad General"; break;
            case "C2": opcion = "Auditoría"; break;
            case "C3": opcion = "Impuestos"; break;
            case "C4": opcion = "Tesorería"; break;
            case "C5": opcion = "Cuentas por Pagar"; break;
            case "C6": opcion = "Cuentas por Cobrar"; break;
            case "C7": opcion = "Presupuestos"; break;
            case "C8": opcion = "Control de Costos"; break;
            case "C9": opcion = "Contabilidad de Gestión"; break;
            case "C10": opcion = "Finanzas Corporativas"; break;
            default: opcion = "No Especificado"; break;
        }
        return opcion;
    }

    @Override
    public String toString() {
        return getOpcion();
    }

    public String getSelectArea(String nombreCampo) {
        StringBuilder html = new StringBuilder();
        html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo).append("'>");

        html.append(getOption("C1", "Contabilidad General", codigo));
        html.append(getOption("C2", "Auditoría", codigo));
        html.append(getOption("C3", "Impuestos", codigo));
        html.append(getOption("C4", "Tesorería", codigo));
        html.append(getOption("C5", "Cuentas por Pagar", codigo));
        html.append(getOption("C6", "Cuentas por Cobrar", codigo));
        html.append(getOption("C7", "Presupuestos", codigo));
        html.append(getOption("C8", "Control de Costos", codigo));
        html.append(getOption("C9", "Contabilidad de Gestión", codigo));
        html.append(getOption("C10", "Finanzas Corporativas", codigo));

        html.append("</select>");
        return html.toString();
    }

    private String getOption(String valor, String texto, String seleccionado) {
        String selected = (valor != null && valor.equals(seleccionado)) ? " selected" : "";
        return "<option value='" + valor + "'" + selected + ">" + texto + "</option>";
    }
}
