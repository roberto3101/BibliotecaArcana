package app.controladores;

import app.dao.AdminRequestDAO;
import app.dao.AdminRequestDAOMySQL;
import app.dao.RolDAO;
import app.dao.RolDAOMySQL;
import app.dao.UsuarioDAO;
import app.dao.UsuarioDAOMySQL;
import app.modelos.Usuario;
import app.util.EmailUtil;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ConfirmarAdminController", urlPatterns = {"/ConfirmarAdminController"})
public class ConfirmarAdminController extends HttpServlet {

    private AdminRequestDAO adminRequestDAO;
    private RolDAO rolDAO;
    private UsuarioDAO usuarioDAO;
    
    // ID del rol de administrador
    private static final int ADMIN_ROLE_ID = 2;
    
    public ConfirmarAdminController() {
        this.adminRequestDAO = new AdminRequestDAOMySQL();
        this.rolDAO = new RolDAOMySQL();
        this.usuarioDAO = new UsuarioDAOMySQL();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        String idUsuarioStr = request.getParameter("idUsuario");
        
        // Validar parámetros
        if (accion == null || idUsuarioStr == null) {
            response.sendRedirect("error.jsp?mensaje=Parámetros inválidos");
            return;
        }
        
        try {
            int idUsuario = Integer.parseInt(idUsuarioStr);
            
            // Obtener información del usuario
            Usuario usuario = usuarioDAO.obtener(idUsuario);
            
            if (usuario == null) {
                response.sendRedirect("error.jsp?mensaje=Usuario no encontrado");
                return;
            }
            
            // Actualizar estado de la solicitud
            boolean solicitudActualizada = false;
            boolean rolActualizado = false;
            
            if ("aprobar".equals(accion)) {
                // Actualizar solicitud a APROBADA
                solicitudActualizada = adminRequestDAO.actualizarEstadoSolicitud(idUsuario, "APROBADA");
                
                // Asignar rol de administrador
                if (solicitudActualizada) {
                    rolActualizado = rolDAO.asignarRolAUsuario(idUsuario, ADMIN_ROLE_ID);
                }
                
                // Enviar notificación al usuario
                if (rolActualizado) {
                    EmailUtil.enviarNotificacionUsuario(usuario.getCorreo(), usuario.getNombreCompleto(), true);
                    request.setAttribute("mensaje", "Solicitud de administrador aprobada correctamente.");
                } else {
                    request.setAttribute("error", "Error al asignar rol de administrador.");
                }
                
            } else if ("rechazar".equals(accion)) {
                // Actualizar solicitud a RECHAZADA
                solicitudActualizada = adminRequestDAO.actualizarEstadoSolicitud(idUsuario, "RECHAZADA");
                
                // Enviar notificación al usuario
                if (solicitudActualizada) {
                    EmailUtil.enviarNotificacionUsuario(usuario.getCorreo(), usuario.getNombreCompleto(), false);
                    request.setAttribute("mensaje", "Solicitud de administrador rechazada.");
                } else {
                    request.setAttribute("error", "Error al actualizar estado de la solicitud.");
                }
            } else {
                request.setAttribute("error", "Acción no válida.");
            }
            
            // Redirigir a una página de confirmación
            request.getRequestDispatcher("admin_confirmacion.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?mensaje=ID de usuario inválido");
        } catch (Exception e) {
            response.sendRedirect("error.jsp?mensaje=Error: " + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Por si en el futuro se necesita manejar solicitudes POST
        doGet(request, response);
    }
}