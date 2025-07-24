
package dao;

/**
 *
 * @author Wilson Florian   
 */
import model.Cliente;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

public class UsuarioDAO {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("ZapateriaDonPepe");

    public Cliente buscarPorCorreo(String correoUsuario) {
        EntityManager em = emf.createEntityManager();
        Cliente cliente = null;
        try {
            TypedQuery<Cliente> query = em.createQuery("SELECT c FROM Usuarios c WHERE c.correoUsuario = :correoUsuario", Cliente.class);
            query.setParameter("correoUsuario", correoUsuario);
            cliente = query.getSingleResult();
        } catch (Exception e) {
            // No encontrado o error
            cliente = null;
        } finally {
            em.close();
        }
        return cliente;
    }

    // Validar login
    public boolean validarLogin(String correoUsuario, String contrasenaCliente) {
        Cliente cliente = buscarPorCorreo(correoUsuario);
        if (cliente != null) {
            // Aquí se puede usar hash en producción
            return cliente.getContrasenaCliente().equals(contrasenaCliente);
        }
        return false;
    }
}