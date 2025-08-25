package controller;

import dao.*;
import model.*;
import util.EntityManagerUtil;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import javax.persistence.EntityManager;

@WebServlet("/ServletCarrito")
public class ServletCarrito extends HttpServlet {

    private final ProductoDAO productoDAO = new ProductoDAO();
    private final CompraDAO compraDAO = new CompraDAO();
    private final CarritoDAO carritoDAO = new CarritoDAO();
    private final PagoDAO pagoDAO = new PagoDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("InicioDeSesion.jsp");
            return;
        }

        try {
            switch (action) {
                case "agregar":
                    agregarAlCarrito(request, response, usuario);
                    break;
                case "actualizar":
                    actualizarCantidad(request, response, usuario);
                    break;
                case "eliminar":
                    eliminarDelCarrito(request, response, usuario);
                    break;
                case "finalizar":
                    finalizarCompra(request, response, usuario);
                    break;
                case "cancelar":
                    cancelarCompra(request, response, usuario);
                    break;
                default:
                    response.sendRedirect("MenuPrincipal.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error al procesar la solicitud: " + e.getMessage());
            response.sendRedirect("Carrito.jsp");
        }
    }

    private void agregarAlCarrito(HttpServletRequest request, HttpServletResponse response, Usuario usuario) throws Exception {
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));

        // Obtener producto con información completa
        Producto producto = productoDAO.obtenerProductoCompletoPorId(idProducto);
        if (producto == null) {
            request.getSession().setAttribute("error", "El producto no existe");
            response.sendRedirect("MenuPrincipal.jsp");
            return;
        }

        // Verificar stock
        if (producto.getStockProducto() <= 0) {
            request.getSession().setAttribute("error", "El producto no está disponible");
            response.sendRedirect("MenuPrincipal.jsp");
            return;
        }

        // Buscar compra pendiente o crear nueva
        Compra compraActiva = compraDAO.buscarCompraPendiente(usuario.getIdUsuario());

        if (compraActiva == null) {
            compraActiva = new Compra();
            compraActiva.setEstadoCompra("Pendiente");
            compraActiva.setFechaCompra(new Timestamp(System.currentTimeMillis()));
            compraActiva.setUsuario(usuario);
            compraDAO.agregarCompra(compraActiva);
        }

        // Verificar si el producto ya está en el carrito
        Carrito itemExistente = carritoDAO.buscarItemCarrito(compraActiva.getIdCompra(), idProducto);

        if (itemExistente != null) {
            // Actualizar cantidad si no supera el stock
            if (itemExistente.getCantidadProducto() + 1 > producto.getStockProducto()) {
                request.getSession().setAttribute("error", "No hay suficiente stock disponible");
                response.sendRedirect("MenuPrincipal.jsp");
                return;
            }

            itemExistente.setCantidadProducto(itemExistente.getCantidadProducto() + 1);
            itemExistente.setSubtotal(itemExistente.getCantidadProducto() * producto.getPrecioProducto());
            carritoDAO.actualizarCarrito(itemExistente);
        } else {
            // Crear nuevo ítem de carrito
            Carrito nuevoItem = new Carrito();
            nuevoItem.setId(new CarritoId(compraActiva.getIdCompra(), producto.getIdProducto()));
            nuevoItem.setCompra(compraActiva);
            nuevoItem.setProducto(producto);
            nuevoItem.setCantidadProducto(1);
            nuevoItem.setSubtotal(producto.getPrecioProducto());

            carritoDAO.agregarCarrito(nuevoItem);
        }

        // Actualizar la compra en la sesión
        actualizarCarritoEnSesion(request, compraActiva.getIdCompra());

        // Mensaje de éxito
        request.getSession().setAttribute("mensaje", "¡Producto agregado al carrito!");
        response.sendRedirect("MenuPrincipal.jsp");
    }

    private void actualizarCantidad(HttpServletRequest request, HttpServletResponse response, Usuario usuario) throws Exception {
        int idCompra = Integer.parseInt(request.getParameter("idCompra"));
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));

        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            em.getTransaction().begin();

            // Buscar el item con todas sus relaciones usando optimized query
            Carrito item = em.createQuery(
                    "SELECT c FROM Carrito c "
                    + "LEFT JOIN FETCH c.producto p "
                    + "LEFT JOIN FETCH p.categoria "
                    + "LEFT JOIN FETCH p.proveedor "
                    + "WHERE c.id.idCompra = :idCompra AND c.id.idProducto = :idProducto",
                    Carrito.class)
                    .setParameter("idCompra", idCompra)
                    .setParameter("idProducto", idProducto)
                    .getSingleResult();

            if (item != null) {
                item.setCantidadProducto(nuevaCantidad);
                item.setSubtotal(nuevaCantidad * item.getProducto().getPrecioProducto());
                em.merge(item);
            }

            em.getTransaction().commit();

            // Actualizar la sesión
            actualizarCarritoEnSesion(request, idCompra);
        } finally {
            em.close();
        }

        response.sendRedirect("Carrito.jsp");
    }

    private void eliminarDelCarrito(HttpServletRequest request, HttpServletResponse response, Usuario usuario) throws Exception {
        int idCompra = Integer.parseInt(request.getParameter("idCompra"));
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        carritoDAO.eliminarItemCarrito(idCompra, idProducto);

        // Actualizar la compra en la sesión
        actualizarCarritoEnSesion(request, idCompra);

        response.sendRedirect("Carrito.jsp");
    }

    private void finalizarCompra(HttpServletRequest request, HttpServletResponse response, Usuario usuario) throws Exception {
        int idCompra = Integer.parseInt(request.getParameter("idCompra"));

        // Actualizar estado de la compra
        Compra compra = compraDAO.obtenerCompraPorId(idCompra);
        compra.setEstadoCompra("Completada");
        compraDAO.actualizarCompra(compra);

        // Crear pago
        Pago pago = new Pago();
        pago.setFechaPago(new Timestamp(System.currentTimeMillis()));
        pago.setEstadoPago("Pagado");
        pago.setMetodoPago("Tarjeta");
        pago.setCompra(compra);
        pagoDAO.agregarPago(pago);

        // Limpiar carrito de la sesión
        request.getSession().removeAttribute("compra");
        request.getSession().removeAttribute("itemsCarrito");
        request.getSession().removeAttribute("total");

        // Mensaje de éxito
        request.getSession().setAttribute("mensaje", "¡Compra finalizada con éxito!");
        response.sendRedirect("MenuPrincipal.jsp");
    }

    private void cancelarCompra(HttpServletRequest request, HttpServletResponse response, Usuario usuario) throws Exception {
        int idCompra = Integer.parseInt(request.getParameter("idCompra"));

        // Actualizar estado de la compra
        Compra compra = compraDAO.obtenerCompraPorId(idCompra);
        compra.setEstadoCompra("Cancelada");
        compraDAO.actualizarCompra(compra);

        // Limpiar carrito de la sesión
        request.getSession().removeAttribute("compra");
        request.getSession().removeAttribute("itemsCarrito");
        request.getSession().removeAttribute("total");

        // Mensaje
        request.getSession().setAttribute("mensaje", "Compra cancelada");
        response.sendRedirect("MenuPrincipal.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("InicioDeSesion.jsp");
            return;
        }

        try {
            // Buscar compra activa (Pendiente)
            Compra compraActiva = compraDAO.buscarCompraPendiente(usuario.getIdUsuario());

            if (compraActiva != null) {
                actualizarCarritoEnSesion(request, compraActiva.getIdCompra());
            }

            request.getRequestDispatcher("Carrito.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error al cargar el carrito: " + e.getMessage());
            response.sendRedirect("MenuPrincipal.jsp");
        }
    }

    private void actualizarCarritoEnSesion(HttpServletRequest request, int idCompra) throws Exception {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            // Optimized query: Load compra with all carrito items and their complete product info in one query
            // This eliminates the N+1 query problem by fetching everything at once
            Compra compra = em.createQuery(
                    "SELECT DISTINCT c FROM Compra c "
                    + "LEFT JOIN FETCH c.carritos cr "
                    + "LEFT JOIN FETCH cr.producto p "
                    + "LEFT JOIN FETCH p.categoria cat "
                    + "LEFT JOIN FETCH p.proveedor prov "
                    + "WHERE c.idCompra = :idCompra",
                    Compra.class)
                    .setParameter("idCompra", idCompra)
                    .getSingleResult();
            
            if (compra != null) {
                // Calculate total using stream for better performance
                double total = compra.getCarritos().stream()
                        .mapToDouble(Carrito::getSubtotal)
                        .sum();

                // Update session with optimized data
                HttpSession session = request.getSession();
                session.setAttribute("compra", compra);
                session.setAttribute("itemsCarrito", compra.getCarritos());
                session.setAttribute("total", total);
            }
        } finally {
            em.close();
        }
    }
}
