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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String correoUsuario = request.getParameter("correoUsuario");
        String contrasenaUsuario = request.getParameter("contrasenaUsuario");

        try {
            if (usuarioDAO.validarLogin(correoUsuario, contrasenaUsuario)) {
                HttpSession session = request.getSession();
                Usuario usuario = usuarioDAO.buscarPorCorreo(correoUsuario);
                session.setAttribute("usuario", usuario);

                if ("Cliente".equals(usuario.getRolUsuario())) {
                    response.sendRedirect("MenuPrincipal.jsp");
                } else if ("Empleado".equals(usuario.getRolUsuario())) {
                    response.sendRedirect("OpcionesMenuAdministrador.jsp");
                }
            } else {
                request.setAttribute("error", "ⓘ Usuario o contraseña incorrectos");
                request.getRequestDispatcher("InicioDeSesion.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en el sistema. Intente nuevamente.");
            request.getRequestDispatcher("InicioDeSesion.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("InicioDeSesion.jsp").forward(req, resp);
    }
}
