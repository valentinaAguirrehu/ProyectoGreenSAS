/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import utils.SessionTracker;

@WebServlet("/admin/logoutUser")
public class LogoutUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idUsuario = request.getParameter("idUsuario");
        HttpSession sesionObjetivo = SessionTracker.obtenerSesion(idUsuario);

        if (sesionObjetivo != null) {
            sesionObjetivo.invalidate();          // <<– cierra la sesión YA
        }

        // Redirige de regreso al panel de admin (ajusta a tu ruta real)
        response.sendRedirect(request.getContextPath() + "/4.Usuarios/usuarios.jsp?ok=1");
    }
}
