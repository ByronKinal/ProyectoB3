package controller;

import dao.CarritoDAO;
import dao.ProductoDAO;
import model.Carrito;
import model.Producto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet para gestionar el carrito de compras
 * Funcionalidades: listar, agregar, editar, eliminar
 * @author asosa
 */
@WebServlet(name = "ServletCarrito", urlPatterns = {"/ServletCarrito"})
public class ServletCarrito extends HttpServlet {
    
    private CarritoDAO carritoDAO;
    private ProductoDAO productoDAO;
    
    @Override
    public void init() throws ServletException {
        carritoDAO = new CarritoDAO();
        productoDAO = new ProductoDAO();
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
    
    /**
     * Procesa las requests GET y POST
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        if (action == null) {
            action = "listar";
        }
        
        switch (action) {
            case "listar":
                listarCarrito(request, response, session);
                break;
            case "agregar":
                agregarAlCarrito(request, response, session);
                break;
            case "editar":
                editarCarrito(request, response, session);
                break;
            case "eliminar":
                eliminarDelCarrito(request, response, session);
                break;
            case "vaciar":
                vaciarCarrito(request, response, session);
                break;
            case "obtenerTotal":
                obtenerTotalCarrito(request, response, session);
                break;
            default:
                listarCarrito(request, response, session);
                break;
        }
    }
    
    /**
     * Lista los productos del carrito
     */
    private void listarCarrito(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            // Obtener carrito de la sesión
            List<Carrito> carritoSesion = (List<Carrito>) session.getAttribute("carrito");
            
            if (carritoSesion == null) {
                carritoSesion = new ArrayList<>();
                session.setAttribute("carrito", carritoSesion);
            }
            
            // Obtener información completa de los productos del carrito
            List<ProductoCarrito> productosCarrito = new ArrayList<>();
            double total = 0.0;
            
            for (Carrito item : carritoSesion) {
                Producto producto = productoDAO.obtenerProductoPorId(item.getIdProducto());
                if (producto != null) {
                    ProductoCarrito pc = new ProductoCarrito();
                    pc.setProducto(producto);
                    pc.setCantidad(item.getCantidadProducto());
                    pc.setSubtotal(item.getSubtotal());
                    productosCarrito.add(pc);
                    total += item.getSubtotal();
                }
            }
            
            request.setAttribute("productosCarrito", productosCarrito);
            request.setAttribute("totalCarrito", total);
            request.setAttribute("cantidadItems", carritoSesion.size());
            
            // Redirigir a la página del carrito
            request.getRequestDispatcher("CarritoCompras.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar el carrito: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    /**
     * Agrega un producto al carrito
     */
    private void agregarAlCarrito(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            
            // Obtener información del producto
            Producto producto = productoDAO.obtenerProductoPorId(idProducto);
            
            if (producto == null) {
                request.setAttribute("error", "Producto no encontrado");
                listarCarrito(request, response, session);
                return;
            }
            
            // Verificar stock disponible
            if (cantidad > producto.getStockProducto()) {
                request.setAttribute("error", "Stock insuficiente. Stock disponible: " + producto.getStockProducto());
                listarCarrito(request, response, session);
                return;
            }
            
            // Obtener carrito de la sesión
            List<Carrito> carritoSesion = (List<Carrito>) session.getAttribute("carrito");
            if (carritoSesion == null) {
                carritoSesion = new ArrayList<>();
            }
            
            // Verificar si el producto ya existe en el carrito
            boolean productoExiste = false;
            for (Carrito item : carritoSesion) {
                if (item.getIdProducto() == idProducto) {
                    // Actualizar cantidad y subtotal
                    int nuevaCantidad = item.getCantidadProducto() + cantidad;
                    if (nuevaCantidad > producto.getStockProducto()) {
                        request.setAttribute("error", "No se puede agregar más cantidad. Stock disponible: " + producto.getStockProducto());
                        listarCarrito(request, response, session);
                        return;
                    }
                    item.setCantidadProducto(nuevaCantidad);
                    item.setSubtotal(nuevaCantidad * producto.getPrecioProducto());
                    productoExiste = true;
                    break;
                }
            }
            
            // Si el producto no existe, agregarlo
            if (!productoExiste) {
                Carrito nuevoItem = new Carrito();
                nuevoItem.setIdProducto(idProducto);
                nuevoItem.setCantidadProducto(cantidad);
                nuevoItem.setSubtotal(cantidad * producto.getPrecioProducto());
                carritoSesion.add(nuevoItem);
            }
            
            // Actualizar sesión
            session.setAttribute("carrito", carritoSesion);
            
            request.setAttribute("success", "Producto agregado al carrito exitosamente");
            listarCarrito(request, response, session);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Datos inválidos");
            listarCarrito(request, response, session);
        } catch (Exception e) {
            request.setAttribute("error", "Error al agregar producto al carrito: " + e.getMessage());
            listarCarrito(request, response, session);
        }
    }
    
    /**
     * Edita la cantidad de un producto en el carrito
     */
    private void editarCarrito(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));
            
            if (nuevaCantidad <= 0) {
                request.setAttribute("error", "La cantidad debe ser mayor a 0");
                listarCarrito(request, response, session);
                return;
            }
            
            // Obtener información del producto
            Producto producto = productoDAO.obtenerProductoPorId(idProducto);
            
            if (producto == null) {
                request.setAttribute("error", "Producto no encontrado");
                listarCarrito(request, response, session);
                return;
            }
            
            // Verificar stock disponible
            if (nuevaCantidad > producto.getStockProducto()) {
                request.setAttribute("error", "Stock insuficiente. Stock disponible: " + producto.getStockProducto());
                listarCarrito(request, response, session);
                return;
            }
            
            // Obtener carrito de la sesión
            List<Carrito> carritoSesion = (List<Carrito>) session.getAttribute("carrito");
            
            if (carritoSesion != null) {
                for (Carrito item : carritoSesion) {
                    if (item.getIdProducto() == idProducto) {
                        item.setCantidadProducto(nuevaCantidad);
                        item.setSubtotal(nuevaCantidad * producto.getPrecioProducto());
                        break;
                    }
                }
                
                // Actualizar sesión
                session.setAttribute("carrito", carritoSesion);
                request.setAttribute("success", "Cantidad actualizada exitosamente");
            }
            
            listarCarrito(request, response, session);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Datos inválidos");
            listarCarrito(request, response, session);
        } catch (Exception e) {
            request.setAttribute("error", "Error al editar carrito: " + e.getMessage());
            listarCarrito(request, response, session);
        }
    }
    
    /**
     * Elimina un producto específico del carrito
     */
    private void eliminarDelCarrito(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            
            // Obtener carrito de la sesión
            List<Carrito> carritoSesion = (List<Carrito>) session.getAttribute("carrito");
            
            if (carritoSesion != null) {
                carritoSesion.removeIf(item -> item.getIdProducto() == idProducto);
                
                // Actualizar sesión
                session.setAttribute("carrito", carritoSesion);
                request.setAttribute("success", "Producto eliminado del carrito");
            }
            
            listarCarrito(request, response, session);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de producto inválido");
            listarCarrito(request, response, session);
        } catch (Exception e) {
            request.setAttribute("error", "Error al eliminar producto: " + e.getMessage());
            listarCarrito(request, response, session);
        }
    }
    
    /**
     * Vacía completamente el carrito
     */
    private void vaciarCarrito(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            // Limpiar carrito de la sesión
            session.setAttribute("carrito", new ArrayList<Carrito>());
            request.setAttribute("success", "Carrito vaciado exitosamente");
            
            listarCarrito(request, response, session);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error al vaciar carrito: " + e.getMessage());
            listarCarrito(request, response, session);
        }
    }
    
    /**
     * Obtiene el total del carrito
     */
    private void obtenerTotalCarrito(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            List<Carrito> carritoSesion = (List<Carrito>) session.getAttribute("carrito");
            double total = 0.0;
            
            if (carritoSesion != null) {
                for (Carrito item : carritoSesion) {
                    total += item.getSubtotal();
                }
            }
            
            response.setContentType("application/json");
            response.getWriter().write("{\"total\": " + total + "}");
            
        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"Error al calcular total\"}");
        }
    }
    
    /**
     * Clase auxiliar para mostrar productos en el carrito
     */
    public static class ProductoCarrito {
        private Producto producto;
        private int cantidad;
        private double subtotal;
        
        // Getters y setters
        public Producto getProducto() { return producto; }
        public void setProducto(Producto producto) { this.producto = producto; }
        
        public int getCantidad() { return cantidad; }
        public void setCantidad(int cantidad) { this.cantidad = cantidad; }
        
        public double getSubtotal() { return subtotal; }
        public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
    }
}