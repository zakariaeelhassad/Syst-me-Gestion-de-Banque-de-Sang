package org.example.services;

import org.example.entities.models.DonationAssociation;

import java.util.List;

public interface IDonationService {

    void createDonation(DonationAssociation donation);
    List<DonationAssociation> getAllDonations();
    DonationAssociation getDonationById(String id);
    void deleteDonation(String id);
    List<DonationAssociation> getDonationsByDonneur(String donneurId);
    List<DonationAssociation> getDonationsByReceveur(String receveurId);
}
