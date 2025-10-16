package org.example.web.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.models.DonationAssociation;
import org.example.entities.models.Donneur;
import org.example.entities.models.Receveur;
import org.example.repositories.DAO.IDonneurRepository;
import org.example.repositories.DAO.IReceveurRepository;
import org.example.repositories.DAO.impl.DonneurRepository;
import org.example.repositories.DAO.impl.ReceveurRepository;
import org.example.services.IDonationService;
import org.example.services.impl.DonationService;
import org.example.services.impl.DonneurService;
import org.example.services.impl.ReceveurService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public class DonationController extends HttpServlet {
    private IDonationService donationService;

    public void init() throws ServletException {
        donationService = new DonationService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) action = "list";

        switch (action) {
            case "create" : showCreateForm(request, response);
                break;
            case "delete": delete(request , response);
                break;
            default:
                List<DonationAssociation> donations = donationService.getAllDonations();
                request.setAttribute("donations", donations);
                request.getRequestDispatcher("/WEB-INF/views/Donation/list.jsp").forward(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createDonation(request, response);
        } else if ("delete".equals(action)) {
            delete(request, response);
        }
    }

    protected void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        IReceveurRepository receveurRepo = new ReceveurRepository();
        ReceveurService receveurService = new ReceveurService(receveurRepo);

        IDonneurRepository donneurRepo = new DonneurRepository();
        DonneurService donneurService = new DonneurService(donneurRepo);

        List<Donneur> donneurs = donneurService.getAll();
        List<Receveur> receveurs = receveurService.getAll();

        request.setAttribute("donneurs", donneurs);
        request.setAttribute("receveurs", receveurs);

        request.getRequestDispatcher("/WEB-INF/views/Donation/create.jsp").forward(request, response);
    }

    private void createDonation(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            String dateParam = request.getParameter("date_association");
            LocalDate date;


            try {
                date = LocalDate.parse(dateParam);
            } catch (Exception ex) {
                request.setAttribute("errorMessage", "Format de date invalide.");
                request.getRequestDispatcher("/WEB-INF/views/Donation/create.jsp").forward(request, response);
                return;
            }

            IDonneurRepository donneurRepo = new DonneurRepository();
            DonneurService donneurService = new DonneurService(donneurRepo);
            Donneur donneur = donneurService.getById(request.getParameter("donneur_id"));

            IReceveurRepository receveurRepo = new ReceveurRepository();
            ReceveurService receveurService = new ReceveurService(receveurRepo);
            Receveur receveur = receveurService.getById(request.getParameter("receveur_id"));

            if (donneur == null || receveur == null) {
                request.setAttribute("errorMessage", "Donneur ou Receveur introuvable.");
                request.getRequestDispatcher("/WEB-INF/views/Donation/create.jsp").forward(request, response);
                return;
            }

            DonationAssociation donation = new DonationAssociation();
            donation.setDateAssociation(date);
            donation.setDonneur(donneur);
            donation.setReceveur(receveur);

            donationService.createDonation(donation);
            response.sendRedirect(request.getContextPath() + "/donations");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la création de la donation: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/Donation/create.jsp").forward(request, response);
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String idDelete = request.getParameter("id");
        donationService.deleteDonation(idDelete);
        response.sendRedirect(request.getContextPath() + "/donations");
    }
}
