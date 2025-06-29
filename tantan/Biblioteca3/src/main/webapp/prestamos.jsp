<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="app.modelos.Prestamo" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
List<Prestamo> prestamos = (List<Prestamo>) request.getAttribute("prestamos");
String filtro = request.getAttribute("filtro") != null ? (String)request.getAttribute("filtro") : "todos";
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Archivos de la Biblioteca Arcana</title>
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
        --text-secondary: #5d4037;
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
            radial-gradient(circle at 80% 70%, rgba(45, 80, 22, 0.1) 0%, transparent 50%),
            url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="%23000" opacity="0.05"/><circle cx="75" cy="75" r="1" fill="%23000" opacity="0.05"/><circle cx="50" cy="10" r="0.5" fill="%23000" opacity="0.03"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
        pointer-events: none;
        z-index: -1;
    }
    
    .container {
        background: var(--parchment);
        border-radius: 15px;
        box-shadow: 
            0 20px 40px var(--shadow),
            inset 0 1px 0 rgba(255,255,255,0.3);
        margin: 1rem auto;
        padding: 1.5rem;
        position: relative;
        border: 3px solid var(--leather);
        max-width: 100%;
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
        font-size: clamp(1.8rem, 4vw, 2.5rem);
        text-shadow: 2px 2px 4px var(--shadow);
        margin-bottom: 2rem;
        position: relative;
    }
    
    h2::after {
        content: '⚜';
        display: block;
        font-size: clamp(1rem, 2vw, 1.2rem);
        color: var(--gold);
        margin-top: 0.5rem;
    }
    
    /* Botones responsive */
    .btn-group {
        width: 100%;
        gap: 0.5rem;
    }
    
    .btn-group .btn {
        font-family: 'Cinzel', serif;
        font-weight: 600;
        border: 2px solid var(--leather);
        background: var(--dark-parchment);
        color: var(--text-primary);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        flex: 1;
        font-size: clamp(0.8rem, 2vw, 1rem);
        padding: 0.75rem 0.5rem;
        text-align: center;
        white-space: nowrap;
    }
    
    .btn-group .btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.2), transparent);
        transition: left 0.5s ease;
    }
    
    .btn-group .btn:hover::before {
        left: 100%;
    }
    
    .btn-group .btn:hover {
        background: var(--gold);
        color: var(--text-primary);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px var(--shadow);
    }
    
    .btn-group .btn.active {
        background: var(--emerald);
        color: var(--parchment);
        border-color: var(--dark-gold);
    }
    
    .btn-primary {
        background: var(--leather);
        border-color: var(--dark-leather);
        font-family: 'Cinzel', serif;
        font-weight: 600;
        transition: all 0.3s ease;
        width: 100%;
        margin-bottom: 1rem;
    }
    
    .btn-primary:hover {
        background: var(--gold);
        border-color: var(--dark-gold);
        color: var(--text-primary);
        transform: translateY(-2px);
        box-shadow: 0 8px 20px var(--shadow);
    }
    
    /* Tabla responsive */
    .table-responsive {
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 10px 30px var(--shadow);
        border: 2px solid var(--leather);
        margin-bottom: 1rem;
    }
    
    .table {
        background: var(--parchment);
        margin-bottom: 0;
        font-size: clamp(0.8rem, 1.5vw, 1rem);
    }
    
    .table thead th {
        background: linear-gradient(135deg, var(--leather), var(--dark-leather));
        color: var(--parchment);
        font-family: 'Cinzel', serif;
        font-weight: 600;
        text-align: center;
        border: none;
        padding: 1rem 0.5rem;
        position: relative;
        white-space: nowrap;
        font-size: clamp(0.7rem, 1.2vw, 0.9rem);
    }
    
    .table thead th::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 2px;
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
        padding: 0.75rem 0.5rem;
        word-wrap: break-word;
        max-width: 150px;
    }
    
    .badge {
        font-family: 'Cinzel', serif;
        font-size: clamp(0.6rem, 1vw, 0.8rem);
        padding: 0.3rem 0.6rem;
        margin: 0.1rem;
        display: inline-block;
        word-break: break-word;
    }
    
    .badge.bg-success {
        background: var(--emerald) !important;
        color: var(--parchment);
    }
    
    .badge.bg-info {
        background: #1e3a8a !important;
        color: var(--parchment);
    }
    
    .badge.bg-warning {
        background: #d97706 !important;
        color: var(--text-primary);
    }
    
    /* Botones de acción responsive */
    .action-buttons {
        display: flex;
        flex-direction: column;
        gap: 0.3rem;
        align-items: center;
        min-width: 120px;
    }
    
    .btn-sm {
        font-size: clamp(0.6rem, 1vw, 0.75rem);
        padding: 0.3rem 0.6rem;
        border-radius: 5px;
        font-family: 'Crimson Text', serif;
        font-weight: 600;
        transition: all 0.3s ease;
        width: 100%;
        max-width: 120px;
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
    }
    
    .btn-info {
        background: #1e3a8a;
        border-color: #1e40af;
    }
    
    .btn-info:hover {
        background: #3b82f6;
        transform: translateY(-1px);
    }
    
    .btn-warning {
        background: #d97706;
        border-color: #b45309;
    }
    
    .btn-warning:hover {
        background: #f59e0b;
        transform: translateY(-1px);
    }
    
    .btn-danger {
        background: var(--ruby);
        border-color: #5f1f1f;
    }
    
    .btn-danger:hover {
        background: #dc2626;
        transform: translateY(-1px);
    }
    
    .btn-success {
        background: var(--emerald);
        border-color: #1f3f0f;
    }
    
    .btn-success:hover {
        background: #16a34a;
        transform: translateY(-1px);
    }
    
    .btn-outline-secondary {
        border-color: var(--leather);
        color: var(--leather);
        font-family: 'Cinzel', serif;
        font-weight: 600;
        width: 100%;
    }
    
    .btn-outline-secondary:hover {
        background: var(--leather);
        border-color: var(--leather);
        color: var(--parchment);
    }
    
    /* Efectos mágicos */
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
        font-size: clamp(1rem, 2vw, 1.5rem);
        animation: sparkle 3s infinite;
        animation-delay: 1s;
    }
    
    /* Responsive breakpoints */
    @media (max-width: 768px) {
        .container {
            margin: 0.5rem;
            padding: 1rem;
            border-radius: 10px;
        }
        
        .btn-group {
            flex-direction: column;
            width: 100%;
        }
        
        .btn-group .btn {
            margin-bottom: 0.5rem;
            white-space: normal;
            line-height: 1.2;
        }
        
        .table thead th {
            padding: 0.5rem 0.25rem;
            font-size: 0.7rem;
        }
        
        .table td {
            padding: 0.5rem 0.25rem;
            font-size: 0.8rem;
        }
        
        .action-buttons {
            gap: 0.2rem;
        }
        
        .btn-sm {
            font-size: 0.6rem;
            padding: 0.25rem 0.4rem;
        }
        
        h2 {
            margin-bottom: 1rem;
        }
    }
    
    @media (max-width: 576px) {
        .container {
            margin: 0.25rem;
            padding: 0.75rem;
        }
        
        .table-responsive {
            border-radius: 5px;
        }
        
        .table thead th i,
        .table td i {
            display: none;
        }
        
        .badge {
            font-size: 0.6rem;
            padding: 0.2rem 0.4rem;
        }
        
        .btn-sm {
            font-size: 0.5rem;
            padding: 0.2rem 0.3rem;
        }
    }
    
    /* Ocultar texto en móviles muy pequeños */
    @media (max-width: 480px) {
        .btn-group .btn {
            font-size: 0.7rem;
        }
        
        .table thead th {
            font-size: 0.6rem;
            padding: 0.4rem 0.2rem;
        }
        
        .table td {
            font-size: 0.7rem;
            padding: 0.4rem 0.2rem;
        }
        
        /* Simplificar botones de acción en móviles */
        .btn-sm .fas {
            margin-right: 0;
        }
        
        .btn-sm {
            padding: 0.2rem;
            min-height: 28px;
        }
    }
