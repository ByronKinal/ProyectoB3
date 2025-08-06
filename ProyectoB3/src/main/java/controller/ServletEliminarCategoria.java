package controller;

import dao.CategoriaDAO;
import dao.ProveedorDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Categoria;

/**
 *
 * @author Roger Valladares
 */
@WebServlet(name = "ServletEliminarCategoria", urlPatterns = {"/ServletEliminarCategoria"})
public class ServletEliminarCategoria extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idCategoria = Integer.parseInt(request.getParameter("id"));
        
        CategoriaDAO categoriaDAO = new CategoriaDAO();
        Categoria categoria = categoriaDAO.obtenerProveedorPorId(idCategoria);
        
        response.sendRedirect("MenuAdministrativo.jsp");
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
}
