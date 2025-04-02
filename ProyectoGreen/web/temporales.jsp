<%@page import="clases.Cargo"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Administrador"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    String lista = "";
    // Filtramos solo los temporales (tipo = 'T')
    List<Persona> datos = Persona.getListaEnObjetos("tipo = 'T'", null);

    for (Persona persona : datos) {
        String tipoDocumento = persona.getTipoDocumento();
        String identificacion = persona.getIdentificacion();
        String nombres = persona.getNombres();
        String apellidos = persona.getApellidos();
        String cargo = Cargo.getCargoPersona(persona.getIdentificacion());
        String establecimiento = persona.getEstablecimiento();
        String cctn = persona.getCctn();
        String fechaIngreso = persona.getFechaIngreso();

        lista += "<tr>";
        lista += "<td>" + tipoDocumento + "</td>";
        lista += "<td align='right'>" + identificacion + "</td>";
        lista += "<td>" + nombres + "</td>";
        lista += "<td>" + apellidos + "</td>";
        lista += "<td>" + cargo + "</td>";
        lista += "<td>" + establecimiento + "</td>";
        lista += "<td>" + cctn + "</td>";
        lista += "<td>" + fechaIngreso + "</td>";
        lista += "<td>";
        lista += "<img src='presentacion/iconos/verDocumento.png' width='25' height='25' title='Ver historia laboral' onclick='verHistoriaLaboral(" + persona.getIdentificacion() + ")'>";
        lista += "<a href='temporalesFormulario.jsp?accion=Modificar&identificacion=" + identificacion + "' title='Modificar'>";
        lista += "<img class='editar' src='presentacion/iconos/modificar.png' alt='Modificar'/></a> ";
        lista += "<img class='ver' src='presentacion/iconos/ojo.png' title='Ver Detalles' onClick='verDetalles(" + identificacion + ")'> ";
        lista += "<img  class='eliminar' src='presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(" + identificacion + ")' style='cursor:pointer;'/>";
        lista += "<img class='subir' src='presentacion/iconos/retirado.png' title='Pasar a retirado' onClick='verRetirados(\"" + persona.getIdentificacion() + "\")' style='cursor:pointer;'/> ";
        lista += "</td>";
        lista += "</tr>";
    }
%>

<jsp:include page="permisos.jsp" />
<%@ include file="menu.jsp" %>

<div class="content">  
    <h3 class="titulo">COLABORADORES TEMPORALES</h3>
    <link rel="stylesheet" href="presentacion/style-Retirados.css">

    <!-- Nuevo buscador dinámico -->
    <div class="search-container">
        <div class="search-box">
            <select id="searchType" class="recuadro">
                <option value="tipoDocumento">Documento de identificación</option>
                <option value="identificacion">Identificación</option>
                <option value="nombre">Nombres</option>
                <option value="apellido">Apellidos</option>
                <option value="cargo">Cargo</option>
                <option value="establecimiento">Establecimiento</option>
                <option value="cctn">Cctn</option>
                <option value="fechaIngreso">Fecha de Ingreso</option>
            </select>
            <input type="text" id="searchInput" onkeyup="filterResults()" placeholder="Buscar..." class="recuadro">
            <img src="presentacion/iconos/lupa.png" alt="Buscar">
        </div>
    </div>

    <table class="table" id="temporalesTable" border="1">
        <tr>
            <th>Documento de identificación</th>
            <th>Número de documento</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Cargo</th>
            <th>Establecimiento</th>
            <th>Cctn</th>
            <th>Fecha de ingreso</th>
            <th>
                <a href="temporalesFormulario.jsp?accion=Adicionar" class="subir" title="Adicionar">
                    <img src="presentacion/iconos/agregar.png" width='30' height='30'>
                </a>
            </th>
        </tr>
        <%= lista%> 
    </table>
</div>

<!-- Script para eliminar un temporal con confirmación -->
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

    // Buscador dinámico con opción de filtro por columna
    function filterResults() {
        const searchType = document.getElementById('searchType').value;
        const input = document.getElementById('searchInput').value.toLowerCase();
        const table = document.getElementById("temporalesTable");
        const rows = table.getElementsByTagName("tr");

        let columnIndex;
        switch (searchType) {
            case "identificacion":
                columnIndex = 1;
                break;
            case "nombre":
                columnIndex = 2;
                break;
            case "apellido":
                columnIndex = 3;
                break;
            case "cargo":
                columnIndex = 4;
                break;
            case "establecimiento":
                columnIndex = 5;
                break;
            case "cctn":
                columnIndex = 6;
                break;
            case "fechaIngreso":
                columnIndex = 7;
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
