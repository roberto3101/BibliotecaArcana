package app.dao.interfaces;

import java.util.List;
import app.modelos.CategoriaLibro;

public interface ICategoriaLibroDAO {
    public List<CategoriaLibro> listar();
    public CategoriaLibro buscarPorId(int idCategoria);
}