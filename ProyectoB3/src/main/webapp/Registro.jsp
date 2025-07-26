
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Registro</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="Registro.css">
    </head>
    <body>
        <div class="card">
            <h1>Crear Cuenta</h1>
            <form action="MenuPrincipal.html" method="get">
                <input type="text" id="username" name="username" placeholder="Nombre de Usuario" required>
                <input type="email" id="email" name="email" placeholder="Correo" required>
                <input type="password" id="password" name="password" placeholder="Contraseña" required>
                <h5>Repita la contraseña</h5>
                <input type="password" id="repeat-password" name="password" placeholder="Contraseña" required>
                <button type="submit">Crear cuenta</button>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" 
        crossorigin="anonymous"></script>
    </body>
</html>

