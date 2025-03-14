<%-- 
    Document   : personaVehiculoFormulario
    Created on : 13/03/2025, 09:31:25 PM
    Author     : Mary
--%>
<%@ page import="clases.Persona, clases.Vehiculo, clases.PersonaVehiculo" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Asignar Vehículo a Persona</title>
</head>
<body>
    <h2>Asignar Vehículo a Persona</h2>

    <form action="personaVehiculo.jsp" method="post">
        <label>Seleccione Persona:</label>
       <select name="identificacionPersona">
    <%
        List<Persona> personas = Persona.getListaEnObjetos(null, "nombre");
        for (Persona p : personas) {
String placaActual = PersonaVehiculo.obtenerVehiculoDePersona(Integer.parseInt(p.getIdentificacion()));
    %>
        <option value="<%= p.getIdentificacion() %>">
            <%= p.getNombres() %> - Vehículo Actual: <%= (placaActual != null) ? placaActual : "Ninguno" %>
        </option>
    <%
        }
    %>
</select>

        <br>

        <label>Seleccione Vehículo:</label>
        <select name="numeroPlacaVehiculo">
            <%
                List<Vehiculo> vehiculos = Vehiculo.getListaEnObjetos(null, "modeloVehiculo");
                for (Vehiculo v : vehiculos) {
            %>
                <option value="<%= v.getNumeroPlaca() %>"><%= v.getModeloVehiculo() %> - <%= v.getNumeroPlaca() %></option>
            <%
                }
            %>
        </select>
        <br>

        <input type="submit" value="Asignar Vehículo">
    </form>
</body>
</html>
