package app.controladores;

import app.dao.AlumnoDAO;
import app.dao.PaisDAO;
import app.modelos.Alumno;
import app.modelos.Pais;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.*;

@WebServlet("/AlumnoServlet")
public class AlumnoServlet extends HttpServlet {

    private AlumnoDAO alumnoDAO;
    private PaisDAO paisDAO;

    @Override
    public void init() {
        alumnoDAO = new AlumnoDAO();
        paisDAO = new PaisDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion") != null ? request.getParameter("accion") : "listar";

        switch (accion) {
            case "editar":
                editar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            default:
                listar(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("registrar".equals(accion)) {
            registrar(request, response);
        } else if ("actualizar".equals(accion)) {
            actualizar(request, response);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Alumno> listaAlumnos = alumnoDAO.listar();
        List<Pais> listaPaises = paisDAO.listarPaises();
        request.setAttribute("alumnos", listaAlumnos);
        request.setAttribute("paises", listaPaises);
        request.getRequestDispatcher("Alumno.jsp").forward(request, response);
    }

    private void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAlumno = Integer.parseInt(request.getParameter("id"));
        Alumno alumno = alumnoDAO.buscar(idAlumno);
        List<Alumno> listaAlumnos = alumnoDAO.listar();
        List<Pais> listaPaises = paisDAO.listarPaises();

        request.setAttribute("alumnoEditar", alumno);
        request.setAttribute("alumnos", listaAlumnos);
        request.setAttribute("paises", listaPaises);
        request.getRequestDispatcher("Alumno.jsp").forward(request, response);
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idAlumno = Integer.parseInt(request.getParameter("id"));
        alumnoDAO.eliminar(idAlumno);
        response.sendRedirect("AlumnoServlet?accion=listar");
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> errores = validarDatos(request);

        if (!errores.isEmpty()) {
            Alumno alumno = obtenerDatosFormulario(request);
            request.setAttribute("errores", errores);
            request.setAttribute("alumnoEditar", alumno);
            request.setAttribute("alumnos", alumnoDAO.listar());
            request.setAttribute("paises", paisDAO.listarPaises());
            request.getRequestDispatcher("Alumno.jsp").forward(request, response);
            return;
        }

        Alumno alumno = obtenerDatosFormulario(request);
        alumno.setFechaRegistro(new Date());
        alumno.setFechaActualizacion(new Date());
        alumnoDAO.registrar(alumno);
        response.sendRedirect("AlumnoServlet?accion=listar");
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> errores = validarDatos(request);

        if (!errores.isEmpty()) {
            Alumno alumno = obtenerDatosFormulario(request);
            alumno.setIdAlumno(Integer.parseInt(request.getParameter("idAlumno")));
            request.setAttribute("errores", errores);
            request.setAttribute("alumnoEditar", alumno);
            request.setAttribute("alumnos", alumnoDAO.listar());
            request.setAttribute("paises", paisDAO.listarPaises());
            request.getRequestDispatcher("Alumno.jsp").forward(request, response);
            return;
        }

        Alumno alumno = obtenerDatosFormulario(request);
        alumno.setIdAlumno(Integer.parseInt(request.getParameter("idAlumno")));
        alumno.setFechaActualizacion(new Date());
        alumnoDAO.actualizar(alumno);
        response.sendRedirect("AlumnoServlet?accion=listar");
    }

    private Alumno obtenerDatosFormulario(HttpServletRequest request) {
        Alumno alumno = new Alumno();
        alumno.setNombres(request.getParameter("nombres").trim());
        alumno.setApellidos(request.getParameter("apellidos").trim());
        alumno.setTelefono(request.getParameter("telefono").trim());
        alumno.setDni(request.getParameter("dni").trim());
        alumno.setCorreo(request.getParameter("correo").trim());
        alumno.setEstado(Integer.parseInt(request.getParameter("estado")));
        alumno.setIdPais(Integer.parseInt(request.getParameter("idPais")));

        try {
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            alumno.setFechaNacimiento(formato.parse(request.getParameter("fechaNacimiento")));
        } catch (Exception e) {
            alumno.setFechaNacimiento(new Date());
        }

        return alumno;
    }

    private List<String> validarDatos(HttpServletRequest request) {
        List<String> errores = new ArrayList<>();

        String nombres = request.getParameter("nombres").trim();
        String apellidos = request.getParameter("apellidos").trim();
        String telefono = request.getParameter("telefono").trim();
        String dni = request.getParameter("dni").trim();
        String correo = request.getParameter("correo").trim();
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String estado = request.getParameter("estado");
        String idPais = request.getParameter("idPais");

        if (nombres.length() < 2 || nombres.replaceAll("\\s", "").isEmpty()) {
            errores.add("El nombre debe tener al menos 2 caracteres y no ser solo espacios.");
        }

        if (apellidos.length() < 2 || apellidos.replaceAll("\\s", "").isEmpty()) {
            errores.add("El apellido debe tener al menos 2 caracteres y no ser solo espacios.");
        }

        if (!dni.matches("\\d{8}")) {
            errores.add("El DNI debe tener 8 dígitos numéricos.");
        }

        if (telefono != null && !telefono.isEmpty() && !telefono.matches("\\d{9}")) {
            errores.add("El teléfono debe tener 9 dígitos numéricos.");
        }

        if (correo == null || correo.trim().isEmpty()) {
            errores.add("El correo es obligatorio.");
        } else if (!correo.matches("^[^@\\s]+@[^@\\s]+\\.[a-zA-Z]{2,}$")) {
            errores.add("El correo no tiene un formato válido.");
        }

        if (fechaNacimiento == null || fechaNacimiento.isEmpty()) {
            errores.add("Debe ingresar una fecha de nacimiento.");
        } else {
            try {
                LocalDate fecha = LocalDate.parse(fechaNacimiento);
                if (!fecha.isBefore(LocalDate.now())) {
                    errores.add("La fecha de nacimiento debe ser anterior a hoy.");
                }
            } catch (DateTimeParseException e) {
                errores.add("La fecha de nacimiento no tiene un formato válido.");
            }
        }

        if (!estado.equals("1") && !estado.equals("0")) {
            errores.add("Debe seleccionar un estado válido (Activo o Inactivo).");
        }

        if (idPais == null || idPais.trim().isEmpty()) {
            errores.add("Debe seleccionar un país.");
        }

        return errores;
    }
}
