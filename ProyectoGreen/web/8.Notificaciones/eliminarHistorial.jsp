<%@ page import="java.sql.*" %>
<%
    response.setContentType("text/plain");
    String tipo = request.getParameter("tipo");
    if (tipo == null) {
        out.print("faltaTipo");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8",
            "adso", "utilizar");

        stmt = conn.prepareStatement(
            "SELECT fechaEnvio FROM historialCorreos WHERE tipoDestinatario = ? ORDER BY fechaEnvio DESC LIMIT 1");
        stmt.setString(1, tipo);
        rs = stmt.executeQuery();

        if (rs.next()) {
            Timestamp ultimaFechaEnvio = rs.getTimestamp("fechaEnvio");
            long diffDias = (System.currentTimeMillis() - ultimaFechaEnvio.getTime()) / (1000L * 60 * 60 * 24);
            if (diffDias >= 30) {
                stmt.close();
                stmt = conn.prepareStatement("DELETE FROM historialCorreos WHERE tipoDestinatario = ?");
                stmt.setString(1, tipo);
                int borrados = stmt.executeUpdate();
                out.print(borrados > 0 ? "ok" : "vacio");
            } else {
                out.print("tiempo");
            }
        } else {
            out.print("vacio");
        }
    } catch (Exception e) {
        out.print("error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
