<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lista de Usuarios</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h1>Lista de Usuarios</h1>
                <a href="ServletAgregarUsuario" class="btn btn-success">
                    <i class="bi bi-plus"></i> Agregar Usuario
                </a>
            </div>
            
            <!-- Mensajes de éxito o error -->
            <%
                String mensaje = (String) session.getAttribute("mensaje");
                String tipoMensaje = (String) session.getAttribute("tipoMensaje");
                if (mensaje != null && tipoMensaje != null) {
            %>
            <div class="alert alert-<%= tipoMensaje %> alert-dismissible fade show" role="alert">
                <%= mensaje %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <%
                    // Limpiar los mensajes de la sesión después de mostrarlos
                    session.removeAttribute("mensaje");
                    session.removeAttribute("tipoMensaje");
                }
            %>
            
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Fecha Nacimiento</th>
                            <th>Género</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <th>Rol</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
                            if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                                for (Usuario usuario : listaUsuarios) {
                        %>
                        <tr>
                            <td><%= usuario.getIdUsuario() %></td>
                            <td><%= usuario.getNombreUsuario() %></td>
                            <td><%= usuario.getApellidoUsuario() %></td>
                            <td><%= usuario.getFechaNacimiento() %></td>
                            <td><%= usuario.getGeneroUsuario() %></td>
                            <td><%= usuario.getTelefonoUsuario() %></td>
                            <td><%= usuario.getCorreoUsuario() %></td>
                            <td><%= usuario.getRolUsuario() %></td>
                            <td>
                                <div class="btn-group" role="group">
                                    <!-- Botón Editar -->
                                    <a href="ServletEditarUsuario?accion=editar&id=<%= usuario.getIdUsuario() %>" 
                                       class="btn btn-primary btn-sm" title="Editar">
                                        <i class="bi bi-pencil"></i> Editar
                                    </a>
                                    
                                    <!-- Botón Eliminar con confirmación -->
                                    <button type="button" 
                                            class="btn btn-danger btn-sm" 
                                            title="Eliminar"
                                            onclick="confirmarEliminacion(<%= usuario.getIdUsuario() %>, '<%= usuario.getNombreUsuario() %> <%= usuario.getApellidoUsuario() %>')">
                                        <i class="bi bi-trash"></i> Eliminar
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="9" class="text-center">
                                <div class="alert alert-info mb-0">
                                    No hay usuarios registrados en el sistema
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Modal de confirmación para eliminar -->
        <div class="modal fade" id="modalConfirmarEliminacion" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirmar Eliminación</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p>¿Está seguro que desea eliminar al usuario <strong id="nombreUsuarioEliminar"></strong>?</p>
                        <p class="text-danger"><small>Esta acción no se puede deshacer.</small></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <form id="formEliminar" method="post" style="display: inline;">
                            <input type="hidden" id="idUsuarioEliminar" name="id">
                            <button type="submit" class="btn btn-danger">Eliminar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        
        <script>
            function confirmarEliminacion(idUsuario, nombreCompleto) {
                // Establecer los valores en el modal
                document.getElementById('idUsuarioEliminar').value = idUsuario;
                document.getElementById('nombreUsuarioEliminar').textContent = nombreCompleto;
                document.getElementById('formEliminar').action = 'ServletEliminarUsuario';
                
                // Mostrar el modal
                var modal = new bootstrap.Modal(document.getElementById('modalConfirmarEliminacion'));
                modal.show();
            }
        </script>
    </body>
</html>