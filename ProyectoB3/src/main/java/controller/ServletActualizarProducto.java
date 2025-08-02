package controller;

import java.io.IOException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Categoria;
import model.Producto;
import model.Proveedor;

/**
 *
 * @author Wilson Florian
 */
@WebServlet(name = "ServletActualizarProducto", urlPatterns = {"/ServletActualizarProducto"})
public class ServletActualizarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        
        try {
            tx = em.getTransaction();
            tx.begin();
            
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            String nombre = request.getParameter("nombreProducto");
            String descripcion = request.getParameter("descripcionProducto");
            String urlImagen = request.getParameter("url_imagen");
            String talla = request.getParameter("tallaProducto");
            String marca = request.getParameter("marcaProducto");
            double precio = Double.parseDouble(request.getParameter("precioProducto"));
            int stock = Integer.parseInt(request.getParameter("stockProducto"));
            int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
            int idProveedor = Integer.parseInt(request.getParameter("idProveedor"));

            // Validaciones
            if (nombre == null || nombre.trim().isEmpty() || 
                descripcion == null || descripcion.trim().isEmpty()) {
                throw new ServletException("Campos requeridos faltantes");
            }

            // Obtener el producto existente
            Producto producto = em.find(Producto.class, idProducto);
            if (producto == null) {
                throw new ServletException("Producto no encontrado");
            }

            // Obtener categoría y proveedor
            Categoria categoria = em.find(Categoria.class, idCategoria);
            Proveedor proveedor = em.find(Proveedor.class, idProveedor);
            
            if (categoria == null || proveedor == null) {
                throw new ServletException("Categoría o Proveedor no encontrados");
            }

            // Actualizar producto
            producto.setNombreProducto(nombre);
            producto.setDescripcionProducto(descripcion);
            producto.setUrlImagen(urlImagen);
            producto.setTallaProducto(talla);
            producto.setMarcaProducto(marca);
            producto.setPrecioProducto(precio);
            producto.setStockProducto(stock);
            producto.setCategoria(categoria);
            producto.setProveedor(proveedor);

            em.merge(producto);
            tx.commit();
            
            response.sendRedirect("MenuAdministrativo.jsp");
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            request.setAttribute("error", "Error al actualizar: " + e.getMessage());
            request.getRequestDispatcher("EditarProducto.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
