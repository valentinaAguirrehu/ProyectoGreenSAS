<%@page import="clases.DetalleEntrega"%>
<%@ page import="java.util.*" %>
<%@ page import="clases.EntregaDotacion" %>
<%@ page import="clasesGenericas.ConectorBD" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");

    String accion = request.getParameter("accion");
    String metodo = request.getMethod();
    String idPersona = request.getParameter("idPersona");

    if (idPersona == null || idPersona.trim().isEmpty()) {
        out.println("Error: idPersona no recibido.");
        return;
    }

    int idPersonaNum = Integer.parseInt(idPersona);

    // ACCIÓN: ELIMINAR
    if ("Eliminar".equals(accion)) {
        String idEntrega = request.getParameter("id");
        if (idEntrega == null || idEntrega.trim().isEmpty()) {
            out.println("Error: id de entrega no recibido.");
            return;
        }

        EntregaDotacion entregaEliminar = new EntregaDotacion();
        entregaEliminar.setIdEntrega(idEntrega);

        if (entregaEliminar.eliminarEntregaDotacion()) {
            response.sendRedirect("historialDotacion.jsp?identificacion=" + idPersona);
        } else {
            out.println("Error al eliminar la entrega.");
        }
        return;
    }

    // ACCIÓN: REGISTRAR o MODIFICAR
    if (("Registrar".equals(accion) || "Modificar".equals(accion)) && "POST".equalsIgnoreCase(metodo)) {
        String[] id_prenda = request.getParameterValues("id_prenda[]");
        String[] talla = request.getParameterValues("talla[]");
        String estado = request.getParameter("estado");
        String unidadNegocio = request.getParameter("unidad_negocio");
        String fechaEntrega = request.getParameter("fechaEntrega");
        String tipoEntrega = request.getParameter("tipoEntrega");
        String responsable = request.getParameter("responsable");
        String observacion = request.getParameter("observacion");

        String idEntrega = request.getParameter("id");
        String numeroEntregaStr = request.getParameter("numeroEntrega");

        int numeroEntrega = 1;

        if ("Modificar".equals(accion)) {
            try {
                numeroEntrega = Integer.parseInt(numeroEntregaStr);
            } catch (Exception e) {
                out.println("Error al obtener número de entrega para modificación.");
                return;
            }
        } else {
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
        }

        StringBuilder json = new StringBuilder("[");
        if (id_prenda != null && talla != null) {
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
                            .append("\"unidad_negocio\":\"").append(unidadNegocio).append("\"")
                            .append("}");
                }
            }
        }
        json.append("]");

        // Crear objeto y asignar datos
        EntregaDotacion entrega = new EntregaDotacion();
        entrega.setIdPersona(idPersona);
        entrega.setFechaEntrega(fechaEntrega);
        entrega.setTipoEntrega(tipoEntrega);
        entrega.setNumeroEntrega(String.valueOf(numeroEntrega));
        entrega.setResponsable(responsable);
        entrega.setObservacion(observacion);
        entrega.setJsonPrendas(json.toString());

        boolean exito = false;

        if ("Registrar".equals(accion)) {
            exito = entrega.registrarEntregaDotacion();
        } else if ("Modificar".equals(accion)) {
            entrega.setIdEntrega(idEntrega);
            exito = entrega.modificarEntregaDotacion();
        }

        if (exito) {
            response.sendRedirect("historialDotacion.jsp?identificacion=" + idPersona);
        } else {
            out.println("Error al procesar la entrega (" + accion + ").");
        }
    }
%>
