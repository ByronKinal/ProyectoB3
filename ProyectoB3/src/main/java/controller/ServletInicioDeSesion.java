
package controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Wilson Florian
 */
import dao.UsuarioDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ServletInicioDeSesion")
public class ServletInicioDeSesion extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (usuarioDAO.validarLogin(username, password)) {
            // Login exitoso: crear sesión
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            resp.sendRedirect("MenuPrincipal.jsp");
        } else {
            // Login fallido: redirigir a login con error
            req.setAttribute("Error", "Usuario o contraseña incorrectos");
            req.getRequestDispatcher("InicioDeSesion.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Mostrar formulario de login (opcional)
        req.getRequestDispatcher("InicioDeSesion.jsp").forward(req, resp);
    }
}