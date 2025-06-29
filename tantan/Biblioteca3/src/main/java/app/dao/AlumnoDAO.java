package app.dao;

import app.modelos.Alumno;
import java.sql.*;
import java.util.*;

public class AlumnoDAO {
    private Connection conexion;

    public AlumnoDAO() {
        Conexion conexionBD = new Conexion();
        this.conexion = conexionBD.conectar();
    }

    public List<Alumno> listar() {
        List<Alumno> lista = new ArrayList<>();
        String sql = "SELECT a.*, p.nombre AS nombrePais FROM alumno a INNER JOIN pais p ON a.idPais = p.idPais";
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Alumno a = mapear(rs);
                lista.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar alumnos: " + e.getMessage());
        }
        return lista;
    }

    public Alumno buscar(int id) {
        Alumno a = null;
        String sql = "SELECT a.*, p.nombre AS nombrePais FROM alumno a INNER JOIN pais p ON a.idPais = p.idPais WHERE a.idAlumno = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) a = mapear(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar alumno: " + e.getMessage());
        }
        return a;
    }

    // --- Este método soluciona tu error ---
    public Alumno buscarPorId(int idAlumno) {
        return buscar(idAlumno);
    }
    // ---------------------------------------

    public boolean registrar(Alumno a) {
        String sql = "INSERT INTO alumno (nombres, apellidos, telefono, dni, correo, fechaNacimiento, fechaRegistro, fechaActualizacion, estado, idPais) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, a.getNombres());
            stmt.setString(2, a.getApellidos());
            stmt.setString(3, a.getTelefono());
            stmt.setString(4, a.getDni());
            stmt.setString(5, a.getCorreo());
            stmt.setDate(6, new java.sql.Date(a.getFechaNacimiento().getTime()));
            stmt.setDate(7, new java.sql.Date(a.getFechaRegistro().getTime()));
            stmt.setDate(8, new java.sql.Date(a.getFechaActualizacion().getTime()));
            stmt.setInt(9, a.getEstado());
            stmt.setInt(10, a.getIdPais());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al registrar alumno: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(Alumno a) {
        String sql = "UPDATE alumno SET nombres = ?, apellidos = ?, telefono = ?, dni = ?, correo = ?, fechaNacimiento = ?, fechaActualizacion = ?, estado = ?, idPais = ? WHERE idAlumno = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, a.getNombres());
            stmt.setString(2, a.getApellidos());
            stmt.setString(3, a.getTelefono());
            stmt.setString(4, a.getDni());
            stmt.setString(5, a.getCorreo());
            stmt.setDate(6, new java.sql.Date(a.getFechaNacimiento().getTime()));
            stmt.setDate(7, new java.sql.Date(a.getFechaActualizacion().getTime()));
            stmt.setInt(8, a.getEstado());
            stmt.setInt(9, a.getIdPais());
            stmt.setInt(10, a.getIdAlumno());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar alumno: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM alumno WHERE idAlumno = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar alumno: " + e.getMessage());
            return false;
        }
    }

    private Alumno mapear(ResultSet rs) throws SQLException {
        Alumno a = new Alumno();
        a.setIdAlumno(rs.getInt("idAlumno"));
        a.setNombres(rs.getString("nombres"));
        a.setApellidos(rs.getString("apellidos"));
        a.setTelefono(rs.getString("telefono"));
        a.setDni(rs.getString("dni"));
        a.setCorreo(rs.getString("correo"));
        a.setFechaNacimiento(rs.getDate("fechaNacimiento"));
        a.setFechaRegistro(rs.getDate("fechaRegistro"));
        a.setFechaActualizacion(rs.getDate("fechaActualizacion"));
        a.setEstado(rs.getInt("estado"));
        a.setIdPais(rs.getInt("idPais"));
        a.setNombrePais(rs.getString("nombrePais"));
        return a;
    }
}
