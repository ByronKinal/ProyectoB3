package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Compra;
import model.Usuario;

public class CompraDAO {
    private final EntityManagerFactory emf;

    public CompraDAO() {
        this.emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
    }

    public List<Compra> listarCompras() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Compra> query = em.createQuery(
                "SELECT c FROM Compra c", 
                Compra.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Compra buscarCompraPendiente(int idUsuario) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Compra> query = em.createQuery(
                "SELECT c FROM Compra c WHERE c.usuario.idUsuario = :idUsuario AND c.estadoCompra = 'Pendiente'", 
                Compra.class);
            query.setParameter("idUsuario", idUsuario);
            return query.getResultList().stream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }
    
    public Compra obtenerCompraPorId(int idCompra) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Compra.class, idCompra);
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
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            Compra compra = em.find(Compra.class, idCompra);
            if (compra != null) {
                em.remove(compra);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al eliminar compra", e);
        } finally {
            em.close();
        }
    }
}