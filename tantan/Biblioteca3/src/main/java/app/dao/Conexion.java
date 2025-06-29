package app.dao;

import java.sql.*;

public class Conexion {
    private Connection con;
    private final String URL = "jdbc:mysql://localhost:3306/biblioteca";
    private final String USER = "root";
    private final String PASS = "mysql"; // Verifica si esta contraseña es correcta

    public Connection conectar() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error de conexión: " + e.getMessage());
            e.printStackTrace(); // Agrega esto para ver el error completo
            con = null; // explícito
        }
        return con;
    }

    public void desconectar() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            System.out.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }
}