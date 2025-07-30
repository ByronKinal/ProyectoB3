<%-- 
    Document   : RegistroProductos
    Created on : Jul 29, 2025, 9:32:23 PM
    Author     : mario.garcia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="StyleRegistroProducto.css">
    </head>
    <body>

    <a class="regresar" href="MenuPrincipal.html">Regresar</a>

    <div class="card">
        <h1>Nuevo Producto</h1>
        <form action="MenuPrincipal.html" method="get">
            <div class="form-group">
                <label class="card-label" for="nombreProducto">Nombre del Producto</label>
                <input type="text" id="nombreProducto" name="nombreProducto" required>
            </div>

            <div class="form-group">
                <label class="card-label" for="descripcionProducto">Descripción</label>
                <input type="text" id="descripcionProducto" name="descripcionProducto" required>
            </div>

            <div class="form-group">
                <label class="card-label" for="url_imagen">URL de la Imagen</label>
                <input type="text" id="url_imagen" name="url_imagen" required>
            </div>

            <div class="form-group">
                <label class="card-label" for="tallaProducto">Talla</label>
                <input type="text" id="tallaProducto" name="tallaProducto">
            </div>
            <div class="form-group">
                <label class="card-label" for="marcaProducto">Marca</label>
                <input type="text" id="marcaProducto" name="marcaProducto" required>
            </div>
            <div class="form-group">
                <label class="card-label" for="precioProducto">Precio (Q)</label>
                <input type="number" step="0.5" id="precioProducto" name="precioProducto" required min="0">
            </div>
            
            <div class="form-group">
                <label class="card-label" for="idProveedor">ID Proveedor</label>
                <input type="number" id="idProveedor" name="idProveedor" required min="0">
            </div>
            
            <div class="form-group">
                <label class="card-label" for="idCategoria">ID Categoría</label>
                <input type="number" id="idCategoria" name="idCategoria" required min="0">
            </div>
            <div class="form-group">
                <label class="card-label" for="stockProducto">Stock</label>
                <input type="number" step="10" id="stockProducto" name="stockProducto" required min="0">
            </div>
            <button type="submit">Guardar Producto</button>
        </form>
    </div>

</body>
</html>
