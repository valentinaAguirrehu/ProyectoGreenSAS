<%@page import="clases.Persona"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="presentacion/estiloTablas.css">

<%@page import="java.util.*" %>
<%
    String accion = request.getParameter("accion");
    String identificacion = request.getParameter("identificacion");
    Persona persona = new Persona();

// Verificar si 'accion' y 'identificacion' no son null y si 'accion' es "Modificar"
    if (accion != null && accion.equals("Modificar") && identificacion != null && !identificacion.isEmpty()) {
        persona = new Persona(identificacion);
    }
%>

<h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> COLABORADORES</h3>

<form name="formulario" method="post" action="principal.jsp?CONTENIDO=personaActualizar.jsp" enctype="multipart/form-data">
    <table border="0">

        <tr>
            <th>Identificación</th>
            <td><input type="text" name="identificacion" value="<%= persona.getIdentificacion()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Tipo</th>
            <td><input type="text" name="tipo" value="<%= persona.getTipo()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Cargo</th>
            <td><input type="text" name="idCargo" value="<%= persona.getIdCargo()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Tipo Documento</th>
            <td><input type="text" name="tipoDocumento" value="<%= persona.getTipoDocumento()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Fecha de Expedición</th>
            <td><input type="date" name="fechaExpedicion" value="<%= persona.getFechaExpedicion()%>"></td>
        </tr>
        <tr>
            <th>Lugar de Expedición</th>
            <td><input type="text" name="lugarExpedicion" value="<%= persona.getLugarExpedicion()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Nombres</th>
            <td><input type="text" name="nombres" value="<%= persona.getNombres()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Apellidos</th>
            <td><input type="text" name="apellidos" value="<%= persona.getApellidos()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Sexo</th>
            <td><input type="text" name="sexo" value="<%= persona.getSexo()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Fecha de Nacimiento</th>
            <td><input type="date" name="fechaNacimiento" value="<%= persona.getFechaNacimiento()%>"></td>
        </tr>
        <tr>
            <th>Lugar de Nacimiento</th>
            <td><input type="text" name="lugarNacimiento" value="<%= persona.getLugarNacimiento()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Tipo de Sangre</th>
            <td><input type="text" name="tipoSangre" value="<%= persona.getTipoSangre()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Tipo de Vivienda</th>
            <td><input type="text" name="tipoVivienda" value="<%= persona.getTipoVivienda()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Dirección</th>
            <td><input type="text" name="direccion" value="<%= persona.getDireccion()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Barrio</th>
            <td><input type="text" name="barrio" value="<%= persona.getBarrio()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Email</th>
            <td><input type="email" name="email" value="<%= persona.getEmail()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Nivel Educativo</th>
            <td><input type="text" name="nivelEducativo" value="<%= persona.getNivelEducativo()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>EPS</th>
            <td><input type="text" name="eps" value="<%= persona.getEps()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Estado Civil</th>
            <td><input type="text" name="estadoCivil" value="<%= persona.getEstadoCivil()%>" size="50" maxlength="50"></td>
        </tr>
    </table>

    <!-- Tabla de Referencias Personales -->
    <h4>Referencias Personales</h4>
    <table border="0">
        <tr>
            <th>Primer Referencia Nombre</th>
            <td><input type="text" name="primerRefNopmbre" value="<%= persona.getPrimerRefNopmbre()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Primer Referencia Parentesco</th>
            <td><input type="text" name="primerRefParentezco" value="<%= persona.getPrimerRefParentezco()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Primer Referencia Celular</th>
            <td><input type="text" name="primerRefCelular" value="<%= persona.getPrimerRefCelular()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Segunda Referencia Nombre</th>
            <td><input type="text" name="segundaRefNombre" value="<%= persona.getSegundaRefNombre()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Segunda Referencia Parentesco</th>
            <td><input type="text" name="segundaRefParentezco" value="<%= persona.getSegundaRefParentezco()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Segunda Referencia Celular</th>
            <td><input type="text" name="segundaRefCelular" value="<%= persona.getSegundaRefCelular()%>" size="50" maxlength="50"></td>
        </tr>
    </table>

    <!-- Tabla de Información de Trabajo -->
    <h4>Información de Trabajo</h4>
    <table border="0">
        <tr>
            <th>Unidad de Negocio</th>
            <td><input type="text" name="unidadNegocio" value="<%= persona.getUnidadNegocio()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Centro de Costos</th>
            <td><input type="text" name="centroCostos" value="<%= persona.getCentroCostos()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Establecimiento</th>
            <td><input type="text" name="establecimiento" value="<%= persona.getEstablecimiento()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Área</th>
            <td><input type="text" name="area" value="<%= persona.getArea()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Tipo de Cargo</th>
            <td><input type="text" name="tipoCargo" value="<%= persona.getTipoCargo()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Cuenta Bancaria</th>
            <td><input type="text" name="cuentaBancaria" value="<%= persona.getCuentaBancaria()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Número de Cuenta</th>
            <td><input type="text" name="numeroCuenta" value="<%= persona.getNumeroCuenta()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Salario</th>
            <td><input type="text" name="salario" value="<%= persona.getSalario()%>" size="50" maxlength="50"></td>
        </tr>
    </table>

    <!-- Tabla de Familiares -->
    <h4>Familiares</h4>
    <table border="0">
        <tr>
            <th>Tiene Hijos</th>
            <td><input type="text" name="tieneHijos" value="<%= persona.getTieneHijos()%>" size="50" maxlength="50"></td>
        </tr>
    </table>

    <!-- Formulario para Dotaciones -->
    <h4>Dotaciones</h4>
    <table border="0">
        <tr>
            <th>Talla Camisa</th>
            <td><input type="text" name="tallaCamisa" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Talla Chaqueta</th>
            <td><input type="text" name="tallaChaqueta" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Talla Pantalón</th>
            <td><input type="text" name="tallaPantalon" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Talla Calzado</th>
            <td><input type="text" name="tallaCalzado" size="50" maxlength="50"></td>
        </tr>
        <input type="hidden" name="identificacion" value="<%= persona.getIdentificacion()%>">
        <input type="submit" value="Guardar Dotaciones">
    </table>






    <h4>Información del Vehículo</h4>
    <table>
        <tr>
            <th>Tiene Vehículo</th>
            <td><input type="text" name="tieneVehiculo" value="<%= persona.getTieneVehiculo()%>" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Tipo de Vehículo</th>
            <td><input type="text" name="tipoVehiculo" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Número de Placa</th>
            <td><input type="text" name="numeroPlaca" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Modelo</th>
            <td><input type="text" name="modeloVehiculo" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Línea</th>
            <td><input type="text" name="linea" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Año</th>
            <td><input type="number" name="ano" size="50" maxlength="4"></td>
        </tr>
        <tr>
            <th>Color</th>
            <td><input type="text" name="color" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Cilindraje</th>
            <td><input type="text" name="cilindraje" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Número de Licencia de Tránsito</th>
            <td><input type="text" name="numLicenciaTransito" size="50" maxlength="50"></td>
        </tr>
        <tr>
            <th>Fecha de Expedición de Licencia de Tránsito</th>
            <td><input type="date" name="fechaExpLicenciaTransito"></td>
        </tr>
    </table>
    <input type="submit" value="Guardar Vehículo">
    
    
    <!-- Foto -->
    <h4>Subir archivos REVISAR</h4>
    <table>
        <tr>
            <th>Foto</th>
            <td><input type="file" name="foto" /></td>
        </tr>
    </table>
</form>

