<%-- 
    Document   : aprendicesActualizar
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="clases.Persona"%>
<%@page import="clases.Hijo"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
    // Capturar acción y valores del formulario
    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");

    // Crear objeto persona y asignar valores del formulario
    Persona persona = new Persona();
    persona.setIdentificacion(request.getParameter("identificacion"));
    persona.setTipo("A");
    persona.setIdCargo(request.getParameter("idCargo"));
    persona.setCctn(request.getParameter("cctn"));
    persona.setTipoDocumento(request.getParameter("tipoDocumento"));
    persona.setFechaExpedicion(request.getParameter("fechaExpedicion"));
    persona.setNombres(request.getParameter("nombres"));
    persona.setApellidos(request.getParameter("apellidos"));
    persona.setSexo(request.getParameter("sexo"));
    persona.setFechaNacimiento(request.getParameter("fechaNacimiento"));
    persona.setLugarNacimiento(request.getParameter("lugarNacimiento"));
    persona.setTipoSangre(request.getParameter("tipoSangre"));
    persona.setTipoVivienda(request.getParameter("tipoVivienda"));
    persona.setDireccion(request.getParameter("direccion"));
    persona.setBarrio(request.getParameter("barrio"));
    persona.setCelular(request.getParameter("celular"));
    persona.setEmail(request.getParameter("email"));
    persona.setNivelEducativo(request.getParameter("nivelEducativo"));
    persona.setEps(request.getParameter("eps"));
    persona.setEstadoCivil(request.getParameter("estadoCivil"));
    persona.setFechaIngreso(request.getParameter("fechaIngreso"));
    persona.setFechaRetiro(request.getParameter("fechaRetiro"));
    persona.setFechaEtapaLectiva(request.getParameter("fechaEtapaLectiva"));
    persona.setFechaEtapaProductiva(request.getParameter("fechaEtapaProductiva"));
    persona.setTituloAprendiz(request.getParameter("TituloAprendiz"));
    persona.setUnidadNegocio(request.getParameter("unidadNegocio"));
    persona.setCentroCostos(request.getParameter("centroCostos"));
    persona.setEstablecimiento(request.getParameter("establecimiento"));
    persona.setArea(request.getParameter("No aplica"));
    persona.setCuentaBancaria(request.getParameter("cuentaBancaria"));
    persona.setNumeroCuenta(request.getParameter("numeroCuenta"));
    persona.setSalario(request.getParameter("salario"));
    persona.setPrimerRefNombre(request.getParameter("primerRefNombre"));
    persona.setPrimerRefParentezco(request.getParameter("primerRefParentezco"));
    persona.setPrimerRefCelular(request.getParameter("primerRefCelular"));
    persona.setSegundaRefNombre(request.getParameter("segundaRefNombre"));
    persona.setSegundaRefParentezco(request.getParameter("segundaRefParentezco"));
    persona.setSegundaRefCelular(request.getParameter("segundaRefCelular"));
    persona.setTerceraRefNombre(request.getParameter("terceraRefNombre"));
    persona.setTerceraRefParentezco(request.getParameter("terceraRefParentezco"));
    persona.setTerceraRefCelular(request.getParameter("terceraRefCelular"));
    persona.setCuartaRefNombre(request.getParameter("cuartaRefNombre"));
    persona.setCuartaRefParentezco(request.getParameter("cuartaRefParentezco"));
    persona.setCuartaRefCelular(request.getParameter("cuartaRefCelular"));
    persona.setTieneHijos(request.getParameter("tieneHijos"));
    String datosHijos = request.getParameter("hijosRegistrados");

    persona.setTallaCamisa(request.getParameter("No aplica"));
    persona.setTallaChaqueta(request.getParameter("No aplica"));
    persona.setTallaO(request.getParameter("No aplica"));
    //persona.setTallaPantalon(request.getParameter("No aplica"));
    //persona.setTallaCalzado(request.getParameter("tallaCalzado"));
    persona.setTieneVehiculo(request.getParameter("tieneVehiculo"));
    persona.setNumeroPlacaVehiculo(request.getParameter("numeroPlacaVehiculo"));
    persona.setTipoVehiculo(request.getParameter("tipoVehiculo"));
    persona.setModeloVehiculo(request.getParameter("modeloVehiculo"));
    persona.setLinea(request.getParameter("linea"));
    persona.setMarca(request.getParameter("marca"));
    persona.setColor(request.getParameter("color"));
    persona.setCilindraje(request.getParameter("cilindraje"));
    persona.setNumLicenciaTransito(request.getParameter("numLicenciaTransito"));
    persona.setFechaExpLicenciaTransito(request.getParameter("fechaExpLicenciaTransito"));
    persona.setNumLicenciaConduccion(request.getParameter("numLicenciaConduccion"));
    persona.setFechaExpConduccion(request.getParameter("fechaExpConduccion"));
    persona.setFechaVencimiento(request.getParameter("fechaVencimiento"));
    persona.setRestricciones(request.getParameter("restricciones"));
    persona.setTitularTrjPro(request.getParameter("titularTrjPro"));
    persona.setEstado(request.getParameter("estado"));
    persona.setFechaTerPriContrato(request.getParameter("fechaTerPriContrato"));
    persona.setFondoPensiones(request.getParameter("No aplica"));
    persona.setFondoCesantias(request.getParameter("No aplica"));
    persona.setFechaUltiEntrega(request.getParameter("fechaUltiEntrega"));
    persona.setFechaProEntrega(request.getParameter("fechaProEntrega"));
    persona.setProfesion(request.getParameter("profesion"));
    persona.setIdDepartamentoExpedicion(request.getParameter("idDepartamento"));
    persona.setIdMunicipioExpedicion(request.getParameter("idMunicipio"));
    persona.setIdDepartamentoNacimiento(request.getParameter("idDepartamento"));
    persona.setIdMunicipioNacimiento(request.getParameter("idMunicipio"));
    persona.setTipoDotacion(request.getParameter("No aplica"));
    persona.setTallaGuantes(request.getParameter("No aplica"));
    persona.setTallaBuzo(request.getParameter("No aplica"));
    persona.setArl(request.getParameter("arl"));

    persona.setTallaCamisa(request.getParameter("no aplica"));
    persona.setTallaChaqueta(request.getParameter("no aplica"));
    // Obtener los valores del request
    String tallaPantalonStr = request.getParameter("tallaPantalon");
    String tallaCalzadoStr = request.getParameter("tallaCalzado");

// Convertir a número si es posible, o asignar NULL si es "No Aplica" o vacío
    String tallaPantalon = (tallaPantalonStr != null && !tallaPantalonStr.equalsIgnoreCase("No Aplica") && !tallaPantalonStr.isEmpty()) ? tallaPantalonStr : "NULL";
    String tallaCalzado = (tallaCalzadoStr != null && !tallaCalzadoStr.equalsIgnoreCase("No Aplica") && !tallaCalzadoStr.isEmpty()) ? tallaCalzadoStr : "NULL";

    // Capturar valores del formulario
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

    // 🔹 Solo proceder con los hijos si la persona se guardó correctamente
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

                System.out.println("SQL Relación: " + sqlRelacion); // <-- Agregado para depurar
                ConectorBD.ejecutarQuery(sqlRelacion);
            }
        }
    }

    // Depuración: Imprimir los datos enviados
    System.out.println("Datos enviados a guardar_hijos: " + identificacionesHijos);

%>
<script type="text/javascript">
    document.location = "aprendiz.jsp";
</script>