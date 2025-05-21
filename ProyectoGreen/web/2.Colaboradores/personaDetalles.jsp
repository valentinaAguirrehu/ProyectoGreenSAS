<%-- 
    Document   : personaDetalle
    Created on : 22/03/2025, 02:30:30 AM
    Author     : Mary
--%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Hijo"%>
<%@page import="clases.Cargo"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


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

    // Obtener el nombre del cargo
    String nombreCargo = "No asignado"; // Valor por defecto
    if (persona != null && persona.getIdentificacion() != null && persona.getIdCargo() != null) {
        Cargo cargo = new Cargo(persona.getIdCargo()); // Crear objeto Cargo
        if (cargo.getNombre() != null && !cargo.getNombre().isEmpty()) {
            nombreCargo = cargo.getNombre(); // Obtener nombre si existe
        }
    }
%>

<%@ include file="menu.jsp" %>

<head>
    <link rel="stylesheet" href="presentacion/style-FormularioColaboradores.css">
</head>
<body>
    <div class="content"> 

        <h3>Detalles del colaborador GREEN S.A.S</h3>

        <h1>Datos personales</h1>
        <table class="info-table" border="1">
            <tr><th>Nombre Completo</th><td><%= persona.getNombres()%> <%= persona.getApellidos()%></td></tr>
            <tr><th>Sexo</th><td><%= persona.getSexo()%></td></tr>
            <tr><th>Fecha de Ingreso</th><td><%= persona.getFechaIngreso()%></td></tr>
            <tr><th>Fecha de retiro</th><td><%= persona.getFechaRetiro()%></td></tr>   
            <tr><th>Documento de identidad</th><td><%= persona.getTipoDocumento()%></td></tr>
            <tr><th>Número del documento</th><td><%= persona.getIdentificacion()%></td></tr>
            <tr><th>Fecha de Expedición</th><td><%= persona.getFechaExpedicion()%></td></tr> 
            <tr><th>Lugar de Expedición</th><td><%= persona.getLugarExpedicion()%></td></tr>
            <tr><th>Fecha de Nacimiento</th><td><%= persona.getFechaNacimiento()%></td></tr>
            <tr><th>Edad</th><td><%= edad >= 0 ? edad + " años" : "Fecha inválida"%></td></tr>
            <tr><th>Lugar de nacimiento</th><td><%= persona.getLugarNacimiento()%></td></tr>
            <tr><th>Tipo de sangre</th><td><%= persona.getTipoSangre()%></td></tr>
            <tr><th>Tipo de vivienda</th><td><%= persona.getTipoVivienda()%></td></tr>
            <tr><th>Dirección</th><td><%= persona.getDireccion()%></td></tr>
            <tr><th>Barrio</th><td><%= persona.getBarrio()%></td></tr>
            <tr><th>Celular</th><td><%= persona.getCelular()%></td></tr>
            <tr><th>Correo electrónico</th><td><%= persona.getEmail()%></td></tr>
            <tr><th>Nivel educativo</th><td><%= persona.getNivelEducativo()%> / <%=persona.getProfesion()%></td></tr>
            <tr><th>Estado civil</th><td><%= persona.getEstadoCivil()%></td></tr>

        </table>

        <h1>Información de hijos</h1>
        <table class="info-table">
            <tr><th>Documento de identidad</th><th>Nombre</th><th>Edad</th></tr>
                    <% if (hijos != null && !hijos.isEmpty()) {
                            for (Hijo hijo : hijos) {%>
            <tr>
                <td><%= hijo.getIdentificacion()%></td>
                <td><%= hijo.getNombres()%></td>
                <td>
                    <%= hijo.calcularEdad()%>
                </td>

            </tr>
            <% }
            } else { %>
            <tr><td colspan="3">No tiene hijos registrados.</td></tr>
            <% } %>
        </table>

        <% if (persona.getNumeroPlacaVehiculo() != null && !persona.getNumeroPlacaVehiculo().isEmpty()) {%>
        <h1>Información del vehículo</h1>
        <table class="info-table">
            <tr><th>Número de placa:</th><td><%= persona.getNumeroPlacaVehiculo()%></td></tr>
            <tr><th>Tipo medio de transporte</th><td><%= persona.getTipoVehiculo()%></td></tr>
            <tr><th>Modelo:</th><td><%= persona.getModeloVehiculo()%></td></tr>
            <tr><th>Línea:</th><td><%= persona.getLinea()%></td></tr>
            <tr><th>Marca:</th><td><%= persona.getMarca()%></td></tr>
            <tr><th>Color:</th><td><%= persona.getColor()%></td></tr>
            <tr><th>Cilindraje:</th><td><%= persona.getCilindraje()%></td></tr>
            <tr><th>Restricciones del conductor</th><td><%= persona.getRestricciones()%></td></tr>
            <tr><th>Titular de la tarjeta de propiedad</th><td><%= persona.getTitularTrjPro()%></td></tr>
            <tr><th>Número de la tarjeta de propiedad</th><td><%= persona.getNumLicenciaTransito()%></td></tr>
            <tr><th>Fecha de expedición tarjeta de propiedad</th><td><%= persona.getFechaExpLicenciaTransito()%></td></tr>
        </table>
        <h1>Licencia de conducción</h1>
        <table class="info-table">
            <tr><th>Estado</th><td><%= persona.getEstado()%></td></tr>
            <tr><th>Fecha de expedición de la licencia de conducción</th><td><%= persona.getFechaExpConduccion()%></td></tr>
            <tr><th>Fecha de vencimiento de la licencia de conducción</th><td><%= persona.getFechaVencimiento()%></td></tr>
            <tr><th>Número de la licencia de conducción</th><td><%= persona.getNumLicenciaConduccion()%></td></tr>
        </table>
        <% }%>

        <h1>Contactos personales</h1>
        <table class="info-table">
            <tr><th>Primer contacto</th><td><%= persona.getPrimerRefNombre()%> - <%= persona.getPrimerRefParentezco()%> - <%= persona.getPrimerRefCelular()%></td></tr>
            <tr><th>Segundo contacto</th><td><%= persona.getSegundaRefNombre()%> - <%= persona.getSegundaRefParentezco()%> - <%= persona.getSegundaRefCelular()%></td></tr>
            <tr><th>Tercer contacto</th><td><%= persona.getTerceraRefNombre()%> - <%= persona.getTerceraRefParentezco()%> - <%= persona.getTerceraRefCelular()%></td></tr>
            <tr><th>Cuarto contacto</th><td><%= persona.getCuartaRefNombre()%> - <%= persona.getCuartaRefParentezco()%> - <%= persona.getCuartaRefCelular()%></td></tr>
        </table>

        <h1>Información laboral</h1>
        <table class="info-table">
            <tr><th>Fecha de termino del primer contrato</th><td><%= persona.getFechaTerPriContrato()%></td></tr>
            <tr><th>Lugar de trabajo</th><td><%= persona.getEstablecimiento()%> - <%= persona.getUnidadNegocio()%></td></tr>
            <tr><th>Cargo</th><td><%=nombreCargo%></td></tr>
            <tr><th>Area</th><td><%= persona.getArea()%></td></tr>
            <tr><th>Centro de costos</th><td><%= persona.getCentroCostos()%></td></tr>
            <tr><th>Centro de trabajo</th><td><%=persona.getCctn()%></td></tr>           
            <tr><th>EPS</th><td><%= persona.getEps()%></td></tr>
            <tr><th>Fondo de pensiones</th><td><%= persona.getFondoPensiones()%></td></tr>
            <tr><th>Fondo de cesantías</th><td><%= persona.getFondoCesantias()%></td></tr>
            <tr><th>Arl</th><td><%= persona.getArl()%></td></tr>
            <tr><th>Banco</th><td><%= persona.getCuentaBancaria()%></td></tr>
            <tr><th>Número de cuenta bancaria</th><td><%= persona.getNumeroCuenta()%></td></tr>
            <tr><th>Salario</th><td><%= persona.getSalario()%></td></tr>
        </table>
        
        <h1>Información de tallas</h1>
        <table class="info-table">
            <tr><th>Talla de camisa</th><td><%= persona.getTallaCamisa()%></td></tr>
            <tr><th>Talla de chaqueta</th><td><%= persona.getTallaChaqueta()%></td></tr>
            <tr><th>Talla de pantalón</th><td><%= persona.getTallaPantalon()%></td></tr>  
            <tr><th>Talla de calzado</th><td><%= persona.getTallaCalzado()%></td></tr>
            <tr><th>Talla de buzo</th><td><%= persona.getTallaBuzo()%></td></tr>                       
            <tr><th>Talla de overol</th><td><%= persona.getTallaO()%></td></tr>
            <tr><th>Talla de guantes</th><td><%= persona.getTallaGuantes()%></td></tr>
        </table>
        <div class="botones-container">          
            <button class="submit" id="regresar" onClick="window.history.back()">Regresar</button>           
        </div>
    </div>
</body>