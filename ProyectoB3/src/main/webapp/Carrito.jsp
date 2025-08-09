<%@page import="java.util.List"%>
<%@page import="model.Carrito"%>
<%@page import="model.Compra"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrito</title>
        <link rel="stylesheet" href="StyleCarrito.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" 
              crossorigin="anonymous">
        <style>
            .contenedor-carrito {
                display: flex;
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                gap: 30px;
            }

            .carrito {
                flex: 2;
            }

            .resumen {
                flex: 1;
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                height: fit-content;
            }

            .item-carrito {
                display: flex;
                margin-bottom: 20px;
                padding-bottom: 20px;
                border-bottom: 1px solid #eee;
                gap: 20px;
            }

            .item-carrito img {
                width: 120px;
                height: 120px;
                object-fit: cover;
                border-radius: 4px;
            }

            .detalle-item {
                flex: 1;
            }

            .precio {
                font-weight: bold;
                color: #333;
            }

            .resumen-linea {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }

            .total {
                font-weight: bold;
                font-size: 1.2em;
                margin-top: 20px;
                padding-top: 10px;
                border-top: 1px solid #ddd;
            }

            .boton-finalizar {
                display: block;
                width: 100%;
                padding: 10px;
                background: #000;
                color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 4px;
                margin-top: 20px;
            }

            .boton-finalizar:hover {
                background: #333;
            }

            .cantidad-control {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .cantidad-control input {
                width: 50px;
                text-align: center;
            }

            .imagen-centro {
                display: block;
                margin: 20px auto;
                max-width: 200px;
            }

            .acciones-item {
                display: flex;
                gap: 10px;
                margin-top: 10px;
            }

            /* Estilo para mensajes */
            .alert-container {
                position: fixed;
                top: 80px;
                left: 50%;
                transform: translateX(-50%);
                z-index: 1000;
                width: 80%;
                max-width: 500px;
            }
        </style>
    </head>
    <body>
        <!-- Mensajes de alerta -->
        <div class="alert-container">
            <c:if test="${not empty mensaje}">
                <div class="alert alert-success alert-dismissible fade show">
                    ${mensaje}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </div>

        <img class="imagen-centro" src="https://i.postimg.cc/MTtLxgXD/Logo-Kinal-Zapato-1-0.jpg" alt="Logo">

        <div class="contenedor-carrito">
            <!-- Carrito de productos -->
            <div class="carrito">
                <h2>TU CARRITO</h2>

                <c:choose>
                    <c:when test="${empty itemsCarrito}">
                        <div class="alert alert-info">Tu carrito está vacío</div>
                        <a href="MenuPrincipal.jsp" class="btn btn-primary">Seguir comprando</a>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${itemsCarrito}" var="item">
                            <div class="item-carrito">
                                <img src="${item.producto.urlImagen}" alt="${item.producto.nombreProducto}">
                                <div class="detalle-item">
                                    <h3>${item.producto.nombreProducto}</h3>
                                    <p>${item.producto.descripcionProducto}</p>
                                    <p>Talla: ${item.producto.tallaProducto}</p>
                                    <p>Precio unitario: Q ${item.producto.precioProducto}</p>

                                    <form action="ServletCarrito" method="POST">
                                        <input type="hidden" name="action" value="actualizar">
                                        <input type="hidden" name="idCompra" value="${compra.idCompra}">
                                        <input type="hidden" name="idProducto" value="${item.producto.idProducto}">
                                        <div class="cantidad-control">
                                            <label>Cantidad:</label>
                                            <input type="number" name="cantidad" value="${item.cantidadProducto}" min="1" max="10">
                                            <button type="submit" class="btn-actualizar">Actualizar</button>
                                        </div>
                                    </form>

                                    <p class="precio">Subtotal: Q ${item.subtotal}</p>

                                    <form action="ServletCarrito" method="POST">
                                        <input type="hidden" name="action" value="eliminar">
                                        <input type="hidden" name="idCompra" value="${compra.idCompra}">
                                        <input type="hidden" name="idProducto" value="${item.producto.idProducto}">
                                        <button type="submit" class="btn-eliminar">Eliminar</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Resumen del pedido -->
            <div class="resumen">
                <h3>RESUMEN</h3>
                <div class="resumen-linea">
                    <span>Subtotal</span>
                    <span>Q ${total}</span>
                </div>
                <div class="resumen-linea">
                    <span>Envío</span>
                    <span>Gratis</span>
                </div>
                <div class="resumen-linea total">
                    <span>Total</span>
                    <span>Q ${total}</span>
                </div>

                <c:if test="${not empty itemsCarrito}">
                    <form action="ServletCarrito" method="POST">
                        <input type="hidden" name="action" value="finalizar">
                        <input type="hidden" name="idCompra" value="${compra.idCompra}">
                        <button type="submit" class="boton-finalizar">FINALIZAR COMPRA</button>
                    </form>

                    <form action="ServletCarrito" method="POST">
                        <input type="hidden" name="action" value="cancelar">
                        <input type="hidden" name="idCompra" value="${compra.idCompra}">
                        <button type="submit" class="btn btn-outline-danger w-100 mt-2">CANCELAR PEDIDO</button>
                    </form>
                </c:if>

                <a href="MenuPrincipal.jsp" class="btn btn-outline-primary w-100 mt-2">SEGUIR COMPRANDO</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" 
        crossorigin="anonymous"></script>

        <script>
            // Ocultar mensajes después de 5 segundos
            setTimeout(function () {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        </script>
    </body>
</html>