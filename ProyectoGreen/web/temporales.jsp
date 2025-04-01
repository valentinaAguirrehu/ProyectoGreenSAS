<%@page import="clases.Cargo"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Administrador"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }
    
    StringBuilder lista = new StringBuilder();
    List<Persona> datos = Persona.getListaEnObjetos(null, null);

    for (Persona persona : datos) {
        if (persona.getTipo().equals("T")) {
            lista.append("<tr>");
            lista.append("<td>").append(persona.getTipoDocumento()).append("</td>");
            lista.append("<td align='right'>").append(persona.getIdentificacion()).append("</td>");
            lista.append("<td>").append(persona.getNombres()).append("</td>");
            lista.append("<td>").append(persona.getApellidos()).append("</td>");
            lista.append("<td>").append(Cargo.getCargoPersona(persona.getIdentificacion())).append("</td>");
            lista.append("<td>").append(persona.getEstablecimiento()).append("</td>");
            lista.append("<td>").append(persona.getUnidadNegocio()).append("</td>");
            lista.append("<td>").append(persona.getFechaIngreso()).append("</td>");
            lista.append("<td>");
            lista.append("<a href='temporalesFormulario.jsp?accion=Modificar&identificacion=").append(persona.getIdentificacion()).append("' title='Modificar'>");
            lista.append("<img class='editar' src='presentacion/iconos/modificar.png' alt='Modificar'/></a> ");
            lista.append("<img class='eliminar' src='presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(").append(persona.getIdentificacion()).append(")' style='cursor:pointer;'/> ");
            lista.append("<img class='ver' src='presentacion/iconos/ojo.png' title='Ver Detalles' onClick='verDetalles(").append(persona.getIdentificacion()).append(")' style='cursor:pointer;'/> ");
            lista.append("<img class='ver' src='presentacion/iconos/verDocumento.png' title='Historia Laboral' onClick='verHistoriaLaboral(").append(persona.getIdentificacion()).append(")' style='cursor:pointer;'/> ");
            lista.append("<img class='subir' src='presentacion/iconos/retirado.png' title='Pasar a retirado' onClick='verRetirados(\"" + persona.getIdentificacion() + "\")' style='cursor:pointer;'/> ");         
            lista.append("</td>");
            lista.append("</tr>");
        }
    }
%>

<jsp:include page="permisos.jsp" />
<%@ include file="menu.jsp" %>

<div class="content">  
    <h3 class="titulo">COLABORADORES TEMPORALES</h3>
    <link rel="stylesheet" href="presentacion/style-Retirados.css">

    <!-- Buscador dinámico -->
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

    <table class="table" id="temporalesTable" border="1">
        <tr>
            <th>Tipo de documento</th>
            <th>Número de documento</th>
            <th>Nombre</th>
            <th>Apellidos</th>
            <th>Cargo</th>
            <th>Establecimiento</th>
            <th>Unidad de negocio</th>
            <th>Fecha de Ingreso</th>
            <th>
                <a href="temporalesFormulario.jsp?accion=Adicionar" class="subir" title="Adicionar">
                    <img src="presentacion/iconos/agregar.png" width='30' height='30'>
                </a>
            </th>
        </tr>
        <%= lista%>
    </table>
</div>

<script type="text/javascript">
    function eliminar(identificacion) {
        var respuesta = confirm("¿Realmente desea eliminar el registro del colaborador temporal?");
        if (respuesta) {
            window.location.href = "temporalesActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }
    function verDetalles(identificacion) {
        document.location = "temporalesDetalle.jsp?identificacion=" + identificacion;
    }
    function verHistoriaLaboral(identificacion) {
        window.location.href = "historiaLaboral.jsp?identificacion=" + identificacion;
    }
    
        function verRetirados(identificacion) {
        window.location.href = "retiradosFormulario.jsp?identificacion=" + identificacion;
    }

    function filterResults() {
        const searchType = document.getElementById('searchType').value;
        const input = document.getElementById('searchInput').value.toLowerCase();
        const table = document.getElementById("temporalesTable");
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
