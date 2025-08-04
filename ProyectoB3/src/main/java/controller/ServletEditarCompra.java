/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Iosef
 */
@WebServlet(name = "ServletEditarCompra", urlPatterns = {"/ServletEditarCompra"})
public class ServletEditarCompra extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idCompra = Integer.parseInt(request.getParameter("id"));
        
        CompraDAO productoDAO = new CompraDAO();
        Compra compra = productoDAO.obtenerCompraCompletoPorId(idCompra);
        
        if (compra == null) {
            request.getSession().setAttribute("mensaje", "Compra no encontrado");
            request.getSession().setAttribute("tipoMensaje", "danger");
            response.sendRedirect("MenuAdministrativo.jsp");
            return;
        }
        
        request.setAttribute("producto", compra);
        request.getRequestDispatcher("EditarProducto.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}