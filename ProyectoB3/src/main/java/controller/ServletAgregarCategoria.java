
package controller;

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
 * @author Roger Valladares
 */
@WebServlet(name = "ServletAgregarCategoria", urlPatterns = {"/ServletAgregarCategoria"})
public class ServletAgregarCategoria  extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
        EntityManager em = emf.createEntityManager();

        try {
            // Obtener parámetros del formulario
            String nombreCategoriaTipo = request.getParameter("nombreCategoriaTipo");
            String nombreCategoriaGenero = request.getParameter("nombreCategoriaGenero");
            String descripcionCategoria = request.getParameter("descripcionCategoria");
           

            // Validaciones básicas
            if (nombreCategoriaTipo == null || nombreCategoriaGenero.trim().isEmpty()
                    || descripcionCategoria == null) {
                throw new ServletException("Categorias y descripción son requeridos");
            }

            // Crear nuevo producto
            Categoria nuevaCategoria = new Categoria();
            nuevaCategoria.setNombreCategoriaTipo(nombreCategoriaTipo);
            nuevaCategoria.setNombreCategoriaGenero(nombreCategoriaGenero);
            nuevaCategoria.setDescripcionCategoria(descripcionCategoria);

            // Guardar en la base de datos
            em.getTransaction().begin();
            em.persist(nuevaCategoria);
            em.getTransaction().commit();

            // Redirigir con mensaje de éxito
            request.getSession().setAttribute("mensaje", "Categoria agregada correctamente");
            request.getSession().setAttribute("tipoMensaje", "success");
            response.sendRedirect("MenuAdministrativo.jsp");

        } catch (Exception e) {
            // Manejar errores
            request.setAttribute("error", "Error al agregar producto: " + e.getMessage());
            
            // el /RegistroCategoria.jsp todavia no existe al momento de mi modificacion
            // entonces si lo agregan que sea con ese nombre o lo cambian sino solo modifiquen
            // el getRequestDispatcher
            request.getRequestDispatcher("/RegistroCategoria.jsp").forward(request, response);
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
