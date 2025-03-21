<%-- 
    Document   : historiaLaboralAprendiz
    Created on : 12/03/2025, 03:40:22 PM
    Author     : VALEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Iterator, java.util.Map, java.util.HashMap" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.FileItem" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext" %>
<%@ page import="java.io.File" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historia Laboral</title>
        <link rel="stylesheet" href="presentacion/style-historiaLGreen.css">
    </head>
    <body>
        <div class="container">
            <h1>HISTORIA LABORAL APRENDIZ</h1>

            <div class="section">
                <input type="text" value="JOHANA LILIANA JIMÉN" class="nombre">
            </div>

            <!-- Datos Laborales -->
            <div class="section">
                <h3 class="titulo-seccion">Datos Laborales</h3>
                <div class="input-group">
                    <div class="campo">
                        <label>C.C.</label>
                        <input type="text" class="campo-pequeno">
                    </div>
                    <div class="campo">
                        <label>Centro de Costo</label>
                        <input type="text" class="campo-mediano">
                    </div>
                    
                    <div class="campo">
                        <label>Establecimiento</label>
                        <input type="text" class="campo-pequeno">
                    </div>
                    <div class="campo">
                        <label>Celular</label>
                        <input type="text" class="campo-pequeno">
                    </div>
                </div>
            </div>

            <!-- Datos Personales -->
            <div class="section">
                <h3 class="titulo-seccion">Datos Personales</h3>

                <div class="data-grid">
                    <div class="data-item">
                        <span>DOCUMENTO DE IDENTIDAD</span>
                        <button class="ver-btn">VER</button>
                    </div>
                    <div class="data-item">
                        <span>DURANTE CONTRATACIÓN</span>
                        <button class="ver-btn">VER</button>
                    </div>
                    <div class="data-item">
                        <span>HOJA DE VIDA</span>
                        <button class="ver-btn">VER</button>
                    </div>
                    <div class="data-item">
                        <span>AUSENTISMOS</span>
                        <button class="ver-btn">VER</button>
                    </div>
                    <div class="data-item">
                        <span>DOCUMENTOS CONTRATACIÓN</span>
                        <button class="ver-btn">VER</button>
                    </div>
                    <div class="data-item">
                        <span>DOCUMENTOS SST-SGA</span>
                        <button class="ver-btn">VER</button>
                    </div>
                    <div class="data-item">
                        <span>AFILIACIONES</span>
                        <button class="ver-btn">VER</button>
                    </div>
                    <div class="data-item">
                        <span>FINALIZAR CONTRATACIÓN</span>
                        <button class="ver-btn">VER</button>
                    </div>
                </div>
            </div>

            <div class="buttons">
                <a href="principal.jsp" class="btn-volver">VOLVER</a>
            </div>
        </div>
    </body>
</html>
