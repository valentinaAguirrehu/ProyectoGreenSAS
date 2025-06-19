<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="clases.Cargo"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%
    request.setCharacterEncoding("UTF-8");
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

    boolean codigoYaExiste = false;

    if ("Adicionar".equals(variables.get("accion"))) {
        codigoYaExiste = Cargo.existeCodigoCargo(variables.get("codigoCargo"));
    } else if ("Modificar".equals(variables.get("accion"))) {
        codigoYaExiste = Cargo.existeCodigoCargo(variables.get("codigoCargo"), variables.get("id"));
    }

    if (codigoYaExiste) {
%>
        <script>
            alert("El código de cargo <%= variables.get("codigoCargo") %> ya está registrado. Por favor, usa uno diferente.");
            window.history.back();
        </script>
<%
    } else {
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
        <script>
            document.location = "cargos.jsp";
        </script>
<%
    }
%>
