package controller;

import dao.UsuarioDAO;
import model.Usuario;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;

/**
 *
 * @author Wilson Florian
 */
@WebServlet("/ServletInicioDeSesion")
public class ServletInicioDeSesion extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String correoUsuario = req.getParameter("correoUsuario");
        String contrasenaUsuario = req.getParameter("contrasenaUsuario");

        try {
            if (usuarioDAO.validarLogin(correoUsuario, contrasenaUsuario)) {
                HttpSession session = req.getSession();
                Usuario usuario = usuarioDAO.buscarPorCorreo(correoUsuario);
                session.setAttribute("usuario", usuario);

                if ("Cliente".equals(usuario.getRolUsuario())) {
                    resp.sendRedirect("MenuPrincipal.jsp");
                } else if ("Empleado".equals(usuario.getRolUsuario())) {
                    resp.sendRedirect("MenuPrincipal.jsp");
                }
            } else {
                req.setAttribute("error", "ⓘ Usuario o contraseña incorrectos");
                req.getRequestDispatcher("InicioDeSesion.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error en el sistema. Intente nuevamente.");
            req.getRequestDispatcher("InicioDeSesion.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("InicioDeSesion.jsp").forward(req, resp);
    }
}
