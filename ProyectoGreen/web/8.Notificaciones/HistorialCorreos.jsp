<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Calendar" %>
<%@ page import="clases.Administrador" %>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../presentacion/style-Cargos.css">
    <link rel="stylesheet" href="../presentacion/style-Correos.css">
</head>
<body>

<jsp:include page="../permisos.jsp" />
<jsp:include page="../menu.jsp" />

<div class="content">
    <h3 class="titulo">Historial de correos electrónicos enviados</h3>

    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh:mm a");
        Timestamp ultimaFechaEnvio = null;
        String tipoDestinatario = request.getParameter("tipo");
        boolean hayDatos = false;

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
                hayDatos = true;
                ultimaFechaEnvio = rs.getTimestamp("fechaEnvio");
                rs.beforeFirst();
    %>

    <div class="botones-container">
        <div class="grupo-izquierda">
            <a href="HistorialCorreos.jsp?tipo=Administradores" class="boton">Administradores</a>
            <a href="HistorialCorreos.jsp?tipo=Persona" class="boton">Colaboradores</a>
        </div>
        <div class="grupo-derecha">
            <a href="javascript:void(0);" onclick="validarEliminacion('<%= new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").format(ultimaFechaEnvio) %>')" class="boton eliminar">Eliminar Historial (Todos)</a>
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
        } 
        %>
    </table>

    <%
        if (!hayDatos) {
    %>
        <div id="sin-historial" style="text-align: center; margin-top: 40px;">
            <p style="font-size: 18px;">No hay historial de correos enviados</p>
            <a href="enviarCorreos.jsp" class="boton">Enviar Correos</a>
        </div>
    <%
        }
    } catch (Exception e) {
        out.println("<p>Error al cargar historial: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
    %>
</div>

<script>
function validarEliminacion(fechaUltimaEnvio) {
    const fechaLimite = new Date(fechaUltimaEnvio);
    fechaLimite.setMinutes(fechaLimite.getMinutes() + 5);
    const ahora = new Date();

    if (ahora < fechaLimite) {
        alert("No se puede eliminar el historial. Deben pasar al menos 3 minutos desde el último envío.");
        return;
    }

    if (!confirm("¿Estás seguro de que deseas eliminar todo el historial de correos?")) return;

    fetch("eliminarHistorial.jsp")
        .then(response => response.text())
        .then(data => {
            data = data.trim(); // <-- Evitar errores por espacios
            if (data === "ok" || data === "vacio") {
                alert("Historial eliminado con éxito.");

                const tabla = document.querySelector("table");
                const botones = document.querySelector(".botones-container");
                if (tabla) tabla.remove();
                if (botones) botones.remove();

                const mensaje = document.createElement("div");
                mensaje.innerHTML = `
                    <div style="text-align: center; margin-top: 40px;">
                        <p style="font-size: 18px;">No hay historial de correos enviados</p>
                        <a href="enviarCorreos.jsp" class="boton">Enviar Correos</a>
                    </div>
                `;
                document.querySelector(".content").appendChild(mensaje);
            } else if (data === "tiempo") {
                alert("No se puede eliminar el historial. Deben pasar al menos 5 minutos desde el último envío.");
            } else {
                alert("Ocurrió un error al intentar eliminar el historial.\nRespuesta del servidor: " + data);
            }
        })
        .catch(error => {
            alert("Error de red al intentar eliminar.");
            console.error(error);
        });
}
</script>

</body>
</html>
