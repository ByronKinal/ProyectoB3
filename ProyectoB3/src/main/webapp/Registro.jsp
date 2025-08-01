<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Crear cuenta</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" 
              crossorigin="anonymous">
        <style></style>
        <link rel="stylesheet" href="StyleRegistro.css">
    </head>
    <body>
        <div class="card">
            <h1>Crear Cuenta</h1>
            <form action="ServletRegistro" method="POST">
                <input type="text" id="nombreUsuario" name="nombreUsuario" 
                       value="${nombreUsuarioValue}" placeholder="Nombre" required>

                <input type="text" id="apellidoUsuario" name="apellidoUsuario" 
                       value="${apellidoUsuarioValue}" placeholder="Apellido (opcional)">

                <input type="date" id="fechaNacimiento" name="fechaNacimiento" 
                       value="${fechaNacimientoValue}" class="fecha-input" required>

                <div class="card2">
                    <label>Género:</label>
                    <label>
                        <input type="radio" id="generoMasculino" name="generoUsuario" 
                               value="masculino" ${generoUsuarioValue eq 'masculino' ? 'checked' : ''}> Masculino
                    </label>
                    <label>
                        <input type="radio" id="generoFemenino" name="generoUsuario" 
                               value="femenino" ${generoUsuarioValue eq 'femenino' ? 'checked' : ''}> Femenino
                    </label>
                </div>

                <input type="text" id="telefonoUsuario" name="telefonoUsuario" 
                       value="${telefonoUsuarioValue}" placeholder="Número de teléfono (opcional)">

                <input type="email" id="correoUsuario" name="correoUsuario" 
                       value="${correoUsuarioValue}" placeholder="Correo" required>

                <input type="password" id="contrasenaUsuario" name="contrasenaUsuario" 
                       placeholder="Contraseña" required>

                <h5>Repita la contraseña</h5>
                <input type="password" id="repeat-password" name="repeat-password" 
                       placeholder="Repita la contraseña" required>

                <% if (request.getAttribute("error") != null) {%>
                <div class="alert alert-danger">
                    <%= request.getAttribute("error")%>
                </div>
                <% }%>

                <button type="submit">Crear cuenta</button>
                <a class="inicioSesion" href="InicioDeSesion.jsp" target="_self">Iniciar Sesion</a>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" 
        crossorigin="anonymous"></script>
    </body>
</html>