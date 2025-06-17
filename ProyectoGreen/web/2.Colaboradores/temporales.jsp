<%@page import="clases.InformacionLaboral"%>
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

        String identificacion = persona.getIdentificacion();
        String tipoDocumento = persona.getTipoDocumento().toString();
        String nombres = persona.getNombres();
        String apellidos = persona.getApellidos();
        String cargo = Cargo.getCargoPersona(persona.getIdentificacion());
        String fechaIngresoTemporal = InformacionLaboral.getFechaIngresoTemporal(persona.getIdentificacion());

        InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(persona.getIdentificacion());
        String centroCostos = (info != null) ? info.getCentroCostos() : "";
        
        lista += "<tr>";
        lista += "<td>" + tipoDocumento + "</td>";
        lista += "<td align='right'>" + identificacion + "</td>";
        lista += "<td>" + nombres + "</td>";
        lista += "<td>" + apellidos + "</td>";
        lista += "<td>" + cargo + "</td>";
        lista += "<td>" + centroCostos + "</td>";  
        lista += "<td>" + fechaIngresoTemporal + "</td>";
        lista += "<td>";  
        // VER DETALLES
        lista += "<img class='ver' src='../presentacion/iconos/ojo.png' title='Ver Detalles' onClick='verDetalles(" + identificacion + ")'> ";
        // VER HISTORIA LABORAL
        lista += "<img src='../presentacion/iconos/verDocumento.png' width='25' height='25' title='Ver historia laboral' onclick='verHistoriaLaboral(" + persona.getIdentificacion() + ")'>";
        // VER HISTORIAL DOTACION
        lista += "<img class='ver' src='../presentacion/iconos/dotacion.png' title='Entregar dotación' onClick='entregarDotacionT(\"" + persona.getIdentificacion() + "\")' style='cursor:pointer;'/> ";
        // MODIFICAR
        lista += "<a href='temporalesFormulario.jsp?accion=Modificar&identificacion=" + identificacion + "' title='Modificar'>";  
        lista += "<img class='editar' src='../presentacion/iconos/modificar.png' alt='Modificar'/></a> ";
        // ELIMINAR PERSONA
        lista += "<img  class='eliminar' src='../presentacion/iconos/eliminar.png' title='Eliminar' onClick='eliminar(" + identificacion + ")' style='cursor:pointer;'/>";
        // PASAR A RETIRADO
        lista += "<img class='subir' src='../presentacion/iconos/retirado.png' title='Pasar a retirado' onClick='verRetirados(\"" + persona.getIdentificacion() + "\")' style='cursor:pointer;'/> ";
        // CAMBIAR A GREEN S.A.S.
        lista += "<img class='subir' src='../presentacion/iconos/cambiarTipo.png' title='Pasar a colaborador' onClick='cambiarAColaborador(\"" + persona.getIdentificacion() + "\")' style='cursor:pointer;'/> ";
        lista += "</td>";
        lista += "</tr>";
    }
%>

<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>

<div class="content">  
    <h3 class="titulo">COLABORADORES TEMPORALES</h3>
    <link rel="stylesheet" href="../presentacion/style-Retirados.css">

    <!-- Nuevo buscador dinámico -->
    <div class="search-container">
        <div class="search-box">
            <select id="searchType" class="recuadro">
                <option value="identificacion">Identificación</option>
                <option value="nombre">Nombres</option>
                <option value="apellido">Apellidos</option>
                <option value="cargo">Cargo</option>
                <option value="centroCostos">Lugar de trabajo</option>
                <option value="fechaIngresoTemporal">Fecha de Ingreso Temporal</option>
            </select>
            <input type="text" id="searchInput" onkeyup="filterResults()" placeholder="Buscar..." class="recuadro">
            <img src="../presentacion/iconos/lupa.png" alt="Buscar">
        </div>
    </div>

    <table class="table" id="temporalesTable" border="1">
        <tr>
            <th>Documento de identificación</th>
            <th>Número de documento</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Cargo</th>
            <th>Lugar de trabajo</th>
            <th>Fecha de ingreso temporal</th>
            <th>
                <a href="temporalesFormulario.jsp?accion=Adicionar" class="subir" title="Adicionar">
                    <img src="../presentacion/iconos/agregar.png" width='30' height='30'>
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
        window.location.href = "../3.HistoriaLaboral/historiaLaboral.jsp?identificacion=" + identificacion;
    }

    function verRetirados(identificacion) {
        window.location.href = "retiradosFormulario.jsp?identificacion=" + identificacion;
    }
    
    function entregarDotacionT(identificacion) {
        window.location.href = "../7.Dotaciones/historialDotacion.jsp?identificacion=" + identificacion;
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
            case "centroCostos":
                columnIndex = 5;
                break;
            case "fechaIngresoTemporal":
                columnIndex = 6;
                break;
            default:
                columnIndex = -1;
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


    function cambiarAColaborador(identificacion) {
        var confirmar = confirm("¿Desea cambiar el tipo de esta persona a 'C' (Colaborador)?");
        if (confirmar) {
            window.location.href = "temporalesActualizar.jsp?accion=CambiarTipo&identificacionAnterior=" + identificacion;
        }
    }

</script>