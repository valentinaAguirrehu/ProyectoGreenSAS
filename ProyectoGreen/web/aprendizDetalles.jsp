<%-- 
    Document   : aprendizDetalle
    Created on : 22/03/2025, 02:30:30 AM
    Author     : Mary
--%>
<%@page import="clases.GeneroPersona"%>
<%@page import="clases.Educacion"%>
<%@page import="clases.Talla"%>
<%@page import="clases.InformacionLaboral"%>
<%@page import="clases.Vehiculo"%>
<%@page import="clases.Referencia"%>
<%@page import="clases.SeguridadSocial"%>
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
    SeguridadSocial seguridadSocial = new SeguridadSocial(identificacion);
    Referencia referencia = new Referencia(identificacion);
    Vehiculo vehiculo = new Vehiculo(identificacion);
    InformacionLaboral informacionLaboral = new InformacionLaboral(identificacion);
    Educacion educacion = new Educacion(identificacion);
    Talla talla = new Talla(identificacion);

    List<Hijo> hijos = persona.obtenerHijos();

    // Obtener el nombre del cargo
    String nombreCargo = "No asignado"; // Valor por defecto
    if (informacionLaboral != null && informacionLaboral.getIdentificacion() != null && informacionLaboral.getIdCargo() != null) {
        Cargo cargo = new Cargo(informacionLaboral.getIdCargo()); // Crear objeto Cargo
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

        <h3>Detalles de aprendices GREEN S.A.S</h3>

        <h1>Datos personales</h1>
        <table class="info-table" border="1">
            <tr><th>Nombre Completo</th><td><%= persona.getNombres()%> <%= persona.getApellidos()%></td></tr>
            <tr><th>Sexo</th><td><%= new GeneroPersona(persona.getSexo())%></td></tr>
            <tr><th>Fecha de ingreso</th><td><%= informacionLaboral.getFechaIngreso()%></td></tr>
            <tr><th>Fecha de inicio de etapa lectiva</th><td><%= educacion.getFechaEtapaLectiva()%></td></tr> 
            <tr><th>Fecha de finalizacion de etapa lectiva</th><td><%= educacion.getFechaFinalizacionEtapaLectiva()%></td></tr> 
            <tr><th>Fecha de inicio de etapa productiva</th><td><%= educacion.getFechaEtapaProductiva()%></td></tr> 
            <tr><th>Fecha de finalizacion de etapa productiva</th><td><%= educacion.getFechaFinalizacionEtapaProductiva()%></td></tr> 
            <tr><th>Fecha retiro anticipado</th><td><%= educacion.getFechaRetiroAnticipado()%></td></tr> 
            <tr><th>Tipo de documento</th><td><%= persona.getTipoDocumento()%></td></tr>
            <tr><th>Número del documento</th><td><%= persona.getIdentificacion()%></td></tr>
            <tr><th>Fecha de Expedición</th><td><%= persona.getFechaExpedicion()%></td></tr>
            <tr><th>Lugar de Expedición</th><td><%= persona.getLugarExpedicion()%></td></tr>
            <tr><th>Fecha de Nacimiento</th><td><%= persona.getFechaNacimiento()%></td></tr>
            <tr><th>Edad</th><td><%= persona.calcularEdad()%></td></tr>
            <tr><th>Lugar de nacimiento</th><td><%= persona.getLugarNacimiento()%></td></tr>
            <tr><th>Tipo de sangre</th><td><%= persona.getTipoSangre()%></td></tr>
            <tr><th>Tipo de vivienda</th><td><%= persona.getTipoVivienda()%></td></tr>
            <tr><th>Dirección</th><td><%= persona.getDireccion()%></td></tr>
            <tr><th>Barrio</th><td><%= persona.getBarrio()%></td></tr>
            <tr><th>Celular</th><td><%= persona.getCelular()%></td></tr>
            <tr><th>Correo electrónico</th><td><%= persona.getEmail()%></td></tr>
            <tr><th>Nivel educativo alcanzado</th><td><%= persona.getNivelEdu()%> </td></tr>
            <tr><th>Titulo a obtener </th><td><%= educacion.getTituloAprendiz()%> </td></tr>
            <tr><th>Profesión </th><td><%= persona.getProfesion()%> </td></tr>
            <tr><th>Estado civil</th><td><%= persona.getEstadoCivil()%></td></tr>

        </table>

        <h1>Información de hijos</h1>
        <table class="info-table">
            <tr><th>Tipo de documento</th><th>Numero de documento</th><th>Nombre</th><th>Edad</th><th>Nivel educativo</th></tr>
                    <% if (hijos != null && !hijos.isEmpty()) {
                            for (Hijo hijo : hijos) {%>
            <tr>
                <td><%= hijo.getTipoIden()%></td>
                <td><%= hijo.getIdentificacion()%></td>
                <td><%= hijo.getNombres()%></td>
                <td><%= hijo.calcularEdad()%></td>
                <td><%= hijo.getNivelEscolar()%></td>
            </tr>
            <% }
            } else { %>
            <tr><td colspan="3">No tiene hijos registrados.</td></tr>
            <% } %>
        </table>

        <% if (vehiculo.getNumeroPlacaVehiculo() != null && !vehiculo.getNumeroPlacaVehiculo().isEmpty()) {%>
        <h1>Información del vehículo</h1>
        <table class="info-table">
            <tr><th>Número de placa:</th><td><%= vehiculo.getNumeroPlacaVehiculo()%></td></tr>
            <tr><th>Tipo medio de transporte</th><td><%= vehiculo.getTipoVehiculo()%></td></tr>
            <tr><th>Modelo:</th><td><%= vehiculo.getModeloVehiculo()%></td></tr>
            <tr><th>Línea:</th><td><%= vehiculo.getLinea()%></td></tr>
            <tr><th>Marca:</th><td><%= vehiculo.getMarca()%></td></tr>
            <tr><th>Color:</th><td><%= vehiculo.getColor()%></td></tr>
            <tr><th>Cilindraje:</th><td><%= vehiculo.getCilindraje()%></td></tr>
            <tr><th>Restricciones del conductor</th><td><%= vehiculo.getRestricciones()%></td></tr>
            <tr><th>Titular Tarjeta de Propiedad</th><td><%= vehiculo.getTitularTrjPro()%></td></tr>
            <tr><th>Número de la tarjeta de propiedad</th><td><%= vehiculo.getNumLicenciaTransito()%></td></tr>
            <tr><th>Fecha de expedición tarjeta de propiedad</th><td><%= vehiculo.getFechaExpLicenciaTransito()%></td></tr>
        </table>
        <h1>Licencia de conducción</h1>
        <table class="info-table">
            <tr><th>Estado</th><td><%= vehiculo.getEstadoV()%></td></tr>
            <tr><th>Fecha de expedición de la licencia de conducción</th><td><%= vehiculo.getFechaExpConduccion()%></td></tr>
            <tr><th>Fecha de vencimiento de la licencia de conducción</th><td><%= vehiculo.getFechaVencimiento()%></td></tr>
            <tr><th>Número de la licencia de conducción</th><td><%= vehiculo.getNumLicenciaConduccion()%></td></tr>
        </table>
        <% }%>

        <h1>Contactos personales</h1>
        <table class="info-table">
            <tr><th>Primer contacto</th><td><%= referencia.getPrimerRefNombre()%> - <%= referencia.getPrimerRefParentezco()%> - <%= referencia.getPrimerRefCelular()%></td></tr>
            <tr><th>Segundo contacto</th><td><%= referencia.getSegundaRefNombre()%> - <%= referencia.getSegundaRefParentezco()%> - <%= referencia.getSegundaRefCelular()%></td></tr>
            <tr><th>Tercer contacto</th><td><%= referencia.getTerceraRefNombre()%> - <%= referencia.getTerceraRefParentezco()%> - <%= referencia.getTerceraRefCelular()%></td></tr>
            <tr><th>Cuarto contacto</th><td><%= referencia.getCuartaRefNombre()%> - <%= referencia.getCuartaRefParentezco()%> - <%= referencia.getCuartaRefCelular()%></td></tr>
        </table>

        <h1>Información laboral</h1>
        <table class="info-table">
            <tr><th>Duración del primer contrato</th><td><%= informacionLaboral.getFechaTerPriContrato()%></td></tr>
            <tr><th>Unidad de negocio</th><td><%=informacionLaboral.getUnidadNegocio()%></td></tr>           
            <tr><th>Centro de costos</th><td><%= informacionLaboral.getCentroCostos()%></td></tr>
            <tr><th>Lugar de trabajo</th><td><%= informacionLaboral.getEstablecimiento()%> - <%= informacionLaboral.getUnidadNegocio()%></td></tr>
            <tr><th>Area</th><td><%= informacionLaboral.getArea()%></td></tr>
            <tr><th>Cargo</th><td><%=nombreCargo%></td></tr>
            <tr><th>EPS</th><td><%= seguridadSocial.getEps()%></td></tr>
            <tr><th>Banco</th><td><%= persona.getCuentaBancaria()%></td></tr>
            <tr><th>Número de cuenta bancaria</th><td><%= persona.getNumeroCuenta()%></td></tr>
            <tr><th>Salario</th><td><%= informacionLaboral.getSalario()%></td></tr>
        </table>

        <h1>Información de tallas</h1>
        <table class="info-table">
            <tr><th>Talla de camisa</th><td><%=  talla.getTallaCamisa()%></td></tr>
            <tr><th>Talla de chaqueta</th><td><%= talla.getTallaChaqueta()%></td></tr>
            <tr><th>Talla de pantalón</th><td><%= talla.getTallaPantalon()%></td></tr>  
            <tr><th>Talla de calzado</th><td><%= talla.getTallaCalzado()%></td></tr>
            <tr><th>Talla de buzo</th><td><%= talla.getTallaBuzo()%></td></tr>                       
            <tr><th>Talla de overol</th><td><%= talla.getTallaO()%></td></tr>
            <tr><th>Talla de guantes</th><td><%= talla.getTallaGuantes()%></td></tr>
        </table>

        <div class="botones-container">          
            <button class="submit" id="regresar" onClick="window.history.back()">Regresar</button>           
        </div>
    </div>
</body>