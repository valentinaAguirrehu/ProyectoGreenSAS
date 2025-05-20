<%-- 
    Document   : colaboradorActualizar
    Created on : 12/05/2025, 04:24:24 PM
    Author     : Mary
--%>

<%@page import="clases.SeguridadSocial"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Hijo"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
    // Capturar acción y valores del formulario
    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");

   SeguridadSocial seguridadSocial = (SeguridadSocial) request.getAttribute("seguridadSocial");
    request.setAttribute("seguridadSocial", seguridadSocial);

    // Crear objeto persona y asignar valores del formulario
    Persona persona = new Persona();
    persona.setIdentificacion(request.getParameter("identificacion"));
    persona.setTipo("C");
    persona.setIdCargo(request.getParameter("idCargo"));
    persona.setTipoDocumento(request.getParameter("tipoDocumento"));
    persona.setFechaExpedicion(request.getParameter("fechaExpedicion"));
    persona.setNombres(request.getParameter("nombres"));
    persona.setApellidos(request.getParameter("apellidos"));
    persona.setSexo(request.getParameter("sexo"));
    persona.setFechaNacimiento(request.getParameter("fechaNacimiento"));
    persona.setLugarNacimiento(request.getParameter("lugarNacimiento"));
    persona.setTipoSangre(request.getParameter("tipoSangreFinal"));
    persona.setTipoVivienda(request.getParameter("tipoViviendaFinal"));
    persona.setDireccion(request.getParameter("direccion"));
    persona.setBarrio(request.getParameter("barrio"));
    persona.setCelular(request.getParameter("celular"));
    persona.setEmail(request.getParameter("email"));
    persona.setEstadoCivil(request.getParameter("estadoCivilFinal"));
    persona.setNumeroCuenta(request.getParameter("numeroCuenta"));
    String datosHijos = request.getParameter("hijosRegistrados");
 persona.setIdDepartamentoExpedicion(request.getParameter("idDepartamento"));
    persona.setIdMunicipioExpedicion(request.getParameter("idMunicipio"));
    persona.setIdDepartamentoNacimiento(request.getParameter("idDepartamento"));
    persona.setIdMunicipioNacimiento(request.getParameter("idMunicipio"));
//    // Capturar valores del formulario
    String idDepartamentoExpedicion = request.getParameter("departamentoExpedicion");
    String idMunicipioExpedicion = request.getParameter("lugarExpedicion");

    String idDepartamentoNacimiento = request.getParameter("departamentoNacimiento");
    String idMunicipioNacimiento = request.getParameter("lugarNacimiento");

//  Concatenar valores
    String lugarExpedicion = idDepartamentoExpedicion + "-" + idMunicipioExpedicion;
    String lugarNacimiento = idDepartamentoNacimiento + "-" + idMunicipioNacimiento;

// Guardar en el objeto Persona
    persona.setLugarExpedicion(lugarExpedicion);
    persona.setLugarNacimiento(lugarNacimiento);

    // Capturar datos de los hijos
    String[] identificacionesHijos = request.getParameterValues("identificacionHijo[]");
    String[] nombresHijos = request.getParameterValues("nombreHijo[]");
    String[] fechasNacimientoHijos = request.getParameterValues("fechaNacimientoHijo[]");

    // Acción según el botón presionado
    // Acción según el botón presionado
    boolean personaGuardada = false;
    switch (accion) {
        case "Adicionar":
            personaGuardada = persona.grabar();
            break;
        case "Modificar":
            personaGuardada = persona.modificar(identificacionAnterior);
            break;
        case "Eliminar":
            personaGuardada = persona.eliminar();
            break;
    }

    // Solo proceder con los hijos si la persona se guardó correctamente
    if (personaGuardada && identificacionesHijos != null) {
        for (int i = 0; i < identificacionesHijos.length; i++) {
            if (!identificacionesHijos[i].trim().isEmpty() && !nombresHijos[i].trim().isEmpty() && !fechasNacimientoHijos[i].trim().isEmpty()) {
                // Insertar en la tabla hijos si no existe
                String sqlHijo = "INSERT INTO hijos (identificacion, nombres, fechaNacimiento) VALUES ('"
                        + identificacionesHijos[i] + "', '" + nombresHijos[i] + "', '" + fechasNacimientoHijos[i] + "') "
                        + "ON DUPLICATE KEY UPDATE nombres = VALUES(nombres), fechaNacimiento = VALUES(fechaNacimiento)";
                ConectorBD.ejecutarQuery(sqlHijo);

                // Insertar en persona_hijos con autoincremental id
                String sqlRelacion = "INSERT INTO persona_hijos (identificacionPersona, identificacionHijo) VALUES ('"
                        + persona.getIdentificacion() + "', '" + identificacionesHijos[i] + "')";
                System.out.println("SQL Relación: " + sqlRelacion);
                ConectorBD.ejecutarQuery(sqlRelacion);
            }
        }
    }

    // 🔥 Solo redirigir automáticamente si se guardó (Adicionar), no si se elimina ni modifica
    if (personaGuardada && "Adicionar".equals(accion)) {
        String identificacionParaRedirigir = persona.getIdentificacion();
        response.sendRedirect("seguridadSocialFormulario.jsp?identificacion=" + identificacionParaRedirigir);
        return; // Detiene el JSP después de redirigir
    }

    // Si no se guardó, puedes mostrar un error o quedarte en la misma página
%>



<!-- Verifica si la persona fue guardada con éxito y muestra el siguiente formulario -->

<script type="text/javascript">
    document.location = "seguridadSocialFormulario.jsp";
</script>
