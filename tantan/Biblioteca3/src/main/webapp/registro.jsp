<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro del Sanctum - BiblioSystem</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
        
        .card {
            background: var(--parchment);
            border-radius: 15px;
            box-shadow: 0 20px 40px var(--shadow), inset 0 1px 0 rgba(255,255,255,0.3);
            border: 3px solid var(--leather);
            position: relative;
        }
        
        .card::before {
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
        
        .card-header {
            background: linear-gradient(135deg, var(--leather), var(--dark-leather));
            border-bottom: 2px solid var(--gold);
            border-radius: 12px 12px 0 0;
        }
        
        .system-name {
            font-family: 'Cinzel', serif;
            font-weight: 600;
            color: var(--parchment);
            font-size: 2.5rem;
            text-shadow: 2px 2px 4px var(--shadow);
        }
        
        .system-name::after {
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
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
            background: var(--parchment);
        }
        
        .btn-primary {
            background: var(--leather);
            border-color: var(--dark-leather);
            font-family: 'Cinzel', serif;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .btn-primary:hover::before {
            left: 100%;
        }
        
        .btn-primary:hover {
            background: var(--gold);
            border-color: var(--dark-gold);
            color: var(--text-primary);
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
            background: var(--emerald);
            border-color: var(--emerald);
            color: var(--parchment);
            transform: translateY(-2px);
        }
        
        .alert-danger {
            background: rgba(114, 47, 55, 0.1);
            border: 1px solid var(--ruby);
            color: var(--ruby);
            border-radius: 8px;
        }
        
        .alert-success {
            background: rgba(45, 80, 22, 0.1);
            border: 1px solid var(--emerald);
            color: var(--emerald);
            border-radius: 8px;
        }
        
        .input-group-text {
            background: var(--leather);
            color: var(--parchment);
            border: 2px solid var(--leather);
            border-right: none;
        }
        
        .input-group .form-control {
            border-left: none;
        }
        
        .form-footer {
            text-align: center;
            margin-top: 1rem;
            color: var(--text-primary);
            font-style: italic;
        }
        
        @keyframes sparkle {
            0%, 100% { opacity: 0; transform: scale(0); }
            50% { opacity: 1; transform: scale(1); }
        }
        
        .card::after {
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
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header text-center">
                        <div class="system-logo">
                            <i class="fas fa-scroll"></i>
                            <div class="system-name">Registro del Sanctum</div>
                        </div>
                    </div>
                    <div class="card-body p-4">
                        <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <%= request.getAttribute("error") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } %>
                        
                        <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            <%= request.getAttribute("success") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } %>
                        
                        <form action="RegistroController" method="post">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="nombres" class="form-label">
                                        <i class="fas fa-user me-2"></i>Nombres
                                    </label>
                                    <input type="text" class="form-control" id="nombres" name="nombres" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="apellidos" class="form-label">
                                        <i class="fas fa-user me-2"></i>Apellidos
                                    </label>
                                    <input type="text" class="form-control" id="apellidos" name="apellidos" required>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="dni" class="form-label">
                                        <i class="fas fa-id-card me-2"></i>DNI
                                    </label>
                                    <input type="text" class="form-control" id="dni" name="dni" maxlength="8" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="fechaNacimiento" class="form-label">
                                        <i class="fas fa-calendar-alt me-2"></i>Fecha de Nacimiento
                                    </label>
                                    <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="direccion" class="form-label">
                                    <i class="fas fa-map-marker-alt me-2"></i>Dirección
                                </label>
                                <input type="text" class="form-control" id="direccion" name="direccion" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="correo" class="form-label">
                                    <i class="fas fa-envelope me-2"></i>Correo Electrónico
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">@</span>
                                    <input type="email" class="form-control" id="correo" name="correo" required>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="login" class="form-label">
                                        <i class="fas fa-user-tag me-2"></i>Nombre de Usuario
                                    </label>
                                    <input type="text" class="form-control" id="login" name="login" maxlength="15" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="password" class="form-label">
                                        <i class="fas fa-lock me-2"></i>Contraseña
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                                        <input type="password" class="form-control" id="password" name="password" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="rol" class="form-label">
                                    <i class="fas fa-user-shield me-2"></i>Rol en el Sanctum
                                </label>
                                <select class="form-select" id="rol" name="idRol" required>
                                    <option value="">Seleccione un rol</option>
                                    <option value="2">Maestro Bibliotecario</option>
                                    <option value="3">Aprendiz</option>
                                </select>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-quill-pen me-2"></i>Inscribirse en el Sanctum
                                </button>
                                <a href="login.jsp" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Regresar al Portal
                                </a>
                            </div>
                        </form>
                        
                        <div class="form-footer">
                            <p>Al registrarte, juras lealtad al conocimiento arcano.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('dni').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    </script>
</body>
</html>