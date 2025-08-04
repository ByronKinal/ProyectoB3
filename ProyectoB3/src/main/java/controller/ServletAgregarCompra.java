/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Compra;
import model.Usuario;

/**
 *
 * @author Iosef
 */
@WebServlet(name = "ServletAgregarCompra", urlPatterns = {"/ServletAgregarCompra"})
public class ServletAgregarCompra extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
        EntityManager em = emf.createEntityManager();

        try {
            // Obtener parámetros del formulario
            String estadoCompra = request.getParameter("estadoCompra");
            Timestamp fechaCompra =Timestamp.valueOf("fechaCompra");
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));

            // Validaciones básicas
            if (estadoCompra == null || estadoCompra.trim().isEmpty()
                    || fechaCompra == null ) {
                throw new ServletException("EstadoCompra y fechaCompra son requeridos");
            }

            // Obtener Usuario
            Usuario usuario = em.find(Usuario.class, idUsuario);

            if (usuario == null ) {
                throw new ServletException("Usuario no encontrado");
            }

            // Crear nueva compra
            Compra nuevaCompra = new Compra();
            nuevaCompra.setEstadoCompra(estadoCompra);
            nuevaCompra.setFechaCompra(fechaCompra);
            nuevaCompra.setIdUsuario(idUsuario);

            // Guardar en la base de datos
            em.getTransaction().begin();
            em.persist(nuevaCompra);
            em.getTransaction().commit();

            // Redirigir con mensaje de éxito
            request.getSession().setAttribute("mensaje", "Compra agregada correctamente");
            request.getSession().setAttribute("tipoMensaje", "success");
            response.sendRedirect("MenuAdministrativo.jsp");

        } catch (Exception e) {
            // Manejar errores
            request.setAttribute("error", "Error al agregar compra: " + e.getMessage());
            request.getRequestDispatcher("/ListarCompra.jsp").forward(request, response);
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
