package org.example.repositories.DAO.impl;

import org.example.config.JPAUtil;
import org.example.entities.models.Donneur;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.repositories.DAO.IDonneurRepository;

import java.util.List;

public class DonneurRepository implements IDonneurRepository {

    private final EntityManagerFactory emf;

    public DonneurRepository() {
        this.emf = JPAUtil.getEntityManagerFactory();
    }

    @Override
    public void create(Donneur donneur) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(donneur);
            tx.commit();
            System.out.println("Avant persist: " + donneur);
            em.persist(donneur);
            System.out.println("Après persist");
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Donneur donneur) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(donneur);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(String id) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Donneur managedDonneur = em.find(Donneur.class, id);
            if (managedDonneur != null) {
                em.remove(managedDonneur);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public Donneur findById(String id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Donneur.class, id);
        } finally {
            em.close();
        }
    }


    @Override
    public List<Donneur> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Donneur> query = em.createQuery("SELECT d FROM Donneur d", Donneur.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
