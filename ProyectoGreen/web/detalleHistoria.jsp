<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Administrador"%>
<%@page import="clases.DetallesHistoria"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    String identificacion = request.getParameter("identificacion");
    String tipo = request.getParameter("tipo");
    String titulo = "";

    switch (tipo) {
        case "Dotros":
            titulo = "Otros si";
            break;
        case "Votros":
            titulo = "Vacaciones";
            break;
        case "HVotros":
            titulo = "Hoja de Vida";
            break;
        case "DVotros":
            titulo = "Datos del vehículo";
            break;
        case "Lotros":
            titulo = "Liquidación";
            break;
        case "LNotros":
            titulo = "Licencia no remunerada";
            break;
        case "DAotros":
            titulo = "Otros documentos";
            break;
        case "OtraOpcion":
            break;
        default:
            break;
    }

    Persona persona = null;
    DetallesHistoria detalleHistoria = null; // Cambiado de HistoriaLaboral
    List<DetallesHistoria> listaDetalles = null;

    if (identificacion != null && !identificacion.isEmpty()) {
        persona = new Persona(identificacion);

        // Filtro con identificación y tipo
        String filtro = "idPersona = '" + identificacion + "' AND tipo = '" + tipo + "'";

        List<DetallesHistoria> datos = DetallesHistoria.getListaEnObjetos(filtro, null); // Cambiado de HistoriaLaboral
        if (datos != null && !datos.isEmpty()) {
            detalleHistoria = datos.get(0); // Cambiado de historiaLaboral
            if (detalleHistoria != null && detalleHistoria.getIdPersona() != null) {
                persona = new Persona(detalleHistoria.getIdPersona());
            }
        }

        // Obtener los detalles de la historia con el filtro aplicado
        listaDetalles = DetallesHistoria.getListaEnObjetos(filtro, null);
    }

%>

<!DOCTYPE html>
<jsp:include page="permisos.jsp" />
<%@ include file="menu.jsp" %>

<div class="content">
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Historia Laboral Retirados</title>
            <link rel="stylesheet" href="presentacion/style-historiaLRetirado.css">
        </head>
        <body>
            <div class="container">
                <h1>HISTORIA LABORAL</h1>
                <div class="section">
                    <h2><%= titulo%></h2>
                    <input type="text" value="<%= (persona != null) ? persona.getNombres() + " " + persona.getApellidos() + " - " + persona.getIdentificacion() : ""%>" class="nombre" readonly>
                </div>
                <div class="buttons">
                    <a href="detalleFormulario.jsp?identificacion=<%= identificacion%>&tipo=<%= tipo%>" class="btn-agregar">AGREGAR DOCUMENTO</a>
                </div>
                <table class="documentos-tabla">
                    <thead>
                        <tr>
                            <th>Nombre Documento</th>
                            <th>Nombre Archivo</th>
                            <th>Ver</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (listaDetalles != null && !listaDetalles.isEmpty()) {
            for (DetallesHistoria detalle : listaDetalles) {%>
                        <tr>
                            <td><%= detalle.getNombreDocumento()%></td>
                            <td><%= detalle.getDocumentoPDF() != null ? detalle.getDocumentoPDF() : "No disponible"%></td>
                            <td>
                                <% if (detalle.getDocumentoPDF() != null && !detalle.getDocumentoPDF().isEmpty()) {%>
                                <a href="<%= detalle.getDocumentoPDF()%>" target="_blank">Ver PDF</a>
                                <% } else { %>
                                No disponible
                                <% }%>
                            </td>
                            <td>
                                <!-- Formulario para eliminar -->
                                <form action="detalleActualizar.jsp" method="POST" style="display:inline;">
                                    <input type="hidden" name="codigoDocumento" id="codigoDocumento" value="<%= detalle.getId()%>">
                                    <input type="hidden" name="idPersona" id="idPersona" value="<%= detalle.getIdPersona()%>">
                                    <input type="hidden" name="tipo" id="tipo" value="<%= detalle.getTipo()%>">
                                    <input type="hidden" name="accion" value="Eliminar">
                                    <button type="submit" onclick="return confirm('¿Estás seguro de eliminar este documento?');">
                                        Eliminar
                                    </button>
                                </form>

                            </td>
                        </tr>
                        <% }
    } else { %>
                        <tr>
                            <td colspan="4">No hay documentos disponibles</td>
                        </tr>
                        <% }%>
                    </tbody>

                </table>
                <div class="buttons">
                    <a href="historiaLaboralGreen.jsp?identificacion=<%= identificacion%>" class="btn-volver">VOLVER</a>
                </div>
            </div>
        </body>
    </html>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll("tr").forEach(row => {
            let viewBtn = row.querySelector(".ver"); // Botón Ver archivo
            let fileMessage = row.querySelector(".estado"); // Mensaje de estado
            let fileData = null;

            if (!viewBtn || !fileMessage)
                return;

            // Ver Archivo
            viewBtn.addEventListener("click", function () {
                if (fileData) {
                    let fileURL = URL.createObjectURL(fileData);
                    window.open(fileURL, "_blank");
                } else {
                    alert("No hay ningún archivo cargado");
                }
            });
        });
    });

    // PERMISOS
    document.addEventListener("DOMContentLoaded", function () {
        controlarPermisos(
    <%= administrador.getpEliminar()%>,
    <%= administrador.getpAgregar()%>,
    <%= administrador.getpLeer()%>,
    <%= administrador.getpDescargar()%>
        );
    });
</script>