package util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * Singleton utility class for managing EntityManagerFactory
 * This optimization prevents expensive EntityManagerFactory creation
 * on every database operation, improving client performance significantly.
 * 
 * @author Performance Optimization
 */
public class EntityManagerUtil {
    
    private static EntityManagerFactory entityManagerFactory;
    private static final String PERSISTENCE_UNIT_NAME = "ZapateriaDonPepe";
    
    // Private constructor to prevent instantiation
    private EntityManagerUtil() {
    }
    
    /**
     * Gets the singleton EntityManagerFactory instance
     * @return EntityManagerFactory instance
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        if (entityManagerFactory == null) {
            synchronized (EntityManagerUtil.class) {
                if (entityManagerFactory == null) {
                    entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
                }
            }
        }
        return entityManagerFactory;
    }
    
    /**
     * Creates a new EntityManager instance
     * @return EntityManager instance
     */
    public static EntityManager createEntityManager() {
        return getEntityManagerFactory().createEntityManager();
    }
    
    /**
     * Closes the EntityManagerFactory (should be called on application shutdown)
     */
    public static void closeEntityManagerFactory() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            entityManagerFactory.close();
        }
    }
}