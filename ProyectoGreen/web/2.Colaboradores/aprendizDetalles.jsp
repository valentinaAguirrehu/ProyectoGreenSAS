<%-- 
    Document   : aprendizDetalle
    Created on : 22/03/2025, 02:30:30 AM
    Author     : Mary
--%>
<%@page import="clases.Municipio"%>
<%@page import="clases.Departamento"%>
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
    String nombreDepartamentoNacimiento = "No asignado";
    String nombreMunicipioNacimiento = "No asignado";

    String idDepNacimiento = persona.getIdDepartamentoNacimiento();
    String idMunNacimiento = persona.getIdMunicipioNacimiento();

    if (idMunNacimiento != null && !idMunNacimiento.trim().isEmpty()) {
        Municipio municipio = new Municipio(idMunNacimiento);
        if (municipio.getNombre() != null && !municipio.getNombre().trim().isEmpty()) {
            nombreMunicipioNacimiento = municipio.getNombre();
        }
    }

    if (idDepNacimiento != null && !idDepNacimiento.trim().isEmpty()) {
        Departamento departamento = new Departamento(idDepNacimiento);
        if (departamento.getNombre() != null && !departamento.getNombre().trim().isEmpty()) {
            nombreDepartamentoNacimiento = departamento.getNombre();
        }
    }

//----
    String nombreDepartamentoExp = "No asignado";
    String nombreMunicipioExp = "No asignado";

    String lugarExp = persona.getLugarExpedicion();
    if (lugarExp != null && lugarExp.contains("-")) {
        String[] partes = lugarExp.split("-");

        if (partes.length > 0 && partes[0] != null && !partes[0].trim().isEmpty()) {
            Departamento departamento = new Departamento(partes[0]);
            if (departamento.getNombre() != null && !departamento.getNombre().trim().isEmpty()) {
                nombreDepartamentoExp = departamento.getNombre();
            }
        }

        if (partes.length > 1 && partes[1] != null && !partes[1].trim().isEmpty()) {
            Municipio municipio = new Municipio(partes[1]);
            if (municipio.getNombre() != null && !municipio.getNombre().trim().isEmpty()) {
                nombreMunicipioExp = municipio.getNombre();
            }
        }
    }
%>
<%!
    public String mostrarCampo(Object valor) {
        return (valor != null && !valor.toString().trim().isEmpty() && !"null".equalsIgnoreCase(valor.toString().trim()))
                ? valor.toString()
                : "No aplica";
    }
%>

<%@ include file="../menu.jsp" %>

<head>
    <link rel="stylesheet" href="../presentacion/style-FormularioColaboradores.css">
