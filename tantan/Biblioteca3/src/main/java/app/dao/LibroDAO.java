package app.dao;

import app.dao.interfaces.ILibroDAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import app.modelos.Libro;

public class LibroDAO implements ILibroDAO {
    private Conexion conexion;
    
    public LibroDAO() {
        this.conexion = new Conexion();
    }
    
    
    
    
    
    public List<Libro> buscarPorTextoYCategoria(String textoBusqueda, Integer idCategoria) {
        List<Libro> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT l.*, c.descripcion FROM libro l " +
            "INNER JOIN categoria_libro c ON l.idCategoria = c.idCategoria " +
            "WHERE l.estado = 1"
        );
        List<Object> params = new ArrayList<>();

        // Búsqueda por texto en múltiples campos
        if (textoBusqueda != null && !textoBusqueda.trim().isEmpty()) {
            sql.append(" AND (l.titulo LIKE ? OR l.serie LIKE ? OR l.tema LIKE ? OR c.descripcion LIKE ? OR l.anio LIKE ?)");
            String likeParam = "%" + textoBusqueda.trim() + "%";
            params.add(likeParam);
            params.add(likeParam);
            params.add(likeParam);
            params.add(likeParam);
            params.add(likeParam);
        }

        // Filtrar por categoría si corresponde
        if (idCategoria != null) {
            sql.append(" AND l.idCategoria = ?");
            params.add(idCategoria);
        }

        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Libro libro = new Libro();
                    libro.setIdLibro(rs.getInt("idLibro"));
                    libro.setTitulo(rs.getString("titulo"));
                    libro.setAnio(rs.getInt("anio"));
                    libro.setSerie(rs.getString("serie"));
                    libro.setTema(rs.getString("tema"));
                    libro.setFechaRegistro(rs.getTimestamp("fechaRegistro"));
                    libro.setFechaActualizacion(rs.getTimestamp("fechaActualizacion"));
                    libro.setEstado(rs.getInt("estado"));
                    libro.setIdCategoria(rs.getInt("idCategoria"));
                    libro.setDescripcionCategoria(rs.getString("descripcion"));
                    lista.add(libro);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar libros por texto/categoría: " + e.getMessage());
        }
        return lista;
    }

    
    
    
    
    
    
    
    
    
    
    
    
    @Override
    public List<Libro> listar() {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT l.*, c.descripcion FROM libro l " +
                     "INNER JOIN categoria_libro c ON l.idCategoria = c.idCategoria " +
                     "WHERE l.estado = 1";
        
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Libro libro = new Libro();
                libro.setIdLibro(rs.getInt("idLibro"));
                libro.setTitulo(rs.getString("titulo"));
                libro.setAnio(rs.getInt("anio"));
                libro.setSerie(rs.getString("serie"));
                libro.setTema(rs.getString("tema"));
                libro.setFechaRegistro(rs.getTimestamp("fechaRegistro"));
                libro.setFechaActualizacion(rs.getTimestamp("fechaActualizacion"));
                libro.setEstado(rs.getInt("estado"));
                libro.setIdCategoria(rs.getInt("idCategoria"));
                libro.setDescripcionCategoria(rs.getString("descripcion"));
                lista.add(libro);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar libros: " + e.getMessage());
        }
        
        return lista;
    }
    
    @Override
    public List<Libro> listarPorCategoria(int idCategoria) {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT l.*, c.descripcion FROM libro l " +
                     "INNER JOIN categoria_libro c ON l.idCategoria = c.idCategoria " +
                     "WHERE l.estado = 1 AND l.idCategoria = ?";
        
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idCategoria);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Libro libro = new Libro();
                    libro.setIdLibro(rs.getInt("idLibro"));
                    libro.setTitulo(rs.getString("titulo"));
                    libro.setAnio(rs.getInt("anio"));
                    libro.setSerie(rs.getString("serie"));
                    libro.setTema(rs.getString("tema"));
                    libro.setFechaRegistro(rs.getTimestamp("fechaRegistro"));
                    libro.setFechaActualizacion(rs.getTimestamp("fechaActualizacion"));
                    libro.setEstado(rs.getInt("estado"));
                    libro.setIdCategoria(rs.getInt("idCategoria"));
                    libro.setDescripcionCategoria(rs.getString("descripcion"));
                    lista.add(libro);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al listar libros por categoría: " + e.getMessage());
        }
        
        return lista;
    }
    
    @Override
    public Libro buscarPorId(int idLibro) {
        Libro libro = null;
        String sql = "SELECT l.*, c.descripcion FROM libro l " +
                     "INNER JOIN categoria_libro c ON l.idCategoria = c.idCategoria " +
                     "WHERE l.idLibro = ?";
        
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idLibro);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    libro = new Libro();
                    libro.setIdLibro(rs.getInt("idLibro"));
                    libro.setTitulo(rs.getString("titulo"));
                    libro.setAnio(rs.getInt("anio"));
                    libro.setSerie(rs.getString("serie"));
                    libro.setTema(rs.getString("tema"));
                    libro.setFechaRegistro(rs.getTimestamp("fechaRegistro"));
                    libro.setFechaActualizacion(rs.getTimestamp("fechaActualizacion"));
                    libro.setEstado(rs.getInt("estado"));
                    libro.setIdCategoria(rs.getInt("idCategoria"));
                    libro.setDescripcionCategoria(rs.getString("descripcion"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar libro por ID: " + e.getMessage());
        }
        
        return libro;
    }
    
    @Override
    public boolean agregar(Libro libro) {
        String sql = "INSERT INTO libro (titulo, anio, serie, tema, fechaRegistro, fechaActualizacion, estado, idCategoria) " +
                     "VALUES (?, ?, ?, ?, NOW(), NOW(), 1, ?)";
        
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, libro.getTitulo());
            ps.setInt(2, libro.getAnio());
            ps.setString(3, libro.getSerie());
            ps.setString(4, libro.getTema());
            ps.setInt(5, libro.getIdCategoria());
            
            int resultado = ps.executeUpdate();
            return resultado > 0;
        } catch (SQLException e) {
            System.out.println("Error al agregar libro: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean actualizar(Libro libro) {
        String sql = "UPDATE libro SET titulo = ?, anio = ?, serie = ?, tema = ?, " +
                     "fechaActualizacion = NOW(), idCategoria = ? WHERE idLibro = ?";
        
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, libro.getTitulo());
            ps.setInt(2, libro.getAnio());
            ps.setString(3, libro.getSerie());
            ps.setString(4, libro.getTema());
            ps.setInt(5, libro.getIdCategoria());
            ps.setInt(6, libro.getIdLibro());
            
            int resultado = ps.executeUpdate();
            return resultado > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar libro: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean eliminar(int idLibro) {
        // Eliminación lógica, cambiando el estado a 0
        String sql = "UPDATE libro SET estado = 0, fechaActualizacion = NOW() WHERE idLibro = ?";
        
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idLibro);
            
            int resultado = ps.executeUpdate();
            return resultado > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar libro: " + e.getMessage());
            return false;
        }
        
        
        
        
    }
    
    
    
    
    
    
}