<%--
    Document   : CargosAct
    Creado     : 8 mar 2025, 18:49:10
    Autor      : Angie
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="clases.Cargo"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%
    Map<String, String> variables = new HashMap<>();
    variables.put("accion",        request.getParameter("accion"));
    variables.put("id",            request.getParameter("id"));
    variables.put("nombre",        request.getParameter("nombre"));
    variables.put("codigoCargo",   request.getParameter("codigoCargo"));
    variables.put("descripcion",   request.getParameter("descripcion"));

    Cargo cargo = new Cargo();
    cargo.setId(variables.get("id"));
    cargo.setNombre(variables.get("nombre"));
    cargo.setCodigoCargo(variables.get("codigoCargo"));
    cargo.setDescripcion(variables.get("descripcion"));

    switch (variables.get("accion")) {
        case "Adicionar":
            cargo.grabar();
            break;
        case "Modificar":
            cargo.modificar(variables.get("id"));
            break;
        case "Eliminar":
            cargo.eliminar(variables.get("id"));
            break;
    }
%>

<script type="text/javascript">
    document.location = "cargos.jsp";
</script>
