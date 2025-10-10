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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("zjhbziurb");
        String pathInfo = request.getPathInfo();
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "createForm":
                    showCreateForm(request, response);
                    break;
                case "list":
                    getAllDonneurs(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("create".equals(action)) {
            createDonneur(request, response);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("bloodGroups", BloodGroup.values());

        request.setAttribute("donorStatuses", DonorStatus.values());
        request.getRequestDispatcher("/WEB-INF/views/Donneur/createFrom.jsp").forward(request, response);
    }

    private void getAllDonneurs(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("donneurs", donneurService.getAll());
        request.getRequestDispatcher("/WEB-INF/views/Donneur/list.jsp").forward(request, response);
    }

    private void getDonneurById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getPathInfo().substring(1));
        Donneur donneur = donneurService.getById(id);
        request.setAttribute("donneur", donneur);
        request.getRequestDispatcher("/views/Donneur/details.jsp").forward(request, response);
    }

    private void createDonneur(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String cin = request.getParameter("cin");
        String sexe = request.getParameter("sexe");
        LocalDate dateNaissance = LocalDate.parse(request.getParameter("dateNaissance"));
        BloodGroup bloodGroup = BloodGroup.valueOf(request.getParameter("bloodGroup").toUpperCase());
        boolean contreIndication = Boolean.parseBoolean(request.getParameter("contreIndication"));
        int pucheDisponible = Integer.parseInt(request.getParameter("pucheDisponible"));
        String notes = request.getParameter("notes");
        DonorStatus donorStatus = DonorStatus.valueOf(request.getParameter("donorStatus").toUpperCase());

        Donneur donneur = new Donneur();
        donneur.setNom(nom);
        donneur.setPrenom(prenom);
        donneur.setCin(cin);
        donneur.setSexe(sexe);
        donneur.setDateNaissance(dateNaissance);
        donneur.setBloodGroup(bloodGroup);
        donneur.setContreIndication(contreIndication);
        donneur.setPucheDisponible(pucheDisponible);
        donneur.setNotes(notes);
        donneur.setDonorStatus(donorStatus);


        try {
            donneurService.create(donneur);
            response.sendRedirect(request.getContextPath() + "/donneurs?action=list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite lors de l'ajout du donneur.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
}
