<%@ page import="clases.Persona, clases.Vehiculo, clases.PersonaVehiculo" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <title>Actualizar Vehículo de Persona</title>
</head>
<body>
    <h2>Actualizar Vehículo de Persona</h2>

    <%
        String mensaje = "";
        if (request.getMethod().equals("POST")) {
            try {
                int identificacionPersona = Integer.parseInt(request.getParameter("identificacionPersona"));
                String nuevaPlaca = request.getParameter("numeroPlacaVehiculo");

                if (PersonaVehiculo.existeRelacion(identificacionPersona)) { // Aquí estaba el error
                    PersonaVehiculo personaVehiculo = new PersonaVehiculo(identificacionPersona, nuevaPlaca);
                    if (personaVehiculo.actualizar(nuevaPlaca)) {
                        mensaje = "<p style='color: green;'>Vehículo actualizado correctamente.</p>";
                    } else {
                        mensaje = "<p style='color: red;'>Error al actualizar el vehículo.</p>";
                    }
                } else {
                    mensaje = "<p style='color: red;'>Esta persona no tiene un vehículo asignado.</p>";
                }
            } catch (Exception e) {
                mensaje = "<p style='color: red;'>Error en la actualización: " + e.getMessage() + "</p>";
            }
        }
    %>

    
    <form action="personaVehiculoActualizar.jsp" method="post">
        <label>Seleccione Persona:</label>
        <select name="identificacionPersona">
            <%
                List<Persona> personas = Persona.getListaEnObjetos(null, "nombre");
                for (Persona p : personas) {
String placaActual = PersonaVehiculo.obtenerVehiculoDePersona(Integer.parseInt(String.valueOf(p.getIdentificacion())));
            %>
                <option value="<%= p.getIdentificacion() %>">
                    <%= p.getNombres() %> - Vehículo Actual: <%= placaActual %>
                </option>
            <%
                }
            %>
        </select>
        <br>

        <label>Seleccione Nuevo Vehículo:</label>
        <select name="numeroPlacaVehiculo">
            <%
                List<Vehiculo> vehiculos = Vehiculo.getListaEnObjetos(null, "modeloVehiculo");
                for (Vehiculo v : vehiculos) {
            %>
                <option value="<%= v.getNumeroPlaca() %>">
                    <%= v.getModeloVehiculo() %> - <%= v.getNumeroPlaca() %>
                </option>
            <%
                }
            %>
        </select>
        <br>

        <input type="submit" value="Actualizar Vehículo">
    </form>

    <%= mensaje %>

</body>
</html>