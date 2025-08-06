
package controller;

import dao.CategoriaDAO;
import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "ServletListarCategoria", urlPatterns = {"/ServletListarCategoria"})

public class ServletListarCategoria extends HttpServlet {
    CategoriaDAO categoriaDAD = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Categoria> listaCategorias = categoriaDAD.listarCategorias();  // ← Asegúrate que este método existe
        request.setAttribute("Categorias", listaCategorias);
        // revisar nombre de jsp
        request.getRequestDispatcher("listarCategorias.jsp").forward(request, response);
    }
}
