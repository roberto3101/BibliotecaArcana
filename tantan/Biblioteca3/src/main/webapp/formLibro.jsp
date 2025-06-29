<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="app.modelos.Libro" %>
<%@ page import="app.modelos.CategoriaLibro" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulario de Libro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header">
                        <%
                            Libro libro = (Libro) request.getAttribute("libro");
                            String titulo = "Nuevo Libro";
                            if (libro != null) {
                                titulo = "Editar Libro";
                            }
                        %>
                        <h4><%= titulo %></h4>
                    </div>
                    <div class="card-body">
                        <form action="libro" method="post">
                            <input type="hidden" name="accion" value="<%= (libro != null) ? "actualizar" : "insertar" %>">
                            
                            <% if (libro != null) { %>
                                <input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
                            <% } %>
                            
                            <div class="mb-3">
                                <label for="titulo" class="form-label">Título</label>
                                <input type="text" class="form-control" id="titulo" name="titulo" 
                                       value="<%= (libro != null) ? libro.getTitulo() : "" %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="anio" class="form-label">Año</label>
                                <input type="number" class="form-control" id="anio" name="anio" 
                                       value="<%= (libro != null) ? libro.getAnio() : "" %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="serie" class="form-label">Serie</label>
                                <input type="text" class="form-control" id="serie" name="serie" 
                                       value="<%= (libro != null) ? libro.getSerie() : "" %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="tema" class="form-label">Tema</label>
                                <input type="text" class="form-control" id="tema" name="tema" 
                                       value="<%= (libro != null) ? libro.getTema() : "" %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="idCategoria" class="form-label">Categoría</label>
                                <select class="form-select" id="idCategoria" name="idCategoria" required>
                                    <option value="">-- Seleccione una categoría --</option>
                                    <%
                                        List<CategoriaLibro> categorias = (List<CategoriaLibro>) request.getAttribute("categorias");
                                        if (categorias != null) {
                                            for (CategoriaLibro categoria : categorias) {
                                                String selected = "";
                                                if (libro != null && libro.getIdCategoria() == categoria.getIdCategoria()) {
                                                    selected = "selected";
                                                }
                                    %>
                                        <option value="<%= categoria.getIdCategoria() %>" <%= selected %>><%= categoria.getDescripcion() %></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                            
                            <div class="mt-4">
                                <button type="submit" class="btn btn-primary">Guardar</button>
                                <a href="libro?accion=listar" class="btn btn-secondary">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>