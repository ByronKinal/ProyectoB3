package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Carrito;
import model.CarritoId;

public class CarritoDAO {

    private final EntityManagerFactory emf;

    public CarritoDAO() {
        this.emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");
    }

    public List<Carrito> listarCarritos() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Carrito> query = em.createQuery(
                    "SELECT c FROM Carrito c",
                    Carrito.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Carrito> listarCarritosPorCompra(int idCompra) {
        EntityManager em = emf.createEntityManager();
        try {
            // Usar JOIN FETCH para cargar todas las relaciones necesarias
            String jpql = "SELECT DISTINCT c FROM Carrito c "
                    + "LEFT JOIN FETCH c.compra comp "
                    + "LEFT JOIN FETCH c.producto p "
                    + "LEFT JOIN FETCH p.categoria "
                    + "LEFT JOIN FETCH p.proveedor "
                    + "WHERE c.compra.idCompra = :idCompra";

            TypedQuery<Carrito> query = em.createQuery(jpql, Carrito.class);
            query.setParameter("idCompra", idCompra);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Carrito buscarItemCarrito(int idCompra, int idProducto) {
        EntityManager em = emf.createEntityManager();
        try {
            CarritoId id = new CarritoId(idCompra, idProducto);
            return em.find(Carrito.class, id);
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

            // Asegurar que las entidades relacionadas estén gestionadas
            if (carrito.getCompra() != null && carrito.getCompra().getIdCompra() != 0) {
                carrito.setCompra(em.merge(carrito.getCompra()));
            }
            if (carrito.getProducto() != null && carrito.getProducto().getIdProducto() != 0) {
                carrito.setProducto(em.merge(carrito.getProducto()));
            }

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

    public void eliminarItemCarrito(int idCompra, int idProducto) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            CarritoId id = new CarritoId(idCompra, idProducto);
            Carrito carrito = em.find(Carrito.class, id);
            if (carrito != null) {
                em.remove(carrito);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Error al eliminar carrito", e);
        } finally {
            em.close();
        }
    }
}
