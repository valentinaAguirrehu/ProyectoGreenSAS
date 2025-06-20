<%-- 
    Document   : prendaFormulario
    Created on : 10 abr 2025, 14:59:40
    Author     : Angie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="clases.Prenda" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="clasesGenericas.ConectorBD" %>

<%
    String accion = request.getParameter("accion");
    String id = request.getParameter("id");
    Prenda prenda = new Prenda();
    prenda.setIdPrenda("Sin generar");

    if ("Modificar".equals(accion)) {
        prenda = new Prenda(id);
    }

    // Obtener tipos de prenda
    ResultSet tipos = ConectorBD.consultar("SELECT id_tipo_prenda, nombre FROM tipoPrenda");
%>

<%@ include file="../menu.jsp" %>

<head>
    <link rel="stylesheet" href="../presentacion/style-CargoFormulario.css">
</head>
<body>
    <div class="content">
        <form name="formulario" method="post" action="prendaActualizar.jsp" enctype="multipart/form-data">
            <table class="table">
                <h3 class="titulo"><%=accion.toUpperCase()%> PRENDA</h3>

                <tr>
                    <th>Tipo de prenda</th>
                    <td>
                        <select class="recuadro" name="id_tipo_prenda" required>
                            <option value="">Seleccione una opción</option>
                            <%
                                while (tipos.next()) {
                                    String idTipo = tipos.getString("id_tipo_prenda");
                                    String nombreTipo = tipos.getString("nombre");
                                    String selected = idTipo.equals(prenda.getIdTipoPrenda()) ? "selected" : "";
                            %>
                                <option value="<%=idTipo%>" <%=selected%>><%=nombreTipo%></option>
                            <%
                                }
                                tipos.close();
                            %>
                        </select>
                    </td>
                </tr>

                <tr>
                    <th>Nombre de la prenda</th>
                    <td>
                        <input class="recuadro" type="text" name="nombre" value="<%=prenda.getNombre()%>" maxlength="100" size="40" required />
                    </td>
                </tr>
            </table> 

            <input type="hidden" name="id" value="<%=prenda.getIdPrenda()%>">
            <div class="button-container">
                <input class="submit" type="submit" name="accion" value="<%=accion%>">
                <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
            </div>
        </form>
    </div>
</body>   
