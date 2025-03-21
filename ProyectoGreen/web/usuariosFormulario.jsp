<%@page import="clases.Administrador"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String accion = request.getParameter("accion");
    String identificacion = request.getParameter("identificacion");
    Administrador usuario = new Administrador();
    if (accion.equals("Modificar")) {
        usuario = new Administrador(identificacion);
    }
%>

<h3 class="titulo"><%=accion.toUpperCase()%> USUARIO</h3>
<link rel="stylesheet" href="presentacion/style-UsuariosFormulario.css">
<form name="formulario" method="post" action="usuariosActualizar.jsp">
    <table class="table" border="1">
        <tr>
            <th>Identificación</th>
            <td><input class="recuadro" type="text" name="identificacion" maxlength="12" value="<%=usuario.getIdentificacion()%>" size="50" required></td>
        </tr>
        <tr>
            <th>Nombres</th>
            <td><input class="recuadro" type="text" name="nombres" value="<%=usuario.getNombres()%>" size="50" maxlength="40" required></td>
        </tr>
        <tr>
            <th>Celular</th>
            <td><input class="recuadro" type="tel" name="celular" value="<%=usuario.getCelular()%>" size="50" maxlength="40" required></td>
        </tr>
        <tr>
            <th>Email</th>
            <td><input class="recuadro" type="email" name="email" value="<%=usuario.getEmail()%>" size="50" maxlength="40" required></td>
        </tr>
        <tr>
            <th>Permisos</th>
            <td>
                <!-- Contenedor de permisos en dos columnas -->
                <div class="permiso-container">
                    <!-- Primera columna -->
                    <div class="permiso-item">
                        <input type="checkbox" class="permiso" id="pLeer" name="pLeer" value="S" <%= "S".equals(usuario.getpLeer()) ? "checked" : ""%>>
                        <label for="pLeer">Leer</label>
                    </div>
                    <div class="permiso-item">
                        <input type="checkbox" class="permiso" id="pEliminar" name="pEliminar" value="S" <%= "S".equals(usuario.getpEliminar()) ? "checked" : ""%>>
                        <label for="pEliminar">Eliminar</label>
                    </div>

                    <div class="permiso-item">
                        <input type="checkbox" class="permiso" id="pEditar" name="pEditar" value="S" <%= "S".equals(usuario.getpEditar()) ? "checked" : ""%>>
                        <label for="pEditar">Editar</label>
                    </div>
                    <div class="permiso-item">
                        <input type="checkbox" class="permiso" id="pDescargar" name="pDescargar" value="S" <%= "S".equals(usuario.getpDescargar()) ? "checked" : ""%>>
                        <label for="pDescargar">Descargar</label>
                    </div>

                    <div class="permiso-item">
                        <input type="checkbox" class="permiso" id="pAgregar" name="pAgregar" value="S" <%= "S".equals(usuario.getpAgregar()) ? "checked" : ""%>>
                        <label for="pAgregar">Agregar</label>
                    </div>
                    <div class="permiso-item">   <!-- Checkbox para seleccionar todos -->
                        <input type="checkbox" id="selectAll"> 
                        <label for="selectAll">Seleccionar todos</label>
                    </div>
                </div>
            </td>

        </tr>
        <tr>
            <th>Estado</th>
            <td>
                <select class="recuadro" name="estado">
                    <option value="Activo" <%= "Activo".equals(usuario.getEstado()) ? "selected" : ""%>>Activo</option>
                    <option value="Inactivo" <%= "Inactivo".equals(usuario.getEstado()) ? "selected" : ""%>>Inactivo</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>Contraseña</th>
            <td><input class="recuadro" type="password" name="clave" value="<%=usuario.getClave()%>" size="50" maxlength="40" required></td>
        </tr>
    </table>

    <input type="hidden" name="identificacionAnterior" value="<%=usuario.getIdentificacion()%>">
    <input type="hidden" name="accion" value="<%=accion%>">
    <input class="submit" type="submit" value="Guardar">
    <input class="button" type="button" value="Cancelar" onClick="window.history.back()">
</form>

<script>
    document.getElementById("selectAll").addEventListener("change", function () {
        let checkboxes = document.querySelectorAll(".permiso");
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    document.querySelectorAll(".permiso").forEach(checkbox => {
        checkbox.addEventListener("change", function () {
            let allChecked = document.querySelectorAll(".permiso:checked").length === document.querySelectorAll(".permiso").length;
            document.getElementById("selectAll").checked = allChecked;
        });
    });

    document.querySelector("form").addEventListener("submit", function () {
        let permisos = document.querySelectorAll(".permiso");
        permisos.forEach(permiso => {
            if (!permiso.checked) {
                let hiddenInput = document.createElement("input");
                hiddenInput.type = "hidden";
                hiddenInput.name = permiso.name;
                hiddenInput.value = "N";
                this.appendChild(hiddenInput);
            }
        });
    });

    window.onload = function () {
        let permisos = document.querySelectorAll(".permiso");
        let allChecked = Array.from(permisos).every(permiso => permiso.checked);
        document.getElementById("selectAll").checked = allChecked;
    };
</script>
