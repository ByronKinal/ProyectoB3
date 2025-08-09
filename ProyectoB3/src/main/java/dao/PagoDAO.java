package dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import model.Pago;

public class PagoDAO {
    private final EntityManagerFactory emf;

    public PagoDAO() {
        this.emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
    }

    public void agregarPago(Pago pago) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(pago);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al agregar pago", e);
        } finally {
            em.close();
        }
    }

    public void actualizarPago(Pago pago) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(pago);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al actualizar pago", e);
        } finally {
            em.close();
        }
    }

    public void eliminarPago(int idPago) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            Pago pago = em.find(Pago.class, idPago);
            if (pago != null) {
                em.remove(pago);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al eliminar pago", e);
        } finally {
            em.close();
        }
    }

    public Pago obtenerPagoPorId(int idPago) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Pago.class, idPago);
        } finally {
            em.close();
        }
    }
}