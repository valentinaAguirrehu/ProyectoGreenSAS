<%@page import="clases.Cargo"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Retirados"%>
<%@page import="clases.Administrador"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    String lista = "";
    List<Retirados> datos = Retirados.getListaEnObjetos(null, null);
    for (Retirados retirado : datos) {
        if (retirado.getIdentificacionPersona() != null) {
            Persona persona = new Persona(retirado.getIdentificacionPersona());
            if (persona != null && persona.getIdentificacion() != null) {
                String nombreCargo = "";
                if (persona.getIdCargo() != null) {
                    Cargo cargo = new Cargo(persona.getIdCargo());
                    nombreCargo = cargo.getNombre();
                }

                lista += "<tr>";
                lista += "<td>" + persona.getIdentificacion() + "</td>";
                lista += "<td>" + persona.getNombres() + " " + persona.getApellidos() + "</td>";
                lista += "<td>" + persona.getEstablecimiento() + "</td>";
                lista += "<td>" + persona.getFechaIngreso() + "</td>";
                lista += "<td>" + persona.getFechaRetiro() + "</td>";
                lista += "<td>" + nombreCargo + "</td>";
                lista += "<td>" + retirado.getNumCaja() + "</td>";
                lista += "<td>" + retirado.getNumCarpeta() + "</td>";
                lista += "<td>" + retirado.getObservaciones() + "</td>";
                lista += "<td>";
                lista += "<img class='iconoLeer' src='presentacion/iconos/ojo.png' width='25' height='25' title='Ver detalles'>";
                lista += "<img class='iconoVer' src='presentacion/iconos/verDocumento.png' width='25' height='25' title='Ver historia laboral' onclick='verHistoriaLaboralRetirados(" + persona.getIdentificacion() + ")'>";
                lista += "<a href='retiradosFormulario.jsp?accion=Modificar&id=" + persona.getIdentificacion()
                        + "' title='Modificar' class='iconoEditar'><img src='presentacion/iconos/modificar.png' width='25' height='25'></a>";
                lista += "<img src='presentacion/iconos/eliminar.png' class='iconoEliminar' width='25' height='25' title='Eliminar' onClick='eliminar("
                        + persona.getIdentificacion() + ")'>";
                lista += "</td>";
                lista += "</tr>";

            }
        }
    }
%>

<jsp:include page="permisos.jsp" />
<%@ include file="menu.jsp" %>

<div class="content">
    <h3 class="titulo">COLABORADORES RETIRADOS</h3>
    <link rel="stylesheet" href="presentacion/style-Retirados.css">

    <div class="search-container">
        <div class="search-box">
            <select id="searchType" class="recuadro">
                <option value="identificacion">Identificación</option>
                <option value="nombre">Nombre</option>
                <option value="fechaRetiro">Fecha de retiro</option>
                <option value="caja">Número de caja</option>
                <option value="carpeta">Número de carpeta</option>
            </select>
            <input type="text" id="searchInput" onkeyup="filterResults()" placeholder="Buscar..." class="recuadro">
            <img src="presentacion/iconos/lupa.png" alt="Buscar">
        </div>
    </div>

    <table class="table" border="1" id="usuariosTable">
        <tr>
            <th>Identificación</th>
            <th>Nombre</th>
            <th>Establecimiento</th>
            <th>Fecha de ingreso</th>
            <th>Fecha de retiro</th>
            <th>Cargo</th>
            <th>Número de caja</th>
            <th>Número de carpeta</th>
            <th>Observaciones</th>
            <th>Acciones</th>
        </tr>
        <%= lista%>
    </table>
</div>

<script type="text/javascript">
    function eliminar(identificacion) {
        resultado = confirm("Realmente desea eliminar el registro con identificación " + identificacion + "?");
        if (resultado) {
            document.location = "retiradosActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }
    function verHistoriaLaboralRetirados(identificacion) {
    window.location.href = "historiaLaboralRetirado.jsp?identificacion=" + identificacion;
}


    function filterResults() {
        const searchType = document.getElementById('searchType').value;
        const input = document.getElementById('searchInput').value.toLowerCase();
        const table = document.getElementById('usuariosTable');
        const rows = table.getElementsByTagName('tr');

        let columnIndex;
        switch (searchType) {
            case "identificacion":
                columnIndex = 0;
                break;
            case "nombre":
                columnIndex = 1;
                break;
            case "caja":
                columnIndex = 6;
                break;
            case "carpeta":
                columnIndex = 7;
                break;
            case "fechaRetiro":
                columnIndex = 4;
                break;
        }

        for (let i = 1; i < rows.length; i++) {
            const cell = rows[i].getElementsByTagName('td')[columnIndex];
            if (cell) {
                const text = cell.textContent || cell.innerText;
                rows[i].style.display = text.toLowerCase().includes(input) ? "" : "none";
            }
        }
    }

    // PERMISOS

    document.addEventListener("DOMContentLoaded", function () {
        controlarPermisos(
    <%= administrador.getpEliminar()%>,
    <%= administrador.getpEditar()%>,
    <%= administrador.getpAgregar()%>,
    <%= administrador.getpLeer()%>
        );
    });

</script>
