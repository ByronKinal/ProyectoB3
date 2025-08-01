
package controller;

import dao.ProveedorDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Roger Valladares
 */
@WebServlet(name = "ServletEliminarProveedor", urlPatterns = {"/ServletEliminarProveedor"})
public class ServletEliminarProveedor extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idProveedor = Integer.parseInt(request.getParameter("id"));
        
        ProveedorDAO proveedorDAO = new ProveedorDAO();
        proveedorDAO.suspenderProveedor(idProveedor);
        
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
