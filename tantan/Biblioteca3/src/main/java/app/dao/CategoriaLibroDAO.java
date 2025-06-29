package app.dao;

import app.dao.interfaces.ICategoriaLibroDAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import app.modelos.CategoriaLibro;

public class CategoriaLibroDAO implements ICategoriaLibroDAO {
    private Conexion conexion;
    
    public CategoriaLibroDAO() {
        this.conexion = new Conexion();
    }
    
    @Override
    public List<CategoriaLibro> listar() {
        List<CategoriaLibro> lista = new ArrayList<>();
        String sql = "SELECT idCategoria, descripcion FROM categoria_libro";
        
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                CategoriaLibro categoria = new CategoriaLibro();
                categoria.setIdCategoria(rs.getInt("idCategoria"));
                categoria.setDescripcion(rs.getString("descripcion"));
                lista.add(categoria);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar categorías: " + e.getMessage());
        }
        
        return lista;
    }
    
    @Override
    public CategoriaLibro buscarPorId(int idCategoria) {
        CategoriaLibro categoria = null;
        String sql = "SELECT idCategoria, descripcion FROM categoria_libro WHERE idCategoria = ?";
        
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idCategoria);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    categoria = new CategoriaLibro();
                    categoria.setIdCategoria(rs.getInt("idCategoria"));
                    categoria.setDescripcion(rs.getString("descripcion"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar categoría por ID: " + e.getMessage());
        }
        
        return categoria;
    }
}