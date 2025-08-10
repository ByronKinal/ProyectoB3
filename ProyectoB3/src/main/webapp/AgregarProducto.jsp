<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro de Productos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="StyleRegistroProducto.css">
    </head>
    <body>
        <div>

            <a class="regresar" href="ListarProductos.jsp">Regresar</a>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="card">
                <div>
                    <h1>NUEVO PRODUCTO</h1>
                </div>
                <div class="card-body">
                    <form action="ServletAgregarProducto" method="post">
                        <div class="mb-3">
                            <label for="nombreProducto" class="form-label">Nombre del Producto</label>
                            <input type="text" class="form-control" id="nombreProducto" name="nombreProducto" required>
                        </div>

                        <div class="mb-3">
                            <label for="descripcionProducto" class="form-label">Descripción</label>
                            <input type="text" class="form-control" id="descripcionProducto" name="descripcionProducto" required>
                        </div>

                        <div class="mb-3">
                            <label for="url_imagen" class="form-label">URL de la Imagen</label>
                            <input type="text" class="form-control" id="url_imagen" name="url_imagen" required>
                        </div>

                        <div class="mb-3">
                            <label for="tallaProducto" class="form-label">Talla</label>
                            <input type="text" class="form-control" id="tallaProducto" name="tallaProducto">
                        </div>

                        <div class="mb-3">
                            <label for="marcaProducto" class="form-label">Marca</label>
                            <input type="text" class="form-control" id="marcaProducto" name="marcaProducto" required>
                        </div>

                        <div class="mb-3">
                            <label for="precioProducto" class="form-label">Precio (Q)</label>
                            <input type="number" step="0.01" class="form-control" id="precioProducto" name="precioProducto" required min="0">
                        </div>

                        <div class="mb-3">
                            <label for="idProveedor" class="form-label">ID Proveedor</label>
                            <input type="number" class="form-control" id="idProveedor" name="idProveedor" required min="1">
                        </div>

                        <div class="mb-3">
                            <label for="idCategoria" class="form-label">ID Categoría</label>
                            <input type="number" class="form-control" id="idCategoria" name="idCategoria" required min="1">
                        </div>

                        <div class="mb-3">
                            <label for="stockProducto" class="form-label">Stock</label>
                            <input type="number" class="form-control" id="stockProducto" name="stockProducto" required min="0">
                        </div>



                        <div class="d-grid">
                            <button type="submit" class="buttonAgregar">Guardar Producto</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>