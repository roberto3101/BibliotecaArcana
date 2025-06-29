package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminRequestDAOMySQL implements AdminRequestDAO {

    private Connection conexion;

    public AdminRequestDAOMySQL() {
        Conexion conexionBD = new Conexion();
        this.conexion = conexionBD.conectar();
    }

    @Override
    public boolean crearSolicitud(int idUsuario) {
        boolean resultado = false;
        String sql = "INSERT INTO admin_request (id_usuario) VALUES (?)";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idUsuario);

            int filasAfectadas = statement.executeUpdate();
            resultado = filasAfectadas > 0;
        } catch (SQLException e) {
            System.out.println("Error al crear solicitud de administrador: " + e.getMessage());
        }

        return resultado;
    }

    @Override
    public boolean actualizarEstadoSolicitud(int idUsuario, String estado) {
        boolean resultado = false;
        String sql = "UPDATE admin_request SET estado = ?, fecha_respuesta = CURRENT_TIMESTAMP WHERE id_usuario = ? AND estado = 'PENDIENTE'";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setString(1, estado);
            statement.setInt(2, idUsuario);

            int filasAfectadas = statement.executeUpdate();
            resultado = filasAfectadas > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar estado de solicitud: " + e.getMessage());
        }

        return resultado;
    }

    @Override
    public String obtenerEstadoSolicitud(int idUsuario) {
        String estado = null;
        String sql = "SELECT estado FROM admin_request WHERE id_usuario = ? ORDER BY fecha_solicitud DESC LIMIT 1";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idUsuario);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                estado = rs.getString("estado");
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener estado de solicitud: " + e.getMessage());
        }

        return estado;
    }

    @Override
    public List<Integer> obtenerSolicitudesPendientes() {
        List<Integer> solicitudes = new ArrayList<>();
        String sql = "SELECT id_usuario FROM admin_request WHERE estado = 'PENDIENTE'";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                solicitudes.add(rs.getInt("id_usuario"));
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener solicitudes pendientes: " + e.getMessage());
        }

        return solicitudes;
    }
}