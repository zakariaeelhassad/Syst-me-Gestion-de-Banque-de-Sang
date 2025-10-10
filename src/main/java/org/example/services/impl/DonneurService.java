package services.impl;

import entities.models.Donneur;
import repositories.DAO.IDonneurRepository;
import services.IDonneurService;

import java.util.List;

public class DonneurService implements IDonneurService {

    private final IDonneurRepository repository;

    public DonneurService(IDonneurRepository repository) {
        this.repository = repository;
    }

    @Override
    public void create(Donneur donneur) {
        repository.create(donneur);
    }

    @Override
    public List<Donneur> getAll() {
        return repository.findAll();
    }

    @Override
    public Donneur getById(int id) {
        return repository.findById(id);
    }

    @Override
    public void update(Donneur donneur) {
        repository.update(donneur);
    }

    @Override
    public void delete(int id) {
        Donneur donneur = repository.findById(id);
        if (donneur != null) {
            repository.delete(donneur);
        }
    }
}
