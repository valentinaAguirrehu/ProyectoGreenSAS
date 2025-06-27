/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package filtros;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")          
public class AuthFilter implements Filter {

    private static final String[] PUBLICOS = {
        "/index.jsp", "/validar.jsp", "/css/", "/js/", "/presentacion/"
    };

    private boolean esRecursoPublico(String path) {
        for (String pub : PUBLICOS) {
            if (path.startsWith(pub)) return true;
        }
        return false;
    }

    @Override                
    public void init(FilterConfig config) throws ServletException {
    
    }

    @Override                 
    public void destroy() {
        
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        String recurso = request.getRequestURI()
                                .substring(request.getContextPath().length());

        if (esRecursoPublico(recurso)) {
            chain.doFilter(req, res);            
            return;
        }

        HttpSession sesion = request.getSession(false);     
        Object usuario     = (sesion != null) ? sesion.getAttribute("usuario") : null;

        if (usuario == null) {                              
            response.sendRedirect(request.getContextPath() + "/index.jsp?exp=1");
            return;                                         
        }

        chain.doFilter(req, res);                            
    }
}
