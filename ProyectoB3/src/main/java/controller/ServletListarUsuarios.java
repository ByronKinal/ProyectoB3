package controller;

import dao.UsuarioDAO;
import model.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletListarUsuarios", urlPatterns = {"/ServletListarUsuarios"})
public class ServletListarUsuarios extends HttpServlet {
    
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
            // Obtener la lista de usuarios desde la base de datos
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            List<Usuario> listaUsuarios = usuarioDAO.listarUsuarios();
            
            // Pasar la lista como atributo al JSP
            request.setAttribute("listaUsuarios", listaUsuarios);
            
            // Reenviar a la página JSP que mostrará la lista
            request.getRequestDispatcher("ListarUsuarios.jsp").forward(request, response);
            
        } catch (Exception e) {
            // En caso de error, establecer mensaje de error en la sesión
            request.getSession().setAttribute("mensaje", "Error al cargar la lista de usuarios: " + e.getMessage());
            request.getSession().setAttribute("tipoMensaje", "danger");
            
            // Reenviar a una página de error o crear lista vacía
            request.setAttribute("listaUsuarios", null);
            request.getRequestDispatcher("ListarUsuarios.jsp").forward(request, response);
        }
    }
}