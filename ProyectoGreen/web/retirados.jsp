<%@page import="clases.Cargo"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Retirados"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
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
<table class="table" border="1">
    <tr>
        <th>Identificación</th>
        <th>Nombre Completo</th>
        <th>Establecimiento</th>
        <th>Fecha Ingreso</th>
        <th>Fecha Retiro</th>
        <th>Cargo</th>
        <th>Número Caja</th>
        <th>Número Carpeta</th>
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
</script>