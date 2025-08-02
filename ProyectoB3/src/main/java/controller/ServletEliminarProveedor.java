package controller;

import dao.ProveedorDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletEliminarProveedor", urlPatterns = {"/ServletEliminarProveedor"})
public class ServletEliminarProveedor extends HttpServlet {
    
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
            int idProveedor = Integer.parseInt(request.getParameter("id"));
            
            ProveedorDAO proveedorDAO = new ProveedorDAO();
            boolean eliminado = proveedorDAO.eliminarProveedor(idProveedor);
            
            if (eliminado) {
                request.getSession().setAttribute("mensaje", "Proveedor eliminado correctamente");
                request.getSession().setAttribute("tipoMensaje", "success");
            } else {
                request.getSession().setAttribute("mensaje", "Error al eliminar el proveedor");
                request.getSession().setAttribute("tipoMensaje", "danger");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("mensaje", "ID de proveedor inválido");
            request.getSession().setAttribute("tipoMensaje", "danger");
        } catch (Exception e) {
            request.getSession().setAttribute("mensaje", "Error al eliminar el proveedor: " + e.getMessage());
            request.getSession().setAttribute("tipoMensaje", "danger");
        }
        
        // Redirigir a la lista de proveedores
        response.sendRedirect("ServletListarProveedores");
    }
}