<%@page import="clases.Cargo"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Retirados"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String lista = "";
    List<Retirados> datos = Retirados.getListaEnObjetos(null, null);
    for (Retirados retirado : datos) {
        if (retirado.getIdentificacion() != null) {
            Persona persona = new Persona(retirado.getIdentificacion());
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
                // lista += "<img src='presentacion/iconos/ojo.png' width='25' height='25' title='Ver detalles'>";
                lista += "<img src='presentacion/iconos/verDocumento.png' width='25' height='25' title='Ver historia laboral'>";
                lista += "<a href='retiradosFormulario.jsp?accion=Modificar&id=" + persona.getIdentificacion()
                        + "' title='Modificar'><img src='presentacion/iconos/modificar.png' width='25' height='25'></a> ";
                lista += "<img src='presentacion/iconos/eliminar.png' width='25' height='25' title='Eliminar' onClick='eliminar("
                        + persona.getIdentificacion() + ")'> ";
               lista += "</td>";
                lista += "</tr>";
            }
        }
    } 
%>

<h3 class="titulo">COLABORADORES RETIRADOS</h3>
<link rel="stylesheet" href="presentacion/style-Retirados.css">

<div class="search-container">
    <div class="search-box">
        <input type="text" id="searchInput" onkeyup="filterNames()" placeholder="Buscar por nombre o identificación " class="recuadro">
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
        <th>Nº de caja</th>
        <th>Nº de carpeta</th>
        <th>Observaciones</th>
        <th>
            <a href="retiradosFormulario.jsp?accion=Adicionar" title="Adicionar">
                <img src="presentacion/iconos/agregar.png" width='30' height='30'>
            </a>
        </th>
    </tr>
    <%= lista%>
</table>

<script type="text/javascript">
    function eliminar(identificacion) {
        resultado = confirm("Realmente desea eliminar el registro con identificación " + identificacion + "?");
        if (resultado) {
            document.location = "retiradosActualizar.jsp?accion=Eliminar&identificacion=" + identificacion;
        }
    }
    
    function filterNames() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toLowerCase();
        const table = document.getElementById('usuariosTable');
        const rows = table.getElementsByTagName('tr');

        for (let i = 1; i < rows.length; i++) { // Saltamos el encabezado
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
    
</script>