package dao;

import model.Producto;
import util.EntityManagerUtil;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

/**
 *
 * @author Wilson Florian
 */
public class ProductoDAO {

    // Removed EntityManagerFactory field - now using singleton utility
    public ProductoDAO() {
        // Constructor simplified - no need to create EntityManagerFactory
    }

    public List<Producto> listarProductosCompletos() {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            TypedQuery<Producto> query = em.createQuery(
                    "SELECT p FROM Producto p LEFT JOIN FETCH p.categoria LEFT JOIN FETCH p.proveedor ",
                    Producto.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Producto> listarProductosActivos() {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            TypedQuery<Producto> query = em.createQuery(
                    "SELECT p FROM Producto p "
                    + "LEFT JOIN FETCH p.categoria "
                    + "LEFT JOIN FETCH p.proveedor "
                    + "WHERE p.estadoProducto = 'ACTIVO'",
                    Producto.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Producto> listarProductosPorGenero(String genero) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            String jpql = "SELECT DISTINCT p FROM Producto p "
                    + "LEFT JOIN FETCH p.categoria c "
                    + "LEFT JOIN FETCH p.proveedor "
                    + "WHERE p.estadoProducto = 'ACTIVO' AND "
                    + "c.nombreCategoriaGenero = :genero";

            TypedQuery<Producto> query = em.createQuery(jpql, Producto.class);
            query.setParameter("genero", genero);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Producto obtenerProductoCompletoPorId(int idProducto) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            TypedQuery<Producto> query = em.createQuery(
                    "SELECT p FROM Producto p LEFT JOIN FETCH p.categoria LEFT JOIN FETCH p.proveedor WHERE p.idProducto = :id",
                    Producto.class);
            query.setParameter("id", idProducto);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public String obtenerGeneroProducto(int idProducto) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            Query query = em.createQuery(
                    "SELECT c.nombreCategoriaGenero FROM Producto p "
                    + "JOIN p.categoria c WHERE p.idProducto = :idProducto");
            query.setParameter("idProducto", idProducto);
            return (String) query.getSingleResult();
        } finally {
            em.close();
        }
    }

    // Modified method with optimized entity management
    public void agregarProducto(Producto producto) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();

            // Ensure related entities are managed for better performance
            if (producto.getCategoria() != null && producto.getCategoria().getIdCategoria() != 0) {
                producto.setCategoria(em.merge(producto.getCategoria()));
            }
            if (producto.getProveedor() != null && producto.getProveedor().getIdProveedor() != 0) {
                producto.setProveedor(em.merge(producto.getProveedor()));
            }

            em.persist(producto);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al agregar producto", e);
        } finally {
            em.close();
        }
    }

    public void actualizarProducto(Producto producto) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(producto);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al actualizar producto", e);
        } finally {
            em.close();
        }
    }

    public void eliminarProducto(int idProducto) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            em.getTransaction().begin();
            Producto producto = em.find(Producto.class, idProducto);
            if (producto != null) {
                em.remove(producto);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Producto obtenerProductoPorId(int idProducto) {
        EntityManager em = EntityManagerUtil.createEntityManager();
        try {
            return em.find(Producto.class, idProducto);
        } finally {
            em.close();
        }
    }
}
