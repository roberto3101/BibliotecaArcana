package app.controladores;

import app.dao.UsuarioDAOMySQL;
import app.dao.UsuarioDAO;
import app.modelos.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController", "/login", "/logout"})
public class LoginController extends HttpServlet {

    private UsuarioDAO usuarioDAO;

    public LoginController() {
        this.usuarioDAO = new UsuarioDAOMySQL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getServletPath();
        
        switch (action) {
            case "/logout":
                logout(request, response);
                break;
            case "/login":
            default:
                showLoginForm(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Usuario usuario = usuarioDAO.login(username, password);
        
        if (usuario != null) {
            // Crear sesión y guardar el usuario
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setAttribute("nombreUsuario", usuario.getNombreCompleto());
            session.setAttribute("rolUsuario", usuario.getRoles().size() > 0 ? usuario.getRoles().get(0).getNombre() : "Usuario");
            
            // Verificar si el usuario es admin
            boolean esAdmin = usuario.tieneRol("Administrador");
            session.setAttribute("esAdmin", esAdmin);
            
            // Redireccionar a la página de inicio
            response.sendRedirect("inicio.jsp");
        } else {
            // Si las credenciales son incorrectas, redirigir al login con un mensaje de error
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    private void showLoginForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verificar si ya hay una sesión activa
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            // Si ya hay sesión, redirigir a la página de inicio
            response.sendRedirect("index.jsp");
        } else {
            // Mostrar formulario de login
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Cerrar la sesión
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        // Redirigir al login
        response.sendRedirect("login.jsp");
    }
}