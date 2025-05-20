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
            case "X": opcion="XS"; break;
            case "S": opcion="S"; break;
            case "M": opcion="M"; break;
            case "L": opcion="L"; break;
            case "XL": opcion="XL"; break;
            case "XXL": opcion="XXL"; break;
            case "O": opcion="Otro"; break;
            default: opcion="No Especificado"; break;
        }
        return opcion;
    }

    @Override
    public String toString() {
        return getOpcion();
    }
    
   public String getSelectTipoMedidaTalla(String nombreCampo) {
    // Iniciar el HTML 
    StringBuilder html = new StringBuilder();

    // Determina si el valor actual es "Otro" compara que no sea ningun valor definido
    boolean esOtro = !(codigo == null || 
        codigo.equals("XS") || codigo.equals("S") || 
        codigo.equals("M") || codigo.equals("L") ||
        codigo.equals("XL") || codigo.equals("XXL"));

    // Si es otro asigna "O" al valor seleccionado, de lo contrario, usa el valor almacenado en 'codigo'
    String valorSeleccionado = esOtro ? "O" : codigo;

    // Si es "Otro", almacena el valor actual (el texto que el usuario ingresó) para mostrarlo en el campo de texto
    String valorTextoOtro = esOtro ? codigo : "";

    // construye el elemento <select> del formulario, configurando su nombre e id
    html.append("<select name='").append(nombreCampo).append("' id='").append(nombreCampo)
        .append("' onchange='manejarOtro(\"").append(nombreCampo)
        .append("\", \"").append(nombreCampo).append("Otro\", \"").append(nombreCampo).append("Final\")'>");

    // Agrega las opciones del select: "Propia", "Arriendo", "Familiar", "Antricres" y "Otro"
    html.append(getOption("XS", "XS", valorSeleccionado));
    html.append(getOption("S", "S", valorSeleccionado));
    html.append(getOption("M", "M", valorSeleccionado));
    html.append(getOption("L", "L", valorSeleccionado));
    html.append(getOption("XL", "XL", valorSeleccionado));
    html.append(getOption("XXL", "XXL", valorSeleccionado));
    html.append(getOption("O", "Otro", valorSeleccionado));

    // Cierra la etiqueta <select>
    html.append("</select>");

    // Agrega un campo de texto, que se muestra solo si el valor seleccionado es "Otro"
    html.append("<input type='text' id='").append(nombreCampo).append("Otro' ")
        // Si es "Otro", muestra el texto previamente ingresado; si no, deja el campo vacío
        .append("value='").append(valorTextoOtro).append("' ")
        // Configura el estilo para que el campo de texto se muestre solo si es "Otro"
        .append("style='display:").append(esOtro ? "inline-block" : "none").append(";' ")
        // Agrega un texto de sugerencia (placeholder) para el campo de texto
        .append("placeholder='Especifique...' />");

    // Agrega un campo oculto para almacenar el valor final seleccionado (ya sea un valor predeterminado o el texto ingresado)
    html.append("<input type='hidden' name='").append(nombreCampo).append("Final' ")
        .append("id='").append(nombreCampo).append("Final' ")
        // Si 'codigo' es nulo, se asigna un valor vacío
        .append("value='").append(codigo == null ? "" : codigo).append("' />");

    // Devuelve el HTML completo generado como un String
    return html.toString();
}

private String getOption(String valor, String texto, String seleccionado) {
    String selected = (valor != null && valor.equals(seleccionado)) ? " selected" : "";
    return "<option value='" + valor + "'" + selected + ">" + texto + "</option>";
}


}

