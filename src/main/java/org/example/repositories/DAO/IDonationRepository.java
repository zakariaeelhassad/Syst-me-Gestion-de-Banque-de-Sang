package org.example.repositories.DAO;

import org.example.entities.models.DonationAssociation;

import java.util.List;

public interface IDonationRepository {

    void create(DonationAssociation donation);
    void delete(String id);
    List<DonationAssociation> findByDonneurId(String donneurId);
    List<DonationAssociation> findByReceveurId(String receveurId);
    List<DonationAssociation> findAll();
    DonationAssociation findById(String id);
}
