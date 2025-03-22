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
    <tr><th>Identificación:</th><td><%= persona.getIdentificacion() %></td></tr>
    <tr><th>Nombre Completo:</th><td><%= persona.getNombres() %> <%= persona.getApellidos() %></td></tr>
    <tr><th>Tipo Documento:</th><td><%= persona.getTipoDocumento() %></td></tr>
    <tr><th>Fecha de Expedición:</th><td><%= persona.getFechaExpedicion() %></td></tr>
    <tr><th>Fecha de Nacimiento:</th><td><%= persona.getFechaNacimiento() %> (<%= edad >= 0 ? edad + " años" : "Fecha inválida" %>)</td></tr>
    <tr><th>Sexo:</th><td><%= persona.getSexo() %></td></tr>
    <tr><th>Dirección:</th><td><%= persona.getDireccion() %></td></tr>
    <tr><th>Barrio:</th><td><%= persona.getBarrio() %></td></tr>
    <tr><th>Celular:</th><td><%= persona.getCelular() %></td></tr>
    <tr><th>Email:</th><td><%= persona.getEmail() %></td></tr>
</table>

<h2>Referencias Personales</h2>
<table class="info-table">
    <tr><th>Primer Referencia:</th><td><%= persona.getPrimerRefNombre() %> - <%= persona.getPrimerRefParentezco() %> - <%= persona.getPrimerRefCelular() %></td></tr>
    <tr><th>Segunda Referencia:</th><td><%= persona.getSegundaRefNombre() %> - <%= persona.getSegundaRefParentezco() %> - <%= persona.getSegundaRefCelular() %></td></tr>
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

<p>
    <button id="regresar" onClick="window.history.back()">Regresar</button>
</p>

<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f0fdf4; /* Verde claro de fondo */
    }

    h2 {
        background-color: #28a745; /* Verde intenso */
        color: white;
        padding: 12px;
        border-radius: 8px;
        text-align: center;
        font-size: 20px;
    }

    .info-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .info-table th, .info-table td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
        color: black; /* Texto en negro */
    }

    .info-table th {
        background-color: #e9f5e9; /* Verde muy suave */
        font-weight: bold;
    }

    .info-table td {
        background-color: #ffffff;
    }

    button {
        display: block;
        width: 160px;
        margin: 20px auto;
        background-color: #28a745;
        color: white;
        padding: 12px;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        cursor: pointer;
        transition: background 0.3s;
    }

    button:hover {
        background-color: #1e7e34;
    }
</style>
