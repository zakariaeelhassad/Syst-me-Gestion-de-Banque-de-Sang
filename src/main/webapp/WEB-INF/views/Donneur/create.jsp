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
            <p class="text-red-800"><%= request.getAttribute("errorMessage") %></p>
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
                        <input type="text" name="nom" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Prénom *</label>
                        <input type="text" name="prenom" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">CIN *</label>
                        <input type="text" name="cin" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Sexe *</label>
                        <select name="sexe" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition">
                            <option value="">Sélectionner...</option>
                            <option value="M">Masculin</option>
                            <option value="F">Féminin</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Date de Naissance *</label>
                        <input type="date" name="dateNaissance" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Téléphone *</label>
                        <input type="tel" name="telephone" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition">
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
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition">
                            <option value="">Sélectionner...</option>
                            <%
                                BloodGroup[] bloodGroups = (BloodGroup[]) request.getAttribute("bloodGroups");
                                if (bloodGroups != null) {
                                    for (BloodGroup bg : bloodGroups) {
                            %>
                            <option value="<%= bg.name() %>"><%= bg.name() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Statut du Donneur *</label>
                        <select name="donorStatus" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition">
                            <option value="">Sélectionner...</option>
                            <%
                                DonorStatus[] donorStatuses = (DonorStatus[]) request.getAttribute("donorStatuses");
                                if (donorStatuses != null) {
                                    for (DonorStatus ds : donorStatuses) {
                            %>
                            <option value="<%= ds.name() %>"><%= ds.name() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Poches Disponibles *</label>
                        <input type="number" name="pocheDisponible" required min="0" value="0"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Contre-indication *</label>
                        <select name="contreIndication" required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition">
                            <option value="false">Non</option>
                            <option value="true">Oui</option>
                        </select>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Notes</label>
                        <textarea name="notes" rows="4"
                                  placeholder="Informations complémentaires..."
                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition resize-none"></textarea>
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
                    <li>• Assurez-vous que le donneur n'a aucune contre-indication médicale</li>
                    <li>• Le nombre de poches disponibles peut être modifié ultérieurement</li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>