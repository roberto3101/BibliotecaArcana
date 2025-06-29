<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca Arcana - Sanctum Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600&family=Crimson+Text:wght@400;600&display=swap');
        
        :root {
            --parchment: #f4f1e8;
            --dark-parchment: #e8e2d0;
            --leather: #8b4513;
            --dark-leather: #654321;
            --gold: #d4af37;
            --emerald: #2d5016;
            --ruby: #722f37;
            --shadow: rgba(0,0,0,0.3);
        }
        
        body {
            background: linear-gradient(135deg, #1a1a1a 0%, #2d1b69 50%, #1a1a1a 100%);
            font-family: 'Crimson Text', serif;
            color: #2c1810;
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
        
        .main-container {
            background: var(--parchment);
            border-radius: 15px;
            box-shadow: 0 20px 40px var(--shadow), inset 0 1px 0 rgba(255,255,255,0.3);
            margin: 2rem auto;
            padding: 2rem;
            position: relative;
            border: 3px solid var(--leather);
        }
        
        .main-container::before {
            content: '';
            position: absolute;
            top: -3px; left: -3px; right: -3px; bottom: -3px;
            background: linear-gradient(45deg, var(--gold), #b8941f, var(--gold));
            border-radius: 18px;
            z-index: -1;
        }
        
        .navbar {
            background: linear-gradient(135deg, var(--leather), var(--dark-leather));
            border-radius: 10px;
            margin-bottom: 2rem;
            border: 2px solid var(--gold);
        }
        
        .navbar-brand {
            font-family: 'Cinzel', serif;
            font-weight: 600;
            color: var(--parchment) !important;
            font-size: 1.8rem;
        }
        
        .nav-link {
            color: var(--parchment) !important;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .nav-link:hover {
            color: var(--gold) !important;
            transform: translateY(-2px);
        }
        
        .hero-section {
            text-align: center;
            padding: 3rem 0;
            background: linear-gradient(135deg, var(--dark-parchment), var(--parchment));
            border-radius: 15px;
            margin-bottom: 3rem;
            border: 2px solid var(--leather);
            position: relative;
        }
        
        .hero-title {
            font-family: 'Cinzel', serif;
            font-size: 3rem;
            font-weight: 600;
            color: var(--leather);
            text-shadow: 2px 2px 4px var(--shadow);
            margin-bottom: 1rem;
        }
        
        .hero-subtitle {
            font-size: 1.3rem;
            color: #5d4037;
            margin-bottom: 2rem;
        }
        
        .btn-arcano {
            font-family: 'Cinzel', serif;
            font-weight: 600;
            border: 2px solid var(--leather);
            background: var(--dark-parchment);
            color: #2c1810;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin: 0.5rem;
            padding: 0.8rem 1.5rem;
        }
        
        .btn-arcano::before {
            content: '';
            position: absolute;
            top: 0; left: -100%; width: 100%; height: 100%;
            background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .btn-arcano:hover::before { left: 100%; }
        
        .btn-arcano:hover {
            background: var(--gold);
            color: #2c1810;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px var(--shadow);
        }
        
        .btn-primary.btn-arcano { background: var(--leather); color: var(--parchment); }
        .btn-success.btn-arcano { background: var(--emerald); color: var(--parchment); }
        .btn-warning.btn-arcano { background: #d97706; color: var(--parchment); }
        
        .feature-card {
            background: var(--parchment);
            border: 2px solid var(--leather);
            border-radius: 10px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px var(--shadow);
            background: var(--dark-parchment);
        }
        
        .card-icon {
            font-size: 3rem;
            color: var(--leather);
            margin-bottom: 1rem;
        }
        
        .feature-title {
            font-family: 'Cinzel', serif;
            color: var(--leather);
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .admin-panel {
            background: linear-gradient(135deg, var(--ruby), #5f1f1f);
            color: var(--parchment);
            border-radius: 10px;
            padding: 2rem;
            margin-top: 3rem;
            border: 2px solid var(--gold);
        }
        
        .admin-panel h4 {
            font-family: 'Cinzel', serif;
            margin-bottom: 1.5rem;
        }
        
        .user-dropdown .dropdown-toggle {
            display: flex;
            align-items: center;
            color: var(--parchment) !important;
            text-decoration: none;
        }
        
        .user-avatar {
            width: 35px; height: 35px;
            background-color: var(--gold);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            color: var(--leather);
            font-weight: bold;
            margin-right: 10px;
        }
        
        .admin-badge {
            background-color: var(--ruby);
            color: white;
            font-size: 0.7rem;
            padding: 3px 8px;
            border-radius: 10px;
            margin-left: 8px;
        }
        
        .footer {
            background: linear-gradient(135deg, var(--leather), var(--dark-leather));
            color: var(--parchment);
            padding: 2rem 0;
            margin-top: 3rem;
            border-radius: 10px;
            border: 2px solid var(--gold);
        }
        
        /* Efectos mágicos */
        @keyframes sparkle {
            0%, 100% { opacity: 0; transform: scale(0); }
            50% { opacity: 1; transform: scale(1); }
        }
        
        .hero-section::after {
            content: '✦';
            position: absolute;
            top: 1rem; right: 1rem;
            color: var(--gold);
            font-size: 1.5rem;
            animation: sparkle 3s infinite;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <i class="fas fa-magic me-2"></i>Biblioteca Arcana
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="#"><i class="fas fa-home me-1"></i>Sanctum</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="libro?accion=listar"><i class="fas fa-book me-1"></i>Grimoires</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="AlumnoServlet?accion=listar"><i class="fas fa-user-graduate me-1"></i>Aprendices</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="prestamo?accion=listar"><i class="fas fa-handshake me-1"></i>Préstamos</a>
                        </li>
                    </ul>
                    
                    <% if(session.getAttribute("usuario") != null) { %>
                    <div class="nav-item dropdown user-dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            <div class="user-avatar">
                                <%= ((String)session.getAttribute("nombreUsuario")).substring(0, 1).toUpperCase() %>
                            </div>
                            <div>
                                <%= session.getAttribute("nombreUsuario") %>
                                <% if(session.getAttribute("esAdmin") != null && (boolean)session.getAttribute("esAdmin")) { %>
                                    <span class="admin-badge">Maestro</span>
                                <% } %>
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>Mi Perfil</a></li>
                            <li><a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión</a></li>
                        </ul>
                    </div>
                    <% } else { %>
                    <a href="login" class="btn btn-outline-light btn-sm">
                        <i class="fas fa-sign-in-alt me-1"></i> Acceder
                    </a>
                    <% } %>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero-section">
            <h1 class="hero-title">Biblioteca Arcana</h1>
            <p class="hero-subtitle">Portal de Gestión de Conocimiento Místico</p>
            <div class="d-flex flex-wrap justify-content-center">
                <a href="libro?accion=listar" class="btn btn-primary btn-arcano">
                    <i class="fas fa-book me-2"></i>Gestión de Grimoires
                </a>
                <a href="AlumnoServlet?accion=listar" class="btn btn-success btn-arcano">
                    <i class="fas fa-user-graduate me-2"></i>Registro de Aprendices
                </a>
                <a href="prestamo?accion=listar" class="btn btn-warning btn-arcano">
                    <i class="fas fa-handshake me-2"></i>Archivo de Préstamos
                </a>
            </div>
        </section>

        <!-- Features Section -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fas fa-scroll card-icon"></i>
                    <h3 class="feature-title">Grimoires Arcanos</h3>
                    <p>Administra tu colección de libros mágicos y pergaminos ancestrales.</p>
                    <a href="libro?accion=listar" class="btn btn-arcano">Explorar</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fas fa-users card-icon"></i>
                    <h3 class="feature-title">Registro de Aprendices</h3>
                    <p>Gestiona los estudiantes de las artes arcanas y sus progresos.</p>
                    <a href="AlumnoServlet?accion=listar" class="btn btn-arcano">Gestionar</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fas fa-exchange-alt card-icon"></i>
                    <h3 class="feature-title">Préstamos Místicos</h3>
                    <p>Controla el flujo de conocimiento entre la biblioteca y los aprendices.</p>
                    <a href="prestamo?accion=listar" class="btn btn-arcano">Revisar</a>
                </div>
            </div>
        </div>

        <!-- Panel de Administración -->
        <% if(session.getAttribute("esAdmin") != null && (boolean)session.getAttribute("esAdmin")) { %>
        <div class="admin-panel">
            <h4><i class="fas fa-crown me-2"></i>Cámara del Consejo - Panel Maestro</h4>
            <div class="row">
                <div class="col-md-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="rounded-circle bg-warning p-3 text-dark me-3">
                            <i class="fas fa-users fa-2x"></i>
                        </div>
                        <div>
                            <h5>Gestión de Usuarios</h5>
                            <p class="mb-0">Administra las cuentas arcanas</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="rounded-circle bg-info p-3 text-white me-3">
                            <i class="fas fa-cogs fa-2x"></i>
                        </div>
                        <div>
                            <h5>Configuración</h5>
                            <p class="mb-0">Ajustes del sistema arcano</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="rounded-circle bg-success p-3 text-white me-3">
                            <i class="fas fa-chart-bar fa-2x"></i>
                        </div>
                        <div>
                            <h5>Reportes</h5>
                            <p class="mb-0">Análisis y estadísticas</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% } %>

        <!-- Footer -->
        <footer class="footer">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-magic me-2"></i>Biblioteca Arcana</h5>
                    <p>Portal de gestión para el conocimiento místico y las artes arcanas.</p>
                </div>
                <div class="col-md-6 text-end">
                    <p>&copy; 2025 Biblioteca Arcana. Todos los secretos protegidos.</p>
                </div>
            </div>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>