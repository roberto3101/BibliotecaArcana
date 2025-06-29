package app.controladores;

import app.dao.PrestamoDAO;
import app.dao.LibroDAO;
import app.dao.AlumnoDAO;
import app.modelos.Prestamo;
import app.modelos.Libro;
import app.modelos.Alumno;
import app.modelos.Usuario;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "PrestamoController", urlPatterns = {"/prestamo"})
public class PrestamoController extends HttpServlet {
    private PrestamoDAO prestamoDAO;
    private LibroDAO libroDAO;
    private AlumnoDAO alumnoDAO;

    public PrestamoController() {
        this.prestamoDAO = new PrestamoDAO();
        this.libroDAO = new LibroDAO();
        this.alumnoDAO = new AlumnoDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "listar":
                listar(request, response);
                break;
            case "filtrar":
                filtrar(request, response);
                break;
            case "detalle":
                detalle(request, response);
                break;
            case "nuevo":
                nuevo(request, response);
                break;
            case "insertar":
                insertar(request, response);
                break;
            case "editar":
                editar(request, response);
                break;
            case "actualizar":
                actualizar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            case "devolver":
                devolver(request, response);
                break;
            default:
                listar(request, response);
        }
    }

    // Listar todos
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Prestamo> prestamos = prestamoDAO.listar();
        request.setAttribute("prestamos", prestamos);
        request.setAttribute("filtro", "todos");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/prestamos.jsp");
        dispatcher.forward(request, response);
    }

    // Filtro correcto (vigentes/devueltos/todos)
    private void filtrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipo = request.getParameter("tipo");
        if (tipo == null) tipo = "todos";
        List<Prestamo> prestamos = prestamoDAO.listar();
        List<Prestamo> filtrados = new ArrayList<>();
        for (Prestamo p : prestamos) {
            if ("vigentes".equals(tipo) && p.getFechaDevolucion() == null) {
                filtrados.add(p);
            } else if ("devueltos".equals(tipo) && p.getFechaDevolucion() != null) {
                filtrados.add(p);
            } else if ("todos".equals(tipo)) {
                filtrados.add(p);
            }
        }
        request.setAttribute("prestamos", filtrados);
        request.setAttribute("filtro", tipo);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/prestamos.jsp");
        dispatcher.forward(request, response);
    }

    // Detalle de préstamo
    private void detalle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idPrestamo = Integer.parseInt(request.getParameter("id"));
        Prestamo prestamo = prestamoDAO.buscarPorId(idPrestamo);
        List<Libro> libros = new ArrayList<>();
        if (prestamo.getLibros() != null) {
            for (Integer idLibro : prestamo.getLibros()) {
                Libro libro = libroDAO.buscarPorId(idLibro);
                if (libro != null) libros.add(libro);
            }
        }
        Alumno alumno = alumnoDAO.buscarPorId(prestamo.getIdAlumno());
        request.setAttribute("prestamo", prestamo);
        request.setAttribute("librosDetalle", libros);
        request.setAttribute("alumnoDetalle", alumno);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/detallePrestamo.jsp");
        dispatcher.forward(request, response);
    }

    private void nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Libro> libros = libroDAO.listar();
        List<Alumno> alumnos = alumnoDAO.listar();
        request.setAttribute("libros", libros);
        request.setAttribute("alumnos", alumnos);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/formPrestamo.jsp");
        dispatcher.forward(request, response);
    }

    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String[] librosSeleccionados = request.getParameterValues("libros");
            int idAlumno = Integer.parseInt(request.getParameter("idAlumno"));

            String fechaPrestamoStr = request.getParameter("fechaPrestamo");
            String fechaDevolucionStr = request.getParameter("fechaDevolucion");
            Date fechaPrestamo = new SimpleDateFormat("yyyy-MM-dd").parse(fechaPrestamoStr);

            Date fechaDevolucion = null;
            if (fechaDevolucionStr != null && !fechaDevolucionStr.isEmpty()) {
                fechaDevolucion = new SimpleDateFormat("yyyy-MM-dd").parse(fechaDevolucionStr);
            }

            HttpSession session = request.getSession();
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            int idUsuario = usuario.getIdUsuario();

            Prestamo prestamo = new Prestamo();
            prestamo.setIdAlumno(idAlumno);
            prestamo.setIdUsuario(idUsuario);
            prestamo.setFechaPrestamo(fechaPrestamo);
            prestamo.setFechaDevolucion(fechaDevolucion);

            List<Integer> listaLibros = new ArrayList<>();
            if (librosSeleccionados != null) {
                for (String idLibroStr : librosSeleccionados) {
                    listaLibros.add(Integer.parseInt(idLibroStr));
                }
            }
            prestamo.setLibros(listaLibros);

            prestamoDAO.agregar(prestamo);

            response.sendRedirect("prestamo?accion=listar");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("prestamo?accion=listar");
        }
    }

    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idPrestamo = Integer.parseInt(request.getParameter("id"));
        Prestamo prestamo = prestamoDAO.buscarPorId(idPrestamo);
        List<Libro> libros = libroDAO.listar();
        List<Alumno> alumnos = alumnoDAO.listar();

        request.setAttribute("prestamo", prestamo);
        request.setAttribute("libros", libros);
        request.setAttribute("alumnos", alumnos);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/formPrestamo.jsp");
        dispatcher.forward(request, response);
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idPrestamo = Integer.parseInt(request.getParameter("idPrestamo"));
            int idAlumno = Integer.parseInt(request.getParameter("idAlumno"));
            String[] librosSeleccionados = request.getParameterValues("libros");

            String fechaPrestamoStr = request.getParameter("fechaPrestamo");
            String fechaDevolucionStr = request.getParameter("fechaDevolucion");
            Date fechaPrestamo = new SimpleDateFormat("yyyy-MM-dd").parse(fechaPrestamoStr);

            Date fechaDevolucion = null;
            if (fechaDevolucionStr != null && !fechaDevolucionStr.isEmpty()) {
                fechaDevolucion = new SimpleDateFormat("yyyy-MM-dd").parse(fechaDevolucionStr);
            }

            HttpSession session = request.getSession();
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            int idUsuario = usuario.getIdUsuario();

            Prestamo prestamo = new Prestamo();
            prestamo.setIdPrestamo(idPrestamo);
            prestamo.setIdAlumno(idAlumno);
            prestamo.setIdUsuario(idUsuario);
            prestamo.setFechaPrestamo(fechaPrestamo);
            prestamo.setFechaDevolucion(fechaDevolucion);

            List<Integer> listaLibros = new ArrayList<>();
            if (librosSeleccionados != null) {
                for (String idLibroStr : librosSeleccionados) {
                    listaLibros.add(Integer.parseInt(idLibroStr));
                }
            }
            prestamo.setLibros(listaLibros);

            prestamoDAO.actualizar(prestamo);

            response.sendRedirect("prestamo?accion=listar");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("prestamo?accion=listar");
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idPrestamo = Integer.parseInt(request.getParameter("id"));
        prestamoDAO.eliminar(idPrestamo);
        response.sendRedirect("prestamo?accion=listar");
    }

    private void devolver(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idPrestamo = Integer.parseInt(request.getParameter("id"));
        java.util.Date fechaUtil = new java.util.Date();
        java.sql.Timestamp fechaDevolucion = new java.sql.Timestamp(fechaUtil.getTime());
        prestamoDAO.marcarComoDevuelto(idPrestamo, fechaDevolucion);
        response.sendRedirect("prestamo?accion=filtrar&tipo=vigentes");
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
