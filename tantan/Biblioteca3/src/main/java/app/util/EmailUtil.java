package app.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {
    
    // Configuración del servidor SMTP de Gmail
    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";
    private static final String USERNAME = "jose0686534@gmail.com"; // Reemplazar con tu correo
    private static final String PASSWORD = "chbjyjvbdcaogjtr"; // Reemplazar con tu contraseña de aplicación
    private static final String ADMIN_EMAIL = "jose0686534@gmail.com";
    
    // URL base de la aplicación - Corregido según el contexto real
    private static final String BASE_URL = "http://localhost:8080/Biblioteca3";
    
    public static boolean enviarCorreoConfirmacionAdmin(String nombreCompleto, String email, int idUsuario) {
        try {
            // Configurar propiedades
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", HOST);
            props.put("mail.smtp.port", PORT);
            
            // Crear sesión con autenticación
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(USERNAME, PASSWORD);
                }
            });
            
            // Crear mensaje
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(ADMIN_EMAIL));
            message.setSubject("Solicitud de Rol Administrador - BiblioSystem");
            
            // URLs correctas con el contexto de la aplicación
            String urlAprobar = BASE_URL + "/ConfirmarAdminController?accion=aprobar&idUsuario=" + idUsuario;
            String urlRechazar = BASE_URL + "/ConfirmarAdminController?accion=rechazar&idUsuario=" + idUsuario;
            
            String contenido = 
                "<html><body>" +
                "<h2>Solicitud de Rol Administrador</h2>" +
                "<p>Se ha recibido una solicitud para asignar el rol de Administrador a un nuevo usuario en el sistema BiblioSystem.</p>" +
                "<p><strong>Datos del usuario:</strong></p>" +
                "<ul>" +
                "<li><strong>Nombre:</strong> " + nombreCompleto + "</li>" +
                "<li><strong>Correo:</strong> " + email + "</li>" +
                "<li><strong>ID de Usuario:</strong> " + idUsuario + "</li>" +
                "</ul>" +
                "<p>Por favor, confirme si desea aprobar o rechazar esta solicitud:</p>" +
                "<div style='margin: 20px 0;'>" +
                "<a href='" + urlAprobar + "' style='background-color: #4CAF50; color: white; padding: 10px 15px; text-decoration: none; border-radius: 5px; margin-right: 10px;'>Aprobar Solicitud</a>" +
                "<a href='" + urlRechazar + "' style='background-color: #f44336; color: white; padding: 10px 15px; text-decoration: none; border-radius: 5px;'>Rechazar Solicitud</a>" +
                "</div>" +
                "<p>Este correo ha sido generado automáticamente. Por favor, no responda a este mensaje.</p>" +
                "</body></html>";
                
            message.setContent(contenido, "text/html; charset=utf-8");
            
            // Enviar mensaje
            Transport.send(message);
            System.out.println("Correo de confirmación enviado con éxito. URL de aprobar: " + urlAprobar);
            
            return true;
        } catch (MessagingException e) {
            System.out.println("Error al enviar correo: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public static boolean enviarNotificacionUsuario(String correoUsuario, String nombreUsuario, boolean aprobado) {
        try {
            // Configurar propiedades
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", HOST);
            props.put("mail.smtp.port", PORT);
            
            // Crear sesión con autenticación
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(USERNAME, PASSWORD);
                }
            });
            
            // Crear mensaje
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(correoUsuario));
            
            String asunto = aprobado ? 
                "Solicitud de Administrador Aprobada - BiblioSystem" : 
                "Solicitud de Administrador Rechazada - BiblioSystem";
            
            message.setSubject(asunto);
            
            String status = aprobado ? 
                "aprobada" : 
                "rechazada";
            
            String accion = aprobado ? 
                "Ya puede acceder a todas las funcionalidades de administrador en el sistema." : 
                "Su cuenta ha sido configurada con permisos de usuario regular.";
            
            // Contenido HTML del correo
            String contenido = 
                "<html><body>" +
                "<h2>Notificación de Estado de Solicitud</h2>" +
                "<p>Estimado/a " + nombreUsuario + ",</p>" +
                "<p>Le informamos que su solicitud para el rol de Administrador en BiblioSystem ha sido <strong>" + status + "</strong>.</p>" +
                "<p>" + accion + "</p>" +
                "<p>Si tiene alguna pregunta, por favor contacte al administrador del sistema.</p>" +
                "<p>Saludos cordiales,<br/>Equipo de BiblioSystem</p>" +
                "</body></html>";
                
            message.setContent(contenido, "text/html; charset=utf-8");
            
            // Enviar mensaje
            Transport.send(message);
            
            return true;
        } catch (MessagingException e) {
            System.out.println("Error al enviar notificación al usuario: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}