
package controller;

import dao.ProductoDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Wilson Florian
 */
@WebServlet(name = "ServletEliminarProducto", urlPatterns = {"/ServletEliminarProducto"})
public class ServletEliminarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idProducto = Integer.parseInt(request.getParameter("id"));
        
        ProductoDAO productoDAO = new ProductoDAO();
        productoDAO.eliminarProducto(idProducto);
        
        response.sendRedirect("MenuAdministrativo.jsp");
    }

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
}