</head>
<body>
    <div class="content"> 

        <h3>Detalles de aprendices GREEN S.A.S</h3>

        <table class="info-table" border="1">
            <tr><th>Nombre Completo</th><td><%= mostrarCampo(persona.getNombres())%> <%= mostrarCampo(persona.getApellidos())%></td></tr>
            <tr><th>Sexo</th><td><%= mostrarCampo(new GeneroPersona(persona.getSexo()).toString())%></td></tr>
            <!-- <tr><th>Fecha de ingreso</th><td><%= mostrarCampo(informacionLaboral.getFechaIngreso())%></td></tr> -->
            <tr><th>Fecha de inicio de etapa lectiva</th><td><%= mostrarCampo(educacion.getFechaEtapaLectiva())%></td></tr> 
            <tr><th>Fecha de finalización de etapa lectiva</th><td><%= mostrarCampo(educacion.getFechaFinalizacionEtapaLectiva())%></td></tr> 
            <tr><th>Fecha de inicio de etapa productiva</th><td><%= mostrarCampo(educacion.getFechaEtapaProductiva())%></td></tr> 
            <tr><th>Fecha de finalización de etapa productiva</th><td><%= mostrarCampo(educacion.getFechaFinalizacionEtapaProductiva())%></td></tr> 
            <tr><th>Fecha retiro anticipado</th><td><%= mostrarCampo(educacion.getFechaRetiroAnticipado())%></td></tr> 
            <tr><th>Tipo de documento</th><td><%= mostrarCampo(persona.getTipoDocumento())%></td></tr>
            <tr><th>Número del documento</th><td><%= mostrarCampo(persona.getIdentificacion())%></td></tr>
            <tr><th>Fecha de Expedición</th><td><%= mostrarCampo(persona.getFechaExpedicion())%></td></tr>
            <tr><th>Lugar de Expedición</th><td><%= nombreMunicipioExp + " - " + nombreDepartamentoExp%></td></tr>
            <tr><th>Fecha de Nacimiento</th><td><%= mostrarCampo(persona.getFechaNacimiento())%></td></tr>
            <tr><th>Edad</th><td><%= persona.calcularEdad() != null ? persona.calcularEdad() : "No aplica"%></td></tr>
            <tr><th>Lugar de nacimiento</th>
                <td><%= mostrarCampo(nombreMunicipioNacimiento)%> - <%= mostrarCampo(nombreDepartamentoNacimiento)%></td>
            </tr>            <tr><th>Tipo de sangre</th><td><%= mostrarCampo(persona.getTipoSangre())%></td></tr>
            <tr><th>Tipo de vivienda</th><td><%= mostrarCampo(persona.getTipoVivienda())%></td></tr>
            <tr><th>Dirección</th><td><%= mostrarCampo(persona.getDireccion())%></td></tr>
            <tr><th>Barrio</th><td><%= mostrarCampo(persona.getBarrio())%></td></tr>
            <tr><th>Celular</th><td><%= mostrarCampo(persona.getCelular())%></td></tr>
            <tr><th>Correo electrónico</th><td><%= mostrarCampo(persona.getEmail())%></td></tr>
            <tr><th>Nivel educativo alcanzado</th><td><%= mostrarCampo(persona.getNivelEdu())%></td></tr>
            <tr><th>Título a obtener</th><td><%= mostrarCampo(educacion.getTituloAprendiz())%></td></tr>
            <tr><th>Profesión</th><td><%= mostrarCampo(persona.getProfesion())%></td></tr>
            <tr><th>Estado civil</th><td><%= mostrarCampo(persona.getEstadoCivil())%></td></tr>
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
            <tr><th>Número de placa:</th><td><%= mostrarCampo(vehiculo.getNumeroPlacaVehiculo())%></td></tr>
            <tr><th>Tipo medio de transporte</th><td><%= mostrarCampo(vehiculo.getTipoVehiculo())%></td></tr>
            <tr><th>Modelo:</th><td><%= mostrarCampo(vehiculo.getModeloVehiculo())%></td></tr>
            <tr><th>Línea:</th><td><%= mostrarCampo(vehiculo.getLinea())%></td></tr>
            <tr><th>Marca:</th><td><%= mostrarCampo(vehiculo.getMarca())%></td></tr>
            <tr><th>Color:</th><td><%= mostrarCampo(vehiculo.getColor())%></td></tr>
            <tr><th>Cilindraje:</th><td><%= mostrarCampo(vehiculo.getCilindraje())%></td></tr>
            <tr><th>Restricciones del conductor</th><td><%= mostrarCampo(vehiculo.getRestricciones())%></td></tr>
            <tr><th>Titular Tarjeta de Propiedad</th><td><%= mostrarCampo(vehiculo.getTitularTrjPro())%></td></tr>
            <tr><th>Número de la tarjeta de propiedad</th><td><%= mostrarCampo(vehiculo.getNumLicenciaTransito())%></td></tr>
            <tr><th>Fecha de expedición tarjeta de propiedad</th><td><%= mostrarCampo(vehiculo.getFechaExpLicenciaTransito())%></td></tr>
        </table>

        <h1>Licencia de conducción</h1>
        <table class="info-table">
            <tr><th>Estado</th><td><%= mostrarCampo(vehiculo.getEstadoV())%></td></tr>
            <tr><th>Fecha de expedición de la licencia de conducción</th><td><%= mostrarCampo(vehiculo.getFechaExpConduccion())%></td></tr>
            <tr><th>Fecha de vencimiento de la licencia de conducción</th><td><%= mostrarCampo(vehiculo.getFechaVencimiento())%></td></tr>
            <tr><th>Número de la licencia de conducción</th><td><%= mostrarCampo(vehiculo.getNumLicenciaConduccion())%></td></tr>
        </table>

        <% }%>

        <h1>Contactos personales</h1>
        <table class="info-table">
            <tr><th>Primer contacto</th><td><%= referencia.getPrimerRefNombre()%> - <%= referencia.getPrimerRefParentezco()%> - <%= referencia.getPrimerRefCelular()%></td></tr>

            <tr><th>Segundo contacto</th><td><%=(referencia.getSegundaRefNombre() + " - " + referencia.getSegundaRefParentezco() + " - " + referencia.getSegundaRefCelular()).equals(" -  - ")
                    ? "No aplica"
                    : referencia.getSegundaRefNombre() + " - " + referencia.getSegundaRefParentezco() + " - " + referencia.getSegundaRefCelular()%></td></tr>
            <tr><th>Tercer contacto</th><td><%= referencia.getTerceraRefNombre()%> - <%= referencia.getTerceraRefParentezco()%> - <%= referencia.getTerceraRefCelular()%></td></tr>
            <tr><th>Cuarto contacto</th><td><%= referencia.getCuartaRefNombre()%> - <%= referencia.getCuartaRefParentezco()%> - <%= referencia.getCuartaRefCelular()%></td></tr>
        </table>


        <h1>Información laboral</h1>
        <table class="info-table">
            <tr><th>Unidad de negocio</th><td><%= mostrarCampo(informacionLaboral.getUnidadNegocio())%></td></tr>           
            <tr><th>Centro de costos</th><td><%= mostrarCampo(informacionLaboral.getCentroCostos())%></td></tr>
            <tr><th>Lugar de trabajo</th><td><%= mostrarCampo(informacionLaboral.getEstablecimiento())%> - <%= mostrarCampo(informacionLaboral.getUnidadNegocio())%></td></tr>
            <tr><th>Área</th><td><%= informacionLaboral.getAreaTexto()%></td></tr>
            <tr><th>Cargo</th><td><%= mostrarCampo(nombreCargo)%></td></tr>
            <tr><th>EPS</th><td><%= mostrarCampo(seguridadSocial.getEps())%></td></tr>
            <tr><th>Banco</th><td><%= mostrarCampo(persona.getCuentaBancaria())%></td></tr>
            <tr><th>Número de cuenta bancaria</th><td><%= mostrarCampo(persona.getNumeroCuenta())%></td></tr>
            <tr><th>Salario</th><td><%= mostrarCampo(informacionLaboral.getSalario())%></td></tr>
        </table>


        <h1>Información de tallas</h1>
        <table class="info-table">
            <tr><th>Talla de camisa</th><td><%= mostrarCampo(talla.getTallaCamisa())%></td></tr>
            <tr><th>Talla de chaqueta</th><td><%= mostrarCampo(talla.getTallaChaqueta())%></td></tr>
            <tr><th>Talla de pantalón</th><td><%= mostrarCampo(talla.getTallaPantalon())%></td></tr>  
            <tr><th>Talla de calzado</th><td><%= mostrarCampo(talla.getTallaCalzado())%></td></tr>
            <tr><th>Talla de buzo</th><td><%= mostrarCampo(talla.getTallaBuzo())%></td></tr>                       
            <tr><th>Talla de overol</th><td><%= mostrarCampo(talla.getTallaO())%></td></tr>
            <tr><th>Talla de guantes</th><td><%= mostrarCampo(talla.getTallaGuantes())%></td></tr>
        </table>


        <div class="botones-container">          
            <button class="submit" id="regresar" onClick="window.history.back()">Regresar</button>           
        </div>
    </div>
</body>