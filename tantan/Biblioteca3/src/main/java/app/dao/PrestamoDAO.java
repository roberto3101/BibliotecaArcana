package app.dao;

import app.dao.interfaces.IPrestamoDAO;
import app.modelos.Prestamo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrestamoDAO implements IPrestamoDAO {
    private Conexion conexion;

    public PrestamoDAO() {
        this.conexion = new Conexion();
    }

    @Override
    public List<Prestamo> listar() {
        List<Prestamo> lista = new ArrayList<>();
        String sql = "SELECT p.*, a.nombres as nombreAlumno, u.nombres as nombreUsuario " +
                     "FROM prestamo p " +
                     "INNER JOIN alumno a ON p.idAlumno = a.idAlumno " +
                     "INNER JOIN usuario u ON p.idUsuario = u.idUsuario";

        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Prestamo prestamo = new Prestamo();
                prestamo.setIdPrestamo(rs.getInt("idPrestamo"));
                prestamo.setFechaPrestamo(rs.getTimestamp("fechaPrestamo"));
                prestamo.setFechaDevolucion(rs.getTimestamp("fechaDevolucion"));
                prestamo.setIdAlumno(rs.getInt("idAlumno"));
                prestamo.setIdUsuario(rs.getInt("idUsuario"));
                prestamo.setNombreAlumno(rs.getString("nombreAlumno"));
                prestamo.setNombreUsuario(rs.getString("nombreUsuario"));
                prestamo.setLibros(obtenerLibrosPorPrestamo(prestamo.getIdPrestamo()));
                lista.add(prestamo);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar préstamos: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public Prestamo buscarPorId(int idPrestamo) {
        Prestamo prestamo = null;
        String sql = "SELECT p.*, a.nombres as nombreAlumno, u.nombres as nombreUsuario " +
                     "FROM prestamo p " +
                     "INNER JOIN alumno a ON p.idAlumno = a.idAlumno " +
                     "INNER JOIN usuario u ON p.idUsuario = u.idUsuario " +
                     "WHERE p.idPrestamo = ?";

        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idPrestamo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    prestamo = new Prestamo();
                    prestamo.setIdPrestamo(rs.getInt("idPrestamo"));
                    prestamo.setFechaPrestamo(rs.getTimestamp("fechaPrestamo"));
                    prestamo.setFechaDevolucion(rs.getTimestamp("fechaDevolucion"));
                    prestamo.setIdAlumno(rs.getInt("idAlumno"));
                    prestamo.setIdUsuario(rs.getInt("idUsuario"));
                    prestamo.setNombreAlumno(rs.getString("nombreAlumno"));
                    prestamo.setNombreUsuario(rs.getString("nombreUsuario"));
                    prestamo.setLibros(obtenerLibrosPorPrestamo(idPrestamo));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar préstamo: " + e.getMessage());
        }
        return prestamo;
    }

    @Override
    public boolean agregar(Prestamo prestamo) {
        String sql = "INSERT INTO prestamo (fechaPrestamo, fechaDevolucion, idAlumno, idUsuario) VALUES (?, ?, ?, ?)";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet generatedKeys = null;
        try {
            con = conexion.conectar();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setTimestamp(1, new Timestamp(prestamo.getFechaPrestamo().getTime()));
            if (prestamo.getFechaDevolucion() != null) {
                ps.setTimestamp(2, new Timestamp(prestamo.getFechaDevolucion().getTime()));
            } else {
                ps.setNull(2, Types.TIMESTAMP);
            }
            ps.setInt(3, prestamo.getIdAlumno());
            ps.setInt(4, prestamo.getIdUsuario());

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) return false;

            generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                int idPrestamo = generatedKeys.getInt(1);
                guardarLibrosPrestamo(idPrestamo, prestamo.getLibros());
            }
            return true;
        } catch (SQLException e) {
            System.out.println("Error al agregar préstamo: " + e.getMessage());
            return false;
        } finally {
            try { if (generatedKeys != null) generatedKeys.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }

    @Override
    public boolean actualizar(Prestamo prestamo) {
        String sql = "UPDATE prestamo SET fechaPrestamo=?, fechaDevolucion=?, idAlumno=?, idUsuario=? WHERE idPrestamo=?";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setTimestamp(1, new Timestamp(prestamo.getFechaPrestamo().getTime()));
            if (prestamo.getFechaDevolucion() != null) {
                ps.setTimestamp(2, new Timestamp(prestamo.getFechaDevolucion().getTime()));
            } else {
                ps.setNull(2, Types.TIMESTAMP);
            }
            ps.setInt(3, prestamo.getIdAlumno());
            ps.setInt(4, prestamo.getIdUsuario());
            ps.setInt(5, prestamo.getIdPrestamo());

            int affectedRows = ps.executeUpdate();

            eliminarLibrosPrestamo(prestamo.getIdPrestamo());
            guardarLibrosPrestamo(prestamo.getIdPrestamo(), prestamo.getLibros());

            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar préstamo: " + e.getMessage());
            return false;
        }
    }
    
    
    public boolean marcarComoDevuelto(int idPrestamo, java.sql.Timestamp fechaDevolucion) {
        String sql = "UPDATE prestamo SET fechaDevolucion = ? WHERE idPrestamo = ?";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setTimestamp(1, fechaDevolucion);
            ps.setInt(2, idPrestamo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al marcar como devuelto: " + e.getMessage());
            return false;
        }
    }

    
    

    @Override
    public boolean eliminar(int idPrestamo) {
        Connection con = null;
        PreparedStatement psLibros = null;
        PreparedStatement psPrestamo = null;
        try {
            con = conexion.conectar();
            con.setAutoCommit(false); // Transacción
            // 1. Elimina los libros asociados (prestamo_tiene_libro)
            String sqlLibros = "DELETE FROM prestamo_tiene_libro WHERE idPrestamo = ?";
            psLibros = con.prepareStatement(sqlLibros);
            psLibros.setInt(1, idPrestamo);
            psLibros.executeUpdate();
            // 2. Elimina el préstamo principal
            String sqlPrestamo = "DELETE FROM prestamo WHERE idPrestamo = ?";
            psPrestamo = con.prepareStatement(sqlPrestamo);
            psPrestamo.setInt(1, idPrestamo);
            int affectedRows = psPrestamo.executeUpdate();
            con.commit();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar préstamo: " + e.getMessage());
            try { if (con != null) con.rollback(); } catch (Exception ex) {}
            return false;
        } finally {
            try { if (psLibros != null) psLibros.close(); } catch (Exception e) {}
            try { if (psPrestamo != null) psPrestamo.close(); } catch (Exception e) {}
            try { if (con != null) con.setAutoCommit(true); con.close(); } catch (Exception e) {}
        }
    }

    // MÉTODOS DE APOYO
    private List<Integer> obtenerLibrosPorPrestamo(int idPrestamo) {
        List<Integer> libros = new ArrayList<>();
        String sql = "SELECT idLibro FROM prestamo_tiene_libro WHERE idPrestamo = ?";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idPrestamo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    libros.add(rs.getInt("idLibro"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener libros de préstamo: " + e.getMessage());
        }
        return libros;
    }

    private void guardarLibrosPrestamo(int idPrestamo, List<Integer> libros) {
        String sql = "INSERT INTO prestamo_tiene_libro (idPrestamo, idLibro) VALUES (?, ?)";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            for (Integer idLibro : libros) {
                ps.setInt(1, idPrestamo);
                ps.setInt(2, idLibro);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            System.out.println("Error al asociar libros a préstamo: " + e.getMessage());
        }
    }

    private void eliminarLibrosPrestamo(int idPrestamo) {
        String sql = "DELETE FROM prestamo_tiene_libro WHERE idPrestamo = ?";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idPrestamo);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al eliminar libros de préstamo: " + e.getMessage());
        }
    }
}
