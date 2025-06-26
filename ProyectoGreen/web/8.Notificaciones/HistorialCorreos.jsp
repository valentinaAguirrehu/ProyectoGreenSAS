<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
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
<jsp:include page="../permisos.jsp"/>
<jsp:include page="../menu.jsp"/>

<div class="content">
    <h3 class="titulo">Historial de correos enviados</h3>

    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh:mm a");
        Timestamp ultimaFechaEnvio = null;
        boolean hayDatos = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8",
                                               "adso", "utilizar");

            String sql = "SELECT id, destinatario, fechaEnvio " +
                         "FROM historialCorreos " +
                         "WHERE tipoDestinatario = 'Administradores' " +
                         "ORDER BY fechaEnvio DESC";

            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            if (rs.next()) {
                hayDatos = true;
                ultimaFechaEnvio = rs.getTimestamp("fechaEnvio");
                rs.beforeFirst();
    %>

    <div class="botones-container">
        <div class="grupo-derecha">
            <a href="javascript:void(0);"
               onclick="validarEliminacion('<%= new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").format(ultimaFechaEnvio) %>')"
               class="eliminar" >Eliminar Historial</a>
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
        %>
    </table>

    <%
            }
            if (!hayDatos) {
    %>
    <div style="text-align: center; margin-top: 40px;">
        <p style="font-size: 18px;">No hay historial de correos enviados a administradores</p>
        <a class="subir" href="enviarCorreos.jsp">Enviar Correos</a>
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
    fechaLimite.setMonth(fechaLimite.getMonth() + 1); 
    const ahora = new Date();

    if (ahora < fechaLimite) {
        alert("No se puede eliminar el historial. Debe pasar al menos 1 mes desde el último envío.");
        return;
    }

    if (!confirm("¿Estás seguro de que deseas eliminar el historial de administradores?")) return;

    fetch("eliminarHistorial.jsp?tipo=Administradores&_=" + new Date().getTime(), { cache: "no-store" })
        .then(response => response.text())
        .then(data => {
            data = data.trim();
            if (data === "ok" || data === "vacio") {
                alert("Historial eliminado con éxito.");
                document.querySelector("table")?.remove();
                document.querySelector(".botones-container")?.remove();
                const msg = document.createElement("div");
                msg.innerHTML = `
                    <div style="text-align: center; margin-top: 40px;">
                        <p style="font-size: 18px;">No hay historial de correos enviados a administradores</p>
                        <a href="enviarCorreos.jsp" class="boton">Enviar Correos</a>
                    </div>`;
                document.querySelector(".content").appendChild(msg);
            } else if (data === "tiempo") {
                alert("No se puede eliminar aún. Debe pasar al menos 1 mes.");
            } else {
                alert("Error al eliminar: " + data);
            }
        })
        .catch(error => {
            console.error(error);
            alert("Error de red al eliminar historial.");
        });
}

</script>

</body>
</html>
