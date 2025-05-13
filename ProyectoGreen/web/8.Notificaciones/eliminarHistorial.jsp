<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Historial</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f7f7f7;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .mensaje {
            text-align: center;
            font-size: 18px;
        }
        .boton {
            text-align: center;
            margin-top: 20px;
        }
        .boton a {
            background-color: #4CAF50;
            padding: 10px 20px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .boton a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<%
    // Conexión a la base de datos
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    boolean eliminado = false;

    try {
        // Establecer conexión
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8";
        conn = DriverManager.getConnection(url, "adso", "utilizar");

        // Obtener el último registro para comparar la fecha
        String sqlUltimaFecha = "SELECT fechaEnvio FROM historialCorreos ORDER BY fechaEnvio DESC LIMIT 1";
        stmt = conn.prepareStatement(sqlUltimaFecha);
        rs = stmt.executeQuery();

        if (rs.next()) {
            Timestamp ultimaFechaEnvio = rs.getTimestamp("fechaEnvio");
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh:mm a");

            // Verificar si han pasado más de 5 minutos
            long diferenciaMinutos = (System.currentTimeMillis() - ultimaFechaEnvio.getTime()) / (1000 * 60);
            if (diferenciaMinutos >= 5) {
                // Si han pasado más de 5 minutos, eliminar los registros
                String sqlEliminar = "DELETE FROM historialCorreos";
                stmt = conn.prepareStatement(sqlEliminar);
                int filasEliminadas = stmt.executeUpdate();

                if (filasEliminadas > 0) {
                    eliminado = true;
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

<%
    if (eliminado) {
%>
    <div class="mensaje">
        <p>¡Historial eliminado con éxito!</p>
    </div>
<%
    } else {
%>
    <div class="mensaje">
        <p>No se puede eliminar el historial. Deben pasar al menos 5 minutos desde el último envío.</p>
    </div>
<%
    }
%>

<div class="boton">
    <a href="HistorialCorreos.jsp">Volver al Historial</a>
</div>

</body>
</html>
