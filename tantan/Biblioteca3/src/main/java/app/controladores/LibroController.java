package app.controladores;

import app.dao.LibroDAO;
import app.dao.CategoriaLibroDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import app.modelos.Libro;
import app.modelos.CategoriaLibro;

@WebServlet(name = "LibroController", urlPatterns = {"/libro"})
public class LibroController extends HttpServlet {
    private LibroDAO libroDAO;
    private CategoriaLibroDAO categoriaDAO;
    
    public LibroController() {
        this.libroDAO = new LibroDAO();
        this.categoriaDAO = new CategoriaLibroDAO();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }
        
        switch (accion) {
            case "listar":
                listar(request, response);
                break;
            case "buscar":
                buscar(request, response);
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
            default:
                listar(request, response);
        }
    }
     
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Libro> libros = libroDAO.listar();
        List<CategoriaLibro> categorias = categoriaDAO.listar();
        
        request.setAttribute("libros", libros);
        request.setAttribute("categorias", categorias);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }
    
    private void buscar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String textoBusqueda = request.getParameter("textoBusqueda");
        String idCategoriaStr = request.getParameter("idCategoria");

        Integer idCategoria = null;
        if (idCategoriaStr != null && !idCategoriaStr.isEmpty()) {
            try {
                idCategoria = Integer.parseInt(idCategoriaStr);
            } catch (NumberFormatException e) {
                idCategoria = null;
            }
        }

        List<Libro> libros = libroDAO.buscarPorTextoYCategoria(textoBusqueda, idCategoria);
        List<CategoriaLibro> categorias = categoriaDAO.listar();

        request.setAttribute("libros", libros);
        request.setAttribute("categorias", categorias);

        if (idCategoria != null) {
            request.setAttribute("categoriaSeleccionada", idCategoria);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }

    
    private void nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<CategoriaLibro> categorias = categoriaDAO.listar();
        request.setAttribute("categorias", categorias);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/formLibro.jsp");
        dispatcher.forward(request, response);
    }
    
    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String titulo = request.getParameter("titulo");
        int anio = Integer.parseInt(request.getParameter("anio"));
        String serie = request.getParameter("serie");
        String tema = request.getParameter("tema");
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        
        Libro libro = new Libro();
        libro.setTitulo(titulo);
        libro.setAnio(anio);
        libro.setSerie(serie);
        libro.setTema(tema);
        libro.setIdCategoria(idCategoria);
        libro.setEstado(1);
        
        libroDAO.agregar(libro);
        
        response.sendRedirect(request.getContextPath() + "/libro?accion=listar");
    }
    
    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idLibro = Integer.parseInt(request.getParameter("id"));
        Libro libro = libroDAO.buscarPorId(idLibro);
        List<CategoriaLibro> categorias = categoriaDAO.listar();
        
        request.setAttribute("libro", libro);
        request.setAttribute("categorias", categorias);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/formLibro.jsp");
        dispatcher.forward(request, response);
    }
    
    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idLibro = Integer.parseInt(request.getParameter("idLibro"));
        String titulo = request.getParameter("titulo");
        int anio = Integer.parseInt(request.getParameter("anio"));
        String serie = request.getParameter("serie");
        String tema = request.getParameter("tema");
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        
        Libro libro = new Libro();
        libro.setIdLibro(idLibro);
        libro.setTitulo(titulo);
        libro.setAnio(anio);
        libro.setSerie(serie);
        libro.setTema(tema);
        libro.setIdCategoria(idCategoria);
        
        libroDAO.actualizar(libro);
        
        response.sendRedirect(request.getContextPath() + "/libro?accion=listar");
    }
    
    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idLibro = Integer.parseInt(request.getParameter("id"));
        libroDAO.eliminar(idLibro);
        
        response.sendRedirect(request.getContextPath() + "/libro?accion=listar");
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