package controller;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Usuario;
import dao.UsuarioDAO;

/**
 *
 * @author Wilson
 */
@WebServlet("/ServletRegistro")
public class ServletRegistro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombreUsuario");
        String apellido = request.getParameter("apellidoUsuario");
        String fechaNacStr = request.getParameter("fechaNacimiento");
        String genero = request.getParameter("generoUsuario");
        String telefono = request.getParameter("telefonoUsuario");
        String correo = request.getParameter("correoUsuario");
        String contrasena = request.getParameter("contrasenaUsuario");
        String repeatPassword = request.getParameter("repeat-password");

        if (!contrasena.equals(repeatPassword)) {
            request.setAttribute("nombreUsuarioValue", nombre);
            request.setAttribute("apellidoUsuarioValue", apellido);
            request.setAttribute("fechaNacimientoValue", fechaNacStr);
            request.setAttribute("generoUsuarioValue", genero);
            request.setAttribute("telefonoUsuarioValue", telefono);
            request.setAttribute("correoUsuarioValue", correo);
            request.setAttribute("error", "Las contraseñas no coinciden");
            request.getRequestDispatcher("Registro.jsp").forward(request, response);
            return;
        }
        
        if (genero == null || (!genero.equalsIgnoreCase("masculino") && !genero.equalsIgnoreCase("femenino"))) {
            request.setAttribute("nombreUsuarioValue", nombre);
            request.setAttribute("apellidoUsuarioValue", apellido);
            request.setAttribute("fechaNacimientoValue", fechaNacStr);
            request.setAttribute("telefonoUsuarioValue", telefono);
            request.setAttribute("correoUsuarioValue", correo);
            request.setAttribute("error", "Seleccione un género");
            request.getRequestDispatcher("Registro.jsp").forward(request, response);
            return;
        }

        Date fechaNacimiento = Date.valueOf(fechaNacStr);

        String generoDB = genero.equalsIgnoreCase("masculino") ? "MASCULINO" : "FEMENINO";

        Usuario nuevoUsuario = new Usuario(
                nombre,
                apellido != null ? apellido : "",
                fechaNacimiento,
                generoDB,
                telefono != null ? telefono : "",
                correo,
                contrasena,
                "Cliente"
        );

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        try {
            if (usuarioDAO.buscarPorCorreo(correo) != null) {
                request.setAttribute("nombreUsuarioValue", nombre);
                request.setAttribute("apellidoUsuarioValue", apellido);
                request.setAttribute("fechaNacimientoValue", fechaNacStr);
                request.setAttribute("generoUsuarioValue", genero);
                request.setAttribute("telefonoUsuarioValue", telefono);
                request.setAttribute("error", "El correo electrónico ya está registrado");
                request.getRequestDispatcher("Registro.jsp").forward(request, response);
                return;
            }

            if (usuarioDAO.guardarUsuario(nuevoUsuario)) {
                request.getSession().setAttribute("mensaje", "¡Registro exitoso!");
                response.sendRedirect("MenuPrincipal.jsp");
            } else {
                request.setAttribute("error", "Ocurrió un error al registrar el usuario");
                request.getRequestDispatcher("Registro.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Ocurrió un error al registrar el usuario: " + e.getMessage());
            request.getRequestDispatcher("Registro.jsp").forward(request, response);
        }
    }
}
