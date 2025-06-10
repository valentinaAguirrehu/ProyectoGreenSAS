package clasesGenericas;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConectorBD {

    private String servidor;
    private String puerto;
    private String usuario;
    private String clave;
    private String baseDatos;

    public Connection conexion;

    public ConectorBD() {
        servidor = "localhost";
        puerto = "3306";
        usuario = "adso";
        clave = "utilizar";
        baseDatos = "proyectogreen";
    }

    public boolean conectar() {
        boolean conectado = false;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Driver cargado correctamente");
            String cadenaConexion = "jdbc:mysql://" + servidor + ":" + puerto + "/" + baseDatos + "?characterEncoding=utf8";
            conexion = DriverManager.getConnection(cadenaConexion, usuario, clave);
            System.out.println("Conectado a la base de datos");
            conectado = true;
        } catch (ClassNotFoundException ex) {
            System.out.println("Error en el controlador de la base de datos: " + ex.getMessage());
        } catch (SQLException ex) {
            System.out.println("Error al conectarse a la base de datos: " + ex.getMessage());
        }
        return conectado;
    }

    public void desconectar() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
                System.out.println("Desconectado de la base de datos");
            }
        } catch (SQLException ex) {
            System.out.println("Error al desconectar la base de datos: " + ex.getMessage());
        }
    }

    // Método para consultas simples
    public static ResultSet consultar(String cadenaSQL) {
        ResultSet resultado = null;
        ConectorBD conector = new ConectorBD();
        if (!conector.conectar()) {
            System.out.println("Error al conectarse a la base de datos");
            return null;
        }
        try {
            PreparedStatement sentencia = conector.conexion.prepareStatement(
                cadenaSQL, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY
            );
            resultado = sentencia.executeQuery();
        } catch (SQLException ex) {
            System.out.println("Error en la consulta SQL: " + cadenaSQL + ". " + ex.getMessage());
        }
        return resultado;
    }

    // Método para consultas con un parámetro (como WHERE identificacion = ?)
    public static ResultSet consultar(String cadenaSQL, String identificacion) {
        ResultSet resultado = null;
        ConectorBD conector = new ConectorBD();
        if (!conector.conectar()) {
            System.out.println("Error al conectarse a la base de datos");
            return null;
        }
        try {
            PreparedStatement sentencia = conector.conexion.prepareStatement(
                cadenaSQL, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY
            );
            sentencia.setString(1, identificacion);
            resultado = sentencia.executeQuery();
        } catch (SQLException ex) {
            System.out.println("Error en la consulta con parámetro. SQL: " + cadenaSQL + ". " + ex.getMessage());
        }
        return resultado;
    }

    // Método para ejecutar sentencias tipo INSERT, UPDATE, DELETE
    public static boolean ejecutarQuery(String cadenaSQL) {
        boolean resultado = false;
        ConectorBD conector = new ConectorBD();
        if (!conector.conectar()) {
            System.out.println("Error al conectarse a la base de datos");
            return false;
        }
        try {
            PreparedStatement sentencia = conector.conexion.prepareStatement(cadenaSQL);
            sentencia.execute();
            resultado = true;
        } catch (SQLException ex) {
            System.out.println("Error al ejecutar query. SQL: " + cadenaSQL + ". " + ex.getMessage());
        } finally {
            conector.desconectar();
        }
        return resultado;
    }

    // Si necesitas exponer la conexión (no recomendado sin control)
    public static Connection getConnection() {
        ConectorBD conector = new ConectorBD();
        if (conector.conectar()) {
            return conector.conexion;
        }
        return null;
    }
}
