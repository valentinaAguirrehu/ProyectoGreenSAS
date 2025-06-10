<%-- 
    Document   : devolucionDotacionActualizar
    Created on : 29 abr 2025, 16:52:35
    Author     : Angie
--%>

<%@ page import="java.util.*" %>
<%@ page import="clases.DevolucionDotacion" %>
<%@ page import="clasesGenericas.ConectorBD" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String accion = request.getParameter("accion");
    String idPersona = request.getParameter("idPersona");

    if (idPersona == null || idPersona.trim().isEmpty()) {
        out.println("Error: idPersona no recibido.");
        return;
    }

    int idPersonaNum = Integer.parseInt(idPersona);

    if ("Eliminar".equals(accion)) {
        String idDevolucion = request.getParameter("id");

        if (idDevolucion == null || idDevolucion.trim().isEmpty()) {
            out.println("Error: ID de devolución no recibido.");
            return;
        }

        DevolucionDotacion devolucionEliminar = new DevolucionDotacion();
        devolucionEliminar.setIdDevolucion(idDevolucion);

        boolean eliminado = devolucionEliminar.eliminarDevolucionDotacion();
        if (!eliminado) {
            out.println("Error al eliminar la devolución.");
        } else {
            response.sendRedirect("historialDotacion.jsp?identificacion=" + idPersona);
        }
        return;
    }

    // Datos comunes para Registrar y Modificar
    String[] id_prenda = request.getParameterValues("id_prenda[]");
    String[] talla = request.getParameterValues("talla[]");
    String[] estado = request.getParameterValues("estado[]");
    String[] unidadNegocio = request.getParameterValues("unidad_negocio[]");
    String fechaDevolucion = request.getParameter("fechaDevolucion");
    String tipoEntrega = request.getParameter("tipoEntrega");
    String responsable = request.getParameter("responsable");
    String observacion = request.getParameter("observacion");

    int numeroDevolucion = 1;
    if (!"Modificar".equals(accion)) {
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
            out.println("Error al consultar el número de devolución: " + e.getMessage());
            return;
        }
    } else {
        // Si es Modificar, usar el número recibido
        String numero = request.getParameter("numeroDevolucion");
        if (numero != null && !numero.trim().isEmpty()) {
            numeroDevolucion = Integer.parseInt(numero);
        }
    }

    StringBuilder json = new StringBuilder("[");
    for (int i = 0; i < id_prenda.length; i++) {
        if (id_prenda[i] != null && !id_prenda[i].isEmpty()) {
            if (json.length() > 1) json.append(",");
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

    // Objeto común
    DevolucionDotacion devolucion = new DevolucionDotacion();
    devolucion.setIdPersona(idPersona);
    devolucion.setFechaDevolucion(fechaDevolucion);
    devolucion.setTipoEntrega(tipoEntrega);
    devolucion.setNumeroDevolucion(String.valueOf(numeroDevolucion));
    devolucion.setJsonPrendas(json.toString());
    devolucion.setResponsable(responsable);
    devolucion.setObservacion(observacion);

    if ("Registrar".equals(accion)) {
        boolean exito = devolucion.registrarDevolucionDotacion();
        if (!exito) {
            out.println("Error al registrar la devolución.");
        } else {
            response.sendRedirect("historialDotacion.jsp?identificacion=" + idPersona);
        }
    } else if ("Modificar".equals(accion)) {
        devolucion.setIdDevolucion(request.getParameter("id")); 
        boolean modificado = devolucion.modificarDevolucionDotacion();
        if (!modificado) {
            out.println("Error al modificar la devolución.");
        } else {
            response.sendRedirect("historialDotacion.jsp?identificacion=" + idPersona);
        }
    }
%>