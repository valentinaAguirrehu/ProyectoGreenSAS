
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="clases.Municipio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idDepartamento = request.getParameter("idDepartamento");
    String tipoLugar = request.getParameter("tipoLugar"); // 'expedicion' o 'nacimiento'

    List<Municipio> municipios = new ArrayList<>();
    
    // Determinar si es para expedición o nacimiento
    if ("expedicion".equals(tipoLugar)) {
        // Obtener los municipios del departamento de expedición
        municipios = Municipio.getListaEnObjetos("id_departamento=" + idDepartamento, "nombre ASC");
    } else if ("nacimiento".equals(tipoLugar)) {
        // Obtener los municipios del departamento de nacimiento
        municipios = Municipio.getListaEnObjetos("id_departamento=" + idDepartamento, "nombre ASC");
    }

    // Generar las opciones de municipio
    for (Municipio municipio : municipios) {
%>
    <<option value="<%= municipio.getId() %>"><%= municipio.getNombre() %></option>
<%
    }
%>