package org.example.web.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.enums.BloodGroup;
import org.example.entities.enums.ReceiverPriority;
import org.example.entities.enums.ReceiverState;
import org.example.entities.models.Receveur;
import org.example.repositories.DAO.IReceveurRepository;
import org.example.repositories.DAO.impl.ReceveurRepository;
import org.example.services.IReceveurService;
import org.example.services.impl.ReceveurService;

import java.io.IOException;
import java.time.LocalDate;

public class ReceveurController extends HttpServlet {

    private IReceveurRepository receveurRepository;
    private IReceveurService receveurService;

    public void init() throws ServletException {
        this.receveurRepository = new ReceveurRepository();
        this.receveurService = new ReceveurService(receveurRepository);
    }

    protected void doGet(HttpServletRequest request , HttpServletResponse response) throws ServletException , IOException {
        String pathInfo = request.getPathInfo();
        String action = request.getParameter("action");

        if(action != null ){
            switch(action){
                case "create" : chowCreateForm(request , response);
                    break;
                case "list" : getAllReceveurs(request , response);
                    break;
                case "update" : showUpdateForm(request , response);
                    break;
                case "delete" : deleteReceveur(request , response);
                    break ;
                default: response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        }else{
            if(pathInfo == null || pathInfo.equals("/")){
                getAllReceveurs(request , response);
            }else{
                getReceveurById(request , response);
            }
        }
    }

    protected void doPost(HttpServletRequest request , HttpServletResponse response) throws ServletException , IOException{
        String action = request.getParameter("action");

        if("create".equals(action)){
            createReceveur(request , response);
        } else if("update".equals(action)){
            updateReceveur(request, response);
        } else if ("delete".equals(action)) {
            deleteReceveur(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/receveurs?action=list");
        }
    }

    private void chowCreateForm(HttpServletRequest request , HttpServletResponse response) throws ServletException , IOException {
        request.setAttribute("bloodGroup" , BloodGroup.values());
        request.setAttribute("receiverPriority" , ReceiverPriority.values());
        request.setAttribute("receiverState" , ReceiverState.values());
        request.getRequestDispatcher("/WEB-INF/views/Receveur/create.jsp").forward(request , response);
    }

    private void createReceveur(HttpServletRequest request , HttpServletResponse response) throws ServletException , IOException {
        try{
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String cin = request.getParameter("cin");
            String sexe = request.getParameter("sexe");
            LocalDate dateNaissance = LocalDate.parse(request.getParameter("dateNaissance"));
            BloodGroup bloodGroup = BloodGroup.valueOf(request.getParameter("bloodGroup").toUpperCase());
            String telephone = request.getParameter("telephone");
            int besoinPoches = Integer.parseInt(request.getParameter("besoinPoches"));
            ReceiverPriority receiverPriority = ReceiverPriority.valueOf(request.getParameter("receiverPriority"));
            ReceiverState receiverState = ReceiverState.valueOf(request.getParameter("receiverState"));

            if (!cin.matches("^[A-Za-z]{2}\\d{6}$")) {
                request.setAttribute("errorMessage", "Le CIN doit contenir 2 lettres suivies de 6 chiffres (ex : AB445577).");
                request.getRequestDispatcher("/WEB-INF/views/Receveur/create.jsp").forward(request, response);
                return;
            }

            int age = java.time.Period.between(dateNaissance, java.time.LocalDate.now()).getYears();
            if (age < 18 || age > 65) {
                request.setAttribute("errorMessage", "L'âge du donneur doit être compris entre 18 et 65 ans.");
                request.getRequestDispatcher("/WEB-INF/views/Receveur/create.jsp").forward(request, response);
                return;
            }

            Receveur receveur = new Receveur();
            receveur.setNom(nom);
            receveur.setPrenom(prenom);
            receveur.setCin(cin);
            receveur.setSexe(sexe);
            receveur.setDateNaissance(dateNaissance);
            receveur.setBloodGroup(bloodGroup);
            receveur.setTelephone(telephone);
            receveur.setBesoinPoches(besoinPoches);
            receveur.setReceiverPriority(receiverPriority);
            receveur.setReceiverState(receiverState);

            receveurService.create(receveur);
            response.sendRedirect(request.getContextPath() + "/receveurs?action=list");

        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite lors de l'ajout du donneur.");
            request.getRequestDispatcher("/WEB-INF/views/Donneur/error.jsp").forward(request, response);
        }
    }

    private void getReceveurById(HttpServletRequest request , HttpServletResponse response) throws ServletException , IOException {
        String id = request.getPathInfo().substring(1);
        Receveur receveur = receveurService.getById(id);

        if (receveur == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Receveur introuvable");
            return;
        }

        request.setAttribute("receveurs" , receveur);
        request.getRequestDispatcher("/WEB-INF/views/Receveur/details.jsp").forward(request, response);
    }

    private void getAllReceveurs(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("Receveurs", receveurService.getAll());
        request.getRequestDispatcher("/WEB-INF/views/Receveur/list.jsp").forward(request, response);
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            String id = request.getParameter("id");
            Receveur receveur = receveurService.getById(id);

            if(receveur == null){
                request.setAttribute("errorMessage", "Receveur introuvable.");
                response.sendRedirect(request.getContextPath() + "/receveurs?action=list");
                return;
            }

            request.setAttribute("receveur" , receveur);
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.setAttribute("receiverPriority" , ReceiverPriority.values());
            request.setAttribute("receiverState" , ReceiverState.values());
            request.getRequestDispatcher("/WEB-INF/views/Receveur/update.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement du formulaire de mise à jour.");
            response.sendRedirect(request.getContextPath() + "/donneurs?action=list");
        }
    }

    private void updateReceveur(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                request.setAttribute("errorMessage", "ID manquant !");
                request.getRequestDispatcher("/WEB-INF/views/Receveur/update.jsp").forward(request, response);
                return;
            }

            Receveur receveur = receveurService.getById(id);

            if (receveur == null) {
                request.setAttribute("errorMessage", "Receveur introuvable.");
                response.sendRedirect(request.getContextPath() + "/receveurs?action=list");
                return;
            }

            receveur.setNom(request.getParameter("nom"));
            receveur.setPrenom(request.getParameter("prenom"));
            receveur.setCin(request.getParameter("cin"));
            receveur.setSexe(request.getParameter("sexe"));
            receveur.setDateNaissance(LocalDate.parse(request.getParameter("dateNaissance")));
            receveur.setBloodGroup(BloodGroup.valueOf(request.getParameter("bloodGroup").toUpperCase()));
            receveur.setTelephone(request.getParameter("telephone"));
            receveur.setBesoinPoches(Integer.parseInt(request.getParameter("besoinPoches")));
            receveur.setReceiverPriority(ReceiverPriority.valueOf(request.getParameter("receiverPriority").toUpperCase()));
            receveur.setReceiverState(ReceiverState.valueOf(request.getParameter("receiverState").toUpperCase()));

            receveurService.update(receveur);
            request.getSession().setAttribute("successMessage", "Receveur mis à jour avec succès !");
            response.sendRedirect(request.getContextPath() + "/receveurs?action=list");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la mise à jour : " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/Receveur/update.jsp").forward(request, response);
        }
    }

    private void deleteReceveur(HttpServletRequest request , HttpServletResponse response) throws ServletException , IOException {
        try{
            String id = request.getParameter("id");
            if(id == null || id.isEmpty()){
                request.setAttribute("errorMessage" , "ID manquant !");
                response.sendRedirect(request.getContextPath() + "/receveurs?action=list");
                return;
            }

            Receveur receveur = receveurService.getById(id);
            if(receveur == null){
                request.setAttribute("errorMessage", "Receveur introuvable !");
                response.sendRedirect(request.getContextPath() + "/receveurs?action=list");
                return;
            }

            receveurService.delete(id);
            request.getSession().setAttribute("successMessage", "Receveur supprimé avec succès !");
            response.sendRedirect(request.getContextPath() + "/receveurs?action=list");

        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la suppression : " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/receveurs?action=list");
        }
    }
}
