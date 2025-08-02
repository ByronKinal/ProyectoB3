<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario"%>
<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Editar Usuario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h1>Editar Usuario</h1>
            <form action="ServletEditarUsuario" method="post">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="id" value="<%=usuario.getIdUsuario()%>">

                <div class="mb-3">
                    <label for="nombreUsuario" class="form-label">Nombre:</label>
                    <input type="text" id="nombreUsuario" name="nombreUsuario" class="form-control" 
                           value="<%=usuario.getNombreUsuario()%>" required>
                </div>

                <div class="mb-3">
                    <label for="apellidoUsuario" class="form-label">Apellido:</label>
                    <input type="text" id="apellidoUsuario" name="apellidoUsuario" class="form-control" 
                           value="<%=usuario.getApellidoUsuario()%>" required>
                </div>

                <div class="mb-3">
                    <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                    <input type="date" id="fechaNacimiento" name="fechaNacimiento" class="form-control" 
                           value="<%=usuario.getFechaNacimiento()%>" required>
                </div>

                <div class="mb-3">
                    <label for="generoUsuario" class="form-label">Género:</label>
                    <select id="generoUsuario" name="generoUsuario" class="form-select" required>
                        <option value="MASCULINO" <%= usuario.getGeneroUsuario().equals("MASCULINO") ? "selected" : ""%>>Masculino</option>
                        <option value="FEMENINO" <%= usuario.getGeneroUsuario().equals("FEMENINO") ? "selected" : ""%>>Femenino</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="telefonoUsuario" class="form-label">Teléfono:</label>
                    <input type="text" id="telefonoUsuario" name="telefonoUsuario" class="form-control" 
                           value="<%=usuario.getTelefonoUsuario()%>" required>
                </div>

                <div class="mb-3">
                    <label for="correoUsuario" class="form-label">Correo:</label>
                    <input type="email" id="correoUsuario" name="correoUsuario" class="form-control" 
                           value="<%=usuario.getCorreoUsuario()%>" required>
                </div>

                <div class="mb-3">
                    <label for="contrasenaUsuario" class="form-label">Contraseña:</label>
                    <input type="password" id="contrasenaUsuario" name="contrasenaUsuario" class="form-control" 
                           value="<%=usuario.getContrasenaUsuario()%>" required>
                </div>

                <div class="mb-3">
                    <label for="rolUsuario" class="form-label">Rol:</label>
                    <select id="rolUsuario" name="rolUsuario" class="form-select" required>
                        <option value="Cliente" <%= usuario.getRolUsuario().equals("Cliente") ? "selected" : ""%>>Cliente</option>
                        <option value="Empleado" <%= usuario.getRolUsuario().equals("Empleado") ? "selected" : ""%>>Empleado</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Actualizar</button>
                <a href="ServletListarUsuarios" class="btn btn-secondary">Cancelar</a>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>