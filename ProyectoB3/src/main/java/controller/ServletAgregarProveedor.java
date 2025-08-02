package controller;

import dao.ProveedorDAO;
import model.Proveedor;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletAgregarProveedor", urlPatterns = {"/ServletAgregarProveedor"})
public class ServletAgregarProveedor extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirigir al formulario de agregar proveedor
        request.getRequestDispatcher("AgregarProveedor.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Obtener los parámetros del formulario
            String nombreProveedor = request.getParameter("nombreProveedor");
            String correoProveedor = request.getParameter("correoProveedor");
            String telefonoProveedor = request.getParameter("telefonoProveedor");
            String direccionProveedor = request.getParameter("direccionProveedor");
            
            // Validaciones básicas
            if (nombreProveedor == null || nombreProveedor.trim().isEmpty() ||
                correoProveedor == null || correoProveedor.trim().isEmpty() ||
                telefonoProveedor == null || telefonoProveedor.trim().isEmpty() ||
                direccionProveedor == null || direccionProveedor.trim().isEmpty()) {
                
                request.getSession().setAttribute("mensaje", "Todos los campos son obligatorios");
                request.getSession().setAttribute("tipoMensaje", "danger");
                response.sendRedirect("ServletAgregarProveedor");
                return;
            }
            
            // Crear el objeto Proveedor (con estado ACTIVO por defecto)
            Proveedor nuevoProveedor = new Proveedor(
                nombreProveedor.trim(), 
                correoProveedor.trim(), 
                telefonoProveedor.trim(), 
                direccionProveedor.trim(),
                "ACTIVO"
            );
            
            // Guardar en la base de datos
            ProveedorDAO proveedorDAO = new ProveedorDAO();
            proveedorDAO.agregarProveedor(nuevoProveedor);
            
            request.getSession().setAttribute("mensaje", "Proveedor agregado correctamente");
            request.getSession().setAttribute("tipoMensaje", "success");
            
            // Redirigir a la lista de proveedores
            response.sendRedirect("ServletListarProveedores");
            
        } catch (Exception e) {
            request.getSession().setAttribute("mensaje", "Error al agregar el proveedor: " + e.getMessage());
            request.getSession().setAttribute("tipoMensaje", "danger");
            response.sendRedirect("ServletListarProveedores");
        }
    }
}