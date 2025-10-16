<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entities.models.Donneur" %>
<%@ page import="org.example.entities.enums.BloodGroup" %>
<%@ page import="org.example.entities.enums.DonorStatus" %>
<%
    Donneur donneur = (Donneur) request.getAttribute("donneur");
    BloodGroup[] bloodGroups = (BloodGroup[]) request.getAttribute("bloodGroups");
    DonorStatus[] donorStatuses = (DonorStatus[]) request.getAttribute("donorStatuses");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier un Donneur</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-orange-50 via-white to-amber-50 min-h-screen">
<div class="container mx-auto px-4 py-8 max-w-4xl">
    <div class="text-center mb-8 fade-in">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-orange-500 to-amber-600 rounded-full mb-4 shadow-lg">
            <span class="text-3xl">✏️</span>
        </div>
        <h1 class="text-4xl font-bold text-gray-900 mb-2 bg-gradient-to-r from-orange-600 to-amber-600 bg-clip-text text-transparent">
            Modifier le Donneur
        </h1>
        <p class="text-gray-600">Mettez à jour les informations du donneur #<%= donneur.getId() %></p>
    </div>

    <div class="bg-white rounded-2xl shadow-xl p-8 fade-in border border-gray-100" style="animation-delay: 0.1s">
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded">
            <p class="text-red-800"><%= request.getAttribute("errorMessage") %></p>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/donneurs" method="post" class="space-y-6">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= donneur.getId() %>">

            <div class="border-b border-gray-200 pb-6">
                <h2 class="text-2xl font-semibold text-gray-800 mb-4 flex items-center">
                    <span class="text-2xl mr-2">👤</span>
                    Informations Personnelles
                </h2>
                <div class="grid md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Nom *</label>
                        <input type="text" name="nom" required value="<%= donneur.getNom() %>"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Prénom *</label>
                        <input type="text" name="prenom" required value="<%= donneur.getPrenom() %>"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">CIN *</label>
                        <input type="text" name="cin" required value="<%= donneur.getCin() %>"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Sexe *</label>
                        <select name="sexe" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition">
                            <option value="M" <%= "M".equals(donneur.getSexe()) ? "selected" : "" %>>Masculin</option>
                            <option value="F" <%= "F".equals(donneur.getSexe()) ? "selected" : "" %>>Féminin</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Date de Naissance *</label>
                        <input type="date" name="dateNaissance" required value="<%= donneur.getDateNaissance() %>"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Téléphone *</label>
                        <input type="tel" name="telephone" required value="<%= donneur.getTelephone() %>"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition">
                    </div>
                </div>
            </div>

            <div class="border-b border-gray-200 pb-6">
                <h2 class="text-2xl font-semibold text-gray-800 mb-4 flex items-center">
                    <span class="text-2xl mr-2">🏥</span>
                    Informations Médicales
                </h2>
                <div class="grid md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Groupe Sanguin *</label>
                        <select name="bloodGroup" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition">
                            <option value="">Sélectionner...</option>
                            <%
                                if (bloodGroups != null) {
                                    for (BloodGroup bg : bloodGroups) {
                            %>
                            <option value="<%= bg.name() %>" <%= (donneur != null && bg == donneur.getBloodGroup()) ? "selected" : "" %>>
                                <%= bg.getDisplayName() %>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Statut du Donneur *</label>
                        <select name="donorStatus" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition">
                            <% if (donorStatuses != null) {
                                for (DonorStatus ds : donorStatuses) { %>
                            <option value="<%= ds.name() %>" <%= ds == donneur.getDonorStatus() ? "selected" : "" %>>
                                <%= ds.name() %>
                            </option>
                            <% }
                            } %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Poches Disponibles *</label>
                        <input type="number" name="pocheDisponible" required min="0" value="<%= donneur.getPucheDisponible() %>"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Contre-indication *</label>
                        <select name="contreIndication" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition">
                            <option value="false" <%= !donneur.getContreIndication() ? "selected" : "" %>>Non</option>
                            <option value="true" <%= donneur.getContreIndication() ? "selected" : "" %>>Oui</option>
                        </select>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Notes</label>
                        <textarea name="notes" rows="4"
                                  placeholder="Informations complémentaires..."
                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent transition resize-none"><%= donneur.getNotes() != null ? donneur.getNotes() : "" %></textarea>
                    </div>
                </div>
            </div>

            <div class="flex space-x-4 pt-4">
                <a href="${pageContext.request.contextPath}/donneurs?action=list"
                   class="flex-1 text-center bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-3 px-6 rounded-lg transition shadow-md">
                    Annuler
                </a>
                <button type="submit"
                        class="flex-1 bg-gradient-to-r from-orange-500 to-amber-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-orange-600 hover:to-amber-700 transition shadow-md hover:shadow-lg">
                    Mettre à Jour
                </button>
            </div>
        </form>
    </div>

    <div class="bg-blue-50 border-l-4 border-blue-500 rounded-lg p-6 mt-6 fade-in" style="animation-delay: 0.2s">
        <div class="flex items-start">
            <span class="text-3xl mr-4">💡</span>
            <div>
                <h3 class="text-lg font-bold text-blue-900 mb-2">Conseils de modification</h3>
                <ul class="text-blue-800 text-sm space-y-1">
                    <li>• Vérifiez attentivement toutes les informations avant de valider</li>
                    <li>• Les champs marqués d'un astérisque (*) sont obligatoires</li>
                    <li>• Mettez à jour le nombre de poches disponibles après chaque don</li>
                    <li>• Vérifiez les contre-indications médicales avant d'autoriser un nouveau don</li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>