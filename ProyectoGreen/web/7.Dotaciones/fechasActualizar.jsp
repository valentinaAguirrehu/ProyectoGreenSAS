<%-- 
    Document   : fechasActualizar
    Created on : 14 abr 2025, 17:28:20
    Author     : Angie
--%>

<%@page import="clases.FechaProxEntregaDotacion"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Map<String, String> variables = new HashMap<>();
    variables.put("accion", request.getParameter("accion"));
    variables.put("fechaAdmin", request.getParameter("fechaAdmin"));
    variables.put("fechaOperativo", request.getParameter("fechaOperativo"));

    variables.put("id", request.getParameter("id"));
    FechaProxEntregaDotacion fechas = new FechaProxEntregaDotacion();
    fechas.setId(variables.get("id"));
    fechas.setFecha_admin(variables.get("fechaAdmin"));
    fechas.setFecha_operativo(variables.get("fechaOperativo"));

    if ("Modificar".equals(variables.get("accion"))) {
        fechas.modificar(variables.get("id"));
    }
%>
<script type="text/javascript">
    document.location = "inventarioDotacion.jsp";
</script>


