package controller;

import dao.ProveedorDAO;
import model.Proveedor;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletEditarProveedor", urlPatterns = {"/ServletEditarProveedor"})
public class ServletEditarProveedor extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("editar".equals(accion)) {
            try {
                int idProveedor = Integer.parseInt(request.getParameter("id"));
                
                ProveedorDAO proveedorDAO = new ProveedorDAO();
                Proveedor proveedor = proveedorDAO.obtenerProveedorPorId(idProveedor);
                
                if (proveedor != null) {
                    request.setAttribute("proveedor", proveedor);
                    request.getRequestDispatcher("EditarProveedores.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("mensaje", "Proveedor no encontrado");
                    request.getSession().setAttribute("tipoMensaje", "danger");
                    response.sendRedirect("ServletListarProveedores");
                }
                
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("mensaje", "ID de proveedor inválido");
                request.getSession().setAttribute("tipoMensaje", "danger");
                response.sendRedirect("ServletListarProveedores");
            }
        } else {
            response.sendRedirect("ServletListarProveedores");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("actualizar".equals(accion)) {
            try {
                // Obtener los parámetros del formulario
                int idProveedor = Integer.parseInt(request.getParameter("id"));
                String nombreProveedor = request.getParameter("nombreProveedor");
                String correoProveedor = request.getParameter("correoProveedor");
                String telefonoProveedor = request.getParameter("telefonoProveedor");
                String direccionProveedor = request.getParameter("direccionProveedor");
                String estadoProveedor = request.getParameter("estadoProveedor");
                
                // Validaciones básicas
                if (nombreProveedor == null || nombreProveedor.trim().isEmpty() ||
                    correoProveedor == null || correoProveedor.trim().isEmpty() ||
                    telefonoProveedor == null || telefonoProveedor.trim().isEmpty() ||
                    direccionProveedor == null || direccionProveedor.trim().isEmpty() ||
                    estadoProveedor == null || estadoProveedor.trim().isEmpty()) {
                    
                    request.getSession().setAttribute("mensaje", "Todos los campos son obligatorios");
                    request.getSession().setAttribute("tipoMensaje", "danger");
                    response.sendRedirect("ServletEditarProveedor?accion=editar&id=" + idProveedor);
                    return;
                }
                
                // Crear el objeto Proveedor con los nuevos datos
                Proveedor proveedor = new Proveedor(
                    idProveedor,
                    nombreProveedor.trim(), 
                    correoProveedor.trim(), 
                    telefonoProveedor.trim(), 
                    direccionProveedor.trim(),
                    estadoProveedor
                );
                
                // Actualizar en la base de datos
                ProveedorDAO proveedorDAO = new ProveedorDAO();
                proveedorDAO.actualizarProveedor(proveedor);
                
                request.getSession().setAttribute("mensaje", "Proveedor actualizado correctamente");
                request.getSession().setAttribute("tipoMensaje", "success");
                
                // Redirigir a la lista de proveedores
                response.sendRedirect("ServletListarProveedores");
                
            } catch (Exception e) {
                request.getSession().setAttribute("mensaje", "Error al actualizar el proveedor: " + e.getMessage());
                request.getSession().setAttribute("tipoMensaje", "danger");
                response.sendRedirect("ServletListarProveedores");
            }
        } else {
            response.sendRedirect("ServletListarProveedores");
        }
    }
}