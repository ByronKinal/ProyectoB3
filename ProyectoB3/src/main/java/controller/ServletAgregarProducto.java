package controller;

import dao.ProductoDAO;
import java.io.IOException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
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
@WebServlet(name = "ServletAgregarProducto", urlPatterns = {"/ServletAgregarProducto"})
public class ServletAgregarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
        EntityManager em = emf.createEntityManager();

        try {
            // Obtener parámetros del formulario
            String nombre = request.getParameter("nombreProducto");
            String descripcion = request.getParameter("descripcionProducto");
            String urlImagen = request.getParameter("url_imagen");
            String talla = request.getParameter("tallaProducto");
            String marca = request.getParameter("marcaProducto");
            double precio = Double.parseDouble(request.getParameter("precioProducto"));
            int stock = Integer.parseInt(request.getParameter("stockProducto"));
            int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
            int idProveedor = Integer.parseInt(request.getParameter("idProveedor"));

            // Validaciones básicas
            if (nombre == null || nombre.trim().isEmpty()
                    || descripcion == null || descripcion.trim().isEmpty()) {
                throw new ServletException("Nombre y descripción son requeridos");
            }

            // Obtener categoría y proveedor
            Categoria categoria = em.find(Categoria.class, idCategoria);
            Proveedor proveedor = em.find(Proveedor.class, idProveedor);

            if (categoria == null || proveedor == null) {
                throw new ServletException("Categoría o Proveedor no encontrados");
            }

            // Crear nuevo producto
            Producto nuevoProducto = new Producto();
            nuevoProducto.setNombreProducto(nombre);
            nuevoProducto.setDescripcionProducto(descripcion);
            nuevoProducto.setUrlImagen(urlImagen);
            nuevoProducto.setTallaProducto(talla);
            nuevoProducto.setMarcaProducto(marca);
            nuevoProducto.setPrecioProducto(precio);
            nuevoProducto.setStockProducto(stock);
            nuevoProducto.setCategoria(categoria);
            nuevoProducto.setProveedor(proveedor);

            // Guardar en la base de datos
            em.getTransaction().begin();
            em.persist(nuevoProducto);
            em.getTransaction().commit();

            // Redirigir con mensaje de éxito
            request.getSession().setAttribute("mensaje", "Producto agregado correctamente");
            request.getSession().setAttribute("tipoMensaje", "success");
            response.sendRedirect("ListarProductos.jsp");

        } catch (Exception e) {
            // Manejar errores
            request.setAttribute("error", "Error al agregar producto: " + e.getMessage());
            request.getRequestDispatcher("/AgregarProducto.jsp").forward(request, response);
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
