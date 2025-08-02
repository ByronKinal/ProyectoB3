package controller;

import dao.ProductoDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Producto;

/**
 *
 * @author Wilson Florian
 */
@WebServlet(name = "ServletEditarProducto", urlPatterns = {"/ServletEditarProducto"})
public class ServletEditarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idProducto = Integer.parseInt(request.getParameter("id"));
        
        ProductoDAO productoDAO = new ProductoDAO();
        Producto producto = productoDAO.obtenerProductoCompletoPorId(idProducto);
        
        if (producto == null) {
            request.getSession().setAttribute("mensaje", "Producto no encontrado");
            request.getSession().setAttribute("tipoMensaje", "danger");
            response.sendRedirect("MenuAdministrativo.jsp");
            return;
        }
        
        request.setAttribute("producto", producto);
        request.getRequestDispatcher("EditarProducto.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}