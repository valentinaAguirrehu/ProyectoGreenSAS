<%--  usuariosFormulario.jsp  --%>
<%@page import="clases.Administrador"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String accion = request.getParameter("accion");            
    String identificacion = request.getParameter("identificacion");
    Administrador usuario = "Modificar".equals(accion) ? new Administrador(identificacion)
            : new Administrador();
    boolean esModificar = "Modificar".equals(accion);
%>

<%@ include file="../menu.jsp" %>

<link rel="stylesheet" href="../presentacion/style-UsuariosFormulario.css">

<div class="content">
    <form name="formulario" method="post" action="usuariosActualizar.jsp" onsubmit="return validarFormulario();">
        <h3 class="titulo"><%= accion.toUpperCase()%> USUARIO</h3>

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
                <th>Correo electrónico</th>
                <td><input class="recuadro" type="email" name="email" value="<%=usuario.getEmail()%>" size="50" maxlength="40" required></td>
            </tr>
            <tr>
                <th>Permisos</th>
                <td>
                    <div class="permiso-container">
                        <!-- pLeer siempre activo -->
                        <div class="permiso-item">
                            <input type="checkbox" id="pLeer" class="permiso" name="pLeer" value="S" checked readonly onclick="return false;">
                            <label for="pLeer">Leer (obligatorio)</label>
                            <input type="hidden" name="pLeer" value="S">
                        </div>
                        <div class="permiso-item">
                            <input type="checkbox" class="permiso" id="pEliminar" name="pEliminar" value="S"
                                   <%= "S".equals(usuario.getpEliminar()) ? "checked" : ""%>>
                            <label for="pEliminar">Eliminar</label>
                        </div>

                        <div class="permiso-item">
                            <input type="checkbox" class="permiso" id="pEditar" name="pEditar" value="S"
                                   <%= "S".equals(usuario.getpEditar()) ? "checked" : ""%>>
                            <label for="pEditar">Editar</label>
                        </div>

                        <div class="permiso-item">
                            <input type="checkbox" class="permiso" id="pDescargar" name="pDescargar" value="S"
                                   <%= "S".equals(usuario.getpDescargar()) ? "checked" : ""%>>
                            <label for="pDescargar">Ver y descargar</label>
                        </div>

                        <div class="permiso-item">
                            <input type="checkbox" class="permiso" id="pAgregar" name="pAgregar" value="S"
                                   <%= "S".equals(usuario.getpAgregar()) ? "checked" : ""%>>
                            <label for="pAgregar">Agregar</label>
                        </div>

                        <div class="permiso-item">
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
                        <option value="Activo"   <%= "Activo".equals(usuario.getEstado()) ? "selected" : ""%>>Activo</option>
                        <option value="Inactivo" <%= "Inactivo".equals(usuario.getEstado()) ? "selected" : ""%>>Inactivo</option>
                    </select>
                </td>
            </tr>

            <% if (esModificar) { %>
            <tr>
                <th>
                    <label><input type="checkbox" id="toggleCambioClave"> Cambiar contraseña</label>
                </th>
                <td></td>
            </tr>
            <% }%>

            <tr id="filaClave" style="<%= esModificar ? "display:none;" : ""%>">
                <th>Nueva contraseña</th>
                <td><input class="recuadro" type="password" id="clave"
                           <%= esModificar ? "disabled" : "required"%>
                           onkeyup="validarClave();verificarCoincidencia();"></td>
            </tr>
            <tr id="filaConfirmar" style="<%= esModificar ? "display:none;" : ""%>">
                <th>Confirmar contraseña</th>
                <td><input class="recuadro" type="password" id="confirmarClave"
                           <%= esModificar ? "disabled" : "required"%>
                           onkeyup="verificarCoincidencia();"></td>
            </tr>
        </table>

        <!-- Requisitos -->
        <div id="requisitosClave" style="<%= esModificar ? "display:none;" : ""%>">
            <p>La contraseña debe cumplir los siguientes requisitos:</p>
            <ul>
                <li id="minimoCaracteres">Mínimo 8 caracteres</li>
                <li id="letraMayuscula">Una letra mayúscula</li>
                <li id="letraMinuscula">Una letra minúscula</li>
                <li id="numero">Un número</li>
                <li id="coincidencia">Las contraseñas deben coincidir</li>
            </ul>
        </div>

        <input type="hidden" name="identificacionAnterior" value="<%= usuario.getIdentificacion()%>">
        <input type="hidden" name="accion" value="<%= accion%>">
        <% if (esModificar) {%>
        <input type="hidden" name="claveActual" value="<%= usuario.getClave()%>">
        <% } %>

        <input class="submit"  type="submit"  value="Guardar">
        <input class="button"  type="button"  value="Cancelar" onclick="window.history.back();">
    </form>
