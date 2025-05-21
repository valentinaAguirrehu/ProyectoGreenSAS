<%-- 
    Document   : tallaActualizar
    Created on : 8/03/2025, 02:18:59 PM
    Author     : Mary
--%>
<%@page import="clases.Talla"%>
<%@page import="clasesGenericas.ConectorBD"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Capturar acción y valores del formulario
    String accion = request.getParameter("accion");
    String identificacionAnterior = request.getParameter("identificacionAnterior");

    // Crear objeto InformacionLaboral y asignar valores del formulario
    Talla talla = new Talla();
    talla.setIdentificacion(request.getParameter("identificacion"));
    talla.setTallaCamisa(request.getParameter("tallaCamisa"));
    talla.setTallaChaqueta(request.getParameter("tallaChaqueta"));
    talla.setTallaO(request.getParameter("tallaO"));
    talla.setTallaPantalon(request.getParameter("tallaPantalon"));
    talla.setTallaCalzado(request.getParameter("tallaCalzado"));
    talla.setTallaGuantes(request.getParameter("tallaGuantes"));
    talla.setTallaBuzo(request.getParameter("tallaBuzo"));
   

    // Acción según el botón presionado
    switch (accion) {
        case "Adicionar":
            // Verificar si la identificación ya existe en la base de datos
            if (talla.getTallaPorIdentificacion(talla.getIdentificacion()) == null) {
                talla.grabar(); // Llama al método de grabar si es una persona nueva
            } else {
                // Si ya existe, muestra un mensaje de error o realiza alguna acción (opcional)
                out.println("<p>Error: La identificación ya existe en la base de datos.</p>");
            }
            break;

        case "Modificar":
            // Si la persona ya existe, proceder con la modificación
            talla.modificar(identificacionAnterior); // Llama al método de modificar
            break;

        case "Eliminar":
            // Llama al método de eliminar
            talla.eliminar();
            break;
    }


%>

<script type="text/javascript">
    document.location = "persona.jsp";
</script>