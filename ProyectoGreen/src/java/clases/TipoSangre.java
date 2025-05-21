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
        String resultado=codigo;
        if(codigo==null) resultado="";
        return resultado;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
    
    public String getOpcion(){
        String opcion=null;
        switch(codigo){
            case "O+": opcion="O+"; break;
            case "O-": opcion="O-"; break;
            case "A+": opcion="A+"; break;
            case "A-": opcion="A-"; break;
            case "B+": opcion="B+"; break;
            case "B-": opcion="B-"; break;
            case "AB+": opcion="AB+"; break;
            case "AB-": opcion="AB-"; break;
            case "O": opcion="Otro"; break;
            default: opcion="No Especificado"; break;
        }
        return opcion;
    }

    @Override
    public String toString() {
        return getOpcion();
    }
    
public String getSelectTipoSangre(String nombreCampo) {
    StringBuilder html = new StringBuilder();

    // Determinar si es un valor personalizado
    boolean esOtro = !(codigo == null || 
        codigo.equals("O+") || codigo.equals("O-") || 
        codigo.equals("A+") || codigo.equals("A-") || 
        codigo.equals("B+") || codigo.equals("B-") || 
        codigo.equals("AB+") || codigo.equals("AB-"));

    String valorSeleccionado = esOtro ? "O" : codigo;
    String valorTextoOtro = esOtro ? codigo : "";

    html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
        .append("' onchange='manejarOtro(\"").append(nombreCampo)
        .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

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

    // Campo de texto precargado con el valor si es "Otro"
    html.append("<input type='text' id='").append(nombreCampo).append("Otro' ")
        .append("value='").append(valorTextoOtro).append("' ")
        .append("style='display:").append(esOtro ? "inline-block" : "none").append(";' ")
        .append("placeholder='Especifique...' />");

    // Campo oculto con el valor final (ya prellenado)
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

