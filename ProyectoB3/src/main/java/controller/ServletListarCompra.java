package controller;

import dao.CompraDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Compra;

/**
 *
 * @author Iosef
 */
@WebServlet("/ServletListarCompra")
public class ServletListarCompra {
    CompraDAO compraDao = new CompraDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Compra> listarCompras = compraDao.listarCompras();  // ← Asegúrate que este método existe
        request.setAttribute("Clientes", listarCompras);
        request.getRequestDispatcher("listarCompras.jsp").forward(request, response);
    }
}
