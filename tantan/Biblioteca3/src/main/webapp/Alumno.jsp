<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, app.modelos.Alumno, app.modelos.Pais" %>
<%
    List<Alumno> lista = (List<Alumno>) request.getAttribute("alumnos");
    List<Pais> paises = (List<Pais>) request.getAttribute("paises");
    Alumno alumnoEditar = (Alumno) request.getAttribute("alumnoEditar");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Aprendices Arcanos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600&family=Crimson+Text:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <style>
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
                radial-gradient(circle at 80% 70%, rgba(45, 80, 22, 0.1) 0%, transparent 50%);
            pointer-events: none;
            z-index: -1;
        }
        
        .navbar {
            background: linear-gradient(135deg, var(--leather), var(--dark-leather)) !important;
            border-bottom: 3px solid var(--gold);
            font-family: 'Cinzel', serif;
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
        
        .page-header h2 {
            font-family: 'Cinzel', serif;
            color: var(--leather);
            text-align: center;
            font-weight: 600;
            font-size: 2.5rem;
            text-shadow: 2px 2px 4px var(--shadow);
            margin-bottom: 1rem;
        }
        
        .page-header h2::after {
            content: '⚜';
            display: block;
            font-size: 1.2rem;
            color: var(--gold);
            margin-top: 0.5rem;
        }
        
        .page-header p {
            color: var(--text-secondary);
            text-align: center;
            font-style: italic;
        }
        
        .card {
            border: 2px solid var(--leather);
            border-radius: 15px;
            box-shadow: 0 10px 30px var(--shadow);
            overflow: hidden;
            background: var(--parchment);
            position: relative;
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, var(--gold), var(--dark-gold));
            border-radius: 17px;
            z-index: -1;
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--leather), var(--dark-leather));
            color: var(--parchment);
            font-family: 'Cinzel', serif;
            font-weight: 600;
            border-bottom: 2px solid var(--gold);
        }
        
        .card-header h3 {
            margin: 0;
            font-size: 1.5rem;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--text-primary);
            font-family: 'Cinzel', serif;
        }
        
        .form-control, .form-select {
            border: 2px solid var(--leather);
            border-radius: 8px;
            background: var(--parchment);
            color: var(--text-primary);
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 0.2rem rgba(212, 175, 55, 0.25);
            background: var(--dark-parchment);
        }
        
        .btn {
            font-family: 'Cinzel', serif;
            font-weight: 600;
            transition: all 0.3s ease;
            border-radius: 8px;
        }
        
        .btn-primary {
            background: var(--leather);
            border-color: var(--dark-leather);
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
        }
        
        .btn-secondary:hover {
            background: var(--leather);
            border-color: var(--dark-leather);
            color: var(--parchment);
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
            position: relative;
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
        }
        
        .badge {
            font-family: 'Cinzel', serif;
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
        }
        
        .badge-success {
            background: var(--emerald) !important;
            color: var(--parchment);
        }
        
        .badge-danger {
            background: var(--ruby) !important;
            color: var(--parchment);
        }
        
        .action-btn {
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
            margin: 0.2rem;
            border-radius: 5px;
            font-family: 'Crimson Text', serif;
            font-weight: 600;
        }
        
        .empty-state {
            color: var(--text-secondary);
            font-style: italic;
        }
        
        .alert-danger {
            background: rgba(231, 76, 60, 0.1);
            border: 2px solid var(--ruby);
            color: var(--ruby);
            border-radius: 10px;
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
            font-size: 1.5rem;
            animation: sparkle 3s infinite;
            animation-delay: 1s;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .table thead {
                display: none;
            }
            
            .table, .table tbody, .table tr, .table td {
                display: block;
                width: 100%;
            }
            
            .table tr {
                margin-bottom: 1rem;
                border: 2px solid var(--leather);
                border-radius: 10px;
                padding: 1rem;
                background: var(--dark-parchment);
            }
            
            .table td {
                text-align: right;
                padding-left: 50%;
                position: relative;
                border: none;
            }
            
            .table td::before {
                content: attr(data-label);
                position: absolute;
                left: 1rem;
                width: 45%;
                text-align: left;
                font-weight: 600;
                font-family: 'Cinzel', serif;
            }
        }
        
        
        
        
        
        
        /* PARCHE ABSOLUTO para forzar colores en la navbar */
nav.navbar,
nav.navbar .navbar-brand,
nav.navbar .navbar-brand *,
nav.navbar .navbar-nav .nav-link,
nav.navbar .navbar-toggler,
nav.navbar .navbar-toggler-icon,
nav.navbar .navbar-collapse,
nav.navbar .navbar-text {
  background: linear-gradient(135deg, var(--leather), var(--dark-leather)) !important;
  color: var(--parchment) !important;
  border: none !important;
  box-shadow: none !important;
}

