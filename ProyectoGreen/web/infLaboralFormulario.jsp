<%-- 
    Document   : informacionLaboralFormulario
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>

<%@page import="clases.InformacionLaboral"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="clases.Cargo"%>



<%
    
    String accion = request.getParameter("accion");
    // Recuperar la identificación desde la URL o el formulario anterior
    String identificacion = request.getParameter("identificacion");
    // Instancia vacía con la identificación por si no se encuentra en BD
    System.out.println(" Entrando a infLaboralActualizar.jsp con identificacion=" + identificacion + " y accion=" + accion);
    InformacionLaboral informacionLaboral = new InformacionLaboral(identificacion);

    if (accion == null) {
        accion = "Adicionar"; // Cambiar a Adicionar si aún no se ha guardado o el boton da null
    }
    
    // Validar que la identificación no sea nula o vacía
    if (identificacion != null && !identificacion.isEmpty()) {
        session.setAttribute("identificacion", identificacion);  // Almacenar en sesión
    }
    // Solo intenta obtener de la BD si la acción es "Modificar"
    // Verifica si la acción a realizar es "Modificar"
    
    if ("Modificar".equals(accion)) {
    // Llama al método estático getInformacionPorIdentificacion de la clase InformacionLaboral
    // para obtener los datos laborales de la persona identificada por 'identificacion'
    InformacionLaboral tmp = InformacionLaboral.getInformacionPorIdentificacion(identificacion);
    // Si la información laboral se encontró (es decir, 'tmp' no es null)
    if (tmp != null) {
        // Asigna los datos obtenidos a la variable 'informacionLaboral'
        // Esto permite trabajar con la información laboral de la persona para modificarla
        informacionLaboral = tmp;
    }
}

%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../menu.jsp" %>

<head>
    <link rel="stylesheet" href="presentacion/style-FormularioColaboradores.css">
</head>
<body>

    <div class="content">
        <h3><%= (accion != null ? accion.toUpperCase() : "ACCION DESCONOCIDA")%> COLABORADOR</h3>
        <form name="formularioInfLaboral" method="post" action="infLaboralActualizar.jsp" onsubmit="obtenerDatosHijos(); pasarIdentificacion(); enviarDatos(); return false; redirigirDespuesGuardar();">

            <h1>Informacion laboral</h1>
            <table border="1">
                <tr>
                    <td><label for="identificacion">Identificación:</label></td>
                    <td>
                        <!-- Mostrar identificación recibida en readonly -->
                        <input type="text" name="identificacion" id="identificacion" value="<%= identificacion%>" readonly />

                        <!-- También enviarla como campo oculto para el UPDATE -->
                        <input type="hidden" name="identificacionAnterior" value="<%= informacionLaboral.getIdentificacion()%>">

                        <!-- Campo oculto para la acción -->
                        <input type="hidden" name="accion" id="accionHidden" value="<%=accion%>">
                    </td>
                </tr>
                <tr>
                    <th>Fecha de ingreso empresa<span style="color: red;">*</span></th>
                    <td>
                        <input type="date" name="fechaIngreso" value="<%= (informacionLaboral != null && informacionLaboral.getFechaIngreso() != null) ? informacionLaboral.getFechaIngreso() : ""%>" required>
                    </td>
                </tr>
                <tr>
                    <td><label for="fechaIngreso">Fecha Ingreso:</label></td>
                    <td><input type="text" name="fechaIngreso" id="fechaIngreso" value="<%= informacionLaboral.getFechaIngreso()%>" /></td>
                </tr>
                <tr>
                    <td><label for="fechaRetiro">Fecha Retiro:</label></td>
                    <td><input type="text" name="fechaRetiro" id="fechaRetiro" value="<%= informacionLaboral.getFechaRetiro()%>" /></td>
                </tr>
                <tr>
                    <td><label for="fechaTerPriContrato">Duración del primer contrato:</label></td>
                    <td>
                        <input type="date" name="fechaTerPriContrato" id="fechaTerPriContrato" 
                               value="<%= (informacionLaboral != null && informacionLaboral.getFechaTerPriContrato() != null) ? informacionLaboral.getFechaTerPriContrato() : "" %>" />
                        <!-- Impresión para verificar el valor -->
                        <%= (informacionLaboral != null && informacionLaboral.getFechaTerPriContrato() != null) ? informacionLaboral.getFechaTerPriContrato() : "Valor no encontrado" %>
                    </td>
                </tr>

                <tr>
                    <td><label for="unidadNegocio">Unidad de Negocio:</label></td>
                    <td>
                        <!-- Asignamos el valor dentro del atributo 'value' para que se muestre dentro del campo -->
                        <input type="text" name="unidadNegocio" id="unidadNegocio" 
                               value="<%= (informacionLaboral != null && informacionLaboral.getUnidadNegocio() != null) ? informacionLaboral.getUnidadNegocio() : "" %>" />
                    </td>
                </tr>

                <tr>
                    <th>Centro Costos:<span style="color: red;">*</span></th>
                    <td><input type="text" name="centroCostos" id="centroCostos" value="<%= informacionLaboral.getCentroCostos()%>" /></td>
                </tr>
                <tr>
                    <th>Lugar de trabajo<span style="color: red;">*</span></th>
                    <td><input type="text" name="establecimiento" id="establecimiento" value="<%= informacionLaboral.getEstablecimiento()%>" /></td>
                </tr>
                <tr>
                    <th>Area<span style="color: red;">*</span></th>
                    <td><input type="text" name="area" id="area" value="<%= informacionLaboral.getArea()%>" /></td>
                </tr>
            </table>

            <div class="botones-container">
                <input type="hidden" name="identificacionAnterior" value="<%=identificacion%>">
                <input type="submit" name="accion" value="<%=accion%>">
                <input type="button" value="Cancelar" onClick="window.history.back()">
            </div>

            <input type="hidden" id="identificacionHidden" name="identificacionHidden">
            <button type="button" onclick="irASiguiente()">Siguiente: Información tallas</button>


        </form>
    </div>
