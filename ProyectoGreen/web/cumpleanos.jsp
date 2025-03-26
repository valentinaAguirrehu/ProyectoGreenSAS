<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.Period"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<%@page import="clases.Cargo"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>



<%!
    // Función para obtener el nombre del mes en español
    String obtenerMesEnEspanol(int mesNumero) {
        String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
            "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
        return meses[mesNumero - 1];
    }
%>

<%
    // Obtener el mes desde la URL (si existe)
    String mesParametro = request.getParameter("mes");
    int mesNumero = (mesParametro != null) ? Integer.parseInt(mesParametro) : LocalDate.now().getMonthValue();
    String mesActual = obtenerMesEnEspanol(mesNumero);

    // Obtener lista de personas nacidas en el mes seleccionado
    List<Persona> datos = Persona.getListaEnObjetos(null, null);
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDate fechaActual = LocalDate.now();

    StringBuilder lista = new StringBuilder();

    for (Persona persona : datos) {
        try {
            if (persona.getFechaNacimiento() != null && !persona.getFechaNacimiento().isEmpty()) {
                LocalDate fechaNacimiento = LocalDate.parse(persona.getFechaNacimiento(), formatter);

                // Filtrar solo los que cumplen años en el mes seleccionado
                if (fechaNacimiento.getMonthValue() == mesNumero) {
                    int edad = Period.between(fechaNacimiento, fechaActual).getYears();

                    // Obtener el nombre del cargo
                    String nombreCargo = "Sin cargo";
                    if (persona.getIdCargo() != null) {
                        Cargo cargo = new Cargo(persona.getIdCargo());
                        nombreCargo = cargo.getNombre();
                    }

                    lista.append("<tr>");
                    lista.append("<td align='center'><b>").append(fechaNacimiento.getDayOfMonth()).append("</b></td>");
                    lista.append("<td>").append(persona.getNombres()).append(" ").append(persona.getApellidos()).append("</td>");
                    lista.append("<td align='center'>").append(edad).append("</td>");
                    lista.append("<td align='center'>").append(persona.getFechaNacimiento()).append("</td>");
                    lista.append("<td>").append(nombreCargo).append("</td>");
                    lista.append("<td align='center'><a href='#'><img src='presentacion/iconos/documentoId.png' width='20'></a></td>");
                    lista.append("</tr>");
                }
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='6' style='color:red;'>Error procesando la fecha de nacimiento de " + persona.getNombres() + "</td></tr>");
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Cumpleañeros</title>
        <link rel="stylesheet" href="presentacion/style-Cumpleanos.css">
    </head>

    <%@ include file="menu.jsp" %>

    <div class="content">
        <body>
            <div id="tituloMes">
                <h1>CUMPLEAÑEROS DEL MES</h1>
                <div class="mes-con-iconos">
                    <img src="presentacion/iconos/pastel.png" alt="Decoración Pastel" class="icono-titulo">
                    <h2><%= mesActual%></h2>
                    <img src="presentacion/iconos/pastel.png" alt="Decoración Pastel" class="icono-titulo">
                </div>
            </div>

            <table id="tablaCumpleanos">
                <thead>
                    <tr>
                        <th>Día</th>
                        <th>Nombre</th>
                        <th>Edad</th>
                        <th>Fecha de nacimiento</th>
                        <th>Cargo</th>
                        <th>Documento de identidad</th>
                    </tr>
                </thead>
                <tbody>
                    <%= lista.toString()%>
                </tbody>
            </table>


            <!-- Botones de navegación -->
            <div class="buttons">
                <img src="presentacion/iconos/izquierda.png" alt="Mes Anterior" class="icono" onclick="irAlMesAnterior()">
                <img src="presentacion/iconos/derecha.png" alt="Siguiente Mes" class="icono" onclick="irAlSiguienteMes()">
            </div>
    </div>

    <script>
        let mesActualJS = <%= mesNumero%>;
        let mesInicial = new Date().getMonth() + 1; // Mes actual en JavaScript (1-12)

        let limiteSuperior = mesInicial + 3;
        let limiteInferior = mesInicial - 3;

        // Ajustar límites para manejar cambio de año
        if (limiteInferior < 1)
            limiteInferior += 12;
        if (limiteSuperior > 12)
            limiteSuperior -= 12;

        function irAlSiguienteMes() {
            // Si ya alcanzó el límite de 3 meses adelante, mostrar alerta
            if (mesActualJS === limiteSuperior || (mesInicial > 9 && mesActualJS === 3)) {
                alert("Solo se puede visualizar hasta tres meses posteriores al mes actual.");
            } else {
                mesActualJS = (mesActualJS % 12) + 1; // Avanza al siguiente mes
                window.location.href = "cumpleanos.jsp?mes=" + mesActualJS;
            }
        }

        function irAlMesAnterior() {
            // Si ya alcanzó el límite de 3 meses atrás, mostrar alerta
            if (mesActualJS === limiteInferior || (mesInicial < 4 && mesActualJS === 10)) {
                alert("Solo se puede visualizar hasta tres meses anteriores al mes actual.");
            } else {
                mesActualJS = (mesActualJS - 1 < 1) ? 12 : mesActualJS - 1; // Retrocede un mes correctamente
                window.location.href = "cumpleanos.jsp?mes=" + mesActualJS;
            }
        }
    </script>
</body>
</html>