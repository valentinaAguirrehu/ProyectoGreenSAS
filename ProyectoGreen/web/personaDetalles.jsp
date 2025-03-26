<%-- 
    Document   : aprendizDetalle
    Created on : 22/03/2025, 02:30:30 AM
    Author     : Mary
--%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Hijo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="presentacion/estiloTablas.css">

<%
    String identificacion = request.getParameter("identificacion");
    Persona persona = new Persona(identificacion);
    List<Hijo> hijos = persona.obtenerHijos();

    // Cálculo de la edad
    int edad = 0;
    if (persona.getFechaNacimiento() != null && !persona.getFechaNacimiento().isEmpty()) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate fechaNacimiento = LocalDate.parse(persona.getFechaNacimiento(), formatter);
            edad = Period.between(fechaNacimiento, LocalDate.now()).getYears();
        } catch (Exception e) {
            edad = -1; // Indica error en la fecha
        }
    }
%>

<h2>Detalles del Colaborador</h2>

<table class="info-table">
    <tr><th>Fecha de Ingreso</th><td><%= persona.getFechaIngreso()%></td></tr>
    <tr><th>Fecha de retiro</th><td><%= persona.getFechaRetiro()%></td></tr>   <tr><th>Nombre Completo:</th><td><%= persona.getNombres() %> <%= persona.getApellidos() %></td></tr>
    <tr><th>Identificación:</th><td><%= persona.getIdentificacion() %></td></tr>
    <tr><th>Tipo Documento:</th><td><%= persona.getTipoDocumento() %></td></tr>
    <tr><th>Fecha de Expedición:</th><td><%= persona.getFechaExpedicion() %></td></tr>
    <tr><th>Fecha de Nacimiento:</th><td><%= persona.getFechaNacimiento() %> (<%= edad >= 0 ? edad + " años" : "Fecha inválida" %>)</td></tr>
    <tr><th>Lugar de nacimiento</th><td><%= persona.getLugarNacimiento()%></td></tr>
    <tr><th>Sexo:</th><td><%= persona.getSexo() %></td></tr>
    <tr><th>Tipo de Sangre</th><td><%= persona.getTipoSangre()%></td></tr>
    <tr><th>Tipo de vivienda</th><td><%= persona.getTipoVivienda()%></td></tr>
    <tr><th>Dirección:</th><td><%= persona.getDireccion() %></td></tr>
    <tr><th>Barrio:</th><td><%= persona.getBarrio() %></td></tr>
    <tr><th>Celular:</th><td><%= persona.getCelular() %></td></tr>
    <tr><th>Email:</th><td><%= persona.getEmail() %></td></tr>
    <tr><th>Nivel Educativo</th><td><%= persona.getNivelEducativo()%></td></tr>
    <tr><th>EPS</th><td><%= persona.getEps()%></td></tr>
    <tr><th>Estado Civil</th><td><%= persona.getEstadoCivil()%></td></tr>
    <tr><th>Profesion</th><td><%= persona.getProfesion()%></td></tr>
    <tr><th>Fondo de Pensiones</th><td><%= persona.getFondoPensiones()%></td></tr>
    <tr><th>Fondo de Cesantias</th><td><%= persona.getFondoCesantias()%></td></tr>
 
</table>

<h2>Información de Hijos</h2>
<table class="info-table">
    <tr><th>Identificación</th><th>Nombre</th><th>Fecha de Nacimiento</th></tr>
    <% if (hijos != null && !hijos.isEmpty()) {
        for (Hijo hijo : hijos) { %>
    <tr>
        <td><%= hijo.getIdentificacion() %></td>
        <td><%= hijo.getNombres() %></td>
        <td><%= hijo.getFechaNacimiento() %></td>
    </tr>
    <% }} else { %>
    <tr><td colspan="3">No tiene hijos registrados.</td></tr>
    <% } %>
</table>

<h2>Información de Vehículo</h2>
<table class="info-table">
    <tr><th>Número de Placa:</th><td><%= persona.getNumeroPlacaVehiculo() %></td></tr>
    <tr><th>Tipo de Vehículo:</th><td><%= persona.getTipoVehiculo() %></td></tr>
    <tr><th>Modelo:</th><td><%= persona.getModeloVehiculo() %></td></tr>
    <tr><th>Línea:</th><td><%= persona.getLinea() %></td></tr>
    <tr><th>Año:</th><td><%= persona.getAno() %></td></tr>
    <tr><th>Color:</th><td><%= persona.getColor() %></td></tr>
    <tr><th>Cilindraje:</th><td><%= persona.getCilindraje() %></td></tr>
</table>

<h2>Licencias</h2>
<table class="info-table">
    <tr><th>Número Licencia de Tránsito:</th><td><%= persona.getNumLicenciaTransito() %></td></tr>
    <tr><th>Fecha Exp. Licencia de Tránsito:</th><td><%= persona.getFechaExpLicenciaTransito() %></td></tr>
    <tr><th>Número Licencia de Conducción:</th><td><%= persona.getNumLicenciaConduccion() %></td></tr>
    <tr><th>Fecha Exp. Licencia de Conducción:</th><td><%= persona.getFechaExpConduccion() %></td></tr>
    <tr><th>Fecha de Vencimiento:</th><td><%= persona.getFechaVencimiento() %></td></tr>
</table>

<h2>Referencias Personales</h2>
<table class="info-table">
    <tr><th>Primer Referencia:</th><td><%= persona.getPrimerRefNombre() %> - <%= persona.getPrimerRefParentezco() %> - <%= persona.getPrimerRefCelular() %></td></tr>
    <tr><th>Segunda Referencia:</th><td><%= persona.getSegundaRefNombre() %> - <%= persona.getSegundaRefParentezco() %> - <%= persona.getSegundaRefCelular() %></td></tr>
</table>

<h2>Informacion de Trabajo</h2>
<table class="info-table">
    <tr><th>Fecha termino primer contrato</th><td><%= persona.getFechaTerPriContrato()%></td></tr>
    <tr><th>Establecimiento</th><td><%= persona.getEstablecimiento()%> - <%= persona.getUnidadNegocio()%></td></tr>
    <tr><th>Centro de costos</th><td><%= persona.getCentroCostos()%></td></tr>
    <tr><th>Area</th><td><%= persona.getArea()%></td></tr>
    <tr><th>Cargos</th><td><%= persona.getTipoCargo()%></td></tr>
    <tr><th>Cuenta Bancaria</th><td><%= persona.getCuentaBancaria()%></td></tr>
    <tr><th>Numero de Bancaria</th><td><%= persona.getNumeroCuenta()%></td></tr>
    <tr><th>Salario</th><td><%= persona.getSalario()%></td></tr>
</table>
<h2>Informacion de Dotacion</h2>
<table class="info-table">
    <tr><th>Fecha proxima entrega</th><td><%= persona.getFechaProEntrega()%></td></tr>
    <tr><th>Fecha ultima entrega</th><td><%= persona.getFechaUltiEntrega()%></td></tr>
    <tr><th>Talla camisa</th><td><%= persona.getTallaCamisa()%></td></tr>
    <tr><th>Talla chaqueta</th><td><%= persona.getTallaChaqueta()%></td></tr>
    <tr><th>Talla pantalon</th><td><%= persona.getTallaPantalon()%></td></tr>
    <tr><th>Talla Calsado</th><td><%= persona.getTallaCalzado()%></td></tr>
</table>
<p>
    <button id="regresar" onClick="window.history.back()">Regresar</button>
</p>

