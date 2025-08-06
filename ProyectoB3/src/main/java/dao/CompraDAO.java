
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Compra;

/**
 *
 * @author asosa
 */
public class CompraDAO {
    private final EntityManagerFactory emf;

    public CompraDAO() {
        this.emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
    }

    public List<Compra> listarCompras() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Compra> query = em.createQuery(
                "SELECT p FROM Compra p", 
                Compra.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Compra obtenerCompraPorId(int idCompra) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Compra> query = em.createQuery(
                "SELECT p FROM Compra p WHERE p.idCompra = :id", 
                Compra.class);
            query.setParameter("id", idCompra);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public void agregarCompra(Compra compra) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(compra);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al agregar compra", e);
        } finally {
            em.close();
        }
    }

    public void actualizarCompra(Compra compra) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(compra);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al actualizar compra", e);
        } finally {
            em.close();
        }
    }

    public void eliminarCompra(int idCompra) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Compra producto = em.find(Compra.class, idCompra);
            if (producto != null) {
                em.remove(producto);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