</body>
</html>


<script>
    function irASiguiente() {
        var identificacionVisible = document.getElementById("identificacion").value;
        var accion = document.getElementById("accionHidden").value; // Obtener la acción
        document.getElementById("identificacionHidden").value = identificacionVisible;

        // Redirigir a la siguiente página pasando los parámetros correctos
        window.location.href = "tallaFormulario.jsp?identificacion=" + encodeURIComponent(identificacionVisible) + "&accion=" + encodeURIComponent(accion);
    }

    // Obtener las opciones del select y guardarlas en un array
    const listaCargos = [];
    document.querySelectorAll("#idCargo option").forEach(option => {
        if (option.value.trim() !== "") {
            listaCargos.push(option.textContent.trim());
        }
    });

    function filtrarCargos() {
        let input = document.getElementById("tipoCargo");
        let sugerenciasDiv = document.getElementById("sugerenciasCargo");
        let texto = input.value.toLowerCase();

        // Limpiar sugerencias previas
        sugerenciasDiv.innerHTML = "";

        if (texto === "") {
            sugerenciasDiv.style.display = "none";
            return;
        }

        // Filtrar opciones que comiencen con lo escrito
        let sugerencia = listaCargos.find(cargo => cargo.toLowerCase().startsWith(texto));

        if (sugerencia) {
            input.value = sugerencia; // Autocompleta el input
        }

        sugerenciasDiv.style.display = "none";
    }



    // Función para precargar la unidad de negocio al seleccionar un establecimiento
    function precargarUnidadNegocio() {
        var establecimiento = document.getElementById("establecimiento").value;
        var unidadNegocio = document.getElementById("unidadNegocio");

        // Mapeo de establecimientos a unidades de negocio
        var unidades = {
            "Avenida": "Green S.A.S. RPS",
            "Principal": "Green S.A.S. RPS",
            "Centro": "Green S.A.S. RPS",
            "Unicentro": "Green S.A.S. RPS",
            "Centro de Procesos": "Green S.A.S. RPS",
            "Teleoperaciones": "Green S.A.S. RPS",
            "Juanambu": "Green S.A.S. EDS",
            "Terminal Americano": "Green S.A.S. EDS",
            "Puente": "Green S.A.S. EDS",
            "Cano Bajo": "Green S.A.S. EDS",
            "GreenField": "Green S.A.S."
        };

        // Asignar unidad de negocio basada en el establecimiento seleccionado
        unidadNegocio.value = unidades[establecimiento] || "";
    }

    // Precargar la unidad de negocio al cargar la página
    document.addEventListener("DOMContentLoaded", precargarUnidadNegocio);



    function validarNumerico(inputName) {
        let input = document.getElementsByName(inputName)[0];
        if (!/^\d*$/.test(input.value)) { // Permite solo números
            alert("Por favor, ingrese solo números en este campo.");
            input.value = ""; // Limpia el campo si tiene caracteres no permitidos
            input.focus();
        }
    }

    function soloNumeros(event) {
        let codigo = event.which || event.keyCode;
        return (codigo >= 48 && codigo <= 57); // Permite solo números (0-9)
    }

    // Ejecutar la función al cargar la página para mostrar u ocultar correctamente
    window.onload = function () {
        mostrarOcultarVehiculo();
        cargarUnidadNegocio();

    };
</script>