<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menú Principal</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="stylesheet" href="OpcionesMenuAdministrador.css">
</head>
<body>
    <div class="button-container">
        <a href="MenuAdministrativo.jsp" class="menu-button">
            <span class="material-symbols-outlined">hand_package</span>
            <span class="button-text">Producto</span>
        </a>
        
        <a href="ListarProveedores.jsp" class="menu-button">
            <span class="material-symbols-outlined">groups</span>
            <span class="button-text">Proveedores</span>
        </a>
        
        <a href="ListarUsuarios.jsp" class="menu-button">
            <span class="material-symbols-outlined">identity_platform</span>
            <span class="button-text">Usuario</span>
        </a>
    </div>
</body>
</html>