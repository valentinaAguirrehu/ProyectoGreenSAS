<%@ page import="java.sql.*" %>
<%
    response.setContentType("text/plain");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8", "adso", "utilizar");

        stmt = conn.prepareStatement("SELECT fechaEnvio FROM historialCorreos ORDER BY fechaEnvio DESC LIMIT 1");
        rs = stmt.executeQuery();

        if (rs.next()) {
            Timestamp ultimaFechaEnvio = rs.getTimestamp("fechaEnvio");
            long diferenciaMinutos = (System.currentTimeMillis() - ultimaFechaEnvio.getTime()) / (1000 * 60);

            if (diferenciaMinutos >= 5) {
                stmt.close();
                stmt = conn.prepareStatement("DELETE FROM historialCorreos");
                stmt.executeUpdate();
                out.print("ok");
            } else {
                out.print("tiempo");
            }
        } else {
            out.print("vacio");
        }

    } catch (Exception e) {
        out.print("error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
