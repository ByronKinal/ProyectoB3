<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Proveedor"%>
<%
    Proveedor proveedor = (Proveedor) request.getAttribute("proveedor");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Editar Proveedor</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h1>Editar Proveedor</h1>
            <form action="ServletEditarProveedor" method="post">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="id" value="<%=proveedor.getIdProveedor()%>">

                <div class="mb-3">
                    <label for="nombreProveedor" class="form-label">Nombre del Proveedor:</label>
                    <input type="text" id="nombreProveedor" name="nombreProveedor" class="form-control" 
                           value="<%=proveedor.getNombreProveedor()%>" required>
                </div>

                <div class="mb-3">
                    <label for="correoProveedor" class="form-label">Correo:</label>
                    <input type="email" id="correoProveedor" name="correoProveedor" class="form-control" 
                           value="<%=proveedor.getCorreoProveedor()%>" required>
                </div>

                <div class="mb-3">
                    <label for="telefonoProveedor" class="form-label">Teléfono:</label>
                    <input type="text" id="telefonoProveedor" name="telefonoProveedor" class="form-control" 
                           value="<%=proveedor.getTelefonoProveedor()%>" required>
                </div>

                <div class="mb-3">
                    <label for="direccionProveedor" class="form-label">Dirección:</label>
                    <textarea id="direccionProveedor" name="direccionProveedor" class="form-control" rows="3" required><%=proveedor.getDireccionProveedor()%></textarea>
                </div>

                <div class="mb-3">
                    <label for="estadoProveedor" class="form-label">Estado:</label>
                    <select id="estadoProveedor" name="estadoProveedor" class="form-select" required>
                        <option value="ACTIVO" <%= "ACTIVO".equals(proveedor.getEstadoProveedor()) ? "selected" : ""%>>Activo</option>
                        <option value="SUSPENDIDO" <%= "SUSPENDIDO".equals(proveedor.getEstadoProveedor()) ? "selected" : ""%>>Suspendido</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Actualizar</button>
                <a href="ServletListarProveedores" class="btn btn-secondary">Cancelar</a>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>