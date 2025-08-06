
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Categoria;

/**
 *
 * @author asosa
 */
public class CategoriaDAO {
    private final EntityManagerFactory emf;

    public CategoriaDAO() {
        this.emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
    }

    public List<Categoria> listarCategorias() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Categoria> query = em.createQuery(
                "SELECT p FROM Categoria p", 
                Categoria.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Categoria obtenerCategoriaPorId(int idCategoria) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Categoria> query = em.createQuery(
                "SELECT p FROM Producto p WHERE p.idCategoria = :id", 
                Categoria.class);
            query.setParameter("id", idCategoria);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public void agregarCategoria(Categoria categoria) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(categoria);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al agregar categoria", e);
        } finally {
            em.close();
        }
    }

    public void actualizarCategoria(Categoria categoria) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(categoria);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al actualizar categoria", e);
        } finally {
            em.close();
        }
    }

    public void eliminarCategoria(int idCategoria) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Categoria producto = em.find(Categoria.class, idCategoria);
            if (producto != null) {
                em.remove(producto);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
