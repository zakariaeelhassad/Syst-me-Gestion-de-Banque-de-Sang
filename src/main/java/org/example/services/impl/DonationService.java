package org.example.services.impl;

import org.example.entities.enums.BloodGroup;
import org.example.entities.models.DonationAssociation;
import org.example.repositories.DAO.impl.DonationRepository;
import org.example.services.IDonationService;

import java.time.LocalDate;
import java.util.List;

public class DonationService implements IDonationService {
    private final DonationRepository repository;

    public DonationService() {
        this.repository = new DonationRepository();
    }

    public void createDonation(DonationAssociation donation) {
        LocalDate today = LocalDate.now();
        if (donation.getDateAssociation().isBefore(today)) {
            throw new IllegalArgumentException("La date de donation ne peut pas être dans le passé !");
        }

        BloodGroup donorGroup = donation.getDonneur().getBloodGroup();
        BloodGroup receiverGroup = donation.getReceveur().getBloodGroup();

        if (!donorGroup.canDonateTo(receiverGroup)) {
            throw new IllegalArgumentException("Donneur et receveur non compatibles !");
        }

        repository.create(donation);
    }

    public List<DonationAssociation> getAllDonations() {
        return repository.findAll();
    }

    public DonationAssociation getDonationById(String id) {
        return repository.findById(id);
    }


    public void deleteDonation(String id) {
        repository.delete(id);
    }

    public List<DonationAssociation> getDonationsByDonneur(String donneurId) {
        return repository.findByDonneurId(donneurId);
    }

    public List<DonationAssociation> getDonationsByReceveur(String receveurId) {
        return repository.findByReceveurId(receveurId);
    }
}
