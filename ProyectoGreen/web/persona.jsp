<%-- 
    Document   : personaUsuario
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="clases.Persona"%>
<%@page import="java.util.List"%>
<%
    
    String lista = "";
    List<Persona> datos = Persona.getListaEnObjetos("Rol='A'", null);

    for (int i = 0; i < datos.size(); i++) {
        Persona persona = datos.get(i);
        lista += "<tr>";
        lista += "<td>" + persona.getIdentificacion() + "</td>";
        lista += "<td>" + persona.getNombres()+ "</td>";
        lista += "<td>" + persona.getApellidos() + "</td>";
        lista += "<td>" + persona.getIdCargo()+ "</td>";
        lista += "<td>";
        lista += "<a href='principal.jsp?CONTENIDO=personaFormulario.jsp&accion=Modificar&identificacion=" + persona.getIdentificacion() +
                 "' title='Modificar'><img src='iconos/editar.png'></a> ";
        lista += "<img src='iconos/borrar.png' title='Eliminar' onClick='eliminar(" + persona.getIdentificacion() + ")'> ";
        lista += "<img src='iconos/verDetalles.png' title='Ver Detalles' onClick='verDetalles(" + persona.getIdentificacion() + ")'> ";
        lista += "</td>";
        lista += "</tr>";
    }
    %>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GREEN SAS ACTIVOS</title>
    </head>
    <body>
        <header>
            <h1>GREEN SAS ACTIVOS</h1>
        </header>

        <section>
            <form method="get">
                <input type="text" name="buscar" placeholder="Buscar por Documento, Nombre, Apellido, Cargo">
                <button type="submit">AGREGAR</button>
            </form>
        </section>

        <table border="1">
            <thead>
                <tr>
                    <th>IDENTIFICACIÓN</th>
                    <th>NOMBRES</th>
                    <th>APELLIDOS</th>
                    <th>CARGO</th>
                    <th>OTROS</th>
            <div class="add-button">
                <a href="principal.jsp?CONTENIDO=personaFormulario.jsp&accion=Adicionar" title="Agregar">
                    <img src="iconos/agregar.png" alt="Agregar" style="width: 20px; vertical-align: middle;"> Agregar Colaborador
                </a>
            </div>
        </tr>
        <%= lista %>
    </thead>
    <tbody>
    <c:forEach var="usuario" items="${listaUsuarios}">
        <tr>
            <td>${usuario.identificacion}</td>
            <td>${usuario.primerNombre}</td>
            <td>${usuario.primerApellido}</td>
            <td>${usuario.rolEnObjeto}</td>
            <td>
                <a href='principal.jsp?CONTENIDO=usuariosFormulario.jsp&accion=Modificar&identificacion=${usuario.identificacion}'>Editar</a>
                <a href='#' onClick='eliminar(${usuario.identificacion})'>Eliminar</a>
                <a href='#' onClick='verDetalles(${usuario.identificacion})'>Ver Detalles</a>
            </td>
        </tr>
    </c:forEach>
</tbody>
</table>

<script type="text/javascript">
    function eliminar(identificacion) {
        if (confirm("¿Realmente desea eliminar el registro con la identificación " + identificacion + "?")) {
            document.location = "principal.jsp?CONTENIDO=usuariosActualizar.jsp&accion=Eliminar&identificacion=" + identificacion;
        }
    }

    function verDetalles(identificacion) {
        document.location = "principal.jsp?CONTENIDO=usuarioDetalles.jsp&identificacion=" + identificacion;
    }
</script>
</body>
</html>
