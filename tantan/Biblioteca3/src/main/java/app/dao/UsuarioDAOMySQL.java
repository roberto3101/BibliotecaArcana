package app.dao;

import app.dao.UsuarioDAO;
import app.modelos.Rol;
import app.modelos.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAOMySQL implements UsuarioDAO {

    private Connection conexion;

    public UsuarioDAOMySQL() {
        Conexion conexionBD = new Conexion();
        this.conexion = conexionBD.conectar();
    }

    @Override
    public Usuario login(String username, String password) {
        Usuario usuario = null;
        String sql = "SELECT u.* FROM usuario u WHERE u.login = ? AND u.password = ?";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setString(1, username);
            statement.setString(2, password);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                usuario = mapearUsuario(rs);
                usuario.setRoles(obtenerRolesDeUsuario(usuario.getIdUsuario()));
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al autenticar usuario: " + e.getMessage());
        }

        return usuario;
    }

    @Override
    public Usuario obtener(int id) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuario WHERE idUsuario = ?";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, id);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                usuario = mapearUsuario(rs);
                usuario.setRoles(obtenerRolesDeUsuario(id));
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener usuario: " + e.getMessage());
        }

        return usuario;
    }

    @Override
    public List<Usuario> listar() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuario";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Usuario usuario = mapearUsuario(rs);
                usuario.setRoles(obtenerRolesDeUsuario(usuario.getIdUsuario()));
                usuarios.add(usuario);
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al listar usuarios: " + e.getMessage());
        }

        return usuarios;
    }

    @Override
    public boolean insertar(Usuario usuario) {
        boolean resultado = false;
        String sql = "INSERT INTO usuario (nombres, apellidos, dni, login, password, correo, fechaRegistro, fechaNacimiento, direccion) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, usuario.getNombres());
            statement.setString(2, usuario.getApellidos());
            statement.setString(3, usuario.getDni());
            statement.setString(4, usuario.getLogin());
            statement.setString(5, usuario.getPassword());
            statement.setString(6, usuario.getCorreo());
            statement.setDate(7, new java.sql.Date(usuario.getFechaRegistro().getTime()));
            statement.setDate(8, new java.sql.Date(usuario.getFechaNacimiento().getTime()));
            statement.setString(9, usuario.getDireccion());

            int filasAfectadas = statement.executeUpdate();
            resultado = filasAfectadas > 0;
            
            // Obtener el ID generado
            if (resultado) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    usuario.setIdUsuario(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al insertar usuario: " + e.getMessage());
        }

        return resultado;
    }

    @Override
    public boolean actualizar(Usuario usuario) {
        boolean resultado = false;
        String sql = "UPDATE usuario SET nombres = ?, apellidos = ?, dni = ?, login = ?, password = ?, correo = ?, fechaNacimiento = ?, direccion = ? WHERE idUsuario = ?";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setString(1, usuario.getNombres());
            statement.setString(2, usuario.getApellidos());
            statement.setString(3, usuario.getDni());
            statement.setString(4, usuario.getLogin());
            statement.setString(5, usuario.getPassword());
            statement.setString(6, usuario.getCorreo());
            statement.setDate(7, new java.sql.Date(usuario.getFechaNacimiento().getTime()));
            statement.setString(8, usuario.getDireccion());
            statement.setInt(9, usuario.getIdUsuario());

            int filasAfectadas = statement.executeUpdate();
            resultado = filasAfectadas > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar usuario: " + e.getMessage());
        }

        return resultado;
    }

    @Override
    public boolean eliminar(int id) {
        boolean resultado = false;
        String sql = "DELETE FROM usuario WHERE idUsuario = ?";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, id);

            int filasAfectadas = statement.executeUpdate();
            resultado = filasAfectadas > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar usuario: " + e.getMessage());
        }

        return resultado;
    }
    
    @Override
    public int obtenerUltimoId() {
        int ultimoId = -1;
        String sql = "SELECT MAX(idUsuario) AS ultimoId FROM usuario";
        
        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            
            if (rs.next()) {
                ultimoId = rs.getInt("ultimoId");
            }
            
            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener último ID: " + e.getMessage());
        }
        
        return ultimoId;
    }

    // Método auxiliar para mapear un ResultSet a un objeto Usuario
    private Usuario mapearUsuario(ResultSet rs) throws SQLException {
        Usuario usuario = new Usuario();
        usuario.setIdUsuario(rs.getInt("idUsuario"));
        usuario.setNombres(rs.getString("nombres"));
        usuario.setApellidos(rs.getString("apellidos"));
        usuario.setDni(rs.getString("dni"));
        usuario.setLogin(rs.getString("login"));
        usuario.setPassword(rs.getString("password"));
        usuario.setCorreo(rs.getString("correo"));
        usuario.setFechaRegistro(rs.getTimestamp("fechaRegistro"));
        usuario.setFechaNacimiento(rs.getDate("fechaNacimiento"));
        usuario.setDireccion(rs.getString("direccion"));
        return usuario;
    }

    // Método para obtener los roles de un usuario
    private List<Rol> obtenerRolesDeUsuario(int idUsuario) {
        List<Rol> roles = new ArrayList<>();
        String sql = "SELECT r.* FROM rol r " +
                     "INNER JOIN usuario_has_rol uhr ON r.idRol = uhr.idRol " +
                     "WHERE uhr.idUsuario = ?";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idUsuario);

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
            System.out.println("Error al obtener roles del usuario: " + e.getMessage());
        }

        return roles;
    }
}