<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*" %>
<%
    response.setHeader("Content-Disposition", "attachment; filename=reporte_personas.xls");
%>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
    <table border="1">
        <thead>
            <tr>
                <th>Identificación</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Tipo</th>
                <th>Fecha Nacimiento</th>
                <th>Dirección</th>
                <th>Celular</th>
                <th>Email</th>
                <th>Estado Civil</th>
                <th>Nivel Educación</th>
                <th>Profesión</th>
                <th>Nombre Hijo</th>
                <th>Fecha Nac. Hijo</th>
                <th>Nivel Escolar</th>
                <th>EPS</th>
                <th>ARL</th>
                <th>Fondo Pensiones</th>
                <th>Fondo Cesantías</th>
                <th>1ra Ref Nombre</th>
                <th>1ra Ref Parentezco</th>
                <th>1ra Ref Celular</th>
                <th>2da Ref Nombre</th>
                <th>2da Ref Parentezco</th>
                <th>2da Ref Celular</th>
                <th>3ra Ref Nombre</th>
                <th>3ra Ref Parentezco</th>
                <th>3ra Ref Celular</th>
                <th>4ta Ref Nombre</th>
                <th>4ta Ref Parentezco</th>
                <th>4ta Ref Celular</th>
                <th>Fecha Ingreso</th>
                <th>Fecha Retiro</th>
                <th>Unidad Negocio</th>
                <th>Centro Costos</th>
                <th>Establecimiento</th>
                <th>Área</th>
                <th>Salario</th>
                <th>Estado</th>
                <th>Fecha Term. Contrato</th>
                <th>Fecha Ingreso Temporal</th>
                <th>Talla Camisa</th>
                <th>Talla Chaqueta</th>
                <th>Talla O</th>
                <th>Talla Pantalón</th>
                <th>Talla Calzado</th>
                <th>Talla Guantes</th>
                <th>Talla Buzo</th>
            </tr>
        </thead>
        <tbody>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver"); // O "com.mysql.cj.jdbc.Driver" para MySQL 8+
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proyectogreen?characterEncoding=utf8",
            "adso", "utilizar");

        String sql = "SELECT p.identificacion, p.nombres, p.apellidos, p.tipo, p.fechaNacimiento, p.direccion, " +
                     "p.celular, p.email, p.estadoCivil, p.nivelEdu, p.profesion, " +
                     "h.nombres AS nombreHijo, h.fechaNacimiento AS fechaNacimientoHijo, h.nivelEscolar, " +
                     "ss.eps, ss.arl, ss.fondoPensiones, ss.fondoCesantias, " +
                     "r.primerRefNombre, r.primerRefParentezco, r.primerRefCelular, " +
                     "r.segundaRefNombre, r.segundaRefParentezco, r.segundaRefCelular, " +
                     "r.terceraRefNombre, r.terceraRefParentezco, r.terceraRefCelular, " +
                     "r.cuartaRefNombre, r.cuartaRefParentezco, r.cuartaRefCelular, " +
                     "il.fechaIngreso, il.fechaRetiro, il.unidadNegocio, il.centroCostos, il.establecimiento, il.area, " +
                     "il.salario, il.estado, il.fechaTerPriContrato, il.fechaIngresoTemporal, " +
                     "t.tallaCamisa, t.tallaChaqueta, t.tallaO, t.tallaPantalon, t.tallaCalzado, t.tallaGuantes, t.tallaBuzo " +
                     "FROM persona p " +
                     "LEFT JOIN hijos h ON h.identificacion = p.identificacion " +
                     "LEFT JOIN seguridadsocial ss ON ss.identificacion = p.identificacion " +
                     "LEFT JOIN referencia r ON r.identificacion = p.identificacion " +
                     "LEFT JOIN informacionlaboral il ON il.identificacion = p.identificacion " +
                     "LEFT JOIN talla t ON t.identificacion = p.identificacion " +
                     "WHERE p.tipo IN ('C', 'T', 'A') ORDER BY p.identificacion LIMIT 1000";

        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getString("identificacion") %></td>
                <td><%= rs.getString("nombres") %></td>
                <td><%= rs.getString("apellidos") %></td>
                <td><%= rs.getString("tipo") %></td>
                <td><%= rs.getString("fechaNacimiento") %></td>
                <td><%= rs.getString("direccion") %></td>
                <td><%= rs.getString("celular") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("estadoCivil") %></td>
                <td><%= rs.getString("nivelEdu") %></td>
                <td><%= rs.getString("profesion") %></td>

                <td><%= rs.getString("nombreHijo") %></td>
                <td><%= rs.getString("fechaNacimientoHijo") %></td>
                <td><%= rs.getString("nivelEscolar") %></td>

                <td><%= rs.getString("eps") %></td>
                <td><%= rs.getString("arl") %></td>
                <td><%= rs.getString("fondoPensiones") %></td>
                <td><%= rs.getString("fondoCesantias") %></td>

                <td><%= rs.getString("primerRefNombre") %></td>
                <td><%= rs.getString("primerRefParentezco") %></td>
                <td><%= rs.getString("primerRefCelular") %></td>
                <td><%= rs.getString("segundaRefNombre") %></td>
                <td><%= rs.getString("segundaRefParentezco") %></td>
                <td><%= rs.getString("segundaRefCelular") %></td>
                <td><%= rs.getString("terceraRefNombre") %></td>
                <td><%= rs.getString("terceraRefParentezco") %></td>
                <td><%= rs.getString("terceraRefCelular") %></td>
                <td><%= rs.getString("cuartaRefNombre") %></td>
                <td><%= rs.getString("cuartaRefParentezco") %></td>
                <td><%= rs.getString("cuartaRefCelular") %></td>

                <td><%= rs.getString("fechaIngreso") %></td>
                <td><%= rs.getString("fechaRetiro") %></td>
                <td><%= rs.getString("unidadNegocio") %></td>
                <td><%= rs.getString("centroCostos") %></td>
                <td><%= rs.getString("establecimiento") %></td>
                <td><%= rs.getString("area") %></td>
                <td><%= rs.getString("salario") %></td>
                <td><%= rs.getString("estado") %></td>
                <td><%= rs.getString("fechaTerPriContrato") %></td>
                <td><%= rs.getString("fechaIngresoTemporal") %></td>

                <td><%= rs.getString("tallaCamisa") %></td>
                <td><%= rs.getString("tallaChaqueta") %></td>
                <td><%= rs.getString("tallaO") %></td>
                <td><%= rs.getString("tallaPantalon") %></td>
                <td><%= rs.getString("tallaCalzado") %></td>
                <td><%= rs.getString("tallaGuantes") %></td>
                <td><%= rs.getString("tallaBuzo") %></td>
            </tr>
<%
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
        </tbody>
    </table>
</body>
</html>
