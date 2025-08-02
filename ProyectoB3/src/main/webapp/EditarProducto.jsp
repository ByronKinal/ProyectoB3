
<%-- 
    Document   : EditarProducto
    Created on : Jul 30, 2025
    Author     : ft/denis
--%>


<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.util.List"%>
<%@page import="model.Proveedor"%>
<%@page import="model.Categoria"%>
<%@page import="dao.ProductoDAO"%>
<%@page import="model.Producto"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Producto</title>

        <link rel="stylesheet" href="StyleEditarProducto.css">
    </head>
    <body>

    <a class="regresar" href="MenuPrincipal.html">Regresar</a>

    <div class="card">
        <h1>Editar Producto</h1>
        <form action="MenuPrincipal.html" method="post">
            <!-- Campo oculto para el ID del producto -->
            <input type="hidden" id="idProducto" name="idProducto" value="${producto.idProducto}">
            
            <div class="form-group">
                <label class="card-label" for="nombreProducto">Nombre del Producto</label>
                <input type="text" id="nombreProducto" name="nombreProducto" value="${producto.nombreProducto}" required>
            </div>

            <div class="form-group">
                <label class="card-label" for="descripcionProducto">Descripción</label>
                <input type="text" id="descripcionProducto" name="descripcionProducto" value="${producto.descripcionProducto}" required>
            </div>

            <div class="form-group">
                <label class="card-label" for="url_imagen">URL de la Imagen</label>
                <input type="text" id="url_imagen" name="url_imagen" value="${producto.urlImagen}">
            </div>

            <div class="form-group">
                <label class="card-label" for="tallaProducto">Talla</label>
                <input type="text" id="tallaProducto" name="tallaProducto" value="${producto.tallaProducto}">
            </div>
            
            <div class="form-group">
                <label class="card-label" for="marcaProducto">Marca</label>
                <input type="text" id="marcaProducto" name="marcaProducto" value="${producto.marcaProducto}" required>
            </div>
            
            <div class="form-group">
                <label class="card-label" for="precioProducto">Precio (Q)</label>
                <input type="number" step="0.01" id="precioProducto" name="precioProducto" value="${producto.precioProducto}" required min="0">
            </div>
            
            <div class="form-group">
                <label class="card-label" for="stockProducto">Stock</label>
                <input type="number" id="stockProducto" name="stockProducto" value="${producto.stockProducto}" required min="0">
            </div>
            
            <div class="form-group">
                <label class="card-label" for="idCategoria">ID Categoría</label>
                <input type="number" id="idCategoria" name="idCategoria" value="${producto.idCategoria}" required min="1">
            </div>
            
            <div class="form-group">
                <label class="card-label" for="idProveedor">ID Proveedor</label>
                <input type="number" id="idProveedor" name="idProveedor" value="${producto.idProveedor}" required min="1">
            </div>

            <div class="form-buttons">
                <button type="submit" class="btn-actualizar">Actualizar Producto</button>
                <button type="button" class="btn-cancelar" onclick="window.location.href='MenuPrincipal.html'">Cancelar</button>
            </div>
        </form>
    </div>

</body>


</html>