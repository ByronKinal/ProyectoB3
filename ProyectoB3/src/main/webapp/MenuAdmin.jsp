<%-- 
    Document   : MenuAdmin
    Created on : Aug 1, 2025, 11:50:55 PM
    Author     : mario.garcia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú administrativo</title>
        <link rel="stylesheet" href="StyleAdmin.css">
    </head>
    <body>
    <div class="centrar">
        <div class="rol">
            <a href="ListarProductos.jsp"><img class="imagen"
                    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyftiXIrUdZ-p8CiTJZPXz2LcNUMmH3--IjQ&s" alt=""></a>
             <p>PRODUCTOS</p>
        </div>
        <div class="rol">
            <a href="ServletListarProveedores"><img class="imagen"
                    src="https://static.vecteezy.com/system/resources/previews/035/772/805/non_2x/supplier-icon-line-outline-sign-symbol-graphic-illustration-vector.jpg" alt=""></a>
            <p>PROVEEDORES</p>
        </div>
        <div class="rol">
            <a href="ServletListarUsuarios"><img class="imagen"
                    src="https://cdn-icons-png.flaticon.com/512/6522/6522581.png    " alt=""></a>
           <p>USUARIOS</p>
        </div>
    </div>
</body>
</html>