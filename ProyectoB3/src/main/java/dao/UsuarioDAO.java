package dao;

import model.Usuario;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import java.util.List;

public class UsuarioDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
    
    // Método existente
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
    
    // Nuevo método para buscar por ID
    public Usuario buscarPorId(int idUsuario) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Usuario.class, idUsuario);
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
    
    // Método existente
    public boolean validarLogin(String correoUsuario, String contrasenaUsuario) {
        Usuario usuario = buscarPorCorreo(correoUsuario);
        return usuario != null && usuario.getContrasenaUsuario().equals(contrasenaUsuario);
    }
    
    // Método existente
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
    
    // Método actualizado para eliminar usuario
    public boolean eliminarUsuario(int idUsuario) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Usuario usuario = em.find(Usuario.class, idUsuario);
            if (usuario != null) {
                em.remove(usuario);
                em.getTransaction().commit();
                return true;
            } else {
                em.getTransaction().rollback();
                return false;
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }
    
    // Nuevo método para actualizar usuario
    public boolean actualizarUsuario(Usuario usuario) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(usuario);
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
    
    // Nuevo método para listar todos los usuarios
    public List<Usuario> listarUsuarios() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Usuario> query = em.createQuery(
                    "SELECT u FROM Usuario u ORDER BY u.idUsuario",
                    Usuario.class);
            return query.getResultList();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
}