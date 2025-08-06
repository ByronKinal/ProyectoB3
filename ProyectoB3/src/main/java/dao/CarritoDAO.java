
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Carrito;

/**
 *
 * @author asosa
 */
public class CarritoDAO {
    private final EntityManagerFactory emf;

    public CarritoDAO() {
        this.emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
    }

    public List<Carrito> listarCarritos() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Carrito> query = em.createQuery(
                "SELECT p FROM Carrito p", 
                Carrito.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Carrito obtenerCarritoPorId(int idCarrito) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Carrito> query = em.createQuery(
                "SELECT p FROM Producto p WHERE p.idCarrito = :id", 
                Carrito.class);
            query.setParameter("id", idCarrito);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public void agregarCarrito(Carrito carrito) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(carrito);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al agregar carrito", e);
        } finally {
            em.close();
        }
    }

    public void actualizarCarrito(Carrito carrito) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(carrito);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al actualizar carrito", e);
        } finally {
            em.close();
        }
    }

    public void eliminarCarrito(int idCarrito) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Carrito producto = em.find(Carrito.class, idCarrito);
            if (producto != null) {
                em.remove(producto);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
