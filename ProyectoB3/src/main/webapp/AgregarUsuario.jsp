<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Agregar usuario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h1>Agregar Nuevo Usuario</h1>
            <form action="ServletAgregarUsuario" method="post">
                <div class="mb-3">
                    <label for="nombreUsuario" class="form-label">Nombre:</label>
                    <input type="text" id="nombreUsuario" name="nombreUsuario" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="apellidoUsuario" class="form-label">Apellido:</label>
                    <input type="text" id="apellidoUsuario" name="apellidoUsuario" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                    <input type="date" id="fechaNacimiento" name="fechaNacimiento" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="generoUsuario" class="form-label">Género:</label>
                    <select id="generoUsuario" name="generoUsuario" class="form-select" required>
                        <option value="">Seleccione un género</option>
                        <option value="MASCULINO">Masculino</option>
                        <option value="FEMENINO">Femenino</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="telefonoUsuario" class="form-label">Teléfono:</label>
                    <input type="text" id="telefonoUsuario" name="telefonoUsuario" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="correoUsuario" class="form-label">Correo:</label>
                    <input type="email" id="correoUsuario" name="correoUsuario" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="contrasenaUsuario" class="form-label">Contraseña:</label>
                    <input type="password" id="contrasenaUsuario" name="contrasenaUsuario" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="rolUsuario" class="form-label">Rol:</label>
                    <select id="rolUsuario" name="rolUsuario" class="form-select" required>
                        <option value="">Seleccione un rol</option>
                        <option value="Cliente">Cliente</option>
                        <option value="Empleado">Empleado</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Guardar</button>
                <a href="ServletListarUsuarios" class="btn btn-secondary">Cancelar</a>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>