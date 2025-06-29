package app.dao.interfaces;

import app.modelos.Prestamo;
import java.util.List;

public interface IPrestamoDAO {
    List<Prestamo> listar();
    Prestamo buscarPorId(int idPrestamo);
    boolean agregar(Prestamo prestamo);
    boolean actualizar(Prestamo prestamo);
    boolean eliminar(int idPrestamo);
}
