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
            titulo = "DOCUMENTO DE IDENTIDAD";
            break;

        // PROCESO DE SELECCION
        case "PruebaT":
            titulo = "PRUEBAS TÉCNICAS";
            break;

        case "PruebaPsi":
            titulo = "PRUEBAS PSICOTÉCNICAS";
            break;

        //HOJA DE VIDA
        case "HVotros":
            titulo = "HOJA DE VIDA";
            break;
        case "AntecedentesP":
            titulo = "ANTECEDENTES PROCURADURÍA";
            break;
        case "AntecedentesC":
            titulo = "ANTECEDENTES CONTRALORÍA";
            break;
        case "AntecedentesJ":
            titulo = "ANTECEDENTES JUDICIALES (POLICÍA)";
            break;
        case "Inhabilidades":
            titulo = "CONSULTA INHABILIDADES";
            break;
        case "RNMC":
            titulo = "CONSULTA RNMC";
            break;
        case "REDAM":
            titulo = "CERTIFICADO REDAM";
            break;
        case "Banco":
            titulo = "CERTIFICADO DE BANCO";
            break;
        case "Licencia":
            titulo = "FOTOCOPIA LICENCIA DE CONDUCCIÓN";
            break;
        case "SOAT":
            titulo = "SOAT";
            break;
        case "Tecnomecanica":
            titulo = "TECNOMECÁNICA";
            break;
        case "SIMIT":
            titulo = "CERTIFICADO SIMIT";
            break;

        //DOCUMENTOS DE CONTRATACION
        case "CTotros":
            titulo = "CONTRATO DE TRABAJO";
            break;
        case "TDotros":
            titulo = "TRATAMIENTO DE DATOS PERSONALES";
            break;
        case "ATDotros":
            titulo = "AUTORIZACIÓN DE TRATAMIENTO DE DATOS PERSONALES";
            break;
        case "AERotros":
            titulo = "AUTORIZACIÓN DE EXÁMENES Y REQUISAS";
            break;
        case "PRotros":
            titulo = "PROFESIOGRAMA";
            break;
        case "SGRILAFTotros":
            titulo = "DOCUMENTOS SAGRILAFT";
            break;
        case "SGHotros":
            titulo = "INDUCCIÓN GESTIÓN HUMANA";
            break;

        //AFILIACIONES
        case "CEPSotros":
            titulo = "CERTIFICADO EPS POR COLABORADOR";
            break;
        case "FUAotros":
            titulo = "FORMULARIO ÚNICO DE AFILIACIÓN Y REGISTRO DE NOVEDADES EPS";
            break;
        case "CAEPSotros":
            titulo = "CERTIFICADO DE AFILIACIÓN EPS";
            break;
        case "CAARLotros":
            titulo = "CERTIFICADO DE AFILIACIÓN ARL";
            break;

        case "CFDPotros":
            titulo = "CERTIFICADO FDP";
            break;
        case "FACotros":
            titulo = "FORMULARIO DE AFILIACIÓN COMFAMILIAR";
            break;

        case "CACotros":
            titulo = "CERTIFICADO DE AFILIACIÓN COMFAMILIAR";
            break;

        //DOCUMENTOSSST-SGAA
        case "IRSGSSTotros":
            titulo = "INDUCCIÓN Y REINDUCCIÓN SG-SST";
            break;
        case "IRSGAotros":
            titulo = "INDUCCIÓN Y REINDUCCIÓN SGA";
            break;
        case "EMOIotros":
            titulo = "EMO INGRESO";
            break;
        case "EMOPotros":
            titulo = "EMO PERIÓDICO";
            break;
        case "EMOINotros":
            titulo = "EMO POST-INCAPACIDAD";
            break;
        case "EMOEotros":
            titulo = "EMO EGRESO";
            break;

        case "EMOSRotros":
            titulo = "EMO SEGUIMIENTO A RECOMENDACIONES";
            break;

        case "ECSotros":
            titulo = "ENCUESTA CONDICIONES DE SALUD";
            break;

        case "CPotros":
            titulo = "CERTIFICADOS Y PERMISOS";
            break;

        //DOCUMENTOS DURANTE LA CONTRATACION
        case "PPROGGASotros":
            titulo = "PREAVISOS Y PRÓRROGAS";
            break;

        case "Dotros":
            titulo = "OTRO SÍ";
            break;

        case "SPAotros":
            titulo = "SUSTITUCIÓN PATRONAL";
            break;

        case "CESotros":
            titulo = "RETIRO DE CESANTÍAS";
            break;

        case "DNOMotros":
            titulo = "DESCUENTO DE NÓMINA";
            break;

        case "ACEMPotros":
            titulo = "ACUERDO ENTRE EMPLEADOR Y TRABAJADOR";
            break;

        case "NSALotros":
            titulo = "NOTIFICACIÓN INCREMENTO DE SALARIO";
            break;

        case "EDESOtros":
            titulo = "EVALUACIÓN DE DESEMPEÑO";
            break;

        case "ACTASotros":
            titulo = "ACTAS";
            break;

        case "DISCotros":
            titulo = "DISCIPLINARIOS";
            break;

        case "CERTLABotros":
            titulo = "CERTIFICADOS LABORALES";
            break;

        case "RGHotros":
            titulo = "REINDUCCIÓN DE GESTIÓN HUMANA";
            break;

        //AUSENTISMOS  
        case "Votros":
            titulo = "VACACIONES";
            break;
        case "LLotros":
            titulo = "LICENCIAS DE LUTO";
            break;
        case "LRotros":
            titulo = "LICENCIAS REMUNERADAS";
            break;
        case "LNotros":
            titulo = "LICENCIAS NO REMUNERADAS";
            break;
        case "PERMotros":
            titulo = "PERMISOS";
            break;
        case "SUSPotros":
            titulo = "SUSPENSIONES";
            break;
        case "DIAFAMotros":
            titulo = "DÍA DE LA FAMILIA";
            break;

        //Incapacidades
        case "INCENFotros":
            titulo = "INCAPACIDAD POR ENFERMEDAD";
            break;

        case "ATotros":
            titulo = "ACCIDENTES DE TRABAJO";
            break;

        case "MATPATotros":
            titulo = "LICENCIA MATERNIDAD / PATERNIDAD";
            break;

        //DOCUMENTOS AL FINALIZAR LA CONTRATACIÓN
        case "Lotros":
            titulo = "DOCUMENTOS DE TERMINACIÓN DE CONTRATO";
            break;

        //temporales
        case "induccionSST":
            titulo = "INDUCCIÓN SST";
            break;
        case "induccionSGA":
            titulo = "INDUCCIÓN SGA";
            break;
        case "induccionSGeH":
            titulo = "INDUCCIÓN GESTIÓN HUMANA";
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

    if (identificacion
            != null && !identificacion.isEmpty()) {
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

<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>

<div class="content">
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Historia Laboral Retirados</title>
            <link rel="stylesheet" href="../presentacion/style-historiaLRetirado.css">
        </head>
        <body>
            <div class="container">
                <h1>HISTORIA LABORAL</h1>
                <div class="section">
                    <h2><%= titulo%></h2>
                    <input type="text" value="<%= (persona != null) ? persona.getNombres() + " " + persona.getApellidos() + " - " + persona.getIdentificacion() : ""%>" class="nombre" readonly>
                </div>

                <table class="documentos-tabla">
                    <thead>
                        <tr>
                            <th>Observación</th>
                            <th>Nombre del archivo</th>
                            <th colspan="2">
                                <a href="detalleFormulario.jsp?identificacion=<%= identificacion%>&tipo=<%= tipo%>">
                                    <img src="../presentacion/iconos/agregar.png" class="subir" alt="Agregar Documento">
                                </a>
                            </th>
                        </tr>
                    </thead>


                    <tbody>
                        <%
                            String tipoParametro = request.getParameter("tipo");

                            if (tipoParametro != null && "votros".equalsIgnoreCase(tipoParametro.trim())
                                    && persona != null && "C".equalsIgnoreCase(persona.getTipo())) {
                        %>
                    <div style="margin: 20px 0; text-align: left;">
                        <a href="../3.HistoriaLaboral/verRegistrosVacaciones.jsp?identificacion=<%= request.getParameter("identificacion")%>" 
                           class="btn-verde" style="padding: 10px 15px; background-color: #24553a; color: white; text-decoration: none; border-radius: 5px;">
                            VER REGISTROS
                        </a>
                    </div>
                    <%
                        }

                        // Nuevo bloque para DIAFAMotros
                        if (tipoParametro != null && "DIAFAMotros".equalsIgnoreCase(tipoParametro.trim())
                                && persona != null && "C".equalsIgnoreCase(persona.getTipo())) {
                    %>
                    <div style="margin: 20px 0; text-align: left;">
                        <a href="../3.HistoriaLaboral/verRegistroDiaFamlia.jsp?identificacion=<%= request.getParameter("identificacion")%>" 
                           class="btn-verde" style="padding: 10px 15px; background-color: #24553a; color: white; text-decoration: none; border-radius: 5px;">
                            VER REGISTROS 
                        </a>
                    </div>
                    <%
                        }
                    %>




                    <% if (listaDetalles
                                != null && !listaDetalles.isEmpty()) {
                            for (DetallesHistoria detalle : listaDetalles) {%>
                    <tr>
                        <td><%= detalle.getNombreDocumento()%></td>
                        <td><%= detalle.getDocumentoPDF() != null ? detalle.getDocumentoPDF() : "No disponible"%></td>
                        <td>
                            <% if (detalle.getDocumentoPDF() != null && !detalle.getDocumentoPDF().isEmpty()) {%>
                            <a href="<%= detalle.getDocumentoPDF()%>" target="_blank">
                                <img class="ver" src="../presentacion/iconos/ojo.png" alt="Ver PDF">
                            </a>
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
                                <button type="submit" onclick="return confirm('¿Estás seguro de eliminar este documento?');" style="border: none; background: none; cursor: pointer;">
                                    <img src="../presentacion/iconos/eliminar.png" class="eliminar" alt="Eliminar">
                                </button>
                            </form>
                        </td>

                        <td>
                            <% if ("Lotros".equals(tipo) && !"R".equals(persona.getTipo())) {%>
                            <img class='subir' src='../presentacion/iconos/retirado.png' 
                                 title='Pasar a retirado' 
                                 onClick='verRetirados("<%= persona.getIdentificacion()%>")' 
                                 style='cursor:pointer;'/>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    <% } else { %>
                    <tr style="background-color: #ffcccc; color: #a10000; font-weight: bold;">
                        <td colspan="5">No hay documentos cargados</td>
                    </tr>

                    <% }%>
                    </tbody>

                </table>
                <div class="buttons">
                    <a href="javascript:history.back()" class="btn-volver">VOLVER</a>
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

    function verRetirados(identificacion) {
        window.location.href = "retiradosFormulario.jsp?identificacion=" + identificacion;
    }

    // PERMISOS

    document.addEventListener("DOMContentLoaded", function () {
        controlarPermisos(
                "<%= administrador.getpEliminar()%>",
                "<%= administrador.getpLeer()%>",
                "<%= administrador.getpAgregar()%>"
                );
    });

</script>