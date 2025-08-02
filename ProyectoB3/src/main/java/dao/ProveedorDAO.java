
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import model.Proveedor;

/**
 *
 * @author informatica
 */
public class ProveedorDAO {

    private final EntityManagerFactory emf;

    public ProveedorDAO() {
        this.emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
    }

    public List<Proveedor> listarProveedores() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Proveedor> query = em.createQuery(
                    "SELECT p FROM Proveedor p",
                    Proveedor.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Proveedor obtenerProveedorCompletoPorId(int idProveedor) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Proveedor> query = em.createQuery(
                    "SELECT p FROM Proveedor p  WHERE p.idProveedor = :id",
                    Proveedor.class);
            query.setParameter("id", idProveedor);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public List<Proveedor> listarProveedoresPorEstado(String estadoProveedor) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Proveedor> query = em.createQuery(
                    "SELECT p FROM Proveedor p "
                    + "WHERE p.estadoProveedor = :estadoProveedor", Proveedor.class);
            query.setParameter("estadoProveedor", estadoProveedor);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public String obtenerEstadoProveedor(int idProveedor) {
        EntityManager em = emf.createEntityManager();
        try {
            Query query = em.createQuery(
                    "SELECT p.estadoProveedor FROM Proveedor p "
                    + "WHERE p.idProveedor = :idProveedor");
            query.setParameter("idProveedor", idProveedor);
            return (String) query.getSingleResult();
        } finally {
            em.close();
        }
    }

    // Modificar el método agregarProducto
    public void agregarProveedor(Proveedor proveedor) {
        EntityManager em = emf.createEntityManager();
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
        EntityManager em = emf.createEntityManager();
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

    public void suspenderProveedor(int idProveedor) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Proveedor proveedor = em.find(Proveedor.class, idProveedor);
            if (proveedor != null) {
                em.remove(proveedor);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    public Proveedor obtenerProveedorPorId(int idProveedor) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Proveedor.class, idProveedor);
        } finally {
            em.close();
        }
    }
}
