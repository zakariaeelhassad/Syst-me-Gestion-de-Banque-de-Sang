package org.example.repositories.DAO.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.config.JPAUtil;
import org.example.entities.models.DonationAssociation;
import org.example.repositories.DAO.IDonationRepository;

import java.util.List;

public class DonationRepository implements IDonationRepository {

    private EntityManagerFactory emf;

    public DonationRepository() {
        this.emf = JPAUtil.getEntityManagerFactory();
    }

    public void create(DonationAssociation donationAssociation) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(donationAssociation);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<DonationAssociation> findAll() {
        EntityManager em = emf.createEntityManager();
        List<DonationAssociation> results = em.createQuery("SELECT d FROM DonationAssociation d", DonationAssociation.class)
                .getResultList();
        em.close();
        return results;
    }

    public DonationAssociation findById(String id) {
        EntityManager em = emf.createEntityManager();
        DonationAssociation donation = em.find(DonationAssociation.class, id);
        em.close();
        return donation;
    }

    public void delete(String id) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            DonationAssociation d = em.find(DonationAssociation.class, id);
            if (d != null) {
                em.remove(d);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<DonationAssociation> findByDonneurId(String donneurId) {
        EntityManager em = emf.createEntityManager();
        TypedQuery<DonationAssociation> query = em.createQuery(
                "SELECT d FROM DonationAssociation d WHERE d.donneur.id = :donneurId",
                DonationAssociation.class
        );
        query.setParameter("donneurId", donneurId);
        List<DonationAssociation> results = query.getResultList();
        em.close();
        return results;
    }

    public List<DonationAssociation> findByReceveurId(String receveurId) {
        EntityManager em = emf.createEntityManager();
        TypedQuery<DonationAssociation> query = em.createQuery(
                "SELECT d FROM DonationAssociation d WHERE d.receveur.id = :receveurId",
                DonationAssociation.class
        );
        query.setParameter("receveurId", receveurId);
        List<DonationAssociation> results = query.getResultList();
        em.close();
        return results;
    }
}
