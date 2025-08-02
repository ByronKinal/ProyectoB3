package controller;

import dao.UsuarioDAO;
import model.Usuario;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletEditarUsuario", urlPatterns = {"/ServletEditarUsuario"})
public class ServletEditarUsuario extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("editar".equals(accion)) {
            try {
                int idUsuario = Integer.parseInt(request.getParameter("id"));
                
                UsuarioDAO usuarioDAO = new UsuarioDAO();
                Usuario usuario = usuarioDAO.buscarPorId(idUsuario);
                
                if (usuario != null) {
                    request.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("EditarUsuario.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("mensaje", "Usuario no encontrado");
                    request.getSession().setAttribute("tipoMensaje", "danger");
                    response.sendRedirect("ServletListarUsuarios");
                }
                
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("mensaje", "ID de usuario inválido");
                request.getSession().setAttribute("tipoMensaje", "danger");
                response.sendRedirect("ServletListarUsuarios");
            }
        } else {
            response.sendRedirect("ServletListarUsuarios");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("actualizar".equals(accion)) {
            try {
                // Obtener los parámetros del formulario
                int idUsuario = Integer.parseInt(request.getParameter("id"));
                String nombreUsuario = request.getParameter("nombreUsuario");
                String apellidoUsuario = request.getParameter("apellidoUsuario");
                String fechaNacimientoStr = request.getParameter("fechaNacimiento");
                String generoUsuario = request.getParameter("generoUsuario");
                String telefonoUsuario = request.getParameter("telefonoUsuario");
                String correoUsuario = request.getParameter("correoUsuario");
                String contrasenaUsuario = request.getParameter("contrasenaUsuario");
                String rolUsuario = request.getParameter("rolUsuario");
                
                // Convertir la fecha
                Date fechaNacimiento = Date.valueOf(fechaNacimientoStr);
                
                // Crear el objeto Usuario con los nuevos datos
                Usuario usuario = new Usuario(
                    idUsuario,
                    nombreUsuario, 
                    apellidoUsuario, 
                    fechaNacimiento, 
                    generoUsuario, 
                    telefonoUsuario, 
                    correoUsuario, 
                    contrasenaUsuario, 
                    rolUsuario
                );
                
                // Actualizar en la base de datos
                UsuarioDAO usuarioDAO = new UsuarioDAO();
                boolean actualizado = usuarioDAO.actualizarUsuario(usuario);
                
                if (actualizado) {
                    request.getSession().setAttribute("mensaje", "Usuario actualizado correctamente");
                    request.getSession().setAttribute("tipoMensaje", "success");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al actualizar el usuario");
                    request.getSession().setAttribute("tipoMensaje", "danger");
                }
                
                // Redirigir a la lista de usuarios
                response.sendRedirect("ServletListarUsuarios");
                
            } catch (Exception e) {
                request.getSession().setAttribute("mensaje", "Error al procesar los datos: " + e.getMessage());
                request.getSession().setAttribute("tipoMensaje", "danger");
                response.sendRedirect("ServletListarUsuarios");
            }
        } else {
            response.sendRedirect("ServletListarUsuarios");
        }
    }
}