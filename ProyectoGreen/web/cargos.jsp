<%-- 
    Document   : cargos
    Created on : 8 mar 2025, 17:52:29
    Author     : Angie
--%>

<%@page import="clases.Cargo"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.Administrador"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    String lista = "";
    ResultSet datos = null;
    try {
        datos = Cargo.getLista("", null);
        if (datos != null) {
            while (datos.next()) {
                Cargo cargo = new Cargo(datos.getString("id"));

                lista += "<tr>";
                lista += "<td align='right'>" + cargo.getId() + "</td>";
                lista += "<td>" + cargo.getNombre() + "</td>";
                lista += "<td>" + cargo.getCodigoCargo() + "</td>";
                lista += "<td>" + cargo.getDescripcion() + "</td>";
                lista += "<td class='acciones'>"; // Agregamos la clase para estilos en línea
                lista += "<a class='editar' href='cargosFormulario.jsp?accion=Modificar&id=" + cargo.getId()
                        + "' title='Modificar'><img src='presentacion/iconos/modificar.png' width='25' height='25'></a> ";
                lista += "<img src='presentacion/iconos/eliminar.png' class='eliminar' width='25' height='25' title='Eliminar' onclick='eliminar(\"" + cargo.getId() + "\")'>";
                lista += "</td>";

                lista += "</tr>";
            }
        } else {
            lista = "<tr><td colspan='5'>No se encontraron registros</td></tr>";
        }
    } catch (Exception ex) {
        lista = "<tr><td colspan='5'>Error al procesar los datos: " + ex.getMessage() + "</td></tr>";
        ex.printStackTrace();
    } finally {
        if (datos != null) {
            try {
                datos.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
%>

<jsp:include page="permisos.jsp" />
<%@ include file="menu.jsp" %>

<head>
    <link rel="stylesheet" href="presentacion/style-Cargos.css">
</head>
<body>
    <div class="content">
        <h3 class="titulo">GESTIÓN DE CARGOS</h3>

        <div class="search-container">
            <div class="search-box">
                <input type="text" id="searchInput" onkeyup="filterNames()" placeholder="Buscar por cargo o código" class="recuadro">
                <img src="presentacion/iconos/lupa.png" alt="Buscar">
            </div>
        </div>
        <table class="table" border="1" id="cargosTable">
            <tr>
                <th>Número</th>
                <th>Cargo</th>
                <th>Código del Cargo</th>
                <th>Descripción</th>
                <th>
                    <a href="cargosFormulario.jsp?accion=Adicionar" class="subir" title="Adicionar">
                        <img src="presentacion/iconos/agregar.png" width='30' height='30'>
                    </a>
                </th>
            </tr>
            <%=lista%>
        </table>
    </div>
</body>

<script>

function eliminar(id) {
    var respuesta = confirm("¿Realmente desea eliminar el cargo?");
    if (respuesta) {
      document.location = "cargosActualizar.jsp?accion=Eliminar&id=" + id;
    }
}

function filterNames() {
    const input = document.getElementById('searchInput');
    const filter = input.value.toLowerCase();
    const table = document.getElementById('cargosTable');
    const rows = table.getElementsByTagName('tr');

    for (let i = 1; i < rows.length; i++) {
        const cells = rows[i].getElementsByTagName('td');
                if (cells.length > 0) {
                    const cargo = cells[1].textContent || cells[1].innerText;
                    const codigo = cells[2].textContent || cells[2].innerText;

                    if (cargo.toLowerCase().indexOf(filter) > -1 || codigo.toLowerCase().indexOf(filter) > -1) {
                                    rows[i].style.display = "";
                    } else {
                                    rows[i].style.display = "none";
                }
            }
        }
    }

// PERMISOS

    document.addEventListener("DOMContentLoaded", function () {
    controlarPermisos(
    <%= administrador.getpEliminar()%>,
    <%= administrador.getpEditar()%>,
    <%= administrador.getpAgregar()%>
    );
});

</script>