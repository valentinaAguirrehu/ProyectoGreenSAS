<%-- 
    Document   : personaActualizar
    Created on : 10/03/2025, 03:57:15 PM
    Author     : Mary
--%>

<html>
<head>
    <meta charset="UTF-8">
    <title>categorias</title>
<link rel="stylesheet" type="text/css" href="presentacion/estiloTablas.css">
</head>
</html>

<%@page import="clases.Persona"%>
<%
    
    String accion=request.getParameter("accion");
    String identificacionAnterior=request.getParameter("identificacionAnterior");

    Persona persona = new Persona();
    persona.setIdentificacion(request.getParameter("identificacion"));
    persona.setTipo(request.getParameter("tipo"));
    persona.setIdCargo(request.getParameter("idCargo"));
    persona.setTipoCargo(request.getParameter("tipoCargo"));
    persona.setTipoDocumento(request.getParameter("tipoDocumento"));
    persona.setFechaExpedicion(request.getParameter("fechaExpedicion"));
    persona.setLugarExpedicion(request.getParameter("lugarExpedicion"));
    persona.setNombres(request.getParameter("nombres"));
    persona.setApellidos(request.getParameter("apellidos"));
    persona.setSexo(request.getParameter("sexo"));
    persona.setFechaNacimiento(request.getParameter("fechaNacimiento"));
    persona.setLugarNacimiento(request.getParameter("lugarNacimiento"));
    persona.setTipoSangre(request.getParameter("tipoSangre"));
    persona.setTipoVivienda(request.getParameter("tipoVivienda"));
    persona.setBarrio(request.getParameter("barrio"));
    persona.setEmail(request.getParameter("email"));
    persona.setNivelEducativo(request.getParameter("nivelEducativo"));
    persona.setEmail(request.getParameter("eps"));
    persona.setEstadoCivil(request.getParameter("estadoCivil"));
    persona.setFechaIngreso(request.getParameter("fechaIngreso"));
    persona.setFechaRetiro(request.getParameter("fechaRetiro"));
    persona.setFechaEtapaLectiva(request.getParameter("fechaEtapaLectiva"));
    persona.setFechaEtapaProductiva(request.getParameter("fechaEtapaProductiva"));
    persona.setUnidadNegocio(request.getParameter("unidadNegocio"));
    persona.setCentroCostos(request.getParameter("centroCostos"));
    persona.setEstablecimiento(request.getParameter("establecimiento"));
    persona.setArea(request.getParameter("area"));
    persona.setTipo(request.getParameter("tipoCargo"));
    persona.setCuentaBancaria(request.getParameter("cuentaBancaria"));
    persona.setNumeroCuenta(request.getParameter("numeroCuenta"));
    persona.setSalario(request.getParameter("salario"));
    persona.setPrimerRefNombre(request.getParameter("primerRefNombre"));
    persona.setPrimerRefParentezco(request.getParameter("primerRefParentezco"));
    persona.setPrimerRefCelular(request.getParameter("primerRefCelular"));
    persona.setSegundaRefNombre(request.getParameter("segundaRefNombre"));
    persona.setSegundaRefNombre(request.getParameter("segundaRefParentezco"));
    persona.setSegundaRefCelular(request.getParameter("segundaRefCelular"));
    persona.setTieneHijos(request.getParameter("tieneHijos"));
    persona.setTallaCamisa(request.getParameter("tallaCamisa"));
    persona.setTallaChaqueta(request.getParameter("tallaChaqueta"));
    persona.setTallaPantalon(request.getParameter("tallaPantalon"));
    persona.setTallaCalzado(request.getParameter("tallaCalzado"));
    persona.setTieneVehiculo(request.getParameter("tieneVehiculo"));
    persona.setNumLicenciaConduccion(request.getParameter("numLicenciaConduccion"));
    persona.setFechaExpConduccion(request.getParameter("fechaExpConduccion"));
    persona.setFechaVencimiento(request.getParameter("fechaVencimiento"));
    persona.setRestricciones(request.getParameter("restricciones"));
    persona.setClave(request.getParameter("clave"));
    persona.setEstado(request.getParameter("estado"));
    persona.setVinculacionLaboral(request.getParameter("estado"));
    persona.setIdVehiculo(request.getParameter("estado"));
    switch(accion){
        case "Adicionar":
            persona.grabar();
            break;
        case "Modificar":
            persona.setIdentificacion(request.getParameter("identificacion"));
            persona.modificar(identificacionAnterior);
            break;
        case "Eliminar":
            persona.setIdentificacion(request.getParameter("identificacion"));
            persona.eliminar();
            break;
    }
 //response.sendRedirect("principal.jsp?CONTENIDO=categorias.jsp");
%>
<script type="text/javascript">
    document.location="principal.jsp?CONTENIDO=categorias.jsp";
</script>



