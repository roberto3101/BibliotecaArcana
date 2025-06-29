package app.modelos;

public class Rol {
    private int idRol;
    private String nombre;
    private String estado;
    
    // Constructores
    public Rol() {
    }
    
    public Rol(int idRol, String nombre, String estado) {
        this.idRol = idRol;
        this.nombre = nombre;
        this.estado = estado;
    }
    
    // Getters y Setters
    public int getIdRol() {
        return idRol;
    }
    
    public void setIdRol(int idRol) {
        this.idRol = idRol;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getEstado() {
        return estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    @Override
    public String toString() {
        return "Rol [idRol=" + idRol + ", nombre=" + nombre + ", estado=" + estado + "]";
    }
}