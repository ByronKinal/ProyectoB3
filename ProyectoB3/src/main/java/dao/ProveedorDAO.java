package dao;

import model.Proveedor;
import util.EntityManagerUtil;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

/**
 * Optimized ProveedorDAO with consolidated methods and singleton EntityManagerFactory
 * @author Performance Optimization
 */
public class ProveedorDAO {
    
    // Method to clear cache - now optimized
    public void limpiarCache() {
        EntityManagerUtil.getEntityManagerFactory().getCache().evictAll();
    }
    
    public List<Proveedor> listarTodos() {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            TypedQuery<Proveedor> query = em.createQuery(
                "SELECT p FROM Proveedor p ORDER BY p.nombreProveedor", Proveedor.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Consolidated method - replaced both obtenerProveedorCompletoPorId and obtenerProveedorPorId
    public Proveedor obtenerProveedorPorId(int idProveedor) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            return em.find(Proveedor.class, idProveedor);
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    // Kept for backward compatibility but now delegates to optimized method
    public Proveedor obtenerProveedorCompletoPorId(int idProveedor) {
        return obtenerProveedorPorId(idProveedor);
    }

    public List<Proveedor> listarProveedoresPorEstado(String estadoProveedor) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            TypedQuery<Proveedor> query = em.createQuery(
                    "SELECT p FROM Proveedor p WHERE p.estadoProveedor = :estadoProveedor",
                    Proveedor.class);
            query.setParameter("estadoProveedor", estadoProveedor);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public String obtenerEstadoProveedor(int idProveedor) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            TypedQuery<String> query = em.createQuery(
                    "SELECT p.estadoProveedor FROM Proveedor p WHERE p.idProveedor = :idProveedor",
                    String.class);
            query.setParameter("idProveedor", idProveedor);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    public void agregarProveedor(Proveedor proveedor) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(proveedor);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al agregar proveedor", e);
        } finally {
            em.close();
        }
    }

    public void actualizarProveedor(Proveedor proveedor) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(proveedor);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al actualizar proveedor", e);
        } finally {
            em.close();
        }
    }

    // Optimized method for deleting provider
    public boolean eliminarProveedor(int idProveedor) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            Proveedor proveedor = em.find(Proveedor.class, idProveedor);
            if (proveedor != null) {
                em.remove(proveedor);
                tx.commit();
                return true;
            } else {
                tx.rollback();
                return false;
            }
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }

    // Simplified method - no longer redundant
    public void suspenderProveedor(int idProveedor) {
        eliminarProveedor(idProveedor);
    }
}
