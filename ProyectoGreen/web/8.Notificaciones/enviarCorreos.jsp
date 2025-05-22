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
    <title>Historial de Correos</title>
</head>
<body>

<jsp:include page="../permisos.jsp" />
<jsp:include page="../menu.jsp" />

<div class="content">

    <!-- CONTRATOS A VENCER -->
    <h3 class="titulo" style="margin-top: 50px;">Contratos próximos a vencer (30 días)</h3>

    <%
        Connection conn2 = null;
        PreparedStatement stmt2 = null;
        ResultSet rs2 = null;
        boolean hayRegistros = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url2 = "jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8";
            conn2 = DriverManager.getConnection(url2, "adso", "utilizar");

            String sql2 = "SELECT p.identificacion, p.nombres, p.apellidos, c.nombre AS cargoNombre, " +
                          "il.unidadNegocio, il.establecimiento, p.email, il.fechaTerPriContrato " +
                          "FROM persona p " +
                          "INNER JOIN informacionlaboral il ON p.identificacion = il.identificacion " +
                          "INNER JOIN cargo c ON p.idCargo = c.id " +
                          "WHERE p.tipo = 'C' AND il.fechaTerPriContrato BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)";

            stmt2 = conn2.prepareStatement(sql2);
            rs2 = stmt2.executeQuery();

            hayRegistros = rs2.isBeforeFirst();

            if (hayRegistros) {
    %>

    <form action="../8.Notificaciones/notificacionesContrato.jsp" method="post" style="text-align: center; margin: 20px 0;">
        <button type="submit" class="boton">Enviar Correos</button>
    </form>

    <table>
        <tr>
            <th>Identificación</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Cargo</th>
            <th>Unidad de negocio</th>
            <th>Establecimiento</th>
            <th>Email</th>
            <th>Fecha término contrato</th>
        </tr>

        <%
            while (rs2.next()) {
        %>
        <tr>
            <td><%= rs2.getString("identificacion") %></td>
            <td><%= rs2.getString("nombres") %></td>
            <td><%= rs2.getString("apellidos") %></td>
            <td><%= rs2.getString("cargoNombre") %></td>
            <td><%= rs2.getString("unidadNegocio") %></td>
            <td><%= rs2.getString("establecimiento") %></td>
            <td><%= rs2.getString("email") %></td>
            <td><%= rs2.getDate("fechaTerPriContrato") %></td>
        </tr>
        <%
            }
        %>
    </table>

    <%
        } else {
    %>
    <p style="text-align:center;">No hay contratos que finalicen en los próximos 30 días.</p>
    <%
        }

        } catch (Exception e) {
            out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
            e.printStackTrace();
        } finally {
            if (rs2 != null) try { rs2.close(); } catch (SQLException ignore) {}
            if (stmt2 != null) try { stmt2.close(); } catch (SQLException ignore) {}
            if (conn2 != null) try { conn2.close(); } catch (SQLException ignore) {}
        }
    %>
</div>

<!-- Scripts -->
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
