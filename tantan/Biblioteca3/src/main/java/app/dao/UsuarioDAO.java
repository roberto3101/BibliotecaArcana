package app.dao;

import app.modelos.Usuario;
import java.util.List;

public interface UsuarioDAO {
    public Usuario login(String username, String password);
    public Usuario obtener(int id);
    public List<Usuario> listar();
    public boolean insertar(Usuario usuario);
    public boolean actualizar(Usuario usuario);
    public boolean eliminar(int id);
    public int obtenerUltimoId();
}