<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario"%>
<%@page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil</title>
        <link rel="stylesheet" href="StyleDetalleUsuario.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" 
              crossorigin="anonymous">
    </head>
    <body>
        <div class="linea-superior">CALZADO BIEN HECHO</div>
        <div class="barra-superior">
            <div class="logo">
                <img src="https://i.postimg.cc/MTtLxgXD/Logo-Kinal-Zapato-1-0.jpg" alt="Logo">
            </div>
        </div>

        <div class="perfil-container">
            <h1>MI PERFIL</h1>
            <img src="https://cdn-icons-png.flaticon.com/128/6676/6676016.png" 
                 class="perfil-img" alt="usuario">
            <div class="datos-container">
                <%
                    Usuario usuario = (Usuario) session.getAttribute("usuario");
                    if (usuario != null) {
                %>
                <div class="dato">
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" value="<%= usuario.getNombreUsuario()%>" readonly>
                </div>
                <div class="dato">
                    <label for="apellido">Apellido</label>
                    <input type="text" id="apellido" value="<%= usuario.getApellidoUsuario()%>" readonly>
                </div>
                <div class="dato">
                    <label for="correo">Correo</label>
                    <input type="email" id="correo" value="<%= usuario.getCorreoUsuario()%>" readonly>
                </div>
                <div class="dato">
                    <label for="genero">Género</label>
                    <input type="text" id="genero" value="<%= usuario.getGeneroUsuario()%>" readonly>
                </div>
                <div class="dato">
                    <label for="telefono">Teléfono</label>
                    <input type="text" id="telefono" value="<%= usuario.getTelefonoUsuario()%>" readonly>
                </div>
                <div class="dato">
                    <label for="nacimiento">Fecha de Nacimiento</label>
                    <input type="text" id="nacimiento" value="<%= usuario.getFechaNacimiento()%>" readonly>
                </div>
                <% } else { %>
                <p class="text-center">No hay información de usuario disponible</p>
                <% } %>
            </div>
            
            <div class="acciones">
                <a href="MenuPrincipal.jsp" class="btn-cerrar-sesion">Regresar</a>
                <a href="ServletCerrarSesion" class="btn-regresar">Cerrar Sesión</a>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" 
        crossorigin="anonymous"></script>
    </body>
</html>