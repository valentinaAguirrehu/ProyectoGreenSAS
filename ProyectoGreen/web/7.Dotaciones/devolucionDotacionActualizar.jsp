<%-- 
    Document   : devolucionDotacionActualizar
    Created on : 29 abr 2025, 16:52:35
    Author     : Angie
--%>

<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="clases.DevolucionDotacion" %>
<%@ page import="clasesGenericas.ConectorBD" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String idPersona = request.getParameter("idPersona");

    if (idPersona == null || idPersona.trim().isEmpty()) {
        out.println("Error: idPersona no recibido.");
        return;
    }

    int idPersonaNum = Integer.parseInt(idPersona);

    String[] id_prenda = request.getParameterValues("id_prenda[]");
    String[] talla = request.getParameterValues("talla[]");
    String[] estado = request.getParameterValues("estado[]");
    String[] unidadNegocio = request.getParameterValues("unidad_negocio[]");
    String fechaDevolucion = request.getParameter("fechaDevolucion");
    String tipoEntrega = request.getParameter("tipoEntrega");
    String responsable = request.getParameter("responsable");
    String observacion = request.getParameter("observacion");

    int numeroDevolucion = 1;
    try {
        java.sql.ResultSet rs = ConectorBD.consultar(
                "SELECT MAX(numero_devolucion) AS max_devolucion FROM devolucionDotacion WHERE id_persona = " + idPersonaNum
        );
        if (rs.next()) {
            int maxDevolucion = rs.getInt("max_devolucion");
            if (!rs.wasNull()) {
                numeroDevolucion = maxDevolucion + 1;
            }
        }
        rs.close();
    } catch (Exception e) {
        out.println("Error al consultar el número de entrega: " + e.getMessage());
        return;
    }

    StringBuilder json = new StringBuilder("[");

    for (int i = 0; i < id_prenda.length; i++) {
        if (id_prenda[i] != null && !id_prenda[i].isEmpty()) {
            if (json.length() > 1) {
                json.append(",");
            }
            json.append("{")
                    .append("\"id_prenda\":").append(id_prenda[i]).append(",")
                    .append("\"talla\":\"").append(talla[i]).append("\",")
                    .append("\"estado\":\"Usada\",")
                    .append("\"unidad_negocio\":\"").append(unidadNegocio[i]).append("\",")
                    .append("\"id_persona\":").append(idPersonaNum).append(",")
                    .append("\"fecha_devolucion\":\"").append(fechaDevolucion).append("\",")
                    .append("\"tipo_entrega\":\"").append(tipoEntrega).append("\",")
                    .append("\"numero_devolucion\":").append(numeroDevolucion).append(",")
                    .append("\"responsable\":\"").append(responsable).append("\",")
                    .append("\"observacion\":\"").append(observacion).append("\"")
                    .append("}");
        }
    }

    json.append("]");

    DevolucionDotacion entrega = new DevolucionDotacion();
    entrega.setIdPersona(idPersona);
    entrega.setFechaDevolucion(fechaDevolucion);
    entrega.setTipoEntrega(tipoEntrega);
    entrega.setNumeroDevolucion(String.valueOf(numeroDevolucion));
    entrega.setJsonPrendas(json.toString());

    if ("Registrar".equals(request.getParameter("accion"))) {
        boolean exito = entrega.registrarDevolucionDotacion();
        if (!exito) {
            out.println("Error al registrar la devolución.");
        } else {
            response.sendRedirect("historialDotacion.jsp?identificacion=" + idPersona);
        }
    }
%>

