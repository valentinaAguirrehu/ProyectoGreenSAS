<%-- 
    Document   : usuarios
    Created on : 10 mar 2025, 14:51:43
    Author     : Angie
--%>

<%@page import="java.util.List"%>
<%@page import="clases.Administrador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String lista = "";
    List<Administrador> datos = Administrador.getListaEnObjetos("tipo<>'S'", null);
    for (int i = 0; i < datos.size(); i++) {
        Administrador usuario = datos.get(i);
        lista += "<tr>";
        lista += "<td>" + usuario.getIdentificacion() + "</td>";
        lista += "<td>" + usuario.getNombres() + "</td>";
        lista += "<td>" + usuario.getCelular() + "</td>";
        lista += "<td>" + usuario.getEmail() + "</td>";
        lista += "<td>";
        lista += "<a href='usuariosFormulario.jsp?accion=Modificar&id=" + usuario.getIdentificacion()
                + "' title='Modificar'><img src='presentacion/iconos/modificar.png' width='25' height='25'></a> ";
        lista += "<img src='presentacion/iconos/eliminar.png' width='25' height='25' title='Eliminar' onClick='eliminar(" + usuario.getIdentificacion() + ")'> ";
        lista += "</td>";
        lista += "</tr>";
    }
%>

<h3 class="titulo">GESTIÓN DE USUARIOS</h3>
<link rel="stylesheet" href="presentacion/style-Proyecto.css">
<table class="table" border="1">
    <tr>
        <th>Identificación</th><th>Nombres</th><th>Apellidos</th><th>Celular</th><th>Email</th>
        <th><a href="usuariosFormulario.jsp?accion=Adicionar" title="Adicionar">
                <img src="presentacion/iconos/agregar.png" width='30' height='30'> </a></th>
    </tr>
    <%=lista%>
</table>

<script type="text/javascript">
    function eliminar(identificacion) {
        resultado = confirm("Realmente desea eliminar el usuario con identificacion" + identificacion + "?");
        if (resultado) {
            document.location = "usuariosActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }
</script>