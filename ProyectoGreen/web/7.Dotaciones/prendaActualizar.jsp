<%--
    Document   : prendaActualizar
    Creado     : 10 abr 2025, 14:59:21
    Autor      : Angies
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="clases.Prenda"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%
    Map<String, String> variables = new HashMap<>();
    variables.put("accion",        request.getParameter("accion"));
    variables.put("id",            request.getParameter("id"));
    variables.put("nombre",        request.getParameter("nombre"));
    variables.put("id_tipo_prenda",request.getParameter("id_tipo_prenda"));

    Prenda prenda = new Prenda();
    prenda.setIdPrenda(variables.get("id"));
    prenda.setNombre(variables.get("nombre"));
    prenda.setIdTipoPrenda(variables.get("id_tipo_prenda"));

    switch (variables.get("accion")) {
        case "Adicionar":
            prenda.grabar();
            break;
        case "Modificar":
            prenda.modificar(variables.get("id"));
            break;
        case "Eliminar":
            prenda.eliminar(variables.get("id"));
            break;
    }
%>

<script type="text/javascript">
    document.location = "prenda.jsp";
</script>
