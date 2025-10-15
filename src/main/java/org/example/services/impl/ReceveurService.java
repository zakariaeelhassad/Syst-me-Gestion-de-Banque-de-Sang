package org.example.services.impl;

import org.example.entities.models.Receveur;
import org.example.repositories.DAO.IReceveurRepository;
import org.example.services.IReceveurService;

import java.util.List;

public class ReceveurService implements IReceveurService {

    private final IReceveurRepository repository ;

    public ReceveurService(IReceveurRepository repository){
        this.repository = repository ;
    }

    public void create(Receveur receveur){
        repository.create(receveur);
    }

    public void update(Receveur receveur){
        repository.update(receveur);
    }

    public void delete(String id){
        Receveur receveur = repository.findById(id);
        if(receveur != null){
            repository.delete(id);
        }
    }

    public Receveur getById(String id){
        return repository.findById(id) ;
    }

    public List<Receveur> getAll(){
        return repository.findAll() ;
    }
}
