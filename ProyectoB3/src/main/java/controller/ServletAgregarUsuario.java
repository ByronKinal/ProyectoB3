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

@WebServlet(name = "ServletAgregarUsuario", urlPatterns = {"/ServletAgregarUsuario"})
public class ServletAgregarUsuario extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirigir al formulario de agregar usuario
        request.getRequestDispatcher("AgregarUsuario.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Obtener los parámetros del formulario
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
            
            // Crear el objeto Usuario
            Usuario nuevoUsuario = new Usuario(
                nombreUsuario, 
                apellidoUsuario, 
                fechaNacimiento, 
                generoUsuario, 
                telefonoUsuario, 
                correoUsuario, 
                contrasenaUsuario, 
                rolUsuario
            );
            
            // Guardar en la base de datos
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            boolean guardado = usuarioDAO.guardarUsuario(nuevoUsuario);
            
            if (guardado) {
                request.getSession().setAttribute("mensaje", "Usuario agregado correctamente");
                request.getSession().setAttribute("tipoMensaje", "success");
            } else {
                request.getSession().setAttribute("mensaje", "Error al agregar el usuario");
                request.getSession().setAttribute("tipoMensaje", "danger");
            }
            
            // Redirigir a la lista de usuarios
            response.sendRedirect("ServletListarUsuarios");
            
        } catch (Exception e) {
            request.getSession().setAttribute("mensaje", "Error al procesar los datos: " + e.getMessage());
            request.getSession().setAttribute("tipoMensaje", "danger");
            response.sendRedirect("ServletListarUsuarios");
        }
    }
}