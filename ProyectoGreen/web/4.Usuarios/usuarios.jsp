<%@page import="clases.Administrador"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String lista = "";
    List<Administrador> datos = Administrador.getListaEnObjetos("tipo<>'S'", null);

    for (Administrador usuario : datos) {
        boolean tieneTodos = usuario.getpLeer().equals("S")
                && usuario.getpEditar().equals("S")
                && usuario.getpAgregar().equals("S")
                && usuario.getpEliminar().equals("S")
                && usuario.getpDescargar().equals("S");

        String permisos = "";
        if (tieneTodos) {
            permisos = "Acceso completo";
        } else {
            if (usuario.getpLeer().equals("S")) {
                permisos += "Lectura - ";
            }
            if (usuario.getpEditar().equals("S")) {
                permisos += "Edición - ";
            }
            if (usuario.getpAgregar().equals("S")) {
                permisos += "Agregar - ";
            }
            if (usuario.getpEliminar().equals("S")) {
                permisos += "Eliminar - ";
            }
            if (usuario.getpDescargar().equals("S")) {
                permisos += "Ver y descargar - ";
            }

            if (!permisos.isEmpty()) {
                permisos = permisos.substring(0, permisos.length() - 3);
            }
        }

        lista += "<tr>";
        lista += "<td>" + usuario.getIdentificacion() + "</td>";
        lista += "<td>" + usuario.getNombres() + "</td>";
        lista += "<td>" + usuario.getCelular() + "</td>";
        lista += "<td>" + usuario.getEmail() + "</td>";
        lista += "<td>" + permisos + "</td>";
        lista += "<td>" + usuario.getEstado() + "</td>";
        lista += "<td>";

// Botón Modificar
        lista += "<a href='usuariosFormulario.jsp?accion=Modificar&identificacion=" + usuario.getIdentificacion()
                + "' title='Modificar'><img src='../presentacion/iconos/modificar.png' width='25' height='25'></a> ";

// Botón Eliminar
        lista += "<img src='../presentacion/iconos/eliminar.png' width='25' height='25' title='Eliminar' "
                + "onClick='eliminar(\"" + usuario.getIdentificacion() + "\")'> ";

// Botón Cerrar Sesión
        lista += "<form method='post' action='" + request.getContextPath() + "/admin/logoutUser' "
                + "style='display:inline; margin-left:5px;' "
                + "onsubmit='return confirmarCierre(\"" + usuario.getNombres() + "\")'>"
                + "<input type='hidden' name='idUsuario' value='" + usuario.getIdentificacion() + "'/>"
                + "<button type='submit' title='Cerrar sesión' style='background:none; border:none; cursor:pointer;'>"
                + "<img src='../presentacion/iconos/logout.png' width='25' height='25' alt='Cerrar sesión'/>"
                + "</button>"
                + "</form>";

        lista += "</td>";

        lista += "</tr>";
    }
%>

<%@ include file="../menu.jsp" %>

<div class="content">

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">

        <div style="
             background-color: #f0f8ff;
             border: 2px solid #3498db;
             border-radius: 8px;
             padding: 10px 15px;
             font-size: 14px;
             font-weight: bold;
             color: #2c3e50;
             box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
             display: inline-block;
             ">
            <div style="display: flex; align-items: center; margin-bottom: 5px;">
                <span style="margin-right: 5px;">📩</span> Correo electrónico: softwaregestionhumana@gmail.com
            </div>
            <div style="display: flex; align-items: center;">
                <span style="margin-right: 5px;">🔑</span> Contraseña: Softwarearchivogh2025
            </div>
        </div>

        <h3 class="titulo">
            GESTIÓN DE USUARIOS
        </h3>

        <div style="width: 350px;"></div>
    </div>

    <link rel="stylesheet" href="../presentacion/style-Usuarios.css">
    <div class="search-container">
        <div class="search-box">
            <input type="text" id="searchInput" onkeyup="filterNames()" placeholder="Buscar por nombre o identificación " class="recuadro">
            <img src="../presentacion/iconos/lupa.png" alt="Buscar">
        </div>
    </div>

    <table class="table" border="1" id="usuariosTable">
        <tr>
            <th>Identificación</th>
            <th>Nombre</th>
            <th>Celular</th>
            <th>Correo electrónico</th>
            <th>Permisos</th>
            <th>Estado</th>
            <th><a href="usuariosFormulario.jsp?accion=Adicionar" title="Adicionar">
                    <img src="../presentacion/iconos/agregar.png" width='30' height='30'> </a></th>
        </tr>
        <%=lista%>
    </table>
</div>

<script type="text/javascript">
    function eliminar(identificacion) {
        resultado = confirm("Realmente desea eliminar el usuario con identificación " + identificacion + "?");
        if (resultado) {
            document.location = "usuariosActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }

    function filterNames() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toLowerCase();
        const table = document.getElementById('usuariosTable');
        const rows = table.getElementsByTagName('tr');

        for (let i = 1; i < rows.length; i++) {
            const cells = rows[i].getElementsByTagName('td');
            if (cells.length > 0) {
                const identificacion = cells[0].textContent || cells[0].innerText;
                const nombres = cells[1].textContent || cells[1].innerText;

                if (
                        identificacion.toLowerCase().indexOf(filter) > -1 ||
                        nombres.toLowerCase().indexOf(filter) > -1
                        ) {
                    rows[i].style.display = "";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }
    }

    function confirmarCierre(nombreUsuario) {
        return confirm("¿Está seguro que desea cerrar la sesión de " + nombreUsuario + "?");
    }

</script>

