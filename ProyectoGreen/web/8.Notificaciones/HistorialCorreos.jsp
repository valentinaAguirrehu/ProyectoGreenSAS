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
        </div>

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

            document.addEventListener("DOMContentLoaded", function () {
                controlarPermisos(
                    <%= administrador.getpEliminar() %>,
                    <%= administrador.getpEditar() %>,
                    <%= administrador.getpAgregar() %>
                );
            });
        </script>
    </body>
</html>
