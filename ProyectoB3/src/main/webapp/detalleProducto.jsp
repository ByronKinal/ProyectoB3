<%-- 
    Document   : detalleProducto
    Created on : Aug 4, 2025, 9:12:53 PM
    Author     : mario.garcia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalle Producto</title>
           <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
           <link rel="stylesheet" href="StyleDetalleProducto.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital@1&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
     <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>
  <body>
    <div class="linea-superior">CALZADO BIEN HECHO</div>
    <div class="barra-superior">
        <div class="logo">
            <img src="https://i.postimg.cc/MTtLxgXD/Logo-Kinal-Zapato-1-0.jpg" alt="Logo">
        </div>
        <div class="espaciador"></div>

        <div class="iconos">
            <a href="InicioDeSesion.html" id="btnSesion" class="btn-sesion">
                <span class="material-icons-outlined">person</span>
            </a>
            <a href="Carrito.html" id="btnSesion" class="btn-carrito">
                <span class="material-icons-outlined">shopping_bag</span>
            </a>
        </div>
    </div>

    <div class="breadcrumb-nav">
        <a href="MenuPrincipal.jsp">Inicio</a> / <span>Tenis de running Supernova Rise
            2</span>
    </div>

    <!-- Contenedor principal del producto xd -->
    <div class="producto-container">
        <!-- Galería de imágenes -->
        <div class="galeria-imagenes">
            <div class="imagen-principal">
                <img id="imagenPrincipal"
                    src="https://lzd-img-global.slatic.net/g/p/4fa9b093eed1f737cab0eb186a47012e.jpg_720x720q80.jpg"
                    alt="Producto">
            </div>
        </div>

        <!-- Información del producto -->
        <div class="producto-info">
            <h1>Tenis de running Supernova Rise 2</h1>
            <div class="producto-categoria">Calzado Deportivo • Mujer</div>
            <div class="producto-precio">
                <span class="precio-descuento">Q 1,800.00</span>
                Q 1,500.00
            </div>

            <!-- Selector de tallas -->
            <div class="selector-tallas">
                <h3>Selecciona tu talla</h3>
                <div class="tallas-grid">
                    <div class="talla-option" onclick="seleccionarTalla(this)">6</div>
                    <div class="talla-option" onclick="seleccionarTalla(this)">6.5</div>
                    <div class="talla-option" onclick="seleccionarTalla(this)">7</div>
                    <div class="talla-option" onclick="seleccionarTalla(this)">7.5</div>
                    <div class="talla-option" onclick="seleccionarTalla(this)">8</div>
                    <div class="talla-option agotada">8.5</div>
                    <div class="talla-option" onclick="seleccionarTalla(this)">9</div>
                    <div class="talla-option" onclick="seleccionarTalla(this)">9.5</div>
                </div>
            </div>

            <!-- Selector de cantidad -->
            <div class="selector-cantidad">
                <h3>Cantidad</h3>
                <div class="cantidad-controls">
                    <input type="number" id="cantidad" class="cantidad-input" value="1" min="1" max="10">
                   
                </div>
            </div>

            <!-- Botones de acción -->
            <div class="acciones-producto">
                <button class="btn-agregar-carrito" onclick="agregarAlCarrito()">
                    AGREGAR AL CARRITO
                </button>
            </div>

            <!-- Información adicional -->
            <div class="info-adicional">
                <div class="info-item">
                    <span class="material-icons">local_shipping</span>
                    <span>Envío gratis en pedidos mayores a Q 500</span>
                </div>
                <div class="info-item">
                    <span class="material-icons">autorenew</span>
                    <span>Devoluciones gratuitas dentro de 30 días</span>
                </div>
                <div class="info-item">
                    <span class="material-icons">verified</span>
                    <span>Garantía de calidad y autenticidad</span>
                </div>
            </div>

            <!-- Descripción del producto -->
            <div class="descripcion-producto">
                <h3>Descripción</h3>
                <p>Los tenis Supernova Rise 2 están diseñados para brindarte la máxima comodidad durante tus
                    entrenamientos de running. Con tecnología de amortiguación avanzada y materiales transpirables de
                    alta calidad.</p>
                <p>Características principales:</p>
                <ul>
                    <li>Suela de goma resistente con tracción superior</li>
                    <li>Upper transpirable de malla técnica</li>
                    <li>Sistema de amortiguación en el talón</li>
                    <li>Diseño ergonómico para mayor comodidad</li>
                </ul>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
        crossorigin="anonymous"></script>
</body>
</html>
