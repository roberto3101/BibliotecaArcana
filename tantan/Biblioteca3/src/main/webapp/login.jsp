<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BiblioSystem - Portal de Entrada Arcana</title>
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
            --text-secondary: #5d4037;
        }
        
        body {
            background: linear-gradient(135deg, #1a1a1a 0%, #2d1b69 50%, #1a1a1a 100%);
            font-family: 'Crimson Text', serif;
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
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
        
        .login-container {
            background: var(--parchment);
            border-radius: 15px;
            box-shadow: 
                0 20px 40px var(--shadow),
                inset 0 1px 0 rgba(255,255,255,0.3);
            overflow: hidden;
            width: 100%;
            max-width: 900px;
            display: flex;
            position: relative;
            border: 3px solid var(--leather);
        }
        
        .login-container::before {
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
        
        .login-container::after {
            content: '✦';
            position: absolute;
            top: 1rem;
            right: 1rem;
            color: var(--gold);
            font-size: 1.5rem;
            animation: sparkle 3s infinite;
            animation-delay: 1s;
            z-index: 10;
        }
        
        .login-image {
            background: linear-gradient(rgba(44, 62, 80, 0.8), rgba(44, 62, 80, 0.8)), 
                        url('https://source.unsplash.com/random/600x800/?ancient+library+books');
            background-size: cover;
            background-position: center;
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: var(--parchment);
            text-align: center;
            position: relative;
        }
        
        .login-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                repeating-linear-gradient(
                    45deg,
                    transparent,
                    transparent 10px,
                    rgba(212, 175, 55, 0.05) 10px,
                    rgba(212, 175, 55, 0.05) 20px
                );
            pointer-events: none;
        }
        
        .login-image h2 {
            font-family: 'Cinzel', serif;
            font-size: 2.2rem;
            font-weight: 600;
            text-shadow: 2px 2px 4px var(--shadow);
            margin-bottom: 1.5rem;
        }
        
        .login-image h4 {
            font-family: 'Cinzel', serif;
            font-size: 1.4rem;
            color: var(--gold);
            margin-bottom: 1rem;
        }
        
        .login-quotes {
            font-style: italic;
            margin-bottom: 30px;
            font-size: 1.1rem;
            text-shadow: 1px 1px 2px var(--shadow);
        }
        
        .login-form {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: var(--parchment);
        }
        
        .login-logo {
            font-family: 'Cinzel', serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--leather);
            margin-bottom: 20px;
            text-align: center;
            text-shadow: 2px 2px 4px var(--shadow);
            position: relative;
        }
        
        .login-logo::after {
            content: '⚜';
            display: block;
            font-size: 1.2rem;
            color: var(--gold);
            margin-top: 0.5rem;
        }
        
        .form-floating {
            margin-bottom: 20px;
            position: relative;
        }
        
        .form-floating input {
            background: var(--dark-parchment);
            border: 2px solid var(--leather);
            color: var(--text-primary);
            font-family: 'Crimson Text', serif;
            transition: all 0.3s ease;
        }
        
        .form-floating input:focus {
            background: var(--parchment);
            border-color: var(--gold);
            box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
        }
        
        .form-floating label {
            color: var(--text-secondary);
            font-family: 'Cinzel', serif;
            font-weight: 600;
        }
        
        .btn-login {
            background: linear-gradient(135deg, var(--leather), var(--dark-leather));
            border: 2px solid var(--leather);
            border-radius: 30px;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            width: 100%;
            color: var(--parchment);
            font-family: 'Cinzel', serif;
            position: relative;
            overflow: hidden;
        }
        
        .btn-login::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.3), transparent);
            transition: left 0.5s ease;
        }
        
        .btn-login:hover::before {
            left: 100%;
        }
        
        .btn-login:hover {
            background: linear-gradient(135deg, var(--gold), var(--dark-gold));
            border-color: var(--dark-gold);
            color: var(--text-primary);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px var(--shadow);
        }
        
        .btn-register {
            background: linear-gradient(135deg, var(--emerald), #1f3f0f);
            border: 2px solid var(--emerald);
            border-radius: 30px;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 15px;
            color: var(--parchment);
            font-family: 'Cinzel', serif;
            position: relative;
            overflow: hidden;
        }
        
        .btn-register::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(45, 80, 22, 0.3), transparent);
            transition: left 0.5s ease;
        }
        
        .btn-register:hover::before {
            left: 100%;
        }
        
        .btn-register:hover {
            background: linear-gradient(135deg, #16a34a, var(--emerald));
            border-color: #16a34a;
            color: var(--parchment);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px var(--shadow);
        }
        
        .login-footer {
            text-align: center;
            margin-top: 30px;
            color: var(--text-secondary);
            font-family: 'Cinzel', serif;
            font-size: 0.9rem;
        }
        
        .alert {
            margin-bottom: 20px;
            border-radius: 10px;
            border: 2px solid;
            font-family: 'Crimson Text', serif;
            font-weight: 600;
        }
        
        .alert-danger {
            background: rgba(114, 47, 55, 0.1);
            border-color: var(--ruby);
            color: var(--ruby);
        }
        
        .alert-info {
            background: rgba(30, 58, 138, 0.1);
            border-color: #1e3a8a;
            color: #1e3a8a;
        }
        
        .form-check {
            margin-bottom: 20px;
            font-family: 'Crimson Text', serif;
            font-weight: 600;
        }
        
        .form-check-input:checked {
            background-color: var(--gold);
            border-color: var(--dark-gold);
        }
        
        .form-check-input:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
        }
        
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }
            
            .login-image {
                display: none;
            }
            
            .login-logo {
                font-size: 2rem;
            }
        }
        
        /* Efectos mágicos */
        @keyframes sparkle {
            0%, 100% { opacity: 0; transform: scale(0) rotate(0deg); }
            50% { opacity: 1; transform: scale(1) rotate(180deg); }
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        
        .login-image::after {
            content: '✧';
            position: absolute;
            top: 2rem;
            left: 2rem;
            color: var(--gold);
            font-size: 1.2rem;
            animation: float 4s ease-in-out infinite;
            animation-delay: 2s;
        }
        
        /* Textura de pergamino */
        .login-form::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            right: 0;
            bottom: 0;
            background: 
                repeating-linear-gradient(
                    45deg,
                    transparent,
                    transparent 15px,
                    rgba(139, 69, 19, 0.03) 15px,
                    rgba(139, 69, 19, 0.03) 30px
                );
            pointer-events: none;
            z-index: 0;
        }
        
        .login-form > * {
            position: relative;
            z-index: 1;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="login-image d-none d-md-flex">
                <div>
                    <h2>Bienvenido al Sanctum Arcanum</h2>
                    <p class="login-quotes">"Los libros son espejos: solo ves en ellos lo que ya llevas dentro."<br>― Carlos Ruiz Zafón</p>
                    <h4>Biblioteca de Conocimiento Arcano</h4>
                    <p>Accede al repositorio ancestral de grimoires y pergaminos místicos. Administra la sabiduría milenaria con el poder de la magia moderna.</p>
                </div>
            </div>
            <div class="login-form">
                <div class="login-logo">
                    <i class="fas fa-book-open me-2"></i>BiblioSystem Arcanum
                </div>
                
                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% } %>
                
                <% if (session.getAttribute("mensajeRegistro") != null) { %>
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <i class="fas fa-scroll me-2"></i>
                    <%= session.getAttribute("mensajeRegistro") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% 
                    session.removeAttribute("mensajeRegistro");
                } %>
                
                <form action="LoginController" method="post">
                    <div class="form-floating animated-input">
                        <input type="text" class="form-control" id="username" name="username" placeholder="Nombre de mago" required>
                        <label for="username"><i class="fas fa-user-secret me-2"></i>Nombre de Mago</label>
                    </div>
                    <div class="form-floating animated-input">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Palabra mágica" required>
                        <label for="password"><i class="fas fa-key me-2"></i>Palabra Mágica</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">
                            <i class="fas fa-memory me-1"></i>Recordar en los archivos akáshicos
                        </label>
                    </div>
                    
                    <div class="action-buttons">
                        <button type="submit" class="btn btn-login btn-lg">
                            <i class="fas fa-magic me-2"></i>Acceder al Sanctum
                        </button>
                        
                        <a href="registro.jsp" class="btn btn-register btn-lg">
                            <i class="fas fa-scroll me-2"></i>Registrar Nuevo Aprendiz
                        </a>
                    </div>
                </form>
                
                <div class="login-footer">
                    <p><i class="fas fa-copyright me-1"></i>2025 BiblioSystem Arcanum. Protegido por hechizos ancestrales.</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>