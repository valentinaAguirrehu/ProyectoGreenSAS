<%-- 
    Document   : inventarioActualizarUsada
    Created on : 23 abr 2025, 15:22:43
    Author     : Angie
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.Enumeration"%>
<%@ page import="clases.InventarioDotacion" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String[] id_prenda = request.getParameterValues("id_prenda[]");
    String[] talla = request.getParameterValues("talla[]");
    String[] cantidad = request.getParameterValues("cantidad[]");
    String[] estado = request.getParameterValues("estado[]");
    String fechaIngreso = request.getParameter("fecha_ingreso");
    String unidadNegocio = request.getParameter("unidad_negocio");

    StringBuilder json = new StringBuilder("[");
    for (int i = 0; i < id_prenda.length; i++) {
        if (id_prenda[i] != null && !id_prenda[i].isEmpty()) {
            if (json.length() > 1) {
                json.append(",");
            }
            json.append("{")
                    .append("\"id_prenda\":").append(id_prenda[i]).append(",")
                    .append("\"talla\":\"").append(talla[i]).append("\",")
                    .append("\"cantidad\":").append(cantidad[i]).append(",")
                    .append("\"estado\":\"").append(estado[i]).append("\",")
                    .append("\"unidad_negocio\":\"").append(unidadNegocio).append("\",")
                    .append("\"fecha_ingreso\":\"").append(fechaIngreso).append("\"")
                    .append("}");
        }
    }
    json.append("]");

    InventarioDotacion inv = new InventarioDotacion();
    inv.setJsonPrendas(json.toString());

    if ("Actualizar".equals(request.getParameter("accion"))) {
        boolean exito = inv.agregarPrendasMultiples();
        if (!exito) {
            out.println("Error al insertar.");
        }
    }
%>

<script type="text/javascript">
    document.location = "inventarioDotacionUsada.jsp";
</script>
