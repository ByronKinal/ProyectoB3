
package controller;

import dao.CategoriaDAO;
import dao.ProveedorDAO;
import java.io.IOException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Categoria;
import model.Producto;
import model.Proveedor;

/**
 *
 * @author Roger Valladares
 */
@WebServlet(name = "ServletEditarCategoria", urlPatterns = {"/ServletEditarCategoria"})
public class ServletEditarCategoria extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idCategoria = Integer.parseInt(request.getParameter("id"));
        
        CategoriaDAO categoriaDAO = new CategoriaDAO();
        Categoria categoria = categoriaDAO.obtenerProveedorPorId(idCategoria);
        
        if (categoria == null) {
            request.getSession().setAttribute("mensaje", "Categoria no encontrado");
            request.getSession().setAttribute("tipoMensaje", "danger");
            response.sendRedirect("ListarProductos.jsp");
            return;
        }
        
        request.setAttribute("categoria", categoria);
        request.getRequestDispatcher("EditarCategoria.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          processRequest(request, response);
   }
}
