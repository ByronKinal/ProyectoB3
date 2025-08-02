<%@page import="java.util.List"%>
<%@page import="model.Producto"%>
<%@page import="dao.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú Administrativo</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="StyleAdministrativo.css">
    </head>
    <body>
        <div class="linea-superior">CALZADO BIEN HECHO</div>
        <div class="menu">
            <div class="tipos">
                <p class="titulo">SHOESKI</p>
            </div>
            <button class="btnCambios" id="agregar" onclick="location.href = 'RegistroProductos.jsp'">AGREGAR</button>
        </div>

        <%-- Mensajes de éxito o error --%>
        <c:if test="${not empty mensaje}">
            <div class="alert alert-${tipoMensaje} alert-dismissible fade show" role="alert">
                ${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="container mt-4">
            <div class="row">
                <%
                    ProductoDAO productoDAO = new ProductoDAO();
                    List<Producto> productos = productoDAO.listarProductosCompletos();
                    request.setAttribute("productos", productos);
                %>

                <c:choose>
                    <c:when test="${empty productos}">
                        <div class="col-12">
                            <div class="alert alert-info">No hay productos registrados</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${productos}" var="producto">
                            <div class="col-md-4 mb-4">
                                <div class="card h-100">
                                    <img src="${producto.urlImagen}" class="card-img-top" alt="${producto.nombreProducto}" style="height: 200px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">${producto.nombreProducto}</h5>
                                        <p class="card-text">${producto.descripcionProducto}</p>
                                        <p class="card-text"><strong>Q ${producto.precioProducto}</strong></p>
                                        <p class="card-text">
                                            <small class="text-muted">
                                                ${producto.categoria.nombreCategoriaGenero} - ${producto.categoria.nombreCategoriaTipo}
                                            </small>
                                        </p>
                                        <p class="card-text">
                                            <small class="text-muted">
                                                Proveedor: ${producto.proveedor.nombreProveedor}
                                            </small>
                                        </p>
                                        <p class="card-text">
                                            <small class="text-muted">
                                                Stock: ${producto.stockProducto}
                                            </small>
                                        </p>
                                    </div>
                                    <div class="card-footer bg-transparent">
                                        <a href="ServletEditarProducto?id=${producto.idProducto}" class="btnCambios" id="editar">Editar</a>
                                        <a href="ServletEliminarProducto?id=${producto.idProducto}" 
                                           class="btnCambios" id="eliminar"
                                           onclick="return confirm('¿Está seguro de eliminar este producto?')">Eliminar</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
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