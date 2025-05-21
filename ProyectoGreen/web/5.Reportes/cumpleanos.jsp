<%@page import="clases.InformacionLaboral"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.Period"%>
<%@page import="java.util.List"%>
<%@page import="clases.Persona"%>
<%@page import="clases.DetallesHistoria"%>
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
    String mesParametro = request.getParameter("mes");
    int mesNumero = (mesParametro != null) ? Integer.parseInt(mesParametro) : LocalDate.now().getMonthValue();
    String mesActual = obtenerMesEnEspanol(mesNumero);

    List<Persona> datos = Persona.getListaEnObjetos(null, null);
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDate fechaActual = LocalDate.now();

    class Cumpleanero {

        Persona persona;
        LocalDate fechaNacimiento;
        int edad;
        String cargo;
        String establecimiento;
        String documentoPDF;

        Cumpleanero(Persona p, LocalDate fn, int edad, String cargo, String establecimiento, String doc) {
            this.persona = p;
            this.fechaNacimiento = fn;
            this.edad = edad;
            this.cargo = cargo;
            this.establecimiento = establecimiento;
            this.documentoPDF = doc;
        }
    }

    List<Cumpleanero> cumpleaneros = new java.util.ArrayList<>();

    for (Persona persona : datos) {
        try {
            if (persona.getFechaNacimiento() != null && !persona.getFechaNacimiento().isEmpty()) {
                LocalDate fechaNacimiento = LocalDate.parse(persona.getFechaNacimiento(), formatter);

                if (fechaNacimiento.getMonthValue() == mesNumero) {
                    int edad = Period.between(fechaNacimiento, fechaActual).getYears();

                    String nombreCargo = "Sin cargo";
                    if (persona.getIdCargo() != null) {
                        Cargo cargo = new Cargo(persona.getIdCargo());
                        nombreCargo = cargo.getNombre();
                    }

                    InformacionLaboral info = InformacionLaboral.getInformacionPorIdentificacion(persona.getIdentificacion());
                    String establecimiento = (info != null && info.getEstablecimiento() != null && !info.getEstablecimiento().isEmpty())
                            ? info.getEstablecimiento()
                            : "Sin establecimiento";

                    String documentoPDF = null;
                    String filtro = "idPersona = '" + persona.getIdentificacion() + "' AND tipo = 'documentoIdentidad'";
                    List<DetallesHistoria> docs = DetallesHistoria.getListaEnObjetos(filtro, null);
                    if (docs != null && !docs.isEmpty()) {
                        documentoPDF = docs.get(0).getDocumentoPDF();
                    }

                    cumpleaneros.add(new Cumpleanero(persona, fechaNacimiento, edad, nombreCargo, establecimiento, documentoPDF));
                }
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='7' style='color:red;'>Error con " + persona.getNombres() + "</td></tr>");
        }
    }

    java.util.Collections.sort(cumpleaneros, new java.util.Comparator<Cumpleanero>() {
        public int compare(Cumpleanero a, Cumpleanero b) {
            return Integer.compare(a.fechaNacimiento.getDayOfMonth(), b.fechaNacimiento.getDayOfMonth());
        }
    });

    StringBuilder lista = new StringBuilder();
    for (Cumpleanero c : cumpleaneros) {
        lista.append("<tr>");
        lista.append("<td align='center'><b>").append(c.fechaNacimiento.getDayOfMonth()).append("</b></td>");
        lista.append("<td>").append(c.persona.getNombres()).append(" ").append(c.persona.getApellidos()).append("</td>");
        lista.append("<td align='center'>").append(c.edad).append("</td>");
        lista.append("<td align='center'>").append(c.persona.getFechaNacimiento()).append("</td>");
        lista.append("<td>").append(c.cargo).append("</td>");
        lista.append("<td>").append(c.establecimiento).append("</td>");

        if (c.documentoPDF != null && !c.documentoPDF.isEmpty()) {
            lista.append("<td align='center'><a href='")
                    .append(c.documentoPDF)
                    .append("' target='_blank'><img src='../presentacion/iconos/documentoId.png' width='20'></a></td>");
        } else {
            lista.append("<td align='center'>No disponible</td>");
        }

        lista.append("</tr>");
    }

    int mesActualNumero = LocalDate.now().getMonthValue();
    int diferenciaMeses = Math.abs(mesNumero - mesActualNumero);

    // Para manejo circular tipo diciembre <-> enero
    if (diferenciaMeses > 6) {
        diferenciaMeses = 12 - diferenciaMeses;
    }

    if (diferenciaMeses > 3) {
%>
<script>
    alert("Solo se puede ver hasta tres meses antes o después del mes actual.");
    window.location.href = "?mes=<%= mesActualNumero%>";
</script>
<%
        return; // Detener el procesamiento
    }
%>


<!DOCTYPE html>
<html>
    <head>
        <title>Cumpleañeros</title>
        <link rel="stylesheet" href="../presentacion/style-Cumpleanos.css">
    </head>

    <%@ include file="../menu.jsp" %>

    <div class="content">
        <body>
            <div id="tituloMes">
                <h1>CUMPLEAÑEROS DEL MES</h1>
                <div class="mes-con-iconos">
                    <img src="../presentacion/iconos/pastel.png" alt="Decoración Pastel" class="icono-titulo">
                    <h2><%= mesActual%></h2>
                    <img src="../presentacion/iconos/pastel.png" alt="Decoración Pastel" class="icono-titulo">
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
                        <th>Establecimiento</th>
                        <th>Documento de identidad</th>
                    </tr>
                </thead>
                <tbody>
                    <%= cumpleaneros.isEmpty() ? "<tr><td colspan='7' align='center'><b>No hay cumpleañeros este mes</b></td></tr>" : lista.toString()%>
                </tbody>
            </table>

            <div class="buttons">
                <img src="../presentacion/iconos/izquierda.png" alt="Mes Anterior" class="icono" onclick="irAlMesAnterior()">
                <img src="../presentacion/iconos/derecha.png" alt="Siguiente Mes" class="icono" onclick="irAlSiguienteMes()">
            </div>
        </body>
    </div>

    <script>
        let mesActualJS = <%= mesNumero%>;
        function irAlSiguienteMes() {
            let siguiente = mesActualJS + 1;
            if (siguiente > 12)
                siguiente = 1;
            location.href = "?mes=" + siguiente;
        }

        function irAlMesAnterior() {
            let anterior = mesActualJS - 1;
            if (anterior < 1)
                anterior = 12;
            location.href = "?mes=" + anterior;
        }
    </script>
</html>
