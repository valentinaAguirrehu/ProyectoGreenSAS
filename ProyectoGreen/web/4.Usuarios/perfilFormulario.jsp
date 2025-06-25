<%-- 
    Document   : perfilFormulario
    Created on : 18-mar-2025
    Author     : Angie
--%>

<%@page import="clases.Administrador"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    HttpSession sesion = request.getSession();
    Administrador usuarioActual = (Administrador) sesion.getAttribute("usuario");
    if (usuarioActual == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="../presentacion/style-Perfil.css">
    </head>

    <%@ include file="../menu.jsp" %>

    <body>
        <div class="content">
            <div class="card">
                <div class="titulo"><h2>MODIFICAR PERFIL</h2></div>

                <div class="card-body">
                    <form method="post" action="perfilActualizar.jsp" onsubmit="return validarFormulario();">

                        <!-- Identificación -->
                        <div class="form-group">
                        <label for="identificacion">Identificación:</label>
                        <input type="text" id="identificacion" name="identificacion"
                               value="<%= usuarioActual.getIdentificacion()%>" required>
                    </div>

                        <div class="form-group">
                            <label for="nombres">Nombres:</label>
                            <input type="text" name="nombres" id="nombres" value="<%=usuarioActual.getNombres()%>" required>
                        </div>

                        <input type="text" name="celular" id="celular" value="<%=usuarioActual.getCelular()%>"
                               maxlength="10" pattern="\d{10}" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required>

                        <div class="form-group">
                            <label for="email">Correo electrónico:</label>
                            <input type="email" id="email" name="email"
                                   value="<%= usuarioActual.getEmail()%>" required>
                        </div>

                        <div class="form-group">
                            <label><input type="checkbox" id="toggleCambioClave"> Cambiar contraseña</label>
                        </div>

                        <div id="cambioClaveSection" style="display:none;">
                            <div class="form-group">
                                <label for="clave">Nueva contraseña:</label>
                                <input type="password" id="clave" disabled oninput="validarClave();verificarCoincidencia();">
                            </div>

                            <div class="form-group">
                                <label for="confirmarClave">Confirmar contraseña:</label>
                                <input type="password" id="confirmarClave" disabled oninput="verificarCoincidencia();">
                            </div>

                            <div id="requisitosClave">
                                <p>La contraseña debe cumplir:</p>
                                <ul>
                                    <li id="minimoCaracteres">Mínimo 8 caracteres</li>
                                    <li id="letraMayuscula">Una letra mayúscula</li>
                                    <li id="letraMinuscula">Una letra minúscula</li>
                                    <li id="numero">Un número</li>
                                    <li id="coincidencia">Las contraseñas deben coincidir</li>
                                </ul>
                            </div>
                        </div>

                        <div class="btn-container">
                            <button type="submit" class="btn-adicionar" name="accion" value="Modificar">
                                Guardar Cambios
                            </button>
                            <button type="button" class="btn-eliminar" onclick="window.history.back();">
                                Cancelar
                            </button>
                        </div>

                        <input type="hidden" name="claveActual" value="<%= usuarioActual.getClave()%>">
                        <input type="hidden" name="identificacionAnterior" value="<%= usuarioActual.getIdentificacion()%>">
                    </form>
                </div>
            </div>
        </div>

        <script>
            document.getElementById("toggleCambioClave").addEventListener("change", () => {
                const checked = document.getElementById("toggleCambioClave").checked;
                const clave = document.getElementById("clave");
                const confirmar = document.getElementById("confirmarClave");
                const section = document.getElementById("cambioClaveSection");

                if (checked) {
                    section.style.display = "block";
                    clave.disabled = confirmar.disabled = false;
                    clave.required = confirmar.required = true;
                    clave.setAttribute("name", "clave");
                    confirmar.setAttribute("name", "confirmarClave");
                } else {
                    section.style.display = "none";
                    clave.disabled = confirmar.disabled = true;
                    clave.required = confirmar.required = false;
                    clave.removeAttribute("name");
                    confirmar.removeAttribute("name");
                    clave.value = confirmar.value = "";
                }
            });

            function validarClave() {
                const clave = document.getElementById("clave").value;
                document.getElementById("minimoCaracteres").style.color = (clave.length >= 8) ? "green" : "red";
                document.getElementById("letraMayuscula").style.color = /[A-Z]/.test(clave) ? "green" : "red";
                document.getElementById("letraMinuscula").style.color = /[a-z]/.test(clave) ? "green" : "red";
                document.getElementById("numero").style.color = /\d/.test(clave) ? "green" : "red";
            }

            function verificarCoincidencia() {
                const c1 = document.getElementById("clave").value;
                const c2 = document.getElementById("confirmarClave").value;
                document.getElementById("coincidencia").style.color = (c1 === c2) ? "green" : "red";
            }

            function validarFormulario() {
                const checked = document.getElementById("toggleCambioClave").checked;
                if (!checked)
                    return true;

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
    </body>
</html>


