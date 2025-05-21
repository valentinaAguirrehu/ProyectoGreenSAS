<%-- 
    Document   : vehiculoActualizar
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="clases.InformacionLaboral"%>
<%@page import="clases.Vehiculo"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
    // Capturar acción y valores del formulario
    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");

    InformacionLaboral informacionLaboral = (InformacionLaboral) request.getAttribute("informacionLaboral");
    request.setAttribute("informacionLaboral", informacionLaboral);

    // Crear objeto persona y asignar valores del formulario
    Vehiculo vehiculo = new Vehiculo();
    vehiculo.setIdentificacion(request.getParameter("identificacion"));
//    persona.setTipo("C");
    
    vehiculo.setTieneVehiculo(request.getParameter("tieneVehiculo"));
    vehiculo.setNumeroPlacaVehiculo(request.getParameter("numeroPlacaVehiculo"));
    vehiculo.setTipoVehiculo(request.getParameter("tipoVehiculo"));
    vehiculo.setModeloVehiculo(request.getParameter("modeloVehiculo"));
    vehiculo.setLinea(request.getParameter("linea"));
    vehiculo.setMarca(request.getParameter("marca"));
    vehiculo.setColor(request.getParameter("color"));
    vehiculo.setCilindraje(request.getParameter("cilindraje"));
    vehiculo.setNumLicenciaTransito(request.getParameter("numLicenciaTransito"));
    vehiculo.setFechaExpLicenciaTransito(request.getParameter("fechaExpLicenciaTransito"));
    vehiculo.setNumLicenciaConduccion(request.getParameter("numLicenciaConduccion"));
    vehiculo.setFechaExpConduccion(request.getParameter("fechaExpConduccion"));
    vehiculo.setFechaVencimiento(request.getParameter("fechaVencimiento"));
    vehiculo.setRestricciones(request.getParameter("restricciones"));
    vehiculo.setTitularTrjPro(request.getParameter("titularTrjPro"));
    vehiculo.setEstado(request.getParameter("estado"));
    
   
    // Acción según el botón presionado
    switch (accion) {
        case "Adicionar":
            // Verificar si la identificación ya existe en la base de datos
            if (Vehiculo.getVehiculoPorIdentificacion(vehiculo.getIdentificacion()) == null) {
                vehiculo.grabar(); // Llama al método de grabar si es una persona nueva
            } else {
                // Si ya existe, muestra un mensaje de error o realiza alguna acción (opcional)
                out.println("<p>Error: La identificación ya existe en la base de datos.</p>");
            }
            break;

        case "Modificar":
            // Si la persona ya existe, proceder con la modificación
            vehiculo.modificar(identificacionAnterior); // Llama al método de modificar
            break;

        case "Eliminar":
            // Llama al método de eliminar
            vehiculo.eliminar();
            break;
    }

// Solo redirigir automáticamente si la persona se guardó correctamente y si la acción fue "Adicionar"
if ("Adicionar".equals(accion)) {
    // Suponiendo que la persona ha sido correctamente guardada, redirigir
    String identificacionParaRedirigir = vehiculo.getIdentificacion();
    response.sendRedirect("infLaboralFormulario.jsp?identificacion=" + identificacionParaRedirigir);
    return; // Detiene el JSP después de redirigir
}
%>


<script type="text/javascript">
    document.location = "persona.jsp";
</script>