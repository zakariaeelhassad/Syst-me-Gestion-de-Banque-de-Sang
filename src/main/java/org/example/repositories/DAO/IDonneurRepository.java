package org.example.DAO;

import org.example.entities.models.Donneur;

import java.util.List;

public interface IDonneurRepository {

    void create(Donneur donneur);
    void update(Donneur donneur);
    void delete(Donneur donneur);
    Donneur findById(int id);
    List<Donneur> findAll();
}
