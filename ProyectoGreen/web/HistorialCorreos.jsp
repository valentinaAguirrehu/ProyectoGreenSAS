<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Historial de Correos</title>
    
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
        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: #fff;
        }
        th, td {
            border: 1px solid #bbb;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .volver {
            text-align: center;
            margin-top: 20px;
        }
        .volver a {
            text-decoration: none;
            background-color: #4CAF50;
            padding: 10px 20px;
            color: white;
            border-radius: 5px;
        }

        .botones-container {
    width: 80%;
    margin: 0 auto 20px auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.grupo-izquierda, .grupo-derecha {
    display: flex;
    align-items: center;
}

.grupo-izquierda a {
    margin-right: 10px;
}

.boton {
    background-color: #4CAF50; /* Verde bonito */
    color: white;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
    transition: background-color 0.3s;
}

.boton:hover {
    background-color: #45a049;
}

.eliminar {
    background-color: #e74c3c; /* Rojo */
}

.eliminar:hover {
    background-color: #c0392b;
}


    </style>

    <script>
        function validarEliminacion(fechaUltimaEnvio) {
            var fechaLimite = new Date(fechaUltimaEnvio);
            fechaLimite.setHours(fechaLimite.getHours() + 48);
            var ahora = new Date();

            if (ahora < fechaLimite) {
                alert("No se puede eliminar el historial. Deben pasar al menos 48 horas desde el último envío.");
            } else {
                window.location.href = "eliminarHistorial.jsp";
            }
        }
    </script>
</head>
<body>
    <h1>Historial de Correos Enviados</h1>

    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh:mm a");

        Timestamp ultimaFechaEnvio = null;

        String tipoDestinatario = request.getParameter("tipo");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8";
            conn = DriverManager.getConnection(url, "adso", "utilizar");

            String sql = "SELECT id, destinatario, tipoDestinatario, fechaEnvio FROM historialCorreos";
            if (tipoDestinatario != null && !tipoDestinatario.isEmpty()) {
                sql += " WHERE tipoDestinatario = ?";
            }
            sql += " ORDER BY fechaEnvio DESC";

            stmt = conn.prepareStatement(sql);
            if (tipoDestinatario != null && !tipoDestinatario.isEmpty()) {
                stmt.setString(1, tipoDestinatario);
            }

            rs = stmt.executeQuery();

            if (rs.next()) {
                ultimaFechaEnvio = rs.getTimestamp("fechaEnvio");
                rs.beforeFirst();

                String ultimaFechaEnvioString = "";
                if (ultimaFechaEnvio != null) {
                    ultimaFechaEnvioString = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").format(ultimaFechaEnvio);
                }
    %>

 <div class="botones-container">
    <div class="grupo-izquierda">
        <a href="HistorialCorreos.jsp?tipo=Administradores" class="boton">Administradores</a>
        <a href="HistorialCorreos.jsp?tipo=Persona" class="boton">Colaboradores</a>
    </div>

    <div class="grupo-derecha">
        <a href="javascript:void(0);" onclick="validarEliminacion('<%= ultimaFechaEnvioString %>')" class="boton eliminar">Eliminar Historial (Todos)</a>
    </div>
</div>



    <table>
        <tr>
            <th>Destinatario</th>
            <th>Fecha de Envío</th>
        </tr>

        <%
                while (rs.next()) {
                    String destinatario = rs.getString("destinatario");
                    Timestamp fechaEnvio = rs.getTimestamp("fechaEnvio");
        %>
        <tr>
            <td><%= destinatario %></td>
            <td><%= sdf.format(fechaEnvio) %></td>
        </tr>
        <%
                }
            } else {
        %>
        <p style="text-align:center;">No hay registros para mostrar.</p>
        <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='2'>Error: " + e.getMessage() + "</td></tr>");
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
        %>
    </table>

    <div class="volver">
        <a href="index.jsp">Volver al Inicio</a>
    </div>
</body>
</html>
