
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Factura;

/**
 *
 * @author asosa
 */
public class FacturaDAO {
    private final EntityManagerFactory emf;

    public FacturaDAO() {
        this.emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
    }

    public List<Factura> listarFacturas() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Factura> query = em.createQuery(
                "SELECT p FROM Factura p", 
                Factura.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Factura obtenerFacturaPorId(int idFactura) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Factura> query = em.createQuery(
                "SELECT p FROM Producto p WHERE p.idFactura = :id", 
                Factura.class);
            query.setParameter("id", idFactura);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public void agregarFactura(Factura factura) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(factura);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al agregar factura", e);
        } finally {
            em.close();
        }
    }

    public void actualizarFactura(Factura factura) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(factura);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al actualizar factura", e);
        } finally {
            em.close();
        }
    }

    public void eliminarFactura(int idFactura) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Factura producto = em.find(Factura.class, idFactura);
            if (producto != null) {
                em.remove(producto);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
