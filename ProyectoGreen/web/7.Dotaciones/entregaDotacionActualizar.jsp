<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="clases.EntregaDotacion" %>
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
    String estado = request.getParameter("estado");
    String unidadNegocio = request.getParameter("unidad_negocio");
    String fechaEntrega = request.getParameter("fechaEntrega");
    String tipoEntrega = request.getParameter("tipoEntrega");

    int numeroEntrega = 1;
    try {
        java.sql.ResultSet rs = ConectorBD.consultar(
                "SELECT MAX(numero_entrega) AS max_entrega FROM entregaDotacion WHERE id_persona = " + idPersonaNum
        );
        if (rs.next()) {
            int maxEntrega = rs.getInt("max_entrega");
            if (!rs.wasNull()) {
                numeroEntrega = maxEntrega + 1;
            }
        }
        rs.close();
    } catch (Exception e) {
        out.println("Error al consultar el número de entrega: " + e.getMessage());
        return;
    }

    StringBuilder json = new StringBuilder("[");

    int longitudMinima = Math.min(id_prenda.length, talla.length);

    for (int i = 0; i < longitudMinima; i++) {
        if (id_prenda[i] != null && !id_prenda[i].isEmpty()) {
            if (json.length() > 1) {
                json.append(",");
            }
            json.append("{")
                    .append("\"id_prenda\":").append(id_prenda[i]).append(",")
                    .append("\"talla\":\"").append(talla[i]).append("\",")
                    .append("\"estado\":\"").append(estado).append("\",")
                    .append("\"unidad_negocio\":\"").append(unidadNegocio).append("\",")
                    .append("\"id_persona\":").append(idPersonaNum).append(",")
                    .append("\"fecha_entrega\":\"").append(fechaEntrega).append("\",")
                    .append("\"tipo_entrega\":\"").append(tipoEntrega).append("\",")
                    .append("\"numero_entrega\":").append(numeroEntrega)
                    .append("}");
        }
    }

    json.append("]");

    EntregaDotacion entrega = new EntregaDotacion();
    entrega.setIdPersona(idPersona);
    entrega.setFechaEntrega(fechaEntrega);
    entrega.setTipoEntrega(tipoEntrega);
    entrega.setNumeroEntrega(String.valueOf(numeroEntrega));
    entrega.setJsonPrendas(json.toString());

    if ("Registrar".equals(request.getParameter("accion"))) {
        boolean exito = entrega.registrarEntregaDotacion();
        if (!exito) {
            out.println("Error al registrar la entrega.");
        } else {
            response.sendRedirect("historialDotacion.jsp?identificacion=" + idPersona);
        }
    }
%>
