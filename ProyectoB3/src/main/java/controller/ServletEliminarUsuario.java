package controller;

import dao.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletEliminarUsuario", urlPatterns = {"/ServletEliminarUsuario"})
public class ServletEliminarUsuario extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int idUsuario = Integer.parseInt(request.getParameter("id"));
            
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            boolean eliminado = usuarioDAO.eliminarUsuario(idUsuario);
            
            if (eliminado) {
                request.getSession().setAttribute("mensaje", "Usuario eliminado correctamente");
                request.getSession().setAttribute("tipoMensaje", "success");
            } else {
                request.getSession().setAttribute("mensaje", "Error al eliminar el usuario");
                request.getSession().setAttribute("tipoMensaje", "danger");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("mensaje", "ID de usuario inválido");
            request.getSession().setAttribute("tipoMensaje", "danger");
        } catch (Exception e) {
            request.getSession().setAttribute("mensaje", "Error al eliminar el usuario: " + e.getMessage());
            request.getSession().setAttribute("tipoMensaje", "danger");
        }
        
        // Redirigir a la lista de usuarios
        response.sendRedirect("ServletListarUsuarios");
    }
}