package app.filtros;
import app.modelos.Usuario;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
// Filtro para todas las rutas excepto login.jsp y recursos estáticos (css, js, imágenes)
@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/*"})
public class AuthenticationFilter implements Filter {
    
    // Rutas públicas que no requieren autenticación
	private static final String[] RUTAS_PUBLICAS = {
		    "/login.jsp", 
		    "/LoginController", 
		    "/login", 
		    "/logout",
		    "/registro.jsp",
		    "/RegistroController",
		    "/registro",
		    "/ConfirmarAdminController", // Añadir esta línea
		    "admin_confirmacion",
		    "/css/", 
		    "/js/", 
		    "/img/", 
		    "/assets/"
		};
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialización
    }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contexto = httpRequest.getContextPath();
        String ruta = requestURI.substring(contexto.length());
        
        // Verificar si la ruta solicitada es pública
        if (esRutaPublica(ruta)) {
            chain.doFilter(request, response);
            return;
        }
        
        // Obtener la sesión actual (sin crear una nueva)
        HttpSession session = httpRequest.getSession(false);
        
        // Verificar si hay un usuario autenticado
        if (session != null && session.getAttribute("usuario") != null) {
            // El usuario está autenticado
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            
            // Verificar permisos según roles para ciertas rutas (ejemplo)
            if (ruta.contains("/admin/") && !usuario.tieneRol("Administrador")) {
                // Si intenta acceder a rutas de admin sin ser admin
                httpResponse.sendRedirect(contexto + "/acceso-denegado.jsp");
                return;
            }
            
            // Usuario autenticado y con permisos adecuados, continuar
            chain.doFilter(request, response);
        } else {
            // Usuario no autenticado, redirigir al login
            httpResponse.sendRedirect(contexto + "/login");
        }
    }
    @Override
    public void destroy() {
        // Cleanup
    }
    
    // Método para verificar si una ruta es pública
    private boolean esRutaPublica(String ruta) {
        for (String rutaPublica : RUTAS_PUBLICAS) {
            if (ruta.equals(rutaPublica) || ruta.startsWith(rutaPublica)) {
                return true;
            }
        }
        return false;
    }
}