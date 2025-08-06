package controller;

import dao.CompraDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Iosef
 */
@WebServlet(name = "ServletEliminarCompra", urlPatterns = {"/ServletEliminarCompra"})
public class ServletEliminarCompra extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idCompra = Integer.parseInt(request.getParameter("id"));
        
        CompraDAO compraDAO = new CompraDAO();
        compraDAO.eliminarCompra(idCompra);
        
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