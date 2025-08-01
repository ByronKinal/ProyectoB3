
package controller;

import dao.ProveedorDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Proveedor;

/**
 *
 * @author Roger Valladares
 */
@WebServlet(name = "ServletEditarProveedor", urlPatterns = {"/ServletEditarProveedor"})
public class ServletEditarProveedor {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProveedor = Integer.parseInt(request.getParameter("id"));
        
        ProveedorDAO proveedorDAO = new ProveedorDAO();
        Proveedor proveedor = proveedorDAO.obtenerProveedorPorId(idProveedor);
        
        if (proveedor == null) {
            request.getSession().setAttribute("mensaje", "Proveedor no encontrado");
            request.getSession().setAttribute("tipoMensaje", "danger");
            response.sendRedirect("MenuAdministrativo.jsp");
            return;
        }
        
        request.setAttribute("proveedor", proveedor);
        request.getRequestDispatcher("EditarProveedor.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
