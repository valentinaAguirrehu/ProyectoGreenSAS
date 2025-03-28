<%@page import="clases.Cargo"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<link rel="stylesheet" href="presentacion/style-colaboradores.css">

<%
    String lista = "";
    List<Persona> datos = Persona.getListaEnObjetos(null, null);

    for (Persona persona : datos) {
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
            lista += "<a href='personaFormulario.jsp?accion=Modificar&identificacion=" + identificacion + "' title='Modificar'>";
            lista += "<img src='presentacion/iconos/modificar.png' alt='Modificar'/></a> ";
            lista += "<img src='presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(" + identificacion + ")' style='cursor:pointer;'/>";
            lista += "<img src='presentacion/iconos/ojo.png' title='Ver Detalles' onClick='verDetalles(" + identificacion + ")'> ";
             lista += "<img src='presentacion/iconos/verDocumento.png' title='Historia Laboral' onClick='verHistoriaLaboral(" + persona.getIdentificacion() + ")' style='cursor:pointer;'/> ";
            lista += "</td>";
            lista += "</tr>";
        }
    
%>


<h3>Lista de Colaboradores</h3>

<!-- Nuevo buscador din�mico -->
<div class="search-container">
    <div class="search-box">
        <select id="searchType" class="recuadro">
            <option value="identificacion">Identificaci�n</option>
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

<table class="table" id="colaboradoresTable">
    <tr>
        <th>Identificación</th>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Cargo</th>
        <th>Establecimiento</th>
        <th>Fecha de Ingreso</th>
        <th>Acciones</th>
    </tr>
    <%= lista%> 
</table>

<!-- Botón para agregar un nuevo colaborador -->
<div class="add-button" style="margin-top: 10px;">
    <a href="personaFormulario.jsp?accion=Adicionar" title="Agregar">
        <img src="presentacion/iconos/agregar.png" alt="Agregar" style="width: 20px; vertical-align: middle;"> Agregar Colaboradores
    </a>
</div>

<!-- Script para eliminar una persona con confirmación -->
<script type="text/javascript">
    function eliminar(identificacion) {
        var respuesta = confirm("¿Realmente desea eliminar el registro del colaborador?");
        if (respuesta) {
            window.location.href = "personaActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }
    function verDetalles(identificacion) {
        document.location = "personaDetalles.jsp?identificacion=" + identificacion;
    }
    function verHistoriaLaboral(identificacion) {
        window.location.href = "historiaLaboralGreen.jsp?identificacion=" + identificacion;
    }

    // Buscador din�mico con opci�n de filtro por columna
    function filterResults() {
        const searchType = document.getElementById('searchType').value;
        const input = document.getElementById('searchInput').value.toLowerCase();
        const table = document.getElementById("colaboradoresTable");
        const rows = table.getElementsByTagName("tr");

        let columnIndex;
        switch (searchType) {
            case "identificacion":
                columnIndex = 0;
                break;
            case "nombre":
                columnIndex = 1;
                break;
            case "apellido":
                columnIndex = 2;
                break;
            case "cargo":
                columnIndex = 3;
                break;
            case "establecimiento":
                columnIndex = 4;
                break;
            case "fechaIngreso":
                columnIndex = 5;
                break;
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

<!-- Botón de cancelar para regresar a la página anterior -->
<input type="button" value="Cancelar" onClick="window.history.back()">
