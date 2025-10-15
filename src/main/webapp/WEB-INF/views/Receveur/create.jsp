<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entities.enums.BloodGroup" %>
<%@ page import="org.example.entities.enums.ReceiverPriority" %>
<%@ page import="org.example.entities.enums.ReceiverState" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Receveur</title>
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
<body class="bg-gradient-to-br from-purple-50 via-white to-pink-50 min-h-screen">
<div class="container mx-auto px-4 py-8 max-w-4xl">
    <!-- Header -->
    <div class="text-center mb-8 fade-in">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-purple-500 to-pink-600 rounded-full mb-4 shadow-lg">
            <span class="text-3xl">🩺</span>
        </div>
        <h1 class="text-4xl font-bold text-gray-900 mb-2 bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
            Ajouter un Nouveau Receveur
        </h1>
        <p class="text-gray-600">Remplissez tous les champs pour enregistrer un nouveau receveur</p>
    </div>

    <!-- Form -->
    <div class="bg-white rounded-2xl shadow-xl p-8 fade-in border border-gray-100" style="animation-delay: 0.1s">
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded">
            <p class="text-red-800"><%= request.getAttribute("errorMessage") %></p>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/receveurs" method="post" class="space-y-6">
            <input type="hidden" name="action" value="create">

            <!-- Informations Personnelles -->
            <div class="border-b border-gray-200 pb-6">
                <h2 class="text-2xl font-semibold text-gray-800 mb-4 flex items-center">
                    <span class="text-2xl mr-2">👤</span>
                    Informations Personnelles
                </h2>
                <div class="grid md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Nom *</label>
                        <input type="text" name="nom" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Prénom *</label>
                        <input type="text" name="prenom" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">CIN *</label>
                        <input type="text" name="cin" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Sexe *</label>
                        <select name="sexe" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition">
                            <option value="">Sélectionner...</option>
                            <option value="M">Masculin</option>
                            <option value="F">Féminin</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Date de Naissance *</label>
                        <input type="date" name="dateNaissance" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Téléphone *</label>
                        <input type="tel" name="telephone" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition">
                    </div>
                </div>
            </div>

            <!-- Informations Médicales -->
            <div class="border-b border-gray-200 pb-6">
                <h2 class="text-2xl font-semibold text-gray-800 mb-4 flex items-center">
                    <span class="text-2xl mr-2">🏥</span>
                    Informations Médicales
                </h2>
                <div class="grid md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Groupe Sanguin *</label>
                        <select name="bloodGroup" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition">
                            <option value="">Sélectionner...</option>
                            <% for (BloodGroup bg : BloodGroup.values()) { %>
                            <option value="<%= bg.name() %>"><%= bg.name() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Besoin en Poches *</label>
                        <input type="number" name="besoinPoches" required min="1"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Priorité *</label>
                        <select name="receiverPriority" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition">
                            <option value="">Sélectionner...</option>
                            <% for (ReceiverPriority rp : ReceiverPriority.values()) { %>
                            <option value="<%= rp.name() %>"><%= rp.name() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">État *</label>
                        <select name="receiverState" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition">
                            <option value="">Sélectionner...</option>
                            <% for (ReceiverState rs : ReceiverState.values()) { %>
                            <option value="<%= rs.name() %>"><%= rs.name() %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Buttons -->
            <div class="flex space-x-4 pt-4">
                <a href="${pageContext.request.contextPath}/receveurs?action=list"
                   class="flex-1 text-center bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-3 px-6 rounded-lg transition shadow-md">
                    Annuler
                </a>
                <button type="submit"
                        class="flex-1 bg-gradient-to-r from-purple-500 to-pink-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-purple-600 hover:to-pink-700 transition shadow-md hover:shadow-lg">
                    Enregistrer le Receveur
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>