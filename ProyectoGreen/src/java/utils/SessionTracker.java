package utils;

import javax.servlet.http.*;
import javax.servlet.annotation.WebListener;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;

@WebListener
public class SessionTracker implements HttpSessionListener {

    private static final Map<String, HttpSession> sesionesPorUsuario =
            new ConcurrentHashMap<>();

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        // Aquí no hacemos nada
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession s = se.getSession();
        String idUsuario = (String) s.getAttribute("ID_USUARIO");
        if (idUsuario != null) {
            sesionesPorUsuario.remove(idUsuario);
        }
    }

    /** Invoca esto justo después de un login exitoso */
    public static void registrarSesion(String idUsuario, HttpSession sesion) {
        sesionesPorUsuario.put(idUsuario, sesion);
        sesion.setAttribute("ID_USUARIO", idUsuario); // clave para limpiar
    }

    public static HttpSession obtenerSesion(String idUsuario) {
        return sesionesPorUsuario.get(idUsuario);
    }
}
