package app.dao;

import app.modelos.Rol;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RolDAOMySQL implements RolDAO {

    private Connection conexion;

    public RolDAOMySQL() {
        Conexion conexionBD = new Conexion();
        this.conexion = conexionBD.conectar();
    }

    @Override
    public List<Rol> listar() {
        List<Rol> roles = new ArrayList<>();
        String sql = "SELECT * FROM rol";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Rol rol = new Rol();
                rol.setIdRol(rs.getInt("idRol"));
                rol.setNombre(rs.getString("nombre"));
                rol.setEstado(rs.getString("estado"));
                roles.add(rol);
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al listar roles: " + e.getMessage());
        }

        return roles;
    }

    @Override
    public Rol obtener(int id) {
        Rol rol = null;
        String sql = "SELECT * FROM rol WHERE idRol = ?";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, id);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                rol = new Rol();
                rol.setIdRol(rs.getInt("idRol"));
                rol.setNombre(rs.getString("nombre"));
                rol.setEstado(rs.getString("estado"));
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener rol: " + e.getMessage());
        }

        return rol;
    }

    @Override
    public boolean asignarRolAUsuario(int idUsuario, int idRol) {
        boolean resultado = false;
        String sql = "INSERT INTO usuario_has_rol (idUsuario, idRol) VALUES (?, ?)";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idUsuario);
            statement.setInt(2, idRol);

            int filasAfectadas = statement.executeUpdate();
            resultado = filasAfectadas > 0;
        } catch (SQLException e) {
            System.out.println("Error al asignar rol a usuario: " + e.getMessage());
        }

        return resultado;
    }
}