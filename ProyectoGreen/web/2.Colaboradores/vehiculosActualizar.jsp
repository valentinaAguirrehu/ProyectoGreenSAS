<%-- 
    Document   : persona
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="clases.Vehiculo"%>
<link rel="stylesheet" type="text/css" href="presentacion/estiloTablas.css">

<%
    String accion = request.getParameter("accion");
    String numeroPlacaAnterior = request.getParameter("numeroPlacaAnterior");

    if (!"Eliminar".equals(accion)) {
        Vehiculo vehiculos = new Vehiculo();
        vehiculos.setNumeroPlaca(request.getParameter("numeroPlaca"));
        vehiculos.setTipoVehiculo(request.getParameter("tipoVehiculo"));
        vehiculos.setModeloVehiculo(request.getParameter("modeloVehiculo"));
        vehiculos.setLinea(request.getParameter("linea"));
        vehiculos.setAno(request.getParameter("ano"));
        vehiculos.setColor(request.getParameter("color"));
        vehiculos.setCilindraje(request.getParameter("cilindraje"));
        vehiculos.setNumLicenciaTransito(request.getParameter("numLicenciaTransito"));
        vehiculos.setFechaExpLicenciaTransito(request.getParameter("fechaExpLicenciaTransito"));

        switch (accion) {
            case "Adicionar":
                vehiculos.grabar();
                break;
            case "Modificar":
                vehiculos.modificar(numeroPlacaAnterior);
                break;
        }
    } else {
        String numeroPlaca = request.getParameter("numeroPlaca");
        Vehiculo.eliminarPorPlaca(numeroPlaca); // Usa el método correcto para eliminar
    }
%>

<script type="text/javascript">
    document.location="principal.jsp?CONTENIDO=vehiculos.jsp";
</script>
