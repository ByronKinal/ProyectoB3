<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Proveedor" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lista de Proveedores</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Listado de Proveedores</h2>
            
            <!-- Mostrar mensajes de éxito o error -->
            <%
                String mensaje = (String) session.getAttribute("mensaje");
                String tipoMensaje = (String) session.getAttribute("tipoMensaje");
                if (mensaje != null) {
            %>
            <div class="alert alert-<%=tipoMensaje%> alert-dismissible fade show" role="alert">
                <%=mensaje%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <%
                    session.removeAttribute("mensaje");
                    session.removeAttribute("tipoMensaje");
                }
            %>
            
            <a href="ServletAgregarProveedor" class="btn btn-primary mb-3">Agregar Proveedor</a>
            <table class="table table-bordered table-striped">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Nombre Proveedor</th>
                        <th>Correo</th>
                        <th>Teléfono</th>
                        <th>Dirección</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Proveedor> listaProveedores = (List<Proveedor>) request.getAttribute("Proveedores");
                        if (listaProveedores != null && !listaProveedores.isEmpty()) {
                            for (Proveedor p : listaProveedores) {
                    %>
                    <tr>
                        <td><%=p.getIdProveedor()%></td>
                        <td><%=p.getNombreProveedor()%></td>
                        <td><%=p.getCorreoProveedor()%></td>
                        <td><%=p.getTelefonoProveedor()%></td>
                        <td><%=p.getDireccionProveedor()%></td>
                        <td>
                            <span class="badge <%= "ACTIVO".equals(p.getEstadoProveedor()) ? "bg-success" : "bg-danger" %>">
                                <%=p.getEstadoProveedor()%>
                            </span>
                        </td>
                        <td>
                            <a href="ServletEditarProveedor?accion=editar&id=<%=p.getIdProveedor()%>" class="btn btn-warning btn-sm">Editar</a>
                            <a href="ServletEliminarProveedor?id=<%=p.getIdProveedor()%>" class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Desea eliminar este proveedor?')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td class="text-center" colspan="7">No hay proveedores registrados</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js