<%-- 
    Document   : persona
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>

<%@page import="clases.Persona"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
    persona.setDireccion(request.getParameter("direccion")); // ✅ 
    persona.setBarrio(request.getParameter("barrio"));
    persona.setEmail(request.getParameter("email")); // ✅ 
    persona.setNivelEducativo(request.getParameter("nivelEducativo"));
    persona.setEps(request.getParameter("eps")); // ✅ 
    persona.setEstadoCivil(request.getParameter("estadoCivil"));
    persona.setFechaIngreso(request.getParameter("1998-16-11"));
    persona.setFechaRetiro(request.getParameter("2000-11-11"));
    persona.setFechaEtapaLectiva(request.getParameter("2000-11-11"));
    persona.setFechaEtapaProductiva(request.getParameter("2000-11-11"));
    persona.setUnidadNegocio(request.getParameter("unidadNegocio"));
    persona.setCentroCostos(request.getParameter("centroCostos"));
    persona.setEstablecimiento(request.getParameter("establecimiento"));
    persona.setArea(request.getParameter("area"));
    persona.setCuentaBancaria(request.getParameter("cuentaBancaria"));
    persona.setNumeroCuenta(request.getParameter("numeroCuenta"));
    persona.setSalario(request.getParameter("salario"));
    persona.setPrimerRefNombre(request.getParameter("primerRefNombre"));
    persona.setPrimerRefParentezco(request.getParameter("primerRefParentezco"));
    persona.setPrimerRefCelular(request.getParameter("primerRefCelular"));
    persona.setSegundaRefNombre(request.getParameter("segundaRefNombre"));
    persona.setSegundaRefParentezco(request.getParameter("segundaRefParentezco")); // ✅ Corregido
    persona.setSegundaRefCelular(request.getParameter("segundaRefCelular"));
   // persona.setTieneHijos(request.getParameter("tieneHijos"));
    persona.setTallaCamisa(request.getParameter("tallaCamisa"));
    persona.setTallaChaqueta(request.getParameter("tallaChaqueta"));
    persona.setTallaPantalon(request.getParameter("tallaPantalon"));
    persona.setTallaCalzado(request.getParameter("tallaCalzado"));
 //   persona.setTieneVehiculo(request.getParameter("tieneVehiculo"));
    //persona.setNumLicenciaConduccion(request.getParameter("1"));
    persona.setNumLicenciaConduccion(request.getParameter("numLicenciaConduccion"));
    persona.setFechaExpConduccion(request.getParameter("fechaExpConduccion"));
    persona.setFechaVencimiento(request.getParameter("2000-11-11"));
    persona.setRestricciones(request.getParameter("restricciones"));
    persona.setEstado(request.getParameter("estado"));
    persona.setNumeroPlacaVehiculo(request.getParameter("numeroPlacaVehiculo"));



switch(accion){
    case "Adicionar":
        persona.grabar();
        break;
    case "Modificar":
        persona.modificar(identificacionAnterior);
        break;
    case "Eliminar":
        persona.eliminar();
        break;
}
%>

<script type="text/javascript">
    document.location="persona.jsp"
</script>


