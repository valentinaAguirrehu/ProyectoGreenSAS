<%-- 
    Document   : usuariosActualizar
    Created on : 10 mar 2025, 14:52:02
    Author     : Angie
--%>

<%@page import="clases.Persona"%>
<%
String accion=request.getParameter("accion");
String identificacionAnterior=request.getParameter("identificacionAnterior");

Persona usuario = new Persona();

usuario.setIdentificacion(request.getParameter("identificacion"));
usuario.setNombres(request.getParameter("nombres"));
usuario.setApellidos(request.getParameter("apellidos"));
usuario.setCelular(request.getParameter("celular"));
usuario.setEmail(request.getParameter("email"));
usuario.setTipo(request.getParameter("tipo"));
usuario.setClave(request.getParameter("clave"));

switch(accion){
    case "Adicionar":
        usuario.grabar();
        break;
    case "Modificar":
        usuario.modificar(identificacionAnterior);
        break;
    case "Eliminar":
        usuario.eliminar();
        break;
}
%>

<script type="text/javascript">
    document.location="usuarios.jsp"
</script>
