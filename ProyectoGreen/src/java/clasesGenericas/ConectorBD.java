/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clasesGenericas;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class ConectorBD {

    public static ResultSet consultar(String cadenaSQL, String identificacion) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public static Object getConnection() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    private String servidor;
    private String puerto;
    private String usuario;
    private String clave;
    private String baseDatos;
    
    
    public Connection conexion; //lleva la conexion a la base de datos

    public ConectorBD() {
        servidor="localhost";
        puerto="3306";
        usuario="adso";
        clave="utilizar";
        baseDatos="proyectoGreen";
        
    }
    
    public boolean conectar (){
        boolean conectado= false;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Driver ok");
            //jdbc:mysql://localhost:3306/tienda
            String cadenaConexion="jdbc:mysql://"+servidor+":"+puerto+"/"+baseDatos+"?characterEncoding=utf8";
            //el parametro character... nos permite agregar ñ, tildes..
            conexion=(Connection) DriverManager.getConnection(cadenaConexion, usuario, clave);
            System.out.println("Conectado a la BD");
            conectado=true;
        } catch (ClassNotFoundException ex) {
            //Logger.getLogger(ConectorBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error en el controlador en la base de datos"+ex.getMessage());//Error del controlador
        } catch (SQLException ex) {
            //Logger.getLogger(ConectorBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al conectarse a la base de datos"+ex.getMessage());//Error de la base de datos
        }
        
        return conectado; 
    } 
   //con conectar funciona, pero el sistema se empieza hacer lento, por la acumulacion de conexiones, entonces por eso se necesita desconectar  
  public void desconectar(){
        try {
            conexion.close();
            System.out.println("Desconectado de la BD");
        } catch (SQLException ex) {
            //Logger.getLogger(ConectorBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al desconectar la BD"+ ex.getMessage());
        }
  }
    
 //static=no es necesario instanciar la clase
 //result=clase que devuelve los resultados como un select en BD
  public static ResultSet consultar(String cadenaSQL){ // getDatos de Archivo
      ResultSet resultado=null;
      ConectorBD conector= new ConectorBD();
      if(!conector.conectar()) System.out.println("Error al conectarse al bd");
        try {
            PreparedStatement sentencia=conector.conexion.prepareStatement(cadenaSQL, ResultSet.TYPE_SCROLL_SENSITIVE,0);
            resultado=sentencia.executeQuery();
        } catch (SQLException ex) {
            //Logger.getLogger(ConectorBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error en la cadenaSQL. "+cadenaSQL+". "+ex.getMessage());
        }
       //conector.desconectar();
      return resultado;
  }
  
  public static boolean ejecutarQuery(String cadenaSQL){
      boolean resultado = false;
      ConectorBD conector = new ConectorBD();
       if(!conector.conectar()) System.out.println("Error al conectarse al bd");
        try {
            PreparedStatement sentencia=conector.conexion.prepareStatement(cadenaSQL);
            resultado= sentencia.execute();
            resultado=true;
        } catch (SQLException ex) {
            //Logger.getLogger(ConectorBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error en la cadenaSQL. "+cadenaSQL+". "+ex.getMessage());
        }
        conector.desconectar();
        return resultado;
  }
  
}
