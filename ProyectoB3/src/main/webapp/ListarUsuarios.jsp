<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Usuario" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lista de Usuarios</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Listado de Usuarios</h2>
            <a href="registroUsuario.jsp" class="btn btn-primary mb-3">Agregar Usuario</a>
            <table class="table table-bordered table-striped">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Fecha Nacimiento</th>
                        <th>Género</th>
                        <th>Teléfono</th>
                        <th>Correo</th>
                        <th>Rol</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("Usuarios");
                        if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                            for (Usuario u : listaUsuarios) {
                    %>
                    <tr>
                        <td><%=u.getIdUsuario()%></td>
                        <td><%=u.getNombreUsuario()%></td>
                        <td><%=u.getApellidoUsuario()%></td>
                        <td><%=u.getFechaNacimiento()%></td>
                        <td><%=u.getGeneroUsuario()%></td>
                        <td><%=u.getTelefonoUsuario()%></td>
                        <td><%=u.getCorreoUsuario()%></td>
                        <td><%=u.getRolUsuario()%></td>
                        <td>
                            <a href="ServletEditarUsuario?accion=editar&id=<%=u.getIdUsuario()%>" class="btn btn-warning btn-sm">Editar</a>
                            <a href="ServletEliminarUsuario?id=<%=u.getIdUsuario()%>" class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Desea eliminar este usuario?')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td class="text-center" colspan="9">No hay usuarios registrados</td>
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