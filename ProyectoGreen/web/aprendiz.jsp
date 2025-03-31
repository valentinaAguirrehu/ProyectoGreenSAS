<%@page import="clases.Cargo"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>

<%
    String lista = "";
    List<Persona> datos = Persona.getListaEnObjetos(null, null);

    for (Persona persona : datos) {
        if (persona.getTipo().equals("A")) { 
            String identificacion = persona.getIdentificacion();
            String nombres = persona.getNombres();
            String apellidos = persona.getApellidos();
            String cargo = Cargo.getCargoPersona(persona.getIdentificacion());
            String establecimiento = persona.getEstablecimiento();
            String fechaIngreso = persona.getFechaIngreso();

            lista += "<tr>";
            lista += "<td align='right'>" + identificacion + "</td>";
            lista += "<td>" + nombres + "</td>";
            lista += "<td>" + apellidos + "</td>";
            lista += "<td>" + cargo + "</td>";
            lista += "<td>" + establecimiento + "</td>";
            lista += "<td>" + fechaIngreso + "</td>";
            lista += "<td>";
            lista += "<a href='aprendizFormulario.jsp?accion=Modificar&identificacion=" + identificacion + "' title='Modificar'>";
            lista += "<img src='presentacion/iconos/modificar.png' alt='Modificar'/></a> ";
            lista += "<img src='presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(" + identificacion + ")' style='cursor:pointer;'/>";
            lista += "<img src='presentacion/iconos/ojo.png' title='Ver Detalles' onClick='verDetalles(" + identificacion + ")' style='cursor:pointer;'/>";
            lista += "<img src='presentacion/iconos/verDocumento.png' title='Ver Historia Laboral' onClick='verHistoriaLaboral(" + identificacion + ")' style='cursor:pointer;'/>";
            lista += "<img class='subir' src='presentacion/iconos/retirado.png' title='Pasar a retirado' onClick='verRetirados(\"" + persona.getIdentificacion() + "\")' style='cursor:pointer;'/> ";
            lista += "</td>";
            lista += "</tr>";
        }
    }
%>

<jsp:include page="permisos.jsp" />
<%@ include file="menu.jsp" %>

<div class="content">  
    <h3 class="titulo">APRENDICES</h3>
    <link rel="stylesheet" href="presentacion/style-Retirados.css">

<!-- Nuevo buscador dinámico -->
<div class="search-container">
    <div class="search-box">
        <select id="searchType" class="recuadro">
            <option value="identificacion">Identificación</option>
            <option value="nombre">Nombre</option>
            <option value="apellido">Apellidos</option>
            <option value="cargo">Cargo</option>
            <option value="establecimiento">Establecimiento</option>
            <option value="fechaIngreso">Fecha de Ingreso</option>
        </select>
        <input type="text" id="searchInput" onkeyup="filterResults()" placeholder="Buscar..." class="recuadro">
        <img src="presentacion/iconos/lupa.png" alt="Buscar">
    </div>
</div>

<table class="table" id="aprendicesTable">
    <tr>
        <th>Identificación</th>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Cargo</th>
        <th>Establecimiento</th>
        <th>Fecha de Ingreso</th>
        <th>
                <a href="aprendizFormulario.jsp?accion=Adicionar" class="subir" title="Adicionar">
                    <img src="presentacion/iconos/agregar.png" width='30' height='30'>
                </a>
            </th>
    </tr>
    <%= lista %>
</table>
</div>

<!-- Script para eliminar un aprendiz con confirmación -->
<script type="text/javascript">
    function eliminar(identificacion) {
        var respuesta = confirm("¿Realmente desea eliminar el registro del aprendiz?");
        if (respuesta) {
            window.location.href = "aprendizActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }
    function verDetalles(identificacion) {
        document.location = "aprendizDetalles.jsp?identificacion=" + identificacion;
    }
    function verHistoriaLaboral(identificacion) {
        window.location.href = "historiaLaboralAprendiz.jsp?identificacion=" + identificacion;
    }
    
    function verRetirados(identificacion) {
        window.location.href = "retiradosFormulario.jsp?identificacion=" + identificacion;
    }

    // Buscador dinámico con opción de filtro por columna
    function filterResults() {
        const searchType = document.getElementById('searchType').value;
        const input = document.getElementById('searchInput').value.toLowerCase();
        const table = document.getElementById("aprendicesTable");
        const rows = table.getElementsByTagName("tr");

        let columnIndex;
        switch (searchType) {
            case "identificacion": columnIndex = 0; break;
            case "nombre": columnIndex = 1; break;
            case "apellido": columnIndex = 2; break;
            case "cargo": columnIndex = 3; break;
            case "establecimiento": columnIndex = 4; break;
            case "fechaIngreso": columnIndex = 5; break;
        }

        for (let i = 1; i < rows.length; i++) {
            const cell = rows[i].getElementsByTagName("td")[columnIndex];
            if (cell) {
                const text = cell.textContent || cell.innerText;
                rows[i].style.display = text.toLowerCase().includes(input) ? "" : "none";
            }
        }
    }
</script>
