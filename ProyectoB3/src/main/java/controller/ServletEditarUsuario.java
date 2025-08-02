package controller;

import dao.ProductoDAO;
import dao.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Producto;
import model.Usuario;

/**
 *
 * @author informatica
 */
@WebServlet("/ServletRegistro")
public class ServletEditarUsuario extends HttpServlet{
     
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         String  correoUsuario = request.getParameter("id");
        
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.buscarPorCorreo(correoUsuario);
        
        if (usuario == null) {
            request.getSession().setAttribute("mensaje", "Usuario no encontrado");
            request.getSession().setAttribute("tipoMensaje", "danger");
            response.sendRedirect("MenuAdministrativo.jsp");
            return;
        }
        
        request.setAttribute("usuario", usuario);
        request.getRequestDispatcher("EditarUsuario.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
