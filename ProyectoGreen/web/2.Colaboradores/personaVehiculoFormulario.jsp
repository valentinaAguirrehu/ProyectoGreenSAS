<%-- 
    Document   : personaVehiculoFormulario
    Created on : 13/03/2025, 09:31:25 PM
    Author     : Mary
--%>
<%@ page import="clases.Persona, clases.Vehiculo, clases.PersonaVehiculo" %>
<%@ page import="java.util.List" %>
<html>
    <head>
      </head>
    <body>
        <h2>Asignar un vehículo a la persona</h2>

        <form action="personaVehiculo.jsp" method="post">
            <label>Seleccione la persona:</label>
            <select name="identificacionPersona">
                <%
                    List<Persona> personas = Persona.getListaEnObjetos(null, "nombre");
                    for (Persona p : personas) {
                        String placaActual = PersonaVehiculo.obtenerVehiculoDePersona(Integer.parseInt(p.getIdentificacion()));
                %>
                <option value="<%= p.getIdentificacion()%>">
                    <%= p.getNombres()%> - Vehículo Actual: <%= (placaActual != null) ? placaActual : "Ninguno"%>
                </option>
                <%
                    }
                %>
            </select>

            <br>

            <label>Seleccione el vehículo</label>
            <select name="numeroPlacaVehiculo">
                <%
                    List<Vehiculo> vehiculos = Vehiculo.getListaEnObjetos(null, "modeloVehiculo");
                    for (Vehiculo v : vehiculos) {
                %>
                <option value="<%= v.getNumeroPlaca()%>"><%= v.getModeloVehiculo()%> - <%= v.getNumeroPlaca()%></option>
                <%
                    }
                %>
            </select>
            <br>

            <input type="submit" value="Asignar vehículo">
        </form>
    </body>
</html> 