<%-- 
    Document   : InicioDeSesion
    Created on : Jul 22, 2025, 11:15:29 PM
    Author     : mario.garcia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Inicio de Sesion</title>
        <link rel="stylesheet" href="InicioDeSesion.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" 
              crossorigin="anonymous">
        <style>



        </style>
    </head>
    <body>
        <div class="card">
            <h1>Iniciar Sesión</h1>
            <form action="ServletInicioDeSesion" method="POST">
                <input type="text" id="correoUsuario" name="correoUsuario" 
                       placeholder="Correo electrónico" required
                       class="<%= request.getAttribute("error") != null ? "error" : ""%>">

                <input type="password" id="contrasenaUsuario" name="contrasenaUsuario" 
                       placeholder="Contraseña" required
                       class="<%= request.getAttribute("error") != null ? "error" : ""%>">
                <% if (request.getAttribute("error") != null) {%>
                <div class="error-message">
                    <%= request.getAttribute("error")%>
                </div>
                <% }%>
                <button type="submit">Iniciar Sesión</button>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" 
        crossorigin="anonymous"></script>
    </body>
</html>