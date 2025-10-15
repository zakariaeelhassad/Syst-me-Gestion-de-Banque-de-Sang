package org.example.repositories.DAO;

import org.example.entities.models.Receveur;

import java.util.List;

public interface IReceveurRepository {
    void create(Receveur receveur);
    void update(Receveur receveur);
    void delete(String id);
    Receveur findById(String id);
    List<Receveur> findAll();
}
