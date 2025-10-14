package org.example.repositories.DAO;

import org.example.entities.models.Donneur;

import java.util.List;

public interface IDonneurRepository {

    void create(Donneur donneur);
    void update(Donneur donneur);
    void delete(String id);
    Donneur findById(String id);
    List<Donneur> findAll();
}
