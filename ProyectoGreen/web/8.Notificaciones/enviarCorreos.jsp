<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
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
    <h3 class="titulo" style="margin-top: 50px;">Contratos próximos a vencer (30 días)</h3>

    <%
        Connection conn2 = null;
        PreparedStatement stmt2 = null;
        ResultSet rs2 = null;
        boolean hayRegistros = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn2 = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8",
                "adso", "utilizar"
            );

            String sql2 =
                "SELECT p.identificacion, p.nombres, p.apellidos, " +
                "c.nombre AS cargoNombre, " +
                "il.unidadNegocio, il.centroCostos, p.email, il.fechaIngreso, il.fechaTerPriContrato " +
                "FROM persona p " +
                "INNER JOIN informacionlaboral il ON p.identificacion = il.identificacion " +
                "INNER JOIN cargo c ON il.idCargo = c.id " +
                "WHERE p.tipo = 'C' " +
                "AND il.fechaTerPriContrato BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)";

            stmt2 = conn2.prepareStatement(sql2);
            rs2 = stmt2.executeQuery();

            hayRegistros = rs2.isBeforeFirst();

            if (hayRegistros) {
                Date ahora = new Date();
                String fechaActual = new SimpleDateFormat("dd/MM/yyyy").format(ahora);
    %>

    <p style="text-align: center; font-weight: bold; margin-top: 20px;">
        Fecha actual: <%= fechaActual %>
    </p>

    <form action="../8.Notificaciones/notificacionesContrato.jsp" method="post"
          style="text-align: center; margin: 20px 0;">
        <button type="submit" class="boton">Enviar Correos</button>
    </form>

    <table>
        <tr>
            <th>Identificación</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Cargo</th>
            <th>Unidad de negocio</th>
            <th>Centro de costos</th>
            <th>Email</th>
            <th>Fecha ingreso</th> <!-- SE AGREGÓ ESTA COLUMNA -->
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
            <td><%= rs2.getString("centroCostos") %></td>
            <td><%= rs2.getString("email") %></td>
            <td><%= rs2.getString("fechaIngreso") %></td> <!-- SE AGREGÓ ESTA CELDA -->
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
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            if (rs2 != null) try { rs2.close(); } catch (SQLException ignore) {}
            if (stmt2 != null) try { stmt2.close(); } catch (SQLException ignore) {}
            if (conn2 != null) try { conn2.close(); } catch (SQLException ignore) {}
        }
    %>
</div>

<script>
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
