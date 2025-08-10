<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Agregar Proveedor</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h1>Agregar Proveedor</h1>
            <form action="ServletAgregarProveedor" method="post">
                <div class="mb-3">
                    <label for="nombreProveedor" class="form-label">Nombre del Proveedor:</label>
                    <input type="text" id="nombreProveedor" name="nombreProveedor" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="correoProveedor" class="form-label">Correo:</label>
                    <input type="email" id="correoProveedor" name="correoProveedor" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="telefonoProveedor" class="form-label">Teléfono:</label>
                    <input type="text" id="telefonoProveedor" name="telefonoProveedor" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="direccionProveedor" class="form-label">Dirección:</label>
                    <textarea id="direccionProveedor" name="direccionProveedor" class="form-control" rows="3" required></textarea>
                </div>

                <button type="submit" class="btn btn-primary">Guardar</button>
                <a href="ServletListarProveedores" class="btn btn-secondary">Cancelar</a>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>