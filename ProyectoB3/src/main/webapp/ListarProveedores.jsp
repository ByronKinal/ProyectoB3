<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Proveedor" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lista Proveedore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Listado de Proveedores</h2>
                    <a href="AgregarProveedor.jsp" class="btn btn-primary mb-3">Agregar Proveedor</a>
            <table class="table table-bordered table-striped">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                        <th>Correo</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Proveedor> listaProveedores = (List<Proveedor>) request.getAttribute("Proveedor");
                        if (listaProveedores != null && !listaProveedores.isEmpty()) {
                            for (Proveedor p : listaProveedores) {
                    %>
                    <tr>
                        <td><%= p.getIdProveedor()%></td>
                        <td><%= p.getNombreProveedor()%></td>
                        <td><%= p.getDireccionProveedor()%></td>
                        <td><%= p.getTelefonoProveedor()%></td>
                        <td><%= p.getCorreoProveedor()%></td>
                        <td>
                            <a href="ServletEditarProveedor?accion=editar&id=<%= p.getIdProveedor()%>" class="btn btn-warning">Editar</a>
                            <a href="ServletEliminarProveedor?id=<%= p.getIdProveedor()%>" class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Desea eliminar este proveedor?')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td class="text-center" colspan="6">No hay proveedores registrados</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
