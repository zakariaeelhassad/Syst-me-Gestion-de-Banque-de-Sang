package org.example.services;

import org.example.entities.models.Donneur;

import java.util.List;

public interface IDonneurService {

    void create (Donneur donneur);
    void update(Donneur donneur);
    void delete(int id);
    List<Donneur> getAll();
    Donneur getById(int id);
}
