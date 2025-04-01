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

<h2>Detalles del colaborador</h2>

<table class="info-table">
    <tr><th>Nombre Completo</th><td><%= persona.getNombres() %> <%= persona.getApellidos() %></td></tr>
    <tr><th>Sexo</th><td><%= persona.getSexo() %></td></tr>
    <tr><th>Fecha de Ingreso</th><td><%= persona.getFechaIngreso()%></td></tr>
    <tr><th>Fecha de retiro</th><td><%= persona.getFechaRetiro()%></td></tr>   
    <tr><th>Fecha etapa lectiva</th><td><%= persona.getFechaEtapaLectiva()%></td></tr>   
    <tr><th>Fecha estapa productiva</th><td><%= persona.getFechaEtapaProductiva()%></td></tr>   
    <tr><th>Documento de identidad</th><td><%= persona.getTipoDocumento() %></td></tr>
    <tr><th>Numero de documento</th><td><%= persona.getIdentificacion() %></td></tr>
    <tr><th>Fecha de Expedición</th><td><%= persona.getFechaExpedicion() %></td></tr>
    <tr><th>Lugar de Expedición</th><td><%= persona.getLugarExpedicion()%></td></tr>
    <tr><th>Fecha de Nacimiento</th><td><%= persona.getFechaNacimiento() %> (<%= edad >= 0 ? edad + " años" : "Fecha inválida" %>)</td></tr>
    <tr><th>Lugar de nacimiento</th><td><%= persona.getLugarNacimiento()%></td></tr>
    <tr><th>Tipo de Sangre</th><td><%= persona.getTipoSangre()%></td></tr>
    <tr><th>Tipo de vivienda</th><td><%= persona.getTipoVivienda()%></td></tr>
    <tr><th>Dirección:</th><td><%= persona.getDireccion() %></td></tr>
    <tr><th>Barrio</th><td><%= persona.getBarrio() %></td></tr>
    <tr><th>Celular</th><td><%= persona.getCelular() %></td></tr>
    <tr><th>Correo Electronico</th><td><%= persona.getEmail() %></td></tr>
    <tr><th>Nivel Educativo</th><td><%= persona.getNivelEducativo()%><%=persona.getProfesion()%></td></tr>
    <tr><th>Estado Civil</th><td><%= persona.getEstadoCivil()%></td></tr>

    
</table>

<h2>Información de hijos</h2>
<table class="info-table">
    <tr><th>Documento de identidad</th><th>Nombre</th><th>Fecha de Nacimiento</th></tr>
    <% if (hijos != null && !hijos.isEmpty()) {
        for (Hijo hijo : hijos) { %>
    <tr>
        <td><%= hijo.getIdentificacion() %></td>
        <td><%= hijo.getNombres() %></td>
        <td><%= hijo.getFechaNacimiento() %>(<%= edad >= 0 ? edad + " años" : "Fecha inválida" %>)</td>
    </tr>
    <% }} else { %>
    <tr><td colspan="3">No tiene hijos registrados.</td></tr>
    <% } %>
</table>

<h2>Información de vehículo</h2>
<table class="info-table">
    <tr><th>Número de placa:</th><td><%= persona.getNumeroPlacaVehiculo() %></td></tr>
    <tr><th>Tipo medio de transporte</th><td><%= persona.getTipoVehiculo() %></td></tr>
    <tr><th>Modelo:</th><td><%= persona.getModeloVehiculo() %></td></tr>
    <tr><th>Línea:</th><td><%= persona.getLinea() %></td></tr>
    <tr><th>Marca:</th><td><%= persona.getMarca()%></td></tr>
    <tr><th>Color:</th><td><%= persona.getColor() %></td></tr>
    <tr><th>Cilindraje:</th><td><%= persona.getCilindraje() %></td></tr>
    <tr><th>Restricciones del conductor</th><td><%= persona.getRestricciones()%></td></tr>
    </table>

<h2>Licencias</h2>
<table class="info-table">
    <tr><th>Numero tarjeta  de propiedad</th><td><%= persona.getNumLicenciaTransito()%></td></tr>
    <tr><th>Fecha expedicion tarjeta de propiedad</th><td><%= persona.getFechaExpLicenciaTransito()%></td></tr>
    <tr><th>Estado</th><td><%= persona.getEstado()%></td></tr>
    <tr><th>Fecha expedicion licencia de conduccion</th><td><%= persona.getFechaExpConduccion()%></td></tr>
    <tr><th>Fecha de vencimiento</th><td><%= persona.getFechaVencimiento()%></td></tr>
    <tr><th>Fecha licencia de conduccion</th><td><%= persona.getNumLicenciaConduccion()%></td></tr>

</table>

<h2>Referencias personales</h2>
<table class="info-table">
    <tr><th>Referencia familiar 1</th><td><%= persona.getPrimerRefNombre() %> - <%= persona.getPrimerRefParentezco() %> - <%= persona.getPrimerRefCelular() %></td></tr>
    <tr><th>Referencia familiar 2</th><td><%= persona.getSegundaRefNombre() %> - <%= persona.getSegundaRefParentezco() %> - <%= persona.getSegundaRefCelular() %></td></tr>
    <tr><th>Referencia familiar 3</th><td><%= persona.getTerceraRefNombre()%> - <%= persona.getTerceraRefParentezco()%> - <%= persona.getTerceraRefCelular()%></td></tr>
    <tr><th>Referencia familiar 4</th><td><%= persona.getCuartaRefNombre()%> - <%= persona.getCuartaRefParentezco()%> - <%= persona.getCuartaRefCelular()%></td></tr>
</table>

<h2>Informacion de trabajo</h2>
<table class="info-table">
    <tr><th>EPS</th><td><%= persona.getEps()%></td></tr>
    <tr><th>Profesion</th><td><%= persona.getProfesion()%></td></tr>
    <tr><th>Fecha termino primer contrato</th><td><%= persona.getFechaTerPriContrato()%></td></tr>
    <tr><th>Establecimiento</th><td><%= persona.getEstablecimiento()%> - <%= persona.getUnidadNegocio()%></td></tr>
    <tr><th>Centro de costos</th><td><%= persona.getCentroCostos()%></td></tr>
    <tr><th>Cargos</th><td><%= persona.getCctn()%></td></tr>
    <tr><th>Cuenta Bancaria</th><td><%= persona.getCuentaBancaria()%></td></tr>
    <tr><th>Numero de Bancaria</th><td><%= persona.getNumeroCuenta()%></td></tr>
    <tr><th>Salario</th><td><%= persona.getSalario()%></td></tr>
</table>

<p>
    <button id="regresar" onClick="window.history.back()">Regresar</button>
</p>