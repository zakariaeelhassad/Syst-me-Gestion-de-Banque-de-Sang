package org.example.services;

import org.example.entities.models.Receveur;

import java.util.List;

public interface IReceveurService {
    void create(Receveur receveur);
    void update(Receveur receveur);
    void delete(String id);
    Receveur getById(String id);
    List<Receveur> getAll();
}
