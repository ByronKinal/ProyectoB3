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
        <title>Menú Principal</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" 
              crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <link rel="stylesheet" href="StyleMenuPrincipal.css">

        <style>



        </style>
    </head>
    <body>
        <div class="linea-superior">CALZADO BIEN HECHO</div>
        <div class="barra-superior">
            <div class="logo">
                <img src="https://i.postimg.cc/MTtLxgXD/Logo-Kinal-Zapato-1-0.jpg" alt="Logo">
            </div>
            <div class="espaciador"></div>

            <div class="iconos">
                <a href="detalleUsuario.jsp" id="btnSesion" class="btn-sesion">
                    <img class="iconos" src="https://i.postimg.cc/4dv7Qhxn/person-40dp-000000-FILL0-wght400-GRAD0-opsz40.png" alt="login"/>
                </a>
                <a href="Carrito.jsp" id="btnCarrito" class="btn-carrito">
                    <img style=" margin-right: 40px "class="iconos" src="https://i.postimg.cc/XJxNvKvK/shopping-cart-35dp-000000-FILL0-wght400-GRAD0-opsz40.png "  alt="carrito"/>
                </a>

            </div>
        </div>



        <div class="menu">
            <div class="tipos">
                <a href="MenuPrincipal.html" id="sneakers" class="btnNavegacion">
                    <h1 class="TipoDeZapato">sneakers</h1>
                </a>
                <a href="MenuPrincipal.html" id="running" class="btnNavegacion">
                    <h1 class="TipoDeZapato">running</h1>
                </a>
                <a href="MenuPrincipal.html" id="golf" class="btnNavegacion">
                    <h1 class="TipoDeZapato">golf</h1>
                </a>
                <a href="MenuPrincipal.html" id="walking" class="btnNavegacion">
                    <h1 class="TipoDeZapato">walking</h1>
                </a>
                <a href="MenuPrincipal.html" id="soccer" class="btnNavegacion">
                    <h1 class="TipoDeZapato">soccer</h1>
                </a>
                <a href="MenuPrincipal.html" id="basquetball" class="btnNavegacion">
                    <h1 class="TipoDeZapato">basquetball</h1>
                </a>
                <a href="MenuPrincipal.html" id="gym" class="btnNavegacion">
                    <h1 class="TipoDeZapato">gym</h1>
                </a>

            </div>
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
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/1fa18f47b66e4f4980ba74d48de04ecc_9366/Handball_Spezial_Shoes_Blue_IF7087_01_standard.jpg"
                     alt="Producto 1">
                <div class="info">
                    <div class="precio">Q 1,325.00</div>
                    <div class="descripcion">Tenis de running Supernova Rise 2</div>
                    <div class="categoria">Mujer</div>
                </div>
            </a>

            <a href="detalleProducto.jsp" class="producto">
                <img src="https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/4659ee058ba34bd2a5d0af500104c17d_9366/Campus_00s_Shoes_Black_HQ8708_01_standard.jpg"
                     alt="Producto 2">
                <div class="info">
                    <div class="precio">Q 1,340.00</div>
                    <div class="descripcion">Tenis Supernova Rise 2 Running</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>

            <a href="detalleProducto.jsp" class="producto">
                <img src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/540653a2-a2aa-4e3a-8c33-6451f258946c/AIR+JORDAN+4+RETRO.png"
                     alt="Producto 3">
                <div class="info">
                    <div class="precio">Q 960.00</div>
                    <div class="descripcion">Tenis Supernova Ease</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>

            <a href="detalleProducto.jsp" class="producto">
                <img src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/4f37fca8-6bce-43e7-ad07-f57ae3c13142/AIR+FORCE+1+%2707.png"
                     alt="Producto 4">
                <div class="info">
                    <div class="precio">Q 960.00</div>
                    <div class="descripcion">Tenis Supernova Ease</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>

            <a href="detalleProducto.jsp" class="producto">
                <img src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/0f76f73e-2578-4d62-abab-c5563ea4f78c/NIKE+DUNK+LOW+RETRO.png"
                     alt="Producto 5">
                <div class="info">
                    <div class="precio">Q 1,340.00</div>
                    <div class="descripcion">Supernova Rise 2 W</div>
                    <div class="categoria">Mujer</div>
                </div>
            </a>

            <a href="detalleProducto.jsp" class="producto">
                <img src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/fe01cb61-0753-4143-accd-b7c654600021/NIKE+AVA+ROVER.png"
                     alt="Producto 6">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/81d10257-65bc-45c1-8970-5449316928c6/AIR+JORDAN+1+RETRO+HIGH+OG.png"
                     alt="Producto 7">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/a7050b74-050c-4e1d-bb91-09cd184e3881/AIR+JORDAN+10+RETRO.png"
                     alt="Producto 8">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/ab8d8bb7-536e-43af-8f49-5d86c370b7a2/AIR+JORDAN+1+MID.png" alt="Producto 9">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/dcbc35ce-491e-4f61-b2ca-4da4a5c1a431/AIR+JORDAN+1+LOW+SE.png" alt="Producto 10">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
        
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/9421d8988fdb4e79aa8a439b2b05043a_9366/Forum_Low_CL_Shoes_White_JQ0207_01_00_standard.jpg" alt="Producto 11">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/763fb5a2d82d448ca62baf4600f657c6_9366/Gazelle_Bold_Shoes_Black_HQ6912_01_00_standard.jpg" alt="Producto 12">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/9c3a7c72-9740-4b33-8d4b-194c6492faf1/AIR+JORDAN+1+LOW+EASYON.png" alt="Producto 13">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_500,h_500/global/395205/02/sv01/fnd/PNA/fmt/png/Tenis-Suede-XL" alt="Producto 14">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_500,h_500/global/395205/03/sv01/fnd/PNA/fmt/png/Tenis-Suede-XL" alt="Producto 15">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/89235dab-3047-41d2-af7b-d0a77f43fe6a/AIR+JORDAN+1+HIGH+G.png" alt="Producto 16">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_500,h_500/global/402869/01/sv01/fnd/PNA/fmt/png/Inhale-Tech-Street-X-Sneakers-Unisex" alt="Producto 16">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>

            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_500,h_500/global/405719/01/sv01/fnd/PNA/fmt/png/GV-Special-Tailored-Stripes-Sneakers-Unisex" alt="Producto 16">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </a>
            
            <a href="detalleProducto.jsp" class="producto">
                <img src="https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/c2ff02abbd304144b45797e8408f581a_9366/Gazelle_Indoor_Shoes_Blue_JI2061_01_standard.jpg" alt="Producto 16">
                <div class="info">
                    <div class="precio">Q 1,055.00</div>
                    <div class="descripcion">Tenis Supernova Surge</div>
                    <div class="categoria">Hombre</div>
                </div>
            </div>
        </a>

        <div class="space-vision">
            <h1 class="titulo-vision">shoesKi</h1>

            <p class="parrafo-vision">
                En ShoesKi, creemos que cada paso cuenta. Queremos brindarte calzado que no solo se ve bien,
                sino que te hace sentir increíble. Ofrecemos zapatos de alta calidad que combinan estilo, comodidad y
                durabilidad, pensados para seguir tu ritmo, ya sea en la ciudad, el trabajo o una aventura inesperada.
                Queremos ser parte de tu día a día con una experiencia de compra confiable, accesible y comprometida con las
                últimas tendencias.
            </p>

            <p class="parrafo-vision">
                Nuestro objetivo es posicionarnos como una marca líder en el mundo del calzado, destacando por la innovación
                en cada diseño, la responsabilidad en cada decisión y una atención al cliente que deja huella. En ShoesKi,
                no solo hacemos zapatos, transformamos la forma en que las personas caminan por la vida: con confianza,
                estilo y propósito.
            </p>

            <p class="parrafo-vision">
                En ShoesKi, apostamos por la calidad, ofreciendo calzado bien fabricado, cómodo y resistente para cada paso.
                Creemos en la innovación, con diseños y tecnologías que marcan tendencia y evolucionan contigo. Actuamos con
                responsabilidad, produciendo con ética y cuidando el planeta que pisamos. Nuestro compromiso con el cliente
                es total: te escuchamos, te entendemos y caminamos a tu lado. Nos mueve la pasión por lo que hacemos, y lo
                reflejamos en cada par que creamos. Valoramos tu tiempo y practicamos la puntualidad, entregando a tiempo y
                abriendo nuestras puertas siempre con una sonrisa.
            </p>

        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" 
        crossorigin="anonymous"></script>
    </body>
</html>
