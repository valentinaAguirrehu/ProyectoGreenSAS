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

        //DOCUMENTOIDENTIDAD
        case "documentoIdentidad":
            titulo = "DOCUMENTO IDENTIDAD";
            break;

        //HOJA DE VIDA
        case "HVotros":
            titulo = "HOJA DE VIDA";
            break;
        case "DVotros":
            titulo = "DATOS DEL VEHÍCULO";
            break;

        //DOCUMENTOS DE CONTRATACION
        case "CTotros":
            titulo = "CONTRATO DE TRABAJO";
            break;
        case "TDotros":
            titulo = "TRATAMIENTO DATOS";
            break;
        case "AERotros":
            titulo = "AUTORIZACION EXAMENES Y REQUISAS";
            break;
        case "PRotros":
            titulo = "PROFESIOGRAMA";
            break;
        case "SSTotros":
            titulo = "INDUCCIÓN SST";
            break;
        case "SGAotros":
            titulo = "INDUCCIÓN SGA";
            break;
        case "APACotros":
            titulo = "ACTA PAUSAS ACTIVAS";
            break;
        case "ICAotros":
            titulo = "INDUCCIÓN AL CARGO";
            break;
        case "SGRILAFTotros":
            titulo = "DOCUMENTO SAGRILAFT";
            break;

        //AFILIACIONES
        case "EPSotros":
            titulo = "EPS";
            break;
        case "ARLotros":
            titulo = "ARL";
            break;
        case "FDPotross":
            titulo = "FONDO DE PENSIONES";
            break;
        case "CESAotros":
            titulo = "FONDO DE CESANTIAS";
            break;
        case "CCPotros":
            titulo = "COMFAMILIAR";
            break;

        //DOCUMENTOS DURANTE LA CONTRATACION
        case "Dotros":
            titulo = "OTROS SI";
            break;
        case "SPAotros":
            titulo = "SUSTITUCION PATRONAL";
            break;
        case "PPROGGASotros":
            titulo = "PREAVISOS Y PRORROGAS";
            break;
        case "DUCONotros":
            titulo = "OTROS DOCUMENTOS";
            break;

        //AUSENTISMOS  
        case "Votros":
            titulo = "VACACIONES";
            break;
        case "LNotros":
            titulo = "LICENCIA NO REMUNERADA";
            break;
        case "DAotros":
            titulo = "OTROS DOCUMENTOS";
            break;

        //DOCUMENTOSSST-SGAA
        case "RInduccionotros":
            titulo = "REINDUCCIÓN";
            break;

        case "EMOPotros":
            titulo = "EMO PERIODICO";
            break;

        case "EMOINotros":
            titulo = "EMO POST-INCAPACIDAD";
            break;
        case "DSTSGAotros":
            titulo = "OTROS DOCUMENTOS";
            break;

        //DOCUMENTOS AL FINALIZAR LA CONTRATACIÓN
        case "Lotros":
            titulo = "LIQUIDACIÓN";
            break;

        //temporales
        case "induccionSST":
            titulo = "INDUCCIÓN SST";
            break;
        case "induccionSGA":
            titulo = "INDUCCIÓN SGA";
            break;

        case "otrosDocumentosT":
            titulo = "OTROS DOCUMENTOS";
            break;

        //Aprendiz 
        case "EPSotrosAp":
            titulo = "EPS APRENDIZ";
            break;

        case "ARLotrosAp":
            titulo = "ARL APRENDIZ";
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
                    <a href="javascript:history.back()" class="btn-volver">VOLVER</a>
                </div>
            </div>s
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