package org.example.repositories.DAO.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.config.JPAUtil;
import org.example.entities.models.Receveur;
import org.example.repositories.DAO.IReceveurRepository;

import java.util.List;

public class ReceveurRepository implements IReceveurRepository {

    private final EntityManagerFactory emf;

    public ReceveurRepository(){
        this.emf = JPAUtil.getEntityManagerFactory();
    }

    public void create(Receveur receveur){
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(receveur);
            tx.commit();
        }catch(Exception e){
            if(tx.isActive()) tx.rollback();
            e.printStackTrace();
        }finally{
            em.close();
        }
    }

    public void update(Receveur receveur){
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try{
            tx.begin();
            em.merge(receveur);
            tx.commit();
        }catch(Exception e){
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }finally {
            em.close();
        }
    }

    public void delete(String id){
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try{
            tx.begin();
            Receveur managerReceveur = em.find(Receveur.class , id  );
            if(managerReceveur != null){
                em.remove(managerReceveur);
            }
            tx.commit();
        }catch(Exception e){
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public Receveur findById(String id){
        EntityManager em = emf.createEntityManager();
        try{
            return em.find(Receveur.class , id );
        }finally{
            em.close();
        }
    }

    public List<Receveur> findAll(){
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Receveur> query = em.createQuery("SELECT r FROM Receveur r" , Receveur.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
