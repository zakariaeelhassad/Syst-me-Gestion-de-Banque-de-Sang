package org.example.web.controllers;

import org.example.entities.enums.BloodGroup;
import org.example.entities.enums.DonorStatus;
import org.example.entities.models.Donneur;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.repositories.DAO.IDonneurRepository;
import org.example.repositories.DAO.impl.DonneurRepository;
import org.example.services.IDonneurService;
import org.example.services.impl.DonneurService;

import java.io.IOException;
import java.time.LocalDate;

public class DonneurController extends HttpServlet {

    private IDonneurRepository donneurRepository;
    private IDonneurService donneurService;

    @Override
    public void init() throws ServletException {
        this.donneurRepository = new DonneurRepository();
        this.donneurService = new DonneurService(donneurRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "createForm":
                    chowCreateForm(request, response);
                    break;
                case "list":
                    getAllDonneurs(request, response);
                    break;
                case "update":
                    showUpdateForm(request, response);
                    break;
                case "delete":
                    deleteDonneur(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } else {
            if (pathInfo == null || pathInfo.equals("/")) {
                getAllDonneurs(request, response);
            } else {
                getDonneurById(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createDonneur(request, response);
        } else if ("update".equals(action)) {
            updateDonneur(request, response);
        }else if ("delete" . equals(action)){
            deleteDonneur(request , response);
        }
    }



    // ------------------- CREATE -------------------
    private void chowCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("bloodGroups", BloodGroup.values());
        request.setAttribute("donorStatuses", DonorStatus.values());
        request.getRequestDispatcher("/WEB-INF/views/Donneur/create.jsp").forward(request, response);
    }

    private void createDonneur(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String cin = request.getParameter("cin");
            String sexe = request.getParameter("sexe");
            LocalDate dateNaissance = LocalDate.parse(request.getParameter("dateNaissance"));
            BloodGroup bloodGroup = BloodGroup.valueOf(request.getParameter("bloodGroup").toUpperCase());
            String telephone = request.getParameter("telephone");
            boolean contreIndication = Boolean.parseBoolean(request.getParameter("contreIndication"));
            int pocheDisponible = Integer.parseInt(request.getParameter("pocheDisponible"));
            String notes = request.getParameter("notes");
            DonorStatus donorStatus = DonorStatus.valueOf(request.getParameter("donorStatus").toUpperCase());

            if (!cin.matches("^[A-Za-z]{2}\\d{6}$")) {
                request.setAttribute("errorMessage", "Le CIN doit contenir 2 lettres suivies de 6 chiffres (ex : AB445577).");
                request.getRequestDispatcher("/WEB-INF/views/Donneur/create.jsp").forward(request, response);
                return;
            }

            int age = java.time.Period.between(dateNaissance, java.time.LocalDate.now()).getYears();
            if (age < 18 || age > 65) {
                request.setAttribute("errorMessage", "L'âge du donneur doit être compris entre 18 et 65 ans.");
                request.getRequestDispatcher("/WEB-INF/views/Donneur/create.jsp").forward(request, response);
                return;
            }

            Donneur donneur = new Donneur();
            donneur.setNom(nom);
            donneur.setPrenom(prenom);
            donneur.setCin(cin);
            donneur.setSexe(sexe);
            donneur.setDateNaissance(dateNaissance);
            donneur.setBloodGroup(bloodGroup);
            donneur.setTelephone(telephone);
            donneur.setContreIndication(contreIndication);
            donneur.setPucheDisponible(pocheDisponible);
            donneur.setNotes(notes);
            donneur.setDonorStatus(donorStatus);

            donneurService.create(donneur);
            response.sendRedirect(request.getContextPath() + "/donneurs?action=list");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite lors de l'ajout du donneur.");
            request.getRequestDispatcher("/WEB-INF/views/Donneur/error.jsp").forward(request, response);
        }
    }


    // ------------------- LIST -------------------
    private void getAllDonneurs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("donneurs", donneurService.getAll());
        request.getRequestDispatcher("/WEB-INF/views/Donneur/list.jsp").forward(request, response);
    }

    // ------------------- DETAILS -------------------
    private void getDonneurById(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getPathInfo().substring(1);
        Donneur donneur = donneurService.getById(id);

        if (donneur == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Donneur introuvable");
            return;
        }

        request.setAttribute("donneur", donneur);
        request.getRequestDispatcher("/WEB-INF/views/Donneur/details.jsp").forward(request, response);
    }

    // ------------------- UPDATE -------------------
    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            Donneur donneur = donneurService.getById(id);

            if (donneur == null) {
                request.setAttribute("errorMessage", "Donneur introuvable.");
                response.sendRedirect(request.getContextPath() + "/donneurs?action=list");
                return;
            }

            request.setAttribute("donneur", donneur);
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.setAttribute("donorStatuses", DonorStatus.values());
            request.getRequestDispatcher("/WEB-INF/views/Donneur/update.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement du formulaire de mise à jour.");
            response.sendRedirect(request.getContextPath() + "/donneurs?action=list");
        }
    }

    private void updateDonneur(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                request.setAttribute("errorMessage", "ID manquant !");
                request.getRequestDispatcher("/WEB-INF/views/Donneur/update.jsp").forward(request, response);
                return;
            }

            Donneur donneur = donneurService.getById(id);

            if (donneur == null) {
                request.setAttribute("errorMessage", "Donneur introuvable.");
                response.sendRedirect(request.getContextPath() + "/donneurs?action=list");
                return;
            }

            donneur.setNom(request.getParameter("nom"));
            donneur.setPrenom(request.getParameter("prenom"));
            donneur.setCin(request.getParameter("cin"));
            donneur.setSexe(request.getParameter("sexe"));
            donneur.setDateNaissance(LocalDate.parse(request.getParameter("dateNaissance")));
            donneur.setBloodGroup(BloodGroup.valueOf(request.getParameter("bloodGroup").toUpperCase()));
            donneur.setTelephone(request.getParameter("telephone"));
            donneur.setContreIndication(Boolean.parseBoolean(request.getParameter("contreIndication")));
            donneur.setPucheDisponible(Integer.parseInt(request.getParameter("pocheDisponible")));
            donneur.setNotes(request.getParameter("notes"));
            donneur.setDonorStatus(DonorStatus.valueOf(request.getParameter("donorStatus").toUpperCase()));

            donneurService.update(donneur);
            request.getSession().setAttribute("successMessage", "Donneur mis à jour avec succès !");
            response.sendRedirect(request.getContextPath() + "/donneurs?action=list");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la mise à jour : " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/Donneur/update.jsp").forward(request, response);
        }
    }

    private void deleteDonneur(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                request.setAttribute("errorMessage", "ID manquant !");
                response.sendRedirect(request.getContextPath() + "/donneurs?action=list");
                return;
            }

            Donneur donneur = donneurService.getById(id);
            if (donneur == null) {
                request.setAttribute("errorMessage", "Donneur introuvable !");
                response.sendRedirect(request.getContextPath() + "/donneurs?action=list");
                return;
            }

            donneurService.delete(id);
            request.getSession().setAttribute("successMessage", "Donneur supprimé avec succès !");
            response.sendRedirect(request.getContextPath() + "/donneurs?action=list");
;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la suppression : " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/donneurs?action=list");
        }
    }

}
