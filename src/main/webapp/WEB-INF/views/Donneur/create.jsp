<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entities.enums.BloodGroup" %>
<%@ page import="org.example.entities.enums.DonorStatus" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Donneur</title>
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
<body class="bg-gradient-to-br from-green-50 via-white to-emerald-50 min-h-screen">
<div class="container mx-auto px-4 py-8 max-w-4xl">
    <div class="text-center mb-8 fade-in">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-green-500 to-emerald-600 rounded-full mb-4 shadow-lg">
            <span class="text-3xl">🩸</span>
        </div>
        <h1 class="text-4xl font-bold text-gray-900 mb-2 bg-gradient-to-r from-green-600 to-emerald-600 bg-clip-text text-transparent">
            Ajouter un Nouveau Donneur
        </h1>
        <p class="text-gray-600">Remplissez tous les champs pour enregistrer un nouveau donneur</p>
    </div>

    <div class="bg-white rounded-2xl shadow-xl p-8 fade-in border border-gray-100" style="animation-delay: 0.1s">
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded">
            <p class="text-red-800 font-semibold"><%= request.getAttribute("errorMessage") %></p>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/donneurs" method="post" class="space-y-6">
            <input type="hidden" name="action" value="create">

            <div class="border-b border-gray-200 pb-6">
                <h2 class="text-2xl font-semibold text-gray-800 mb-4 flex items-center">
                    <span class="text-2xl mr-2">👤</span>
                    Informations Personnelles
                </h2>
                <div class="grid md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Nom *</label>
                        <input type="text" name="nom"
                               value="<%= request.getParameter("nom") != null ? request.getParameter("nom") : "" %>"
                               required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Prénom *</label>
                        <input type="text" name="prenom"
                               value="<%= request.getParameter("prenom") != null ? request.getParameter("prenom") : "" %>"
                               required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">CIN *</label>
                        <input type="text" name="cin"
                               value="<%= request.getParameter("cin") != null ? request.getParameter("cin") : "" %>"
                               required
                               placeholder="Ex : AB112233"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Sexe *</label>
                        <select name="sexe" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition">
                            <option value="">Sélectionner...</option>
                            <option value="M" <%= "M".equals(request.getParameter("sexe")) ? "selected" : "" %>>Masculin</option>
                            <option value="F" <%= "F".equals(request.getParameter("sexe")) ? "selected" : "" %>>Féminin</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Date de Naissance *</label>
                        <input type="date" name="dateNaissance"
                               value="<%= request.getParameter("dateNaissance") != null ? request.getParameter("dateNaissance") : "" %>"
                               required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Téléphone *</label>
                        <input type="tel" name="telephone"
                               value="<%= request.getParameter("telephone") != null ? request.getParameter("telephone") : "" %>"
                               required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition">
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
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition">
                            <option value="">Sélectionner...</option>
                            <%
                                BloodGroup[] bloodGroups = BloodGroup.values();
                                for (BloodGroup bg : bloodGroups) {
                                    String selected = bg.name().equalsIgnoreCase(request.getParameter("bloodGroup")) ? "selected" : "";
                            %>
                            <option value="<%= bg.name() %>" <%= selected %>><%= bg.getDisplayName() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Statut du Donneur *</label>
                        <select name="donorStatus" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition">
                            <option value="">Sélectionner...</option>
                            <%
                                DonorStatus[] donorStatuses = (DonorStatus[]) request.getAttribute("donorStatuses");
                                if (donorStatuses != null) {
                                    for (DonorStatus ds : donorStatuses) {
                                        String selected = ds.name().equalsIgnoreCase(request.getParameter("donorStatus")) ? "selected" : "";
                            %>
                            <option value="<%= ds.name() %>" <%= selected %>><%= ds.name() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Poches Disponibles *</label>
                        <input type="number" name="pocheDisponible"
                               value="<%= request.getParameter("pocheDisponible") != null ? request.getParameter("pocheDisponible") : "0" %>"
                               required min="0"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Contre-indication *</label>
                        <select name="contreIndication" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition">
                            <option value="false" <%= "false".equals(request.getParameter("contreIndication")) ? "selected" : "" %>>Non</option>
                            <option value="true" <%= "true".equals(request.getParameter("contreIndication")) ? "selected" : "" %>>Oui</option>
                        </select>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Notes</label>
                        <textarea name="notes" rows="4"
                                  placeholder="Informations complémentaires..."
                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition resize-none"><%= request.getParameter("notes") != null ? request.getParameter("notes") : "" %></textarea>
                    </div>
                </div>
            </div>

            <div class="flex space-x-4 pt-4">
                <a href="${pageContext.request.contextPath}/donneurs?action=list"
                   class="flex-1 text-center bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-3 px-6 rounded-lg transition shadow-md">
                    Annuler
                </a>
                <button type="submit"
                        class="flex-1 bg-gradient-to-r from-green-500 to-emerald-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-green-600 hover:to-emerald-700 transition shadow-md hover:shadow-lg">
                    Enregistrer le Donneur
                </button>
            </div>
        </form>
    </div>

    <div class="bg-blue-50 border-l-4 border-blue-500 rounded-lg p-6 mt-6 fade-in" style="animation-delay: 0.2s">
        <div class="flex items-start">
            <span class="text-3xl mr-4">💡</span>
            <div>
                <h3 class="text-lg font-bold text-blue-900 mb-2">Informations importantes</h3>
                <ul class="text-blue-800 text-sm space-y-1">
                    <li>• Vérifiez que toutes les informations sont exactes avant validation</li>
                    <li>• Les champs marqués d'un astérisque (*) sont obligatoires</li>
                    <li>• Le CIN doit comporter 2 lettres suivies de 6 chiffres (ex : AB445577)</li>
                    <li>• L'âge du donneur doit être entre 18 et 65 ans</li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
