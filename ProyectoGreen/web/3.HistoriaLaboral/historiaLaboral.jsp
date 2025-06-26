<%@ page import="clases.Persona" %>
<%@ page import="clases.InformacionLaboral" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Iterator, java.util.Map, java.util.HashMap" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.FileItem" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext" %>
<%@ page import="java.io.File" %>



<%
    String identificacion = request.getParameter("identificacion");
    Persona persona = null;
    InformacionLaboral info = null;

    if (identificacion != null && !identificacion.isEmpty()) {
        persona = new Persona(identificacion);
        info = InformacionLaboral.getInformacionPorIdentificacion(identificacion);
    }
%>
<%
    String tipo = persona.getTipo();
    session.setAttribute("tipoPersona", tipo);
    out.println("<!-- DEBUG_ORIG: tipoPersona en session = " + tipo + " -->");
%>

<!DOCTYPE html>
<%@ include file="../menu.jsp" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Historia Laboral Temporales</title>
    <link rel="stylesheet" href="../presentacion/style-historiaLGreen.css">
</head>
<body>
    <div class="content">
        <div class="container">
            <h1>HISTORIA LABORAL TEMPORALES</h1>

            <!-- Nombre completo -->
            <div class="section">
                <input type="text" value="<%= (persona != null) ? persona.getNombres() + " " + persona.getApellidos() : "" %>" class="nombre" readonly>
            </div>

            <!-- Datos del colaborador -->
            <div class="section">
                <h3 class="titulo-seccion">DATOS DEL COLABORADOR</h3>
                <div class="input-group">
                    <div class="campo">
                        <label>Documento de identificación</label>
                        <input type="text" class="campo-mediano" value="<%= (persona != null) ? persona.getIdentificacion() : "" %>" readonly>
                    </div>
                    <div class="campo">
                        <label>Centro de costos</label>
                        <input type="text" class="campo-mediano" value="<%= (info != null) ? info.getCentroCostos() : "" %>" readonly>
                    </div>
                    <div class="campo">
                        <label>Lugar de trabajo</label>
                        <input type="text" class="campo-pequeno" value="<%= (info != null) ? info.getEstablecimiento() : "" %>" readonly>
                    </div>
                    <div class="campo">
                        <label>Celular</label>
                        <input type="text" class="campo-pequeno" value="<%= (persona != null) ? persona.getCelular() : "" %>" readonly>
                    </div>
                    <div class="campo">
                        <label>Fecha de inicio del contrato</label>
                        <input type="text" class="campo-mediano" value="<%= (info != null) ? info.getFechaIngreso() : "" %>" readonly>
                    </div>
                </div>
            </div>

            <!-- Documentos -->
            <div class="section">
                <h3 class="titulo-seccion">DOCUMENTOS</h3>
                <div class="data-grid">
                    <div class="data-item">
                        <span>DOCUMENTO DE IDENTIDAD</span>
                        <button class="ver-btn" onclick="window.location.href = 'detalleHistoria.jsp?identificacion=<%= identificacion %>&tipo=documentoIdentidad'">VER</button>
                    </div>
                    <div class="data-item">
                        <span>DOCUMENTO DE CONTRATACIÓN</span>
                        <button class="ver-btn" onclick="window.location.href = 'detalleHistoria.jsp?identificacion=<%= identificacion %>&tipo=TemporalesContra'">VER</button>
                    </div>
                    <div class="data-item">
                        <span>SG-SST-SGA</span>
                        <button class="ver-btn" onclick="window.location.href = 'verDocumentosSSTSGTemporal.jsp?identificacion=<%= identificacion %>'">VER</button>
                    </div>
                    <div class="data-item">
                        <span>DOCUMENTOS DURANTE LA CONTRATACIÓN</span>
                        <button class="ver-btn" onclick="window.location.href = 'verDuranteContratacionTemporal.jsp?identificacion=<%= identificacion %>'">VER</button>
                    </div>
                    <div class="data-item">
                        <span>AUSENTISMOS</span>
                        <button class="ver-btn" onclick="window.location.href = 'verAusentismosTemporal.jsp?identificacion=<%= identificacion %>'">VER</button>
                    </div>
                    <div class="data-item">
                        <span>INCAPACIDADES</span>
                        <button class="ver-btn" onclick="window.location.href = 'verIncapacidades.jsp?identificacion=<%= identificacion %>'">VER</button>
                    </div>
                    <div class="data-item">
                        <span>DOCUMENTOS AL FINALIZAR CONTRATACION</span>
                        <button class="ver-btn" onclick="window.location.href = 'detalleHistoria.jsp?identificacion=<%= identificacion %>&tipo=FinalizarTemporal'">VER</button>
                    </div>
                </div>

                <div class="buttons">
                    <a href="../2.Colaboradores/temporales.jsp" class="btn-volver">VOLVER</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
