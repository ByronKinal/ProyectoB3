<%-- 
    Document   : ProductoDetalle
    Created on : Jul 29, 2025
    Author     : ft\denis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Producto - Zapatería</title>
        <link rel="stylesheet" href="ProductoDetalle.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" 
              crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        
        <!-- Estilos básicos temporales para que no se descontrole xd -->
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                background-color: #fff;
            }
            
            /* Barra superior básica */
            .barra-superior {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 20px;
                border-bottom: 1px solid #eee;
            }
            
            .logo img {
                height: 50px;
            }
            
            .espaciador {
                flex: 1;
            }
            
            .buscador {
                display: flex;
                align-items: center;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 5px;
            }
            
            .buscador input {
                border: none;
                outline: none;
                padding: 5px;
            }
            
            .iconos {
                display: flex;
                gap: 15px;
            }
            
            .iconos button {
                background: none;
                border: none;
                cursor: pointer;
            }
            
            /* Breadcrumb */
            .breadcrumb-nav {
                padding: 15px 20px;
                font-size: 14px;
                color: #666;
            }
            
            .breadcrumb-nav a {
                color: #666;
                text-decoration: none;
            }
            
            /* Control básico de imágenes */
            .imagen-principal img {
                max-width: 400px;
                height: 300px;
                object-fit: cover;
                border-radius: 8px;
            }
            
            .imagen-mini {
                width: 60px;
                height: 60px;
                border: 1px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
            }
            
            .imagen-mini img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 4px;
            }
            
            .imagen-mini.active {
                border-color: #000;
            }
            
            .producto-card img {
                width: 100%;
                height: 150px;
                object-fit: cover;
            }
            
            /* Layout básico */
            .producto-container {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 40px;
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            
            .imagenes-mini {
                display: flex;
                gap: 10px;
                margin-top: 10px;
            }
            
            .productos-relacionados {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 20px;
            }
            
            .productos-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
            }
            
            .producto-card {
                border: 1px solid #eee;
                border-radius: 6px;
                overflow: hidden;
            }
            
            .card-info {
                padding: 10px;
            }
            
            /* Selectores de talla y cantidad básicos */
            .tallas-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 8px;
                margin: 10px 0;
            }
            
            .talla-option {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
                cursor: pointer;
                border-radius: 4px;
            }
            
            .talla-option.selected {
                background-color: #000;
                color: #fff;
            }
            
            .talla-option.agotada {
                background-color: #f5f5f5;
                color: #ccc;
                cursor: not-allowed;
            }
            
            .cantidad-controls {
                display: flex;
                align-items: center;
                gap: 10px;
                margin: 10px 0;
            }
            
            .cantidad-btn {
                width: 30px;
                height: 30px;
                border: 1px solid #ddd;
                background: #f5f5f5;
                cursor: pointer;
                border-radius: 4px;
            }
            
            .cantidad-input {
                width: 50px;
                text-align: center;
                border: 1px solid #ddd;
                padding: 5px;
                border-radius: 4px;
            }
            
            /* Botones básicos */
            .btn-agregar-carrito, .btn-comprar-ahora {
                width: 100%;
                padding: 12px;
                margin: 5px 0;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
            }
            
            .btn-agregar-carrito {
                background-color: #000;
                color: #fff;
                border: none;
            }
            
            .btn-comprar-ahora {
                background-color: transparent;
                color: #000;
                border: 1px solid #000;
            }
            
            /* Info adicional */
            .info-item {
                display: flex;
                align-items: center;
                gap: 10px;
                margin: 8px 0;
                font-size: 14px;
            }
            
            /* Responsive básico */
            @media (max-width: 768px) {
                .producto-container {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }
                
                .productos-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
        </style>
    </head>
    <body>
        <!-- Barra superior igual que el menú principal -->
        <div class="barra-superior">
            <div class="logo">
                <img src="1000099271-removebg-preview.png" alt="Logo" height="40">
            </div>
            <div class="espaciador"></div>
            <div class="buscador">
                <input type="text" placeholder="Buscar">
                <button id="btnBuscar" type="button">
                    <span class="material-icons">search</span>
                </button>
            </div>
            <div class="iconos">
                <button id="btnSesion" type="button">
                    <span class="material-icons">person</span>
                </button>
                <button id="btnCarrito" type="button">
                    <span class="material-icons">shopping_bag</span>
                </button>
            </div>
        </div>

        <!-- Navegación breadcrumb -->
        <div class="breadcrumb-nav">
            <a href="MenuPrincipal.jsp">Inicio</a> / <a href="#">Calzado</a> / <span>Tenis de running Supernova Rise 2</span>
        </div>

        <!-- Contenedor principal del producto xd -->
        <div class="producto-container">
            <!-- Galería de imágenes -->
            <div class="galeria-imagenes">
                <div class="imagen-principal">
                    <img id="imagenPrincipal" src="https://lzd-img-global.slatic.net/g/p/4fa9b093eed1f737cab0eb186a47012e.jpg_720x720q80.jpg" alt="Producto">
                </div>
                <div class="imagenes-mini">
                    <div class="imagen-mini active" onclick="cambiarImagen(this)">
                        <img src="https://lzd-img-global.slatic.net/g/p/4fa9b093eed1f737cab0eb186a47012e.jpg_720x720q80.jpg" alt="Vista 1">
                    </div>
                    <div class="imagen-mini" onclick="cambiarImagen(this)">
                        <img src="https://tse4.mm.bing.net/th/id/OIP.oVa7xS6lNdkLDKlvgs3U8AHaHa?r=0&w=2048&h=2048&rs=1&pid=ImgDetMain&o=7&rm=3" alt="Vista 2">
                    </div>
                    <div class="imagen-mini" onclick="cambiarImagen(this)">
                        <img src="https://img.joomcdn.net/798278fb406fd543d3ff528ba20ed629e9a99855_original.jpeg" alt="Vista 3">
                    </div>
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
                        <button class="cantidad-btn" onclick="cambiarCantidad(-1)">-</button>
                        <input type="number" id="cantidad" class="cantidad-input" value="1" min="1" max="10">
                        <button class="cantidad-btn" onclick="cambiarCantidad(1)">+</button>
                    </div>
                </div>

                <!-- Botones de acción -->
                <div class="acciones-producto">
                    <button class="btn-agregar-carrito" onclick="agregarAlCarrito()">
                        <span class="material-icons">shopping_cart</span>
                        Agregar al carrito
                    </button>
                    <button class="btn-comprar-ahora" onclick="comprarAhora()">
                        Comprar ahora
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
                    <p>Los tenis Supernova Rise 2 están diseñados para brindarte la máxima comodidad durante tus entrenamientos de running. Con tecnología de amortiguación avanzada y materiales transpirables de alta calidad.</p>
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

        <!-- Productos relacionados -->
        <div class="productos-relacionados">
            <h2>También te puede interesar</h2>
            <div class="productos-grid">
                <div class="producto-card">
                    <img src="https://tse4.mm.bing.net/th/id/OIP.oVa7xS6lNdkLDKlvgs3U8AHaHa?r=0&w=2048&h=2048&rs=1&pid=ImgDetMain&o=7&rm=3" alt="Producto relacionado">
                    <div class="card-info">
                        <div class="card-precio">Q 1,340.00</div>
                        <div class="card-descripcion">Tenis Supernova Rise 2 Running</div>
                    </div>
                </div>
                <div class="producto-card">
                    <img src="https://img.joomcdn.net/798278fb406fd543d3ff528ba20ed629e9a99855_original.jpeg" alt="Producto relacionado">
                    <div class="card-info">
                        <div class="card-precio">Q 960.00</div>
                        <div class="card-descripcion">Tenis Supernova Ease</div>
                    </div>
                </div>
                <div class="producto-card">
                    <img src="https://tse2.mm.bing.net/th/id/OIP.gcwCCbC66G5mjayWFfo-8AHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3" alt="Producto relacionado">
                    <div class="card-info">
                        <div class="card-precio">Q 1,340.00</div>
                        <div class="card-descripcion">Supernova Rise 2 W</div>
                    </div>
                </div>
                <div class="producto-card">
                    <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto relacionado">
                    <div class="card-info">
                        <div class="card-precio">Q 1,055.00</div>
                        <div class="card-descripcion">Tenis Supernova Surge</div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" 
        crossorigin="anonymous"></script>
    </body>
</html>