package app.dao.interfaces;

import java.util.List;
import app.modelos.Libro;

public interface ILibroDAO {
    public List<Libro> listar();
    public List<Libro> listarPorCategoria(int idCategoria);
    public Libro buscarPorId(int idLibro);
    public boolean agregar(Libro libro);
    public boolean actualizar(Libro libro);
    public boolean eliminar(int idLibro);
    
    public List<Libro> buscarPorTextoYCategoria(String textoBusqueda, Integer idCategoria);

}