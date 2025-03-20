<%-- 
    Document   : permisos
    Created on : 17 mar 2025, 14:54:20
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>

<%
    Administrador administrador = (Administrador) session.getAttribute("usuario");

    String permisoEliminar = "N";
    String permisoEditar = "N";
    String permisoAgregar = "N";
    String permisoLeer = "N";
    String permisoDescargar = "N";

    if (administrador != null) {
        permisoEliminar = administrador.getpEliminar();
        permisoEditar = administrador.getpEditar();
        permisoAgregar = administrador.getpAgregar();
        permisoLeer = administrador.getpLeer();
        permisoDescargar = administrador.getpDescargar();
    }
%>

<script>
    console.log("El script se está ejecutando");

    document.addEventListener("DOMContentLoaded", function () {
        let pEliminar = "<%= permisoEliminar %>";
        let pEditar = "<%= permisoEditar %>";
        let pAgregar = "<%= permisoAgregar %>";
        let pLeer = "<%= permisoLeer %>";
        let pDescargar = "<%= permisoDescargar %>";

        console.log("Permisos recibidos en JS:", pEliminar, pEditar, pAgregar, pLeer, pDescargar);

        if (pEliminar !== "S") {
            document.querySelectorAll(".iconoEliminar").forEach(icono => {
                icono.style.pointerEvents = "none";
                icono.style.opacity = "0.5";
                icono.title = "No tiene permiso para eliminar";
            });
        }

        if (pEditar !== "S") {
            document.querySelectorAll(".iconoEditar").forEach(icono => {
                icono.style.pointerEvents = "none";
                icono.style.opacity = "0.5";
                icono.title = "No tiene permiso para editar";
            });
        }

        if (pAgregar !== "S") {
            document.querySelectorAll(".iconoAgregar").forEach(icono => {
                icono.style.pointerEvents = "none";
                icono.style.opacity = "0.5";
                icono.style.cursor = "not-allowed";
                icono.title = "No tiene permiso para agregar";
            });
        }

        if (pLeer !== "S") {
            document.querySelectorAll(".iconoLeer").forEach(icono => {
                icono.style.pointerEvents = "none";
                icono.style.opacity = "0.5";
                icono.title = "No tiene permiso para ver detalles de esta información";
            });
        }

        if (pDescargar !== "S") {
            document.querySelectorAll(".iconoDescargar").forEach(icono => {
                icono.style.pointerEvents = "none";
                icono.style.opacity = "0.5";
                icono.style.cursor = "not-allowed";
                icono.title = "No tiene permiso para descargar";
            });
        }
    });
</script>
