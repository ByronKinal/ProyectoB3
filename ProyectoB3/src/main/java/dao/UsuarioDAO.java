package dao;

import model.Usuario;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

/**
 *
 * @author Wilson Florian
 */
public class UsuarioDAO {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");

    public Usuario buscarPorCorreo(String correoUsuario) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Usuario> query = em.createQuery(
                    "SELECT u FROM Usuario u WHERE u.correoUsuario = :correoUsuario",
                    Usuario.class);
            query.setParameter("correoUsuario", correoUsuario);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    public boolean validarLogin(String correoUsuario, String contrasenaUsuario) {
        Usuario usuario = buscarPorCorreo(correoUsuario);
        return usuario != null && usuario.getContrasenaUsuario().equals(contrasenaUsuario);
    }
}