</style>
</head>
<body>
<div class="container">
<h2 class="mb-3">Archivos de Préstamos Arcanos</h2>

<form method="get" action="prestamo" class="mb-3">
<input type="hidden" name="accion" value="filtrar">
<div class="btn-group mb-3" role="group">
<button type="submit" name="tipo" value="todos" class="btn <%= "todos".equals(filtro) ? "active" : "" %>">
    <i class="fas fa-scroll"></i> <span class="d-none d-sm-inline">Todos los Registros</span><span class="d-sm-none">Todos</span>
</button>
<button type="submit" name="tipo" value="vigentes" class="btn <%= "vigentes".equals(filtro) ? "active" : "" %>">
    <i class="fas fa-hourglass-half"></i> <span class="d-none d-sm-inline">Grimoires Prestados</span><span class="d-sm-none">Prestados</span>
</button>
<button type="submit" name="tipo" value="devueltos" class="btn <%= "devueltos".equals(filtro) ? "active" : "" %>">
    <i class="fas fa-check-circle"></i> <span class="d-none d-sm-inline">Tomos Devueltos</span><span class="d-sm-none">Devueltos</span>
</button>
</div>
</form>

<a href="prestamo?accion=nuevo" class="btn btn-primary mb-3">
    <i class="fas fa-plus"></i> <span class="d-none d-sm-inline">Registrar Nuevo Préstamo</span><span class="d-sm-none">Nuevo Préstamo</span>
