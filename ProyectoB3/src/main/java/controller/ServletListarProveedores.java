package controller;

import dao.ProveedorDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Proveedor;

@WebServlet("/ServletListarProveedores")
public class ServletListarProveedores extends HttpServlet {

    ProveedorDAO clienteDao = new ProveedorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Proveedor> listaClientes = clienteDao.listarTodos();  // ← Asegúrate que este método existe
        request.setAttribute("Proveedor", listaClientes);
        request.getRequestDispatcher("ListarProveedores.jsp").forward(request, response);
    }
}