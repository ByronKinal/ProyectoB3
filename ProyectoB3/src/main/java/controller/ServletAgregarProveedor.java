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
import model.Proveedor;

/**
 *
 * @author Roger Valladares
 */
@WebServlet(name = "ServletAgregarProveedor", urlPatterns = {"/ServletAgregarProveedor"})
public class ServletAgregarProveedor extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
        EntityManager em = emf.createEntityManager();
        try {
            // Obtener parámetros del formulario
            String nombreProveedor = request.getParameter("nombreProveedor");
            String correoProveedor = request.getParameter("correoProveedor");
            String telefonoProveedor = request.getParameter("telefonoProveedor");
            String direccionProveedor = request.getParameter("direccionProveedor");

            // Validaciones básicas
            if (nombreProveedor == null || nombreProveedor.trim().isEmpty()
                    || correoProveedor == null || correoProveedor.trim().isEmpty()
                    || telefonoProveedor == null || telefonoProveedor.trim().isEmpty()
                    || direccionProveedor == null || direccionProveedor.trim().isEmpty()) {
                throw new ServletException("Llenar todos los campos solicitados");
            }

            // Crear nuevo Proveedor
            Proveedor nuevoProveedor = new Proveedor();
            nuevoProveedor.setNombreProveedor(nombreProveedor);
            nuevoProveedor.setCorreoProveedor(correoProveedor);
            nuevoProveedor.setTelefonoProveedor(telefonoProveedor);
            nuevoProveedor.setDireccionProveedor(direccionProveedor);

            // Guardar en la base de datos
            em.getTransaction().begin();
            em.persist(nuevoProveedor);
            em.getTransaction().commit();

            // Redirigir con mensaje de éxito
            request.getSession().setAttribute("mensaje", "Proveedor agregado correctamente");
            request.getSession().setAttribute("tipoMensaje", "success");
            response.sendRedirect("MenuAdministrativo.jsp");

        } catch (Exception e) {
            // Manejar errores
            request.setAttribute("error", "Error al agregar producto: " + e.getMessage());
            request.getRequestDispatcher("/RegistroProveedor.jsp").forward(request, response);
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
