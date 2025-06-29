package app.dao;

import app.modelos.Pais;
import java.sql.*;
import java.util.*;

public class PaisDAO {
    private Connection conexion;

    public PaisDAO() {
        Conexion conexionBD = new Conexion();
        this.conexion = conexionBD.conectar();
    }

    public List<Pais> listarPaises() {
        List<Pais> lista = new ArrayList<>();
        String sql = "SELECT * FROM pais";
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Pais p = new Pais();
                p.setIdPais(rs.getInt("idPais"));
                p.setNombre(rs.getString("nombre"));
                lista.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar países: " + e.getMessage());
        }
        return lista;
    }
}
