<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
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
        .boton {
            text-align: center;
            margin: 20px 0;
        }
        .boton a {
            background-color: #4CAF50;
            padding: 10px 20px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
    
</head>
<body>
    <h1>Historial de Correos Enviados</h1>
    

    <div class="boton">
        <a href="HistorialCorreos.jsp?tipo=Administradores">Administradores</a>
        <a href="HistorialCorreos.jsp?tipo=Persona">Colaboradores</a>
    </div>

    <table>
        <tr>
            <th>Destinatario</th>
            <th>Fecha de Envío</th>
        </tr>

        <%
            String tipoFiltro = request.getParameter("tipo");
            if (tipoFiltro != null && !tipoFiltro.isEmpty()) {
                tipoFiltro = tipoFiltro.substring(0, 1).toUpperCase() + tipoFiltro.substring(1).toLowerCase(); // Primer letra en mayúscula
            }
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh:mm a"); // Formato para la fecha

            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8";
                conn = DriverManager.getConnection(url, "adso", "utilizar");

                String sql = "SELECT destinatario, tipoDestinatario, fechaEnvio FROM historialCorreos";
                if (tipoFiltro != null && !tipoFiltro.isEmpty()) {
                    sql += " WHERE tipoDestinatario = ?";
                }
                sql += " ORDER BY fechaEnvio DESC";
                
                stmt = conn.prepareStatement(sql);
                if (tipoFiltro != null && !tipoFiltro.isEmpty()) {
                    stmt.setString(1, tipoFiltro);
                }
                rs = stmt.executeQuery();

                while (rs.next()) {
                    String destinatario = rs.getString("destinatario");
              
                    Timestamp fechaEnvio = rs.getTimestamp("fechaEnvio");
        %>

        <tr>
            <td><%= destinatario %></td>
      
            <td><%= sdf.format(fechaEnvio) %></td> <!-- Fecha formateada -->
        </tr>

        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
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
