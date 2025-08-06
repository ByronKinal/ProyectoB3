<%-- 
    Document   : detalleUsuario
    Created on : Aug 4, 2025, 10:32:04 PM
    Author     : mario.garcia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalle Usuario</title>
        <link rel="stylesheet" href="StyleDetalleUsuario.css"/>
    </head>
    <body>
        <div class="perfil-container">
            <h1>PERFIL</h1>
            <img src="https://tse2.mm.bing.net/th/id/OIP.LnY-X2X737l_QQluLQlMKQHaIH?rs=1&pid=ImgDetMain&o=7&rm=3"
                 class="perfil-img" alt="usuario">

            <div class="datos-container">
                <div class="dato">
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" value="Juan" readonly>
                </div>
                <div class="dato">
                    <label for="apellido">Apellido</label>
                    <input type="text" id="apellido" value="Pérez" readonly>
                </div>
                <div class="dato">
                    <label for="correo">Correo</label>
                    <input type="email" id="correo" value="juan.perez@example.com" readonly>
                </div>
                <div class="dato">
                    <label for="genero">Género</label>
                    <input type="text" id="genero" value="Masculino" readonly>
                </div>
            </div>
        </div>
    </body>
</html>
