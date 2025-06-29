package app.modelos;

import java.util.Date;
import java.util.List;

public class Usuario {
    private int idUsuario;
    private String nombres;
    private String apellidos;
    private String dni;
    private String login;
    private String password;
    private String correo;
    private Date fechaRegistro;
    private Date fechaNacimiento;
    private String direccion;
    private List<Rol> roles;
    
    // Constructores
    public Usuario() {
    }
    
    public Usuario(int idUsuario, String nombres, String apellidos, String dni, String login, String password,
            String correo, Date fechaRegistro, Date fechaNacimiento, String direccion) {
        this.idUsuario = idUsuario;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.dni = dni;
        this.login = login;
        this.password = password;
        this.correo = correo;
        this.fechaRegistro = fechaRegistro;
        this.fechaNacimiento = fechaNacimiento;
        this.direccion = direccion;
    }

    // Getters y Setters
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    public List<Rol> getRoles() {
        return roles;
    }

    public void setRoles(List<Rol> roles) {
        this.roles = roles;
    }
    
    // Método para verificar si el usuario tiene un rol específico
    public boolean tieneRol(String nombreRol) {
        if (roles == null) {
            return false;
        }
        
        return roles.stream()
                .anyMatch(rol -> rol.getNombre().equals(nombreRol));
    }
    
    // Método para obtener nombre completo
    public String getNombreCompleto() {
        return nombres + " " + apellidos;
    }
}