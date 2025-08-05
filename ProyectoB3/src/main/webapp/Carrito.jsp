<%-- 
    Document   : Carrito
    Created on : Aug 4, 2025, 10:52:41 PM
    Author     : mario.garcia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrito</title>
        <link rel="stylesheet" href="StyleCarrito.css"/>
    </head>
    <body>
    <img class="imagen-centro" src="https://i.postimg.cc/MTtLxgXD/Logo-Kinal-Zapato-1-0.jpg" alt="Logo">
    <div class="contenedor-carrito">
        <!-- Carrito de productos -->
        <div class="carrito">
            <h2>TU CARRITO</h2>

            <div class="item-carrito">
                <img src="https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/1fa18f47b66e4f4980ba74d48de04ecc_9366/Handball_Spezial_Shoes_Blue_IF7087_01_standard.jpg" alt="Zapatilla Adidas">
                <div class="detalle-item">
                    <h3>Adidas Ultraboost</h3>
                    <p>Talla: 42</p>
                    <p>Cantidad: 1</p>
                    <p class="precio">Q180.00</p>
                </div>
            </div>

            <div class="item-carrito">
                <img src="https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/4659ee058ba34bd2a5d0af500104c17d_9366/Campus_00s_Shoes_Black_HQ8708_01_standard.jpg" alt="Camiseta Adidas">
                <div class="detalle-item">
                    <h3>Camiseta Adidas Originals</h3>
                    <p>Talla: 42</p>
                    <p>Cantidad: 2</p>
                    <p class="precio">Q60.00</p>
                </div>
            </div>
            
        </div>

        <!-- Resumen del pedido -->
        <div class="resumen">
            <h3>RESUMEN</h3>
            <div class="resumen-linea">
                <span>Subtotal</span>
                <span>Q240.00</span>
            </div>
            <div class="resumen-linea">
                <span>Envío</span>
                <span>Gratis</span>
            </div>
            <div class="resumen-linea total">
                <span>Total</span>
                <span>Q240.00</span>
            </div>
           <a href="MenuPrincipal.jsp" class="boton-finalizar" onclick="alert('¡Compra finalizada con éxito!')">FINALIZAR COMPRA</a>
        </div>
    </div>

</body>
</html>