</div>

<script>

    document.getElementById("selectAll").addEventListener("change", function () {
        document.querySelectorAll(".permiso:not(#pLeer)").forEach(cb => cb.checked = this.checked);
    });
    document.querySelectorAll(".permiso").forEach(cb => {
        cb.addEventListener("change", () => {
            const total = document.querySelectorAll(".permiso:not(#pLeer)").length;
            const checked = document.querySelectorAll(".permiso:not(#pLeer):checked").length;
            document.getElementById("selectAll").checked = total === checked;
        });
    });

    document.querySelector("form").addEventListener("submit", function () {
        document.querySelectorAll(".permiso").forEach(cb => {
            if (!cb.checked) {
                const hidden = document.createElement("input");
                hidden.type = "hidden";
                hidden.name = cb.name;
                hidden.value = "N";
                this.appendChild(hidden);
            }
        });

        const claveInput = document.getElementById("clave");
        if (claveInput.name === "clave") {
            const hidden = document.createElement("input");
            hidden.type = "hidden";
            hidden.name = "clave";
            hidden.value = claveInput.value;
            this.appendChild(hidden);

            const hidden2 = document.createElement("input");
            hidden2.type = "hidden";
            hidden2.name = "confirmarClave";
            hidden2.value = document.getElementById("confirmarClave").value;
            this.appendChild(hidden2);
        }
    });

    <% if (esModificar) { %>
    document.getElementById("toggleCambioClave").addEventListener("change", () => {
        const checked = document.getElementById("toggleCambioClave").checked;
        document.getElementById("filaClave").style.display = checked ? "" : "none";
        document.getElementById("filaConfirmar").style.display = checked ? "" : "none";
        document.getElementById("requisitosClave").style.display = checked ? "" : "none";

        const clave = document.getElementById("clave");
        const confirmar = document.getElementById("confirmarClave");

        if (checked) {
            clave.disabled = confirmar.disabled = false;
            clave.required = confirmar.required = true;
            clave.setAttribute("name", "clave");
            confirmar.setAttribute("name", "confirmarClave");
        } else {
            clave.disabled = confirmar.disabled = true;
            clave.required = confirmar.required = false;
            clave.removeAttribute("name");
            confirmar.removeAttribute("name");
            clave.value = confirmar.value = "";
        }
    });
    <% } %>

    /* === Validación de la clave === */
    function validarClave() {
        const clave = document.getElementById("clave").value;
        document.getElementById("minimoCaracteres").style.color = (clave.length >= 8) ? "green" : "red";
        document.getElementById("letraMayuscula").style.color = /[A-Z]/.test(clave) ? "green" : "red";
        document.getElementById("letraMinuscula").style.color = /[a-z]/.test(clave) ? "green" : "red";
        document.getElementById("numero").style.color = /\d/.test(clave) ? "green" : "red";
    }
    function verificarCoincidencia() {
        const igual = document.getElementById("clave").value === document.getElementById("confirmarClave").value;
        document.getElementById("coincidencia").style.color = igual ? "green" : "red";
    }

    /* === Validación global antes de enviar === */
    function validarFormulario() {
    <% if (esModificar) { %>
        if (!document.getElementById("toggleCambioClave").checked)
            return true;
    <% }%>

        const clave = document.getElementById("clave").value;
        const confirmar = document.getElementById("confirmarClave").value;

        if (clave.length < 8 || !/[A-Z]/.test(clave) || !/[a-z]/.test(clave) || !/\d/.test(clave)) {
            alert("La contraseña no cumple los requisitos.");
            return false;
        }
        if (clave !== confirmar) {
            alert("Las contraseñas no coinciden.");
            return false;
        }
        return true;
    }
</script>
