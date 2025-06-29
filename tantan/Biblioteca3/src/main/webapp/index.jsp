<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="app.modelos.Libro" %>
<%@ page import="app.modelos.CategoriaLibro" %>
<%
List<Libro> libros = (List<Libro>) request.getAttribute("libros");
List<CategoriaLibro> categorias = (List<CategoriaLibro>) request.getAttribute("categorias");
Integer categoriaSeleccionada = (Integer) request.getAttribute("categoriaSeleccionada");

// Lógica de paginación
int registrosPorPagina = 5;
int paginaActual = 1;
if (request.getParameter("pagina") != null) {
    try {
        paginaActual = Integer.parseInt(request.getParameter("pagina"));
        if (paginaActual < 1) paginaActual = 1;
    } catch (NumberFormatException e) {
        paginaActual = 1;
    }
}

int totalRegistros = libros != null ? libros.size() : 0;
int totalPaginas = (int) Math.ceil((double) totalRegistros / registrosPorPagina);
if (paginaActual > totalPaginas && totalPaginas > 0) paginaActual = totalPaginas;

int indiceInicial = (paginaActual - 1) * registrosPorPagina;
int indiceFinal = Math.min(indiceInicial + registrosPorPagina, totalRegistros);

List<Libro> librosPaginados = totalRegistros > 0 ?
    libros.subList(indiceInicial, indiceFinal) :
    libros;
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Biblioteca Arcana - Grimoires</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
    @import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600&family=Crimson+Text:ital,wght@0,400;0,600;1,400&display=swap');
    
    :root {
        --parchment: #f4f1e8;
        --dark-parchment: #e8e2d0;
        --leather: #8b4513;
        --dark-leather: #654321;
        --gold: #d4af37;
        --dark-gold: #b8941f;
        --emerald: #2d5016;
        --ruby: #722f37;
        --shadow: rgba(0,0,0,0.3);
        --text-primary: #2c1810;
    }
    
    body {
        background: linear-gradient(135deg, #1a1a1a 0%, #2d1b69 50%, #1a1a1a 100%);
        font-family: 'Crimson Text', serif;
        color: var(--text-primary);
        min-height: 100vh;
        position: relative;
    }
    
    body::before {
        content: '';
        position: fixed;
        top: 0; left: 0; width: 100%; height: 100%;
        background: 
            radial-gradient(circle at 20% 30%, rgba(212, 175, 55, 0.1) 0%, transparent 50%),
            radial-gradient(circle at 80% 70%, rgba(45, 80, 22, 0.1) 0%, transparent 50%);
        pointer-events: none;
        z-index: -1;
    }
    
    .container {
        background: var(--parchment);
        border-radius: 15px;
        box-shadow: 0 20px 40px var(--shadow);
        margin: 2rem auto;
        padding: 2rem;
        border: 3px solid var(--leather);
        position: relative;
    }
    
    .container::before {
        content: '';
        position: absolute;
        top: -3px; left: -3px; right: -3px; bottom: -3px;
        background: linear-gradient(45deg, var(--gold), var(--dark-gold), var(--gold));
        border-radius: 18px;
        z-index: -1;
    }
    
    h2 {
        font-family: 'Cinzel', serif;
        color: var(--leather);
        text-align: center;
        font-weight: 600;
        font-size: 2.5rem;
        text-shadow: 2px 2px 4px var(--shadow);
        margin-bottom: 2rem;
    }
    
    h2::after {
        content: '⚜';
        display: block;
        font-size: 1.2rem;
        color: var(--gold);
        margin-top: 0.5rem;
    }
    
    .search-grimoire {
        background: var(--dark-parchment);
        border: 2px solid var(--leather);
        border-radius: 10px;
        padding: 1.5rem;
        margin-bottom: 2rem;
        box-shadow: inset 0 2px 5px rgba(0,0,0,0.1);
    }
    
    .search-title {
        font-family: 'Cinzel', serif;
        color: var(--leather);
        font-weight: 600;
        margin-bottom: 1rem;
    }
    
    .form-select, .form-control {
        border: 2px solid var(--leather);
        background: var(--parchment);
        color: var(--text-primary);
        font-family: 'Crimson Text', serif;
    }
    
    .form-select:focus, .form-control:focus {
        border-color: var(--gold);
        box-shadow: 0 0 0 0.2rem rgba(212, 175, 55, 0.25);
    }
    
    .btn {
        font-family: 'Cinzel', serif;
        font-weight: 600;
        border: 2px solid;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }
    
    .btn::before {
        content: '';
        position: absolute;
        top: 0; left: -100%; width: 100%; height: 100%;
        background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.2), transparent);
        transition: left 0.5s ease;
    }
    
    .btn:hover::before { left: 100%; }
    
    .btn-primary {
        background: var(--leather);
        border-color: var(--dark-leather);
        color: var(--parchment);
    }
    
    .btn-primary:hover {
        background: var(--gold);
        border-color: var(--dark-gold);
        color: var(--text-primary);
        transform: translateY(-2px);
    }
    
    .btn-success {
        background: var(--emerald);
        border-color: #1f3f0f;
        color: var(--parchment);
    }
    
    .btn-success:hover {
        background: #16a34a;
        transform: translateY(-1px);
    }
    
    .btn-info {
        background: #1e3a8a;
        border-color: #1e40af;
        color: var(--parchment);
    }
    
    .btn-warning {
        background: #d97706;
        border-color: #b45309;
        color: white;
    }
    
    .btn-danger {
        background: var(--ruby);
        border-color: #5f1f1f;
        color: var(--parchment);
    }
    
    .btn-outline-secondary {
        border-color: var(--leather);
        color: var(--leather);
    }
    
    .btn-outline-secondary:hover {
        background: var(--leather);
        color: var(--parchment);
    }
    
    .table {
        background: var(--parchment);
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 10px 30px var(--shadow);
        border: 2px solid var(--leather);
    }
    
    .table thead th {
        background: linear-gradient(135deg, var(--leather), var(--dark-leather));
        color: var(--parchment);
        font-family: 'Cinzel', serif;
        font-weight: 600;
        text-align: center;
        border: none;
        padding: 1rem;
        position: relative;
    }
    
    .table thead th::after {
        content: '';
        position: absolute;
        bottom: 0; left: 0; right: 0; height: 2px;
        background: var(--gold);
    }
    
    .table tbody tr {
        transition: all 0.3s ease;
        background: var(--parchment);
    }
    
    .table tbody tr:nth-child(even) {
        background: var(--dark-parchment);
    }
    
    .table tbody tr:hover {
        background: rgba(212, 175, 55, 0.1);
        transform: scale(1.01);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .table td {
        border-color: rgba(139, 69, 19, 0.2);
        vertical-align: middle;
        text-align: center;
        padding: 0.8rem;
    }
    
    .badge {
        font-family: 'Cinzel', serif;
        font-size: 0.8rem;
        padding: 0.4rem 0.8rem;
        margin: 0.2rem;
        background: var(--emerald) !important;
        color: var(--parchment);
    }
    
    .btn-sm {
        font-size: 0.8rem;
        padding: 0.4rem 0.8rem;
        margin: 0.2rem;
        border-radius: 5px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-sm:hover {
        transform: translateY(-1px);
    }
    
    @keyframes sparkle {
        0%, 100% { opacity: 0; transform: scale(0); }
        50% { opacity: 1; transform: scale(1); }
    }
    
    .container::after {
        content: '✦';
        position: absolute;
        top: 1rem; right: 1rem;
        color: var(--gold);
        font-size: 1.5rem;
        animation: sparkle 3s infinite;
        animation-delay: 1s;
    }
    
    .modal-content {
        background: var(--parchment);
        border: 3px solid var(--leather);
        border-radius: 15px;
    }
    
    .modal-header {
        background: linear-gradient(135deg, var(--leather), var(--dark-leather));
        color: var(--parchment);
        border-bottom: 2px solid var(--gold);
    }
    
    .modal-title {
        font-family: 'Cinzel', serif;
        font-weight: 600;
    }
    /* Estilo paginador */
    .pagination .page-link {
        background: var(--dark-parchment);
        border: 1.5px solid var(--leather);
        color: var(--text-primary);
        font-family: 'Cinzel', serif;
        font-weight: 600;
        transition: all 0.3s;
    }
    .pagination .page-item.active .page-link {
        background: var(--gold);
        border-color: var(--dark-gold);
        color: var(--text-primary);
    }
    .pagination .page-link:hover {
        background: var(--gold);
        color: var(--text-primary);
        border-color: var(--dark-gold);
    }
</style>
</head>
<body>
<div class="container mt-4">
<h2 class="mb-3">Biblioteca de Grimoires Arcanos</h2>

<!-- Filtro de búsqueda -->
<div class="search-grimoire">
<h5 class="search-title"><i class="fas fa-search"></i> Buscar en los Archivos</h5>
<form action="libro" method="get" class="row g-3">
    <input type="hidden" name="accion" value="buscar">
    <div class="col-md-4">
        <label for="textoBusqueda" class="form-label">Buscar por texto (Título, Año, Serie, Tema, Categoría)</label>
        <input type="text" id="textoBusqueda" name="textoBusqueda" class="form-control" placeholder="Ingresa título, tema, serie, año..." value="<%= request.getParameter("textoBusqueda") != null ? request.getParameter("textoBusqueda") : "" %>">
    </div>
    <div class="col-md-4">
        <label for="idCategoria" class="form-label">Categoría del Grimoire</label>
        <select name="idCategoria" id="idCategoria" class="form-select">
            <option value="">-- Todas --</option>
            <% if (categorias != null) {
                for (CategoriaLibro categoria : categorias) {
                    String selected = "";
                    if (categoriaSeleccionada != null && categoria.getIdCategoria() == categoriaSeleccionada) {
                        selected = "selected";
                    }
            %>
                <option value="<%= categoria.getIdCategoria() %>" <%= selected %>><%= categoria.getDescripcion() %></option>
            <% }} %>
        </select>
    </div>
    <div class="col-md-2 d-flex align-items-end">
        <button type="submit" class="btn btn-primary mb-3">
            <i class="fas fa-search"></i> Buscar
        </button>
    </div>
    <div class="col-md-2 d-flex align-items-end">
        <a href="libro?accion=listar" class="btn btn-outline-secondary mb-3">
            <i class="fas fa-sync-alt"></i> Todos
        </a>
    </div>
</form>
</div>


<!-- Botón nuevo libro -->
<button type="button" class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#libroModal">
<i class="fas fa-plus"></i> Nuevo Grimoire
</button>

<!-- Paginador antes de la tabla -->
<% if (totalPaginas > 1) { %>
<nav aria-label="Paginación de grimoires" class="mb-3">
    <ul class="pagination justify-content-center">
        <li class="page-item <%= (paginaActual == 1) ? "disabled" : "" %>">
            <a class="page-link" href="libro?accion=listar<%= categoriaSeleccionada != null && categoriaSeleccionada > 0 ? "&idCategoria=" + categoriaSeleccionada : "" %>&pagina=<%= paginaActual-1 %>">
                <i class="fas fa-angle-left"></i>
            </a>
        </li>
        <% 
        int inicio = Math.max(1, paginaActual - 2);
        int fin = Math.min(totalPaginas, paginaActual + 2);
        if (inicio > 1) { %>
            <li class="page-item"><a class="page-link" href="libro?accion=listar<%= categoriaSeleccionada != null && categoriaSeleccionada > 0 ? "&idCategoria=" + categoriaSeleccionada : "" %>&pagina=1">1</a></li>
            <% if (inicio > 2) { %>
                <li class="page-item disabled"><span class="page-link">...</span></li>
            <% } %>
        <% }
        for (int i = inicio; i <= fin; i++) { %>
            <li class="page-item <%= (i == paginaActual) ? "active" : "" %>">
                <a class="page-link" href="libro?accion=listar<%= categoriaSeleccionada != null && categoriaSeleccionada > 0 ? "&idCategoria=" + categoriaSeleccionada : "" %>&pagina=<%= i %>"><%= i %></a>
            </li>
        <% }
        if (fin < totalPaginas) { 
            if (fin < totalPaginas - 1) { %>
                <li class="page-item disabled"><span class="page-link">...</span></li>
            <% } %>
            <li class="page-item"><a class="page-link" href="libro?accion=listar<%= categoriaSeleccionada != null && categoriaSeleccionada > 0 ? "&idCategoria=" + categoriaSeleccionada : "" %>&pagina=<%= totalPaginas %>"><%= totalPaginas %></a></li>
        <% } %>
        <li class="page-item <%= (paginaActual == totalPaginas) ? "disabled" : "" %>">
            <a class="page-link" href="libro?accion=listar<%= categoriaSeleccionada != null && categoriaSeleccionada > 0 ? "&idCategoria=" + categoriaSeleccionada : "" %>&pagina=<%= paginaActual+1 %>">
                <i class="fas fa-angle-right"></i>
            </a>
        </li>
    </ul>
    <div class="text-center">
        <small class="text-muted">Mostrando <%= indiceInicial + 1 %> - <%= indiceFinal %> de <%= totalRegistros %> registros</small>
    </div>
</nav>
<% } %>

<!-- Tabla de libros -->
<table class="table table-bordered">
<thead>
<tr>
<th><i class="fas fa-hashtag"></i> ID</th>
<th><i class="fas fa-book"></i> Título</th>
<th><i class="fas fa-calendar"></i> Año</th>
<th><i class="fas fa-bookmark"></i> Serie</th>
<th><i class="fas fa-tag"></i> Tema</th>
<th><i class="fas fa-folder"></i> Categoría</th>
<th><i class="fas fa-cogs"></i> Acciones</th>
</tr>
</thead>
<tbody>
<% if(librosPaginados != null && !librosPaginados.isEmpty()) {
for (Libro libro : librosPaginados) { %>
<tr>
<td><%= libro.getIdLibro() %></td>
<td><i class="fas fa-scroll"></i> <%= libro.getTitulo() %></td>
<td><%= libro.getAnio() %></td>
<td><%= libro.getSerie() %></td>
<td><%= libro.getTema() %></td>
<td><span class="badge"><%= libro.getDescripcionCategoria() %></span></td>
<td>
<button type="button" class="btn btn-sm btn-info" onclick="verDetalle(<%= libro.getIdLibro() %>, '<%= libro.getTitulo() %>', <%= libro.getAnio() %>, '<%= libro.getSerie() %>', '<%= libro.getTema() %>', '<%= libro.getDescripcionCategoria() %>')">
<i class="fas fa-eye"></i>
</button>
<button type="button" class="btn btn-sm btn-warning" onclick="editarLibro(<%= libro.getIdLibro() %>, '<%= libro.getTitulo() %>', <%= libro.getAnio() %>, '<%= libro.getSerie() %>', '<%= libro.getTema() %>', <%= libro.getIdCategoria() %>)">
<i class="fas fa-edit"></i>
</button>
<a href="libro?accion=eliminar&id=<%= libro.getIdLibro() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar este grimoire del archivo?')">
<i class="fas fa-trash"></i>
</a>
</td>
</tr>
<% }} else { %>
<tr>
<td colspan="7" class="text-center py-4">
    <div class="empty-state">
        <i class="fas fa-search fa-3x mb-3 text-muted"></i>
        <h5>No se encontraron grimoires</h5>
        <p class="text-muted">Intenta con diferentes criterios de búsqueda o agrega un nuevo grimoire.</p>
    </div>
</td>
</tr>
<% } %>
</tbody>
</table>

<a href="prestamo?accion=listar" class="btn btn-outline-secondary">
<i class="fas fa-exchange-alt"></i> Ver Préstamos
</a>
</div>

<!-- Modal para Libro -->
<div class="modal fade" id="libroModal" tabindex="-1">
<div class="modal-dialog modal-lg">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="libroModalLabel">
<i class="fas fa-book"></i> Nuevo Grimoire
</h5>
<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
</div>
<div class="modal-body">
<form id="libroForm" action="libro" method="post">
<input type="hidden" id="accion" name="accion" value="insertar">
<input type="hidden" id="idLibro" name="idLibro" value="">

<div class="mb-3">
<label for="titulo" class="form-label">Título del Grimoire</label>
<input type="text" class="form-control" id="titulo" name="titulo" required>
</div>

<div class="mb-3">
<label for="anio" class="form-label">Año de Creación</label>
<input type="number" class="form-control" id="anio" name="anio" required>
</div>

<div class="mb-3">
<label for="serie" class="form-label">Serie</label>
<input type="text" class="form-control" id="serie" name="serie" required>
</div>

<div class="mb-3">
<label for="tema" class="form-label">Tema Arcano</label>
<input type="text" class="form-control" id="tema" name="tema" required>
</div>

<div class="mb-3">
<label for="modalIdCategoria" class="form-label">Categoría</label>
<select class="form-select" id="modalIdCategoria" name="idCategoria" required>
<option value="">-- Seleccione una categoría --</option>
<% if (categorias != null) {
for (CategoriaLibro categoria : categorias) { %>
<option value="<%= categoria.getIdCategoria() %>"><%= categoria.getDescripcion() %></option>
<% }} %>
</select>
</div>
</form>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
<i class="fas fa-times"></i> Cancelar
</button>
<button type="button" class="btn btn-primary" onclick="document.getElementById('libroForm').submit()">
<i class="fas fa-save"></i> Guardar
</button>
</div>
</div>
</div>
</div>

<!-- Modal Detalles -->
<div class="modal fade" id="detalleModal" tabindex="-1">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title">
<i class="fas fa-info-circle"></i> Detalles del Grimoire
</h5>
<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
</div>
<div class="modal-body">
<div class="row mb-2">
<div class="col-4 fw-bold">ID:</div>
<div class="col-8" id="detalleId"></div>
</div>
<div class="row mb-2">
<div class="col-4 fw-bold">Título:</div>
<div class="col-8" id="detalleTitulo"></div>
</div>
<div class="row mb-2">
<div class="col-4 fw-bold">Año:</div>
<div class="col-8" id="detalleAnio"></div>
</div>
<div class="row mb-2">
<div class="col-4 fw-bold">Serie:</div>
<div class="col-8" id="detalleSerie"></div>
</div>
<div class="row mb-2">
<div class="col-4 fw-bold">Tema:</div>
<div class="col-8" id="detalleTema"></div>
</div>
<div class="row mb-2">
<div class="col-4 fw-bold">Categoría:</div>
<div class="col-8" id="detalleCategoria"></div>
</div>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
<i class="fas fa-times"></i> Cerrar
</button>
</div>
</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
function editarLibro(id, titulo, anio, serie, tema, idCategoria) {
    document.getElementById('libroModalLabel').innerHTML = '<i class="fas fa-edit"></i> Editar Grimoire';
    document.getElementById('accion').value = 'actualizar';
    document.getElementById('idLibro').value = id;
    document.getElementById('titulo').value = titulo;
    document.getElementById('anio').value = anio;
    document.getElementById('serie').value = serie;
    document.getElementById('tema').value = tema;
    document.getElementById('modalIdCategoria').value = idCategoria;
    
    var modal = new bootstrap.Modal(document.getElementById('libroModal'));
    modal.show();
}

function verDetalle(id, titulo, anio, serie, tema, categoria) {
    document.getElementById('detalleId').textContent = id;
    document.getElementById('detalleTitulo').textContent = titulo;
    document.getElementById('detalleAnio').textContent = anio;
    document.getElementById('detalleSerie').textContent = serie;
    document.getElementById('detalleTema').textContent = tema;
    document.getElementById('detalleCategoria').textContent = categoria;
    
    var modal = new bootstrap.Modal(document.getElementById('detalleModal'));
    modal.show();
}

// Reset form when adding new book
document.getElementById('libroModal').addEventListener('hidden.bs.modal', function () {
    if (document.getElementById('accion').value === 'insertar') {
        document.getElementById('libroForm').reset();
        document.getElementById('libroModalLabel').innerHTML = '<i class="fas fa-book"></i> Nuevo Grimoire';
    }
});
</script>
</body>
</html>
