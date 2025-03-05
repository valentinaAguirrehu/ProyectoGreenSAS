/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

/**
 *
 * @author Angie
 */
public class GeneroPersona {
    
    private String codigo;

    public GeneroPersona(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
   
    public String getOpcion(){
        String opcion=null;
        switch(codigo){
            case "M": opcion="Masculino"; break;
            case "F": opcion="Femenino"; break;
            default: opcion="No Especificado"; break;
        }
        return opcion;
    }

    @Override
    public String toString() {
        return getOpcion();
    }
   
    public String getRadioButtons(){
    String lista="";
    if(codigo==null) codigo="";
    switch(codigo){
        case "M":
            lista="<input type='radio' name='sexo' value='M' checked>Masculino"
                    + "<input type='radio' name='genero' value='F'>Femenino";
            break;
        case "F":
             lista="<input type='radio' name='sexo' value='M' >Masculino"
                    + "<input type='radio' name='genero' value='F' checked>Femenino";
             break;
        default:
            lista="<input type='radio' name='sexo' value='M' checked>Masculino"
                    + "<input type='radio' name='genero' value='F'>Femenino";
            break;
    }
    return lista;
    }
}


