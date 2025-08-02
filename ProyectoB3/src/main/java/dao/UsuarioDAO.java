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

    public boolean guardarUsuario(Usuario usuario) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(usuario);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }
    
     public void eliminarUsuario(int idUsuario) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Usuario usuario = em.find(Usuario.class, idUsuario);
            if (usuario != null) {
                em.remove(usuario);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
