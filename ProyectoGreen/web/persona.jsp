<%-- 
    Document   : persona
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
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
    List<Persona> datos = Persona.getListaEnObjetos("tipo = 'C'", null);

    for (Persona persona : datos) {
        String tipoDocumento = persona.getTipoDocumento();
        String identificacion = persona.getIdentificacion();
        String nombres = persona.getNombres();
        String apellidos = persona.getApellidos();
        String cargo = Cargo.getCargoPersona(persona.getIdentificacion());
        String establecimiento = persona.getEstablecimiento();
        String cctn = persona.getCctn();
        //String unidadNegocio = persona.getUnidadNegocio();

        String fechaIngreso = persona.getFechaIngreso();

        lista += "<tr>";
        lista += "<td>" + tipoDocumento + "</td>";
        lista += "<td align='right'>" + identificacion + "</td>";
        lista += "<td>" + nombres + "</td>";
        lista += "<td>" + apellidos + "</td>";
        lista += "<td>" + cargo + "</td>";
        lista += "<td>" + establecimiento + "</td>";
        lista += "<td>" + cctn + "</td>";
        //lista += "<td>" + unidadNegocio + "</td>";
        lista += "<td>" + fechaIngreso + "</td>";
        lista += "<td>";
        lista += "<img class='ver' src='presentacion/iconos/verDocumento.png' width='25' height='25' title='Ver historia laboral' onclick='historiaLaboralGreen(" + persona.getIdentificacion() + ")'>";
        lista += "<a href='personaFormulario.jsp?accion=Modificar&identificacion=" + identificacion + "' title='Modificar'>";
        lista += "<img class='editar' src='presentacion/iconos/modificar.png' alt='Modificar'/></a> ";
        lista += "<img class='ver' src='presentacion/iconos/ojo.png' title='Ver Detalles' onClick='verDetalles(" + identificacion + ")'> ";
        lista += "<img class='eliminar' src='presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(" + identificacion + ")' style='cursor:pointer;'/>";
        lista += "<img class='subir' src='presentacion/iconos/retirado.png' title='Pasar a retirado' onClick='verRetirados(\"" + persona.getIdentificacion() + "\")' style='cursor:pointer;'/> ";
        lista += "</td>";
        lista += "</tr>";
    }

%>

<jsp:include page="permisos.jsp" />
<%@ include file="menu.jsp" %>

<div class="content">  
    <h3 class="titulo">COLABORADORES GREEN S.A.S</h3>
    <link rel="stylesheet" href="presentacion/style-Retirados.css">

    <!-- Nuevo buscador dinÃ¡mico -->
    <div class="search-container">
        <div class="search-box">
            <select id="searchType" class="recuadro">

                <option value="tipoDocumento">Documento de identificacion</option>
                <option value="identificacion">identificacion</option>
                <option value="nombre">Nombres</option>
                <option value="apellido">Apellidos</option>
                <option value="cargo">Cargo</option>
                <option value="establecimiento">Establecimiento</option>  
                <option value="cctn">Cctn</option>  
                <option value="unidadNegocio">Unidad de negocio</option>
                <option value="fechaIngreso">Fecha de Ingreso</option>
            </select>
            <input type="text" id="searchInput" onkeyup="filterResults()" placeholder="Buscar..." class="recuadro">
            <img src="presentacion/iconos/lupa.png" alt="Buscar">
        </div>
    </div>

    <table class="table" id="colaboradoresTable" border="1">
        <tr>

            <th>Documento de identificacion</th>
            <th>Número de documento</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Cargo</th>
            <th>Establecimiento</th>
            <th>Unidad de negocio por nomina</th>
            <th>Fecha de ingreso</th>
            <th>
                <a href="personaFormulario.jsp?accion=Adicionar" class="subir" title="Adicionar">
                    <img src="presentacion/iconos/agregar.png" width='30' height='30'>
                </a>
            </th>
        </tr>
        <%= lista%> 
    </table>
</div>

<!-- Script para eliminar una persona con confirmaciÃ³n -->
<script type="text/javascript">
    function eliminar(identificacion) {
        var respuesta = confirm("Â¿Realmente desea eliminar el registro del colaborador?");
        if (respuesta) {
            window.location.href = "personaActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }
    function verDetalles(identificacion) {
        document.location = "personaDetalles.jsp?identificacion=" + identificacion;
    }
    function historiaLaboralGreen(identificacion) {
        window.location.href = "historiaLaboralGreen.jsp?identificacion=" + identificacion;
    }
    
    function verRetirados(identificacion) {
        window.location.href = "retiradosFormulario.jsp?identificacion=" + identificacion;
    }

    // Buscador dinÃ¡mico con opciÃ³n de filtro por columna
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
            case "cctn":
                columnIndex = 5;
                break;
            case "fechaIngreso":
                columnIndex = 6;
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

