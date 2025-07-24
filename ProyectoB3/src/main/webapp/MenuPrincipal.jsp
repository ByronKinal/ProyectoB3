<%-- 
    Document   : MenuPrincipal
    Created on : Jul 22, 2025, 11:57:28 PM
    Author     : mario.garcia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Inicio de Sesion</title>
        <link rel="stylesheet" href="MenuPrincipal.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" 
              crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <style>



        </style>
    </head>
    <body>
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



        <div class="menu">
            <h2>Novedades</h2>
            <div>
                <select id="ordenar">
                    <option value="default">Ordenar por</option>
                    <option value="precio-asc">Precio: menor a mayor</option>
                    <option value="precio-desc">Precio: mayor a menor</option>
                    <option value="nombre">Nombre (A-Z)</option>
                </select>


                <select id="filtro">
                    <option value="todos">Todos</option>
                    <option value="hombre">Hombre</option>
                    <option value="mujer">Mujer</option>
                </select>
            </div>
        </div>


        <!-- Galería de productos -->
        <div class="galeria">
            <div class="producto">
                <img src="https://lzd-img-global.slatic.net/g/p/4fa9b093eed1f737cab0eb186a47012e.jpg_720x720q80.jpg"
                     alt="Producto 1">
                <div class="info">
                    <div class="precio">Q 1,325.00</div>
                    <div class="descripcion">Tenis de running Supernova Rise 2</div>
                    <div class="categoria">Mujer</div>
                </div>
            </div>

            <div class="producto">
                <img src="https://tse4.mm.bing.net/th/id/OIP.oVa7xS6lNdkLDKlvgs3U8AHaHa?r=0&w=2048&h=2048&rs=1&pid=ImgDetMain&o=7&rm=3"
                     alt="Producto 2">
                <div class="info">
                    <div class="precio">Q 1,340.00</div>
                    <div class="descripcion">Tenis Supernova Rise 2 Running</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>

            <div class="producto">
                <img src="https://img.joomcdn.net/798278fb406fd543d3ff528ba20ed629e9a99855_original.jpeg" alt="Producto 3">
                <div class="info">
                    <div class="precio">Q 960.00</div>
                    <div class="descripcion">Tenis Supernova Ease</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>

            <div class="producto">
                <img src="https://sc04.alicdn.com/kf/Hc56d8857810248188aff63dc8dd4950f4/257971277/Hc56d8857810248188aff63dc8dd4950f4.jpg"
                     alt="Producto 4">
                <div class="info">
                    <div class="precio">Q 960.00</div>
                    <div class="descripcion">Tenis Supernova Ease</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>

            <div class="producto">
                <img src="https://tse2.mm.bing.net/th/id/OIP.gcwCCbC66G5mjayWFfo-8AHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3"
                     alt="Producto 5">
                <div class="info">
                    <div class="precio">Q 1,340.00</div>
                    <div class="descripcion">Supernova Rise 2 W</div>
                    <div class="categoria">Mujer</div>
                </div>
            </div>

            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 6">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 7">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 8">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 9">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 10">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 11">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 12">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 13">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 14">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 15">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
            <div class="producto">
                <img src="https://http2.mlstatic.com/D_NQ_NP_769698-MCO26513862779_122017-O.jpg" alt="Producto 16">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>



        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" 
        crossorigin="anonymous"></script>
    </body>
</html>
