package app.dao;

import app.modelos.Rol;
import java.util.List;

public interface RolDAO {
    public List<Rol> listar();
    public Rol obtener(int id);
    public boolean asignarRolAUsuario(int idUsuario, int idRol);
}