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
public class EstadoCivil {
    
    private String codigo;

    public EstadoCivil(String codigo) {
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
            case "S": opcion="Soltero(a)"; break;
            case "C": opcion="Casado(a)"; break;
            case "D": opcion="Divorciado(a)"; break;
            case "V": opcion="Viudo(a)"; break;
            case "U": opcion="Union libre"; break;
            case "O": opcion="Otro"; break;
            default: opcion="No Especificado"; break;
        }
        return opcion;
    }

    @Override
    public String toString() {
        return getOpcion();
    }
    
public String getSelectEstadoCivil(String nombreCampo) {
    StringBuilder html = new StringBuilder();

    // Determinar si es un valor personalizado
    boolean esOtro = !(codigo == null || 
        codigo.equals("S") || codigo.equals("C") || 
        codigo.equals("D") || codigo.equals("V") || 
        codigo.equals("U") ); 

    String valorSeleccionado = esOtro ? "O" : codigo;
    String valorTextoOtro = esOtro ? codigo : "";

    html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
        .append("' onchange='manejarOtro(\"").append(nombreCampo)
        .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

    html.append(getOption("S", "Soltero(a)", valorSeleccionado));
    html.append(getOption("C", "Casado(a)", valorSeleccionado));
    html.append(getOption("D", "Divorciado(a)", valorSeleccionado));
    html.append(getOption("V", "Viudo(a)", valorSeleccionado));
    html.append(getOption("U", "Union libre", valorSeleccionado));
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

