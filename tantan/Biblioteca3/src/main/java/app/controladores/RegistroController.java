package app.controladores;

import app.dao.UsuarioDAOMySQL;
import app.dao.UsuarioDAO;
import app.dao.RolDAO;
import app.dao.RolDAOMySQL;
import app.dao.AdminRequestDAO;
import app.dao.AdminRequestDAOMySQL;
import app.modelos.Usuario;
import app.modelos.Rol;
import app.util.EmailUtil;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistroController", urlPatterns = {"/RegistroController", "/registro"})
public class RegistroController extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    private RolDAO rolDAO;
    private AdminRequestDAO adminRequestDAO;
    
    
    
    private static final int BIBLIOTECOLOGO_ROLE_ID = 1;

    
    // ID del rol de administrador
    private static final int ADMIN_ROLE_ID = 2;
    // ID del rol de usuario regular
    private static final int USER_ROLE_ID = 3;
    
    public RegistroController() {
        this.usuarioDAO = new UsuarioDAOMySQL();
        this.rolDAO = new RolDAOMySQL();
        this.adminRequestDAO = new AdminRequestDAOMySQL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Mostrar el formulario de registro
        request.getRequestDispatcher("registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Recoger los datos del formulario
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String dni = request.getParameter("dni");
            String login = request.getParameter("login");
            String password = request.getParameter("password");
            String correo = request.getParameter("correo");
            String direccion = request.getParameter("direccion");
            String fechaNacimientoStr = request.getParameter("fechaNacimiento");
            int idRol = Integer.parseInt(request.getParameter("idRol"));
            
            // Validar datos
            if (nombres == null || nombres.trim().isEmpty() ||
                apellidos == null || apellidos.trim().isEmpty() ||
                dni == null || dni.trim().isEmpty() ||
                login == null || login.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                correo == null || correo.trim().isEmpty() ||
                fechaNacimientoStr == null || fechaNacimientoStr.trim().isEmpty()) {
                
                request.setAttribute("error", "Todos los campos son obligatorios");
                request.getRequestDispatcher("registro.jsp").forward(request, response);
                return;
            }
            
            // Convertir fecha de nacimiento
            java.sql.Date fechaNacimiento = null;
            try {
                fechaNacimiento = java.sql.Date.valueOf(fechaNacimientoStr);
            } catch (Exception e) {
                request.setAttribute("error", "Formato de fecha inválido");
                request.getRequestDispatcher("registro.jsp").forward(request, response);
                return;
            }
            
            // Crear el objeto Usuario
            Usuario usuario = new Usuario();
            usuario.setNombres(nombres);
            usuario.setApellidos(apellidos);
            usuario.setDni(dni);
            usuario.setLogin(login);
            usuario.setPassword(password);
            usuario.setCorreo(correo);
            usuario.setDireccion(direccion);
            usuario.setFechaNacimiento(fechaNacimiento);
            usuario.setFechaRegistro(new Date()); // Fecha actual
            
            // Insertar el usuario en la base de datos
            boolean resultado = usuarioDAO.insertar(usuario);
            
            if (resultado) {
                // Obtener el último ID insertado
                int idUsuario = usuarioDAO.obtenerUltimoId();
                
                boolean rolAsignado = false;
                
                // Si el rol solicitado es de administrador
                if (idRol == ADMIN_ROLE_ID) {
                    // Asignar rol de usuario regular temporalmente
                    rolAsignado = rolDAO.asignarRolAUsuario(idUsuario, USER_ROLE_ID);
                    
                    if (rolAsignado) {
                        // Crear solicitud de administrador
                        boolean solicitudCreada = adminRequestDAO.crearSolicitud(idUsuario);
                        
                        if (solicitudCreada) {
                            // Enviar correo de confirmación al admin
                            boolean emailEnviado = EmailUtil.enviarCorreoConfirmacionAdmin(
                                usuario.getNombreCompleto(), 
                                usuario.getCorreo(), 
                                idUsuario
                            );
                            
                            if (emailEnviado) {
                                request.setAttribute("adminRequest", true);
                                request.getSession().setAttribute("mensajeRegistro", 
                                    "Se ha enviado su solicitud de administrador, en breves momentos recibirá una respuesta, manténgase atento.");
                                response.sendRedirect("login.jsp");
                                return;
                            } else {
                                request.setAttribute("error", "No se pudo enviar el correo de confirmación");
                                request.getRequestDispatcher("registro.jsp").forward(request, response);
                                return;
                            }
                        } else {
                            request.setAttribute("error", "Error al crear la solicitud de administrador");
                            request.getRequestDispatcher("registro.jsp").forward(request, response);
                            return;
                        }
                    } else {
                        request.setAttribute("error", "Error al asignar el rol temporal al usuario");
                        request.getRequestDispatcher("registro.jsp").forward(request, response);
                        return;
                    }
                } else {
                    // Si es un usuario regular, asignar el rol directamente
                    rolAsignado = rolDAO.asignarRolAUsuario(idUsuario, idRol);
                    
                    if (rolAsignado) {
                        request.getSession().setAttribute("mensajeRegistro", "Usuario registrado correctamente");
                        response.sendRedirect("login.jsp");
                        return;
                    } else {
                        request.setAttribute("error", "Error al asignar el rol al usuario");
                        request.getRequestDispatcher("registro.jsp").forward(request, response);
                        return;
                    }
                }
            } else {
                request.setAttribute("error", "Error al registrar el usuario");
                request.getRequestDispatcher("registro.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error en el registro: " + e.getMessage());
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }
    }
}