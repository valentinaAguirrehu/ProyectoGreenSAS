<%@page import="java.util.List"%>
<%@page import="clases.DetallesHistoria"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Administrador"%>
<jsp:include page="../permisos.jsp" />
<%@ include file="../menu.jsp" %>

<%
    Administrador administrador = (Administrador) session.getAttribute("administrador");
    if (administrador == null) {
        administrador = new Administrador();
    }

    String identificacion = request.getParameter("identificacion");
    String codigoDocumento = request.getParameter("codigoDocumento"); // Si existe, es una modificación
    String tipo = request.getParameter("tipo");
    String nombreDocumento = "";
    String documentoPDF = "";

    // Verificación si ya existe el archivo
    String nombreArchivoSubido = request.getParameter("nombreDocumento"); // Obtener nombre del archivo
    String mensajeError = "";

    // Si no estamos editando un documento (es un nuevo archivo), validamos si ya existe
    if (codigoDocumento == null && nombreArchivoSubido != null && !nombreArchivoSubido.isEmpty()) {
        // Verificar si ya existe un archivo con el mismo nombre para esta persona y tipo
        String filtro = "nombreDocumento = '" + nombreArchivoSubido + "' AND idPersona = '" + identificacion + "'";
        List<DetallesHistoria> archivoExistente = DetallesHistoria.getListaEnObjetos(filtro, null);

        if (archivoExistente != null && !archivoExistente.isEmpty()) {
            // Si existe, se muestra un mensaje para cambiar el nombre
            mensajeError = "¡Advertencia! Ya existe un archivo con el mismo nombre. Por favor, cambia el nombre del archivo.";
        }
    }

    // Cargar los datos del documento si se está editando
    if (codigoDocumento != null) {
        DetallesHistoria documento = new DetallesHistoria(codigoDocumento);
        nombreDocumento = documento.getNombreDocumento();
        documentoPDF = documento.getDocumentoPDF();
    }
%>

<div class="content">
    <html>
        <head>
            <title><%= (codigoDocumento != null) ? "Modificar" : "Nuevo"%> Documento</title>
            <link rel="stylesheet" href="../presentacion/style-historiaLRetirado.css">
            <% if (!mensajeError.isEmpty()) { %>
                <script>
                    alert("<%= mensajeError %>");
                </script>
            <% } %>
        </head>
        <body>
            <div class="container">
                <h1><%= (codigoDocumento != null) ? "Modificar" : "Agregar Nuevo"%> Documento</h1>
                <form action="detalleActualizar.jsp" method="POST" enctype="multipart/form-data">
                    <input type="hidden" id="identificacion" name="identificacion" value="<%= identificacion%>">
                    <input type="hidden" id="codigoDocumento" name="codigoDocumento" value="<%= (codigoDocumento != null) ? codigoDocumento : ""%>">
                    <input type="hidden" id="tipo" name="tipo" value="<%= tipo%>">

                    <!-- Aquí agregamos el campo oculto 'accion' -->
                    <input type="hidden" id="accion" name="accion" value="<%= (codigoDocumento != null) ? "Modificar" : "Adicionar"%>">

                    <table>
                        <tr>
                            <th>Archivo PDF:</th>
                            <td>
                                <input type="file" id="documentoPDF" name="documentoPDF" accept="application/pdf">
                                <% if (codigoDocumento != null && documentoPDF != null && !documentoPDF.isEmpty()) {%>
                                <p>Documento actual: <a href="<%= documentoPDF%>" target="_blank">Ver documento</a></p>
                                <% }%>
                            </td>
                        </tr>
                         <tr>
                            <th>Observación:</th>
                            <td>
                                <input type="text" id="nombreDocumento" name="nombreDocumento" value="<%= nombreDocumento%>">
                            </td>
                        </tr>
                    </table>

                    <input class="btn-guardar"  type="submit" value="<%= (codigoDocumento != null) ? "Actualizar" : "Guardar"%>">
                    <a href="javascript:history.back()" class="btn-volver">VOLVER</a>
                </form>
            </div>
        </body>
    </html>
</div>
