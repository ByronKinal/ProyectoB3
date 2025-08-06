<%@page import="java.util.List"%>
<%@page import="model.Producto"%>
<%@page import="dao.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                <a href="MenuPrincipal.jsp" id="todos" class="btnNavegacion">
                    <h1 class="TipoDeZapato">Todos</h1>
                </a>
                <a href="MenuPrincipal.jsp?genero=Hombre" id="hombre" class="btnNavegacion">
                    <h1 class="TipoDeZapato">Hombre</h1>
                </a>
                <a href="MenuPrincipal.jsp?genero=Mujer" id="mujer" class="btnNavegacion">
                    <h1 class="TipoDeZapato">Mujer</h1>
                </a>
                <a href="MenuPrincipal.jsp?genero=Unisex" id="unisex" class="btnNavegacion">
                    <h1 class="TipoDeZapato">Unisex</h1>
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
                    <option value="casual">Casual</option>
                    <option value="deportivo">Deportivo</option>
                </select>
            </div>
        </div>

        <div class="galeria">

            <%
                ProductoDAO productoDAO = new ProductoDAO();
                String genero = request.getParameter("genero");
                List<Producto> productos;

                if (genero != null && !genero.isEmpty()) {
                    productos = productoDAO.listarProductosPorGenero(genero);
                } else {
                    productos = productoDAO.listarProductosCompletos();
                }
                request.setAttribute("productos", productos);
            %>

            <c:choose>
                <c:when test="${empty productos}">
                    <div class="mensaje-vacio">No se encontraron productos</div>
                </c:when>
                <c:otherwise>
                    <div class="galeria">
                        <c:forEach items="${productos}" var="producto">
                            <div class="producto">
                                <div class="card producto">
                                    <img src="${producto.urlImagen}" class="logo" alt="${producto.nombreProducto}">
                                    <div class="info">
                                        <h5 class="card-title">${producto.nombreProducto}</h5>
                                        <p  style="margin-bottom: 0px" class="precio">Q ${producto.precioProducto}</p>
                                        <p  style="margin-bottom: 0px">${producto.descripcionProducto}</p>
                                        <p>
                                                ${producto.categoria.nombreCategoriaGenero} - ${producto.categoria.nombreCategoriaTipo}
                                        </p>
                                        <a href="#" class="btn btn-primary">Agregar al carrito</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

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