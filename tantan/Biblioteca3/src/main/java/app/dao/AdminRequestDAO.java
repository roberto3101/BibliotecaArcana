package app.dao;

import java.util.List;

public interface AdminRequestDAO {
    public boolean crearSolicitud(int idUsuario);
    public boolean actualizarEstadoSolicitud(int idUsuario, String estado);
    public String obtenerEstadoSolicitud(int idUsuario);
    public List<Integer> obtenerSolicitudesPendientes();
}