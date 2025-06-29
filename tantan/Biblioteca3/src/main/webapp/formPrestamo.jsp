<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="app.modelos.Prestamo" %>
<%@ page import="app.modelos.Libro" %>
<%@ page import="app.modelos.Alumno" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
Prestamo prestamo = (Prestamo) request.getAttribute("prestamo");
List<Libro> libros = (List<Libro>) request.getAttribute("libros");
List<Alumno> alumnos = (List<Alumno>) request.getAttribute("alumnos");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title><%= (prestamo != null ? "Editar" : "Nuevo") %> Préstamo Arcano</title>
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
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: 
        radial-gradient(circle at 20% 30%, rgba(212, 175, 55, 0.1) 0%, transparent 50%),
        radial-gradient(circle at 80% 70%, rgba(45, 80, 22, 0.1) 0%, transparent 50%);
    pointer-events: none;
    z-index: -1;
}

.container {
    background: var(--parchment);
    border-radius: 15px;
    box-shadow: 0 20px 40px var(--shadow), inset 0 1px 0 rgba(255,255,255,0.3);
    margin: 2rem auto;
    padding: 2rem;
    position: relative;
    border: 3px solid var(--leather);
}

.container::before {
    content: '';
    position: absolute;
    top: -3px;
    left: -3px;
    right: -3px;
    bottom: -3px;
    background: linear-gradient(45deg, var(--gold), var(--dark-gold), var(--gold));
    border-radius: 18px;
    z-index: -1;
}

h2 {
    font-family: 'Cinzel', serif;
    color: var(--leather);
    text-align: center;
    font-weight: 600;
    font-size: 2.2rem;
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

.form-label {
    font-family: 'Cinzel', serif;
    font-weight: 600;
    color: var(--leather);
    margin-bottom: 0.5rem;
}

.form-control, .form-select {
    border: 2px solid var(--leather);
    border-radius: 8px;
    background: var(--dark-parchment);
    color: var(--text-primary);
    transition: all 0.3s ease;
    padding: 0.8rem;
}

.form-control:focus, .form-select:focus {
    border-color: var(--gold);
    box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
    background: var(--parchment);
}

.form-select[multiple] {
    min-height: 120px;
}

.btn-success {
    background: var(--emerald);
    border-color: var(--emerald);
    font-family: 'Cinzel', serif;
    font-weight: 600;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.btn-success::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.2), transparent);
    transition: left 0.5s ease;
}

.btn-success:hover::before {
    left: 100%;
}

.btn-success:hover {
    background: #16a34a;
    border-color: #16a34a;
    transform: translateY(-2px);
    box-shadow: 0 8px 20px var(--shadow);
}

.btn-secondary {
    background: var(--dark-parchment);
    border-color: var(--leather);
    color: var(--text-primary);
    font-family: 'Cinzel', serif;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn-secondary:hover {
    background: var(--leather);
    border-color: var(--leather);
    color: var(--parchment);
    transform: translateY(-2px);
}

@keyframes sparkle {
    0%, 100% { opacity: 0; transform: scale(0); }
    50% { opacity: 1; transform: scale(1); }
}

.container::after {
    content: '✦';
    position: absolute;
    top: 1rem;
    right: 1rem;
    color: var(--gold);
    font-size: 1.5rem;
    animation: sparkle 3s infinite;
    animation-delay: 1s;
}
</style>
</head>
<body>
<div class="container mt-4">
<h2 class="mb-3"><%= (prestamo != null ? "Editar" : "Nuevo") %> Préstamo Arcano</h2>
<form action="prestamo?accion=<%= (prestamo != null ? "actualizar" : "insertar") %>" method="post">
<% if(prestamo != null) { %>
<input type="hidden" name="idPrestamo" value="<%= prestamo.getIdPrestamo() %>">
<% } %>

<div class="mb-3">
<label for="idAlumno" class="form-label">
    <i class="fas fa-user-graduate me-2"></i>Aprendiz
</label>
<select class="form-select" id="idAlumno" name="idAlumno" required>
<option value="">Seleccione un aprendiz</option>
<% for(Alumno a : alumnos) { %>
<option value="<%= a.getIdAlumno() %>" <%= (prestamo != null && a.getIdAlumno() == prestamo.getIdAlumno() ? "selected" : "") %>><%= a.getNombres() %></option>
<% } %>
</select>
</div>

<div class="mb-3">
<label for="libros" class="form-label">
    <i class="fas fa-book me-2"></i>Grimoires (Mantén Ctrl para seleccionar múltiples)
</label>
<select class="form-select" id="libros" name="libros" multiple required>
<% for(Libro l : libros) { %>
<option value="<%= l.getIdLibro() %>"
<% if(prestamo != null && prestamo.getLibros() != null && prestamo.getLibros().contains(l.getIdLibro())) { %>selected<% } %>>
<%= l.getTitulo() %>
</option>
<% } %>
</select>
</div>

<div class="mb-3">
<label for="fechaPrestamo" class="form-label">
    <i class="fas fa-calendar-alt me-2"></i>Fecha de Préstamo
</label>
<input type="date" class="form-control" id="fechaPrestamo" name="fechaPrestamo"
value="<%= prestamo != null && prestamo.getFechaPrestamo() != null ? sdf.format(prestamo.getFechaPrestamo()) : sdf.format(new java.util.Date()) %>" required>
</div>

<div class="mb-3">
<label for="fechaDevolucion" class="form-label">
    <i class="fas fa-calendar-check me-2"></i>Fecha de Devolución (Opcional)
</label>
<input type="date" class="form-control" id="fechaDevolucion" name="fechaDevolucion"
value="<%= prestamo != null && prestamo.getFechaDevolucion() != null ? sdf.format(prestamo.getFechaDevolucion()) : "" %>">
</div>

<div class="d-grid gap-2 d-md-flex justify-content-md-center">
<button type="submit" class="btn btn-success btn-lg me-2">
    <i class="fas fa-save me-2"></i>Registrar en los Archivos
</button>
<a href="prestamo?accion=listar" class="btn btn-secondary btn-lg">
    <i class="fas fa-arrow-left me-2"></i>Regresar a los Archivos
</a>
</div>
</form>
</div>
</body>
</html>