</a>

<div class="table-responsive">
<table class="table table-bordered">
<thead>
<tr>
<th><i class="fas fa-hashtag"></i> <span class="d-none d-md-inline">ID</span></th>
<th><i class="fas fa-user-graduate"></i> <span class="d-none d-sm-inline">Aprendiz</span><span class="d-sm-none">Usuario</span></th>
<th class="d-none d-lg-table-cell"><i class="fas fa-user-tie"></i> Bibliotecario</th>
<th><i class="fas fa-calendar-alt"></i> <span class="d-none d-md-inline">Fecha Préstamo</span><span class="d-md-none">F.Préstamo</span></th>
<th><i class="fas fa-calendar-check"></i> <span class="d-none d-md-inline">Fecha Devolución</span><span class="d-md-none">F.Devolución</span></th>
<th class="d-none d-sm-table-cell"><i class="fas fa-book"></i> <span class="d-none d-md-inline">Código Grimorio</span><span class="d-md-none">Grimorio</span></th>
<th><i class="fas fa-cogs"></i> <span class="d-none d-sm-inline">Acciones</span></th>
</tr>
</thead>
<tbody>
<% if(prestamos != null) {
for (Prestamo p : prestamos) { %>
<tr>
<td><%= p.getIdPrestamo() %></td>
<td><i class="fas fa-user d-none d-sm-inline"></i> <%= p.getNombreAlumno() %></td>
<td class="d-none d-lg-table-cell"><i class="fas fa-user-shield"></i> <%= p.getNombreUsuario() %></td>
<td><%= p.getFechaPrestamo() != null ? sdf.format(p.getFechaPrestamo()) : "" %></td>
<td>
<% if (p.getFechaDevolucion() != null) { %>
<span class="badge bg-success">
    <i class="fas fa-check"></i> <span class="d-none d-md-inline"><%= sdf.format(p.getFechaDevolucion()) %></span><span class="d-md-none">Devuelto</span>
</span>
<% } else { %>
<span class="badge bg-warning text-dark">
    <i class="fas fa-clock"></i> <span class="d-none d-sm-inline">En préstamo</span><span class="d-sm-none">Prestado</span>
</span>
<% } %>
</td>
<td class="d-none d-sm-table-cell">
<% if (p.getLibros() != null) { %>
<% for (Integer idLibro : p.getLibros()) { %>
<span class="badge bg-info"><i class="fas fa-book"></i> <%= idLibro %></span>
<% } %>
<% } %>
</td>
<td>
<div class="action-buttons">
<a href="prestamo?accion=detalle&id=<%= p.getIdPrestamo() %>" class="btn btn-sm btn-info">
    <i class="fas fa-eye"></i> <span class="d-none d-md-inline">Detalles</span>
</a>
<a href="prestamo?accion=editar&id=<%= p.getIdPrestamo() %>" class="btn btn-sm btn-warning">
    <i class="fas fa-edit"></i> <span class="d-none d-md-inline">Editar</span>
</a>
<a href="prestamo?accion=eliminar&id=<%= p.getIdPrestamo() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Seguro de eliminar este registro arcano?')">
    <i class="fas fa-trash"></i> <span class="d-none d-md-inline">Eliminar</span>
</a>
<%-- Solo mostrar "Marcar como devuelto" si está vigente (sin fecha de devolución) --%>
<% if (p.getFechaDevolucion() == null) { %>
<a href="prestamo?accion=devolver&id=<%= p.getIdPrestamo() %>" class="btn btn-sm btn-success" onclick="return confirm('¿Registrar la devolución del grimoire?')">
    <i class="fas fa-undo"></i> <span class="d-none d-md-inline">Devolver</span>
</a>
<% } %>
</div>
</td>
</tr>
<% }} %>
</tbody>
</table>
</div>

<a href="inicio.jsp" class="btn btn-outline-secondary">
    <i class="fas fa-home"></i> <span class="d-none d-sm-inline">Regresar al Sanctum</span><span class="d-sm-none">Inicio</span>
</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>