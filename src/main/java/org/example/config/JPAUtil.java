package config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static EntityManagerFactory ENTITY_MANAGER_FACTORY ;
    private JPAUtil() {}

    public static EntityManagerFactory getEntityManagerFactory() {
        if (ENTITY_MANAGER_FACTORY == null) {
            ENTITY_MANAGER_FACTORY = Persistence.createEntityManagerFactory("sang");
        }
        return ENTITY_MANAGER_FACTORY;
    }

    public static void closeEntityManagerFactory() {
        if (ENTITY_MANAGER_FACTORY != null) {
            ENTITY_MANAGER_FACTORY.close();
        }
    }
}
