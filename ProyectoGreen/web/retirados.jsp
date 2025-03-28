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
                lista += "<td>" + persona.getTipoDocumento() + "</td>";
                lista += "<td>" + persona.getIdentificacion() + "</td>";
                lista += "<td>" + persona.getNombres() + " " + persona.getApellidos() + "</td>";
                lista += "<td>" + persona.getEstablecimiento() + "</td>";
                lista += "<td>" + nombreCargo + "</td>";
                lista += "<td>" + persona.getFechaIngreso() + "</td>";
                lista += "<td>" + persona.getFechaRetiro() + "</td>";
                lista += "<td>" + retirado.getNumCaja() + "</td>";
                lista += "<td>" + retirado.getNumCarpeta() + "</td>";
                lista += "<td>" + persona.getUnidadNegocio() + "</td>";
                lista += "<td>" + retirado.getObservaciones() + "</td>";
                lista += "<td>";
                lista += "<img class='ver' src='presentacion/iconos/ojo.png' width='25' height='25' title='Ver detalles'>";
                lista += "<img src='presentacion/iconos/verDocumento.png' width='25' height='25' title='Ver historia laboral' onclick='verHistoriaLaboralRetirados(" + persona.getIdentificacion() + ")'>";
                lista += "<a href='retiradosFormulario.jsp?accion=Modificar&id=" + persona.getIdentificacion()
                        + "' title='Modificar' class='editar'><img src='presentacion/iconos/modificar.png' width='25' height='25'></a>";
                lista += "<img src='presentacion/iconos/eliminar.png' class='eliminar' width='25' height='25' title='Eliminar' onClick='eliminar("
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
                <option value="cargo">Cargo</option>
                <option value="unidadNegocio">Unidad de negocio</option>
                <option value="establecimiento">Establecimiento</option>                 
                <option value="caja">Número de caja</option>
                <option value="carpeta">Número de carpeta</option>
                <option value="fechaRetiro">Fecha de retiro</option>
            </select>
            <input type="text" id="searchInput" onkeyup="filterResults()" placeholder="Buscar..." class="recuadro">
            <img src="presentacion/iconos/lupa.png" alt="Buscar">
        </div>
    </div>

    <table class="table" border="1" id="usuariosTable">
        <tr>
            <th>Tipo del documento</th>
            <th>Documento</th>
            <th>Nombre</th>
            <th>Establecimiento</th>
            <th>Cargo</th>
            <th>Fecha de ingreso</th>
            <th>Fecha de retiro</th>
            <th>Número de caja</th>
            <th>Número de carpeta</th>          
            <th>Unidad de negocio</th>
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
                columnIndex = 1;
                break;
            case "nombre":
                columnIndex = 2;
                break;
            case "establecimiento":
                columnIndex = 3;
                break;
            case "cargo":
                columnIndex = 4;
                break;
            case "fechaRetiro":
                columnIndex = 6;
                break;
            case "caja":
                columnIndex = 7;
                break;
            case "carpeta":
                columnIndex = 8;
                break;
            case "unidadNegocio":
                columnIndex = 9;
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
