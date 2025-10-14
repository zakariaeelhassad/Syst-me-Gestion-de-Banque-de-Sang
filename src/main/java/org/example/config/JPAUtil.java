package org.example.config;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class JPAUtil {

    private static EntityManagerFactory ENTITY_MANAGER_FACTORY;

    private JPAUtil() {
    }

    public static EntityManagerFactory getEntityManagerFactory() {
        if (ENTITY_MANAGER_FACTORY == null) {
            try {
                Properties dbProperties = loadDatabaseProperties();

                Map<String, String> configOverrides = new HashMap<>();
                configOverrides.put("jakarta.persistence.jdbc.driver",
                        dbProperties.getProperty("db.driver"));
                configOverrides.put("jakarta.persistence.jdbc.url",
                        dbProperties.getProperty("db.url"));
                configOverrides.put("jakarta.persistence.jdbc.user",
                        dbProperties.getProperty("db.username"));
                configOverrides.put("jakarta.persistence.jdbc.password",
                        dbProperties.getProperty("db.password"));

                ENTITY_MANAGER_FACTORY = Persistence.createEntityManagerFactory("sang", configOverrides);

            } catch (IOException e) {
                throw new RuntimeException("Failed to load database properties from db.properties file", e);
            }
        }
        return ENTITY_MANAGER_FACTORY;
    }

    private static Properties loadDatabaseProperties() throws IOException {
        Properties properties = new Properties();

        try (InputStream input = JPAUtil.class.getClassLoader()
                .getResourceAsStream("db.properties")) {

            if (input == null) {
                throw new IOException("Unable to find db.properties file in classpath");
            }

            properties.load(input);
        }

        return properties;
    }

    public static void closeEntityManagerFactory() {
        if (ENTITY_MANAGER_FACTORY != null && ENTITY_MANAGER_FACTORY.isOpen()) {
            ENTITY_MANAGER_FACTORY.close();
        }
    }
}