nav.navbar .navbar-brand:hover,
nav.navbar .navbar-brand:focus {
  color: var(--gold) !important;
}
        
        
        
        
        nav.navbar,
nav.navbar * {
  background-color: transparent !important;
  color: var(--parchment) !important;
  text-shadow: 0 1px 2px #0008 !important;
}
        
        
        
        
        
        
        
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="inicio.jsp">
                <i class="fas fa-hat-wizard me-2"></i>
                Academia Arcana
            </a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="page-header">
            <h2><i class="fas fa-users-cog me-2"></i>Registro de Aprendices</h2>
            <p>Administre los aprendices de las artes arcanas registrados en la academia</p>
        </div>

        <!-- Formulario de Registro / Edición -->
        <div class="card mb-5">
            <div class="card-header">
                <h3>
                    <i class="fas <%= (alumnoEditar != null) ? "fa-edit" : "fa-user-plus" %> me-2"></i>
                    <%= (alumnoEditar != null) ? "Modificar Aprendiz" : "Nuevo Aprendiz" %>
                </h3>
            </div>
            <div class="card-body">
                <div id="alertaErrores" class="alert alert-danger d-none mb-3" role="alert">
                    <ul id="listaErrores" class="mb-0"></ul>
                </div>
                <form action="AlumnoServlet" method="post">
                    <input type="hidden" name="accion" value="<%= (alumnoEditar != null) ? "actualizar" : "registrar" %>">
                    <input type="hidden" name="idAlumno" value="<%= (alumnoEditar != null) ? alumnoEditar.getIdAlumno() : "" %>">

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label"><i class="fas fa-signature me-1"></i>Nombres:</label>
                            <input type="text" name="nombres" class="form-control" required value="<%= (alumnoEditar != null) ? alumnoEditar.getNombres() : "" %>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label"><i class="fas fa-user-tag me-1"></i>Apellidos:</label>
                            <input type="text" name="apellidos" class="form-control" required value="<%= (alumnoEditar != null) ? alumnoEditar.getApellidos() : "" %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label"><i class="fas fa-phone me-1"></i>Teléfono:</label>
                            <input type="text" name="telefono" class="form-control" value="<%= (alumnoEditar != null) ? alumnoEditar.getTelefono() : "" %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label"><i class="fas fa-id-card me-1"></i>DNI:</label>
                            <input type="text" name="dni" class="form-control" required value="<%= (alumnoEditar != null) ? alumnoEditar.getDni() : "" %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label"><i class="fas fa-envelope me-1"></i>Correo:</label>
                            <input type="email" name="correo" class="form-control" value="<%= (alumnoEditar != null) ? alumnoEditar.getCorreo() : "" %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label"><i class="fas fa-calendar me-1"></i>Fecha Nacimiento:</label>
                            <input type="date" name="fechaNacimiento" class="form-control" value="<%= (alumnoEditar != null && alumnoEditar.getFechaNacimiento() != null) ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(alumnoEditar.getFechaNacimiento()) : "" %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label"><i class="fas fa-toggle-on me-1"></i>Estado:</label>
                            <select name="estado" class="form-select">
                                <option value="1" <%= (alumnoEditar != null && alumnoEditar.getEstado() == 1) ? "selected" : "" %>>Activo</option>
                                <option value="0" <%= (alumnoEditar != null && alumnoEditar.getEstado() == 0) ? "selected" : "" %>>Inactivo</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label"><i class="fas fa-globe me-1"></i>Reino:</label>
                            <select name="idPais" class="form-select" required>
                                <option value="">-- Seleccionar Reino --</option>
                                <% for (Pais p : paises) { %>
                                    <option value="<%= p.getIdPais() %>" <%= (alumnoEditar != null && p.getIdPais() == alumnoEditar.getIdPais()) ? "selected" : "" %>><%= p.getNombre() %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="mt-4">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas <%= (alumnoEditar != null) ? "fa-sync-alt" : "fa-save" %> me-2"></i>
                            <%= (alumnoEditar != null) ? "Actualizar" : "Registrar" %>
                        </button>
                        <a href="AlumnoServlet" class="btn btn-secondary">
                            <i class="fas fa-broom me-2"></i>Limpiar
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabla de Listado de Alumnos -->
        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-scroll me-2"></i>Registro de Aprendices</h3>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag"></i> ID</th>
                                <th><i class="fas fa-user"></i> Nombres</th>
                                <th><i class="fas fa-user-tag"></i> Apellidos</th>
                                <th><i class="fas fa-phone"></i> Teléfono</th>
                                <th><i class="fas fa-id-card"></i> DNI</th>
                                <th><i class="fas fa-envelope"></i> Correo</th>
                                <th><i class="fas fa-calendar"></i> F. Nacimiento</th>
                                <th><i class="fas fa-globe"></i> Reino</th>
                                <th><i class="fas fa-toggle-on"></i> Estado</th>
                                <th><i class="fas fa-cogs"></i> Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (lista != null && !lista.isEmpty()) {
                                for (Alumno a : lista) { %>
                                    <tr>
                                        <td data-label="ID"><%= a.getIdAlumno() %></td>
                                        <td data-label="Nombres"><%= a.getNombres() %></td>
                                        <td data-label="Apellidos"><%= a.getApellidos() %></td>
                                        <td data-label="Teléfono"><%= a.getTelefono() %></td>
                                        <td data-label="DNI"><%= a.getDni() %></td>
                                        <td data-label="Correo"><%= a.getCorreo() %></td>
                                        <td data-label="F. Nacimiento"><%= a.getFechaNacimiento() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(a.getFechaNacimiento()) : "" %></td>
                                        <td data-label="Reino"><%= a.getNombrePais() %></td>
                                        <td data-label="Estado">
                                            <span class="badge <%= (a.getEstado() == 1) ? "badge-success" : "badge-danger" %>">
                                                <i class="fas <%= (a.getEstado() == 1) ? "fa-check" : "fa-times" %>"></i>
                                                <%= (a.getEstado() == 1) ? "Activo" : "Inactivo" %>
                                            </span>
                                        </td>
                                        <td data-label="Acciones">
                                            <a href="AlumnoServlet?accion=editar&id=<%= a.getIdAlumno() %>" class="btn btn-warning btn-sm action-btn">
                                                <i class="fas fa-edit"></i> Editar
                                            </a>
                                            <a href="AlumnoServlet?accion=eliminar&id=<%= a.getIdAlumno() %>" class="btn btn-danger btn-sm action-btn" onclick="return confirm('¿Seguro de eliminar este aprendiz del registro?')">
                                                <i class="fas fa-trash"></i> Eliminar
                                            </a>
                                        </td>
                                    </tr>
                            <%  }
                            } else { %>
                                <tr>
                                    <td colspan="10" class="text-center py-5">
                                        <div class="empty-state">
                                            <i class="fas fa-users fa-3x mb-3 text-muted"></i>
                                            <h5>Los registros arcanos están vacíos</h5>
                                            <p class="text-muted">Utilice el formulario superior para registrar un nuevo aprendiz.</p>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.querySelector('form').addEventListener('submit', function (e) {
        const errores = [];
        const nombres = document.querySelector('input[name="nombres"]').value.trim();
        const apellidos = document.querySelector('input[name="apellidos"]').value.trim();
        const telefono = document.querySelector('input[name="telefono"]').value.trim();
        const dni = document.querySelector('input[name="dni"]').value.trim();
        const correo = document.querySelector('input[name="correo"]').value.trim();
        const fechaNacimiento = document.querySelector('input[name="fechaNacimiento"]').value;
        const estado = document.querySelector('select[name="estado"]').value;
        const pais = document.querySelector('select[name="idPais"]').value;

        if (nombres.length < 2 || !nombres.replace(/\s/g, '').length) errores.push("El nombre debe tener al menos 2 caracteres y no ser solo espacios.");
        if (apellidos.length < 2 || !apellidos.replace(/\s/g, '').length) errores.push("El apellido debe tener al menos 2 caracteres y no ser solo espacios.");
        if (!/^\d{8}$/.test(dni)) errores.push("El DNI debe tener 8 dígitos numéricos.");
        if (telefono && !/^\d{9}$/.test(telefono)) errores.push("El teléfono debe tener 9 dígitos numéricos.");
        if (!correo) {
            errores.push("El correo es obligatorio.");
        } else if (!/^[^@]+@[^@]+\.[a-zA-Z]{2,}$/.test(correo)) {
            errores.push("El correo no tiene un formato válido.");
        }
        if (!fechaNacimiento) {
            errores.push("Debe ingresar una fecha de nacimiento.");
        } else {
            const fechaNac = new Date(fechaNacimiento);
            const hoy = new Date();
            if (fechaNac >= hoy) errores.push("La fecha de nacimiento debe ser anterior a hoy.");
        }
        if (!["0", "1"].includes(estado)) errores.push("Debe seleccionar un estado válido.");
        if (!pais) errores.push("Debe seleccionar un reino.");

        const alerta = document.getElementById('alertaErrores');
        const lista = document.getElementById('listaErrores');
        lista.innerHTML = "";
        if (errores.length > 0) {
            e.preventDefault();
            errores.forEach(error => {
                const li = document.createElement('li');
                li.textContent = error;
                lista.appendChild(li);
            });
            alerta.classList.remove('d-none');
            alerta.scrollIntoView({ behavior: "smooth" });
        } else {
            alerta.classList.add('d-none');
        }
    });
    </script>
</body>
</html>