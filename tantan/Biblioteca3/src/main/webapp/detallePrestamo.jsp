<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="app.modelos.Prestamo,app.modelos.Alumno,java.util.List,app.modelos.Libro,java.text.SimpleDateFormat" %>
<%
Prestamo prestamo = (Prestamo) request.getAttribute("prestamo");
Alumno alumno = (Alumno) request.getAttribute("alumnoDetalle");
List<Libro> libros = (List<Libro>) request.getAttribute("librosDetalle");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pergamino del Préstamo Arcano</title>
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
        margin: 2rem auto;
        padding: 2rem;
        position: relative;
        border: 3px solid var(--leather);
        max-width: 1200px;
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
    
    h2 {
        font-family: 'Cinzel', serif;
        color: var(--leather);
        text-align: center;
        font-weight: 600;
        font-size: 2.5rem;
        text-shadow: 2px 2px 4px var(--shadow);
        margin-bottom: 2rem;
        position: relative;
    }
    
    h2::after {
        content: '⚜';
        display: block;
        font-size: 1.2rem;
        color: var(--gold);
        margin-top: 0.5rem;
    }
    
    .card {
        background: var(--parchment);
        border: 2px solid var(--leather);
        border-radius: 15px;
        box-shadow: 0 15px 35px var(--shadow);
        overflow: hidden;
        position: relative;
    }
    
    .card::before {
        content: '';
        position: absolute;
        top: -2px;
        left: -2px;
        right: -2px;
        bottom: -2px;
        background: linear-gradient(45deg, var(--gold), var(--dark-gold), var(--gold));
        border-radius: 17px;
        z-index: -1;
    }
    
    .card-header {
        background: linear-gradient(135deg, var(--leather), var(--dark-leather));
        color: var(--parchment);
        font-family: 'Cinzel', serif;
        font-weight: 600;
        font-size: 1.3rem;
        text-align: center;
        border: none;
        padding: 1.2rem;
        position: relative;
    }
    
    .card-header::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 3px;
        background: var(--gold);
    }
    
    .card-header::before {
        content: '📜';
        position: absolute;
        left: 1rem;
        top: 50%;
        transform: translateY(-50%);
        font-size: 1.5rem;
    }
    
    .card-body {
        padding: 2rem;
        background: var(--parchment);
    }
    
    .card-title {
        font-family: 'Cinzel', serif;
        color: var(--leather);
        font-weight: 600;
        font-size: 1.5rem;
        margin-bottom: 1.5rem;
        text-align: center;
        position: relative;
    }
    
    .card-title::after {
        content: '';
        display: block;
        width: 100px;
        height: 2px;
        background: var(--gold);
        margin: 0.5rem auto;
    }
    
    .info-section {
        background: var(--dark-parchment);
        border-radius: 10px;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        border-left: 4px solid var(--gold);
        position: relative;
    }
    
    .info-section::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        width: 2px;
        background: linear-gradient(to bottom, transparent, var(--gold), transparent);
    }
    
    .info-row {
        display: flex;
        flex-wrap: wrap;
        margin-bottom: 1rem;
        align-items: center;
    }
    
    .info-label {
        font-family: 'Cinzel', serif;
        font-weight: 600;
        color: var(--leather);
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .info-value {
        color: var(--text-primary);
        font-weight: 500;
        font-size: 1.1rem;
    }
    
    .status-badge {
        display: inline-block;
        padding: 0.5rem 1rem;
        border-radius: 25px;
        font-family: 'Cinzel', serif;
        font-weight: 600;
        font-size: 0.9rem;
        text-align: center;
        position: relative;
        overflow: hidden;
    }
    
    .status-active {
        background: linear-gradient(135deg, #d97706, #f59e0b);
        color: white;
        border: 2px solid var(--dark-gold);
    }
    
    .status-returned {
        background: linear-gradient(135deg, var(--emerald), #16a34a);
        color: white;
        border: 2px solid #1f3f0f;
    }
    
    .books-section {
        background: var(--dark-parchment);
        border-radius: 10px;
        padding: 1.5rem;
        margin-top: 1.5rem;
        border: 2px solid var(--leather);
        position: relative;
    }
    
    .books-section::before {
        content: '📚';
        position: absolute;
        top: -15px;
        left: 20px;
        background: var(--parchment);
        padding: 0 0.5rem;
        font-size: 1.5rem;
    }
    
    .books-title {
        font-family: 'Cinzel', serif;
        color: var(--leather);
        font-weight: 600;
        font-size: 1.3rem;
        margin-bottom: 1rem;
        text-align: center;
    }
    
    .book-item {
        background: var(--parchment);
        border-radius: 8px;
        padding: 1rem;
        margin-bottom: 1rem;
        border: 1px solid var(--leather);
        transition: all 0.3s ease;
        position: relative;
    }
    
    .book-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        background: rgba(212, 175, 55, 0.1);
    }
    
    .book-item::before {
        content: '📖';
        position: absolute;
        top: 0.5rem;
        right: 0.5rem;
        font-size: 1.2rem;
    }
    
    .book-title {
        font-weight: 600;
        color: var(--leather);
        margin-bottom: 0.5rem;
        font-size: 1.1rem;
    }
    
    .book-details {
        color: var(--text-secondary);
        font-size: 0.95rem;
    }
    
    .no-books {
        text-align: center;
        color: var(--text-secondary);
        font-style: italic;
        padding: 2rem;
        background: rgba(139, 69, 19, 0.1);
        border-radius: 8px;
        border: 2px dashed var(--leather);
    }
    
    .btn {
        font-family: 'Cinzel', serif;
        font-weight: 600;
        border-radius: 8px;
        padding: 0.8rem 1.5rem;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        text-decoration: none;
        display: inline-block;
    }
    
    .btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: left 0.5s ease;
    }
    
    .btn:hover::before {
        left: 100%;
    }
    
    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px var(--shadow);
    }
    
    .btn-secondary {
        background: var(--leather);
        border-color: var(--dark-leather);
        color: var(--parchment);
    }
    
    .btn-secondary:hover {
        background: var(--gold);
        border-color: var(--dark-gold);
        color: var(--text-primary);
    }
    
    @keyframes sparkle {
        0%, 100% { opacity: 0; transform: scale(0); }
        50% { opacity: 1; transform: scale(1); }
    }
    
    /* Responsive Design */
    @media (max-width: 768px) {
        .container {
            margin: 1rem;
            padding: 1rem;
        }
        
        h2 {
            font-size: 2rem;
        }
        
        .card-header {
            font-size: 1.1rem;
            padding: 1rem;
        }
        
        .card-body {
            padding: 1rem;
        }
        
        .info-section {
            padding: 1rem;
        }
        
        .info-row {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .info-label {
            margin-bottom: 0.3rem;
        }
        
        .books-section {
            padding: 1rem;
        }
        
        .book-item {
            padding: 0.8rem;
        }
        
        .container::after {
            display: none;
        }
    }
    
    @media (max-width: 576px) {
        .container {
            margin: 0.5rem;
            padding: 0.8rem;
            border-radius: 10px;
        }
        
        h2 {
            font-size: 1.8rem;
        }
        
        .card-header::before {
            display: none;
        }
        
        .books-section::before {
            position: static;
            display: block;
            text-align: center;
            margin-bottom: 1rem;
            background: none;
            padding: 0;
        }
        
        .btn {
            width: 100%;
            margin-top: 1rem;
        }
    }
    
    /* Animaciones adicionales */
    .card {
        animation: fadeInUp 0.8s ease-out;
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .book-item {
        animation: slideInLeft 0.6s ease-out;
        animation-fill-mode: both;
    }
    
    .book-item:nth-child(1) { animation-delay: 0.1s; }
    .book-item:nth-child(2) { animation-delay: 0.2s; }
    .book-item:nth-child(3) { animation-delay: 0.3s; }
    .book-item:nth-child(4) { animation-delay: 0.4s; }
    .book-item:nth-child(5) { animation-delay: 0.5s; }
    
    @keyframes slideInLeft {
        from {
            opacity: 0;
            transform: translateX(-30px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
</style>
</head>
<body>
<div class="container">
    <h2>Pergamino del Préstamo Arcano</h2>
    
    <div class="card">
        <div class="card-header">
            Registro Místico #<%= prestamo.getIdPrestamo() %>
        </div>
        <div class="card-body">
            <h5 class="card-title">
                <i class="fas fa-user-graduate"></i>
                <%= alumno != null ? alumno.getNombres() + " " + alumno.getApellidos() : prestamo.getNombreAlumno() %>
            </h5>
            
            <div class="info-section">
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <div class="info-row">
                            <div class="col-12">
                                <div class="info-label">
                                    <i class="fas fa-user-shield"></i>
                                    Guardián de los Tomos:
                                </div>
                                <div class="info-value"><%= prestamo.getNombreUsuario() %></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12">
                        <div class="info-row">
                            <div class="col-12">
                                <div class="info-label">
                                    <i class="fas fa-calendar-alt"></i>
                                    Fecha de Préstamo:
                                </div>
                                <div class="info-value">
                                    <%= prestamo.getFechaPrestamo() != null ? sdf.format(prestamo.getFechaPrestamo()) : "-" %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row mt-3">
                    <div class="col-12">
                        <div class="info-row">
                            <div class="col-12">
                                <div class="info-label">
                                    <i class="fas fa-calendar-check"></i>
                                    Estado del Préstamo:
                                </div>
                                <div class="info-value">
                                    <% if (prestamo.getFechaDevolucion() != null) { %>
                                        <span class="status-badge status-returned">
                                            <i class="fas fa-check-circle"></i>
                                            Devuelto el <%= sdf.format(prestamo.getFechaDevolucion()) %>
                                        </span>
                                    <% } else { %>
                                        <span class="status-badge status-active">
                                            <i class="fas fa-hourglass-half"></i>
                                            En préstamo activo
                                        </span>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="books-section">
                <h6 class="books-title">
                    <i class="fas fa-book-open"></i>
                    Grimoires Prestados
                </h6>
                
                <% if (libros != null && libros.size() > 0) {
                    for (Libro libro : libros) { %>
                    <div class="book-item">
                        <div class="book-title">
                            <i class="fas fa-book"></i>
                            <%= libro.getTitulo() %>
                        </div>
                        <div class="book-details">
                            <div class="row">
                                <div class="col-md-6">
                                    <strong>Serie:</strong> <%= libro.getSerie() %>
                                </div>
                                <div class="col-md-6">
                                    <strong>Categoría:</strong> <%= libro.getDescripcionCategoria() %>
                                </div>
                            </div>
                        </div>
                    </div>
                <% }} else { %>
                    <div class="no-books">
                        <i class="fas fa-exclamation-triangle fa-2x mb-2"></i>
                        <p>No hay grimoires registrados en este préstamo.</p>
                    </div>
                <% } %>
            </div>
            
            <div class="text-center">
                <a href="prestamo?accion=listar" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Regresar a los Archivos
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>