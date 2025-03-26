
<%@page import="java.util.List"%>
<%@page import="clases.Municipio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idDepartamento = request.getParameter("idDepartamento");
    List<Municipio> municipios = Municipio.getListaEnObjetos("id_departamento=" + idDepartamento, "nombre ASC");

    for (Municipio municipio : municipios) {
%>
    <option value="<%= municipio.getNombre() %>"><%= municipio.getNombre() %></option>
<%
    }
%>

