<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entities.models.Receveur" %>
<%@ page import="java.time.Period" %>
<%@ page import="java.time.LocalDate" %>
<%
    Receveur receveur = (Receveur) request.getAttribute("receveurs");
    int age = receveur != null ? Period.between(receveur.getDateNaissance(), LocalDate.now()).getYears() : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du Receveur</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        .pulse-animation {
            animation: pulse 2s infinite;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-indigo-50 via-white to-purple-50 min-h-screen">
<div class="container mx-auto px-4 py-8 max-w-5xl">
    <div class="text-center mb-8 fade-in">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-full mb-4 shadow-lg pulse-animation">
            <span class="text-4xl">🩺</span>
        </div>
        <h1 class="text-4xl font-bold text-gray-900 mb-2 bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">
            Détails du Receveur
        </h1>
        <p class="text-gray-600">Informations complètes du receveur #<%= receveur.getId() %></p>
    </div>

    <div class="flex justify-center space-x-4 mb-8 fade-in" style="animation-delay: 0.1s">
        <a href="${pageContext.request.contextPath}/receveurs?action=list"
           class="bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-2 px-6 rounded-lg transition shadow-md flex items-center">
            <span class="mr-2">←</span> Retour à la liste
        </a>
        <a href="${pageContext.request.contextPath}/receveurs?action=update&id=<%= receveur.getId() %>"
           class="bg-gradient-to-r from-orange-500 to-orange-600 text-white font-semibold py-2 px-6 rounded-lg hover:from-orange-600 hover:to-orange-700 transition shadow-md flex items-center">
            <span class="mr-2">✏️</span> Modifier
        </a>
        <button onclick="confirmDelete()"
                class="bg-gradient-to-r from-red-500 to-red-600 text-white font-semibold py-2 px-6 rounded-lg hover:from-red-600 hover:to-red-700 transition shadow-md flex items-center">
            <span class="mr-2">🗑️</span> Supprimer
        </button>
    </div>

    <div class="grid md:grid-cols-3 gap-6">
        <div class="md:col-span-1">
            <div class="bg-white rounded-2xl shadow-xl p-8 text-center fade-in border border-gray-100" style="animation-delay: 0.2s">
                <div class="w-24 h-24 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-full flex items-center justify-center mx-auto mb-4 shadow-lg">
                    <span class="text-5xl"><%= "M".equals(receveur.getSexe()) ? "👨" : "👩" %></span>
                </div>
                <h2 class="text-2xl font-bold text-gray-900 mb-1">
                    <%= receveur.getPrenom() %> <%= receveur.getNom() %>
                </h2>
                <p class="text-gray-500 mb-4">ID: #<%= receveur.getId() %></p>

                <div class="space-y-3 mb-6">
                    <div class="bg-red-50 border-2 border-red-200 rounded-lg p-3">
                        <p class="text-sm text-gray-600 mb-1">Groupe Sanguin</p>
                        <p class="text-3xl font-bold text-red-600"><%= receveur.getBloodGroup() %></p>
                    </div>
                    <div class="bg-purple-50 border-2 border-purple-200 rounded-lg p-3">
                        <p class="text-sm text-gray-600 mb-1">Besoin en Poches</p>
                        <p class="text-3xl font-bold text-purple-600">🩸 <%= receveur.getBesoinPoches() %></p>
                    </div>
                </div>

                <div class="mb-4">
                    <span class="inline-block px-4 py-2 <%=
                        receveur.getReceiverPriority().name().equals("URGENT") ? "bg-red-500" :
                        receveur.getReceiverPriority().name().equals("HIGH") ? "bg-orange-500" :
                        receveur.getReceiverPriority().name().equals("MEDIUM") ? "bg-yellow-500" :
                        "bg-green-500"
                    %> text-white rounded-full font-bold text-sm shadow-lg">
                        ⚠️ <%= receveur.getReceiverPriority() %>
                    </span>
                </div>

                <div>
                    <span class="inline-block px-4 py-2 <%=
                        receveur.getReceiverState().name().equals("WAITING") ? "bg-yellow-100 text-yellow-800 border border-yellow-300" :
                        receveur.getReceiverState().name().equals("IN_PROGRESS") ? "bg-blue-100 text-blue-800 border border-blue-300" :
                        receveur.getReceiverState().name().equals("COMPLETED") ? "bg-green-100 text-green-800 border border-green-300" :
                        "bg-gray-100 text-gray-800 border border-gray-300"
                    %> rounded-full font-semibold text-sm">
                        <%= receveur.getReceiverState() %>
                    </span>
                </div>
            </div>

            <div class="bg-gradient-to-br from-indigo-500 to-purple-600 rounded-2xl shadow-xl p-6 mt-6 text-white fade-in" style="animation-delay: 0.3s">
                <h3 class="text-xl font-bold mb-4 flex items-center">
                    <span class="mr-2">📊</span>
                    Statistiques Rapides
                </h3>
                <div class="space-y-3">
                    <div class="bg-white bg-opacity-20 rounded-lg p-3 backdrop-blur-sm">
                        <p class="text-sm text-white text-opacity-90">Âge</p>
                        <p class="text-2xl font-bold"><%= age %> ans</p>
                    </div>
                    <div class="bg-white bg-opacity-20 rounded-lg p-3 backdrop-blur-sm">
                        <p class="text-sm text-white text-opacity-90">Sexe</p>
                        <p class="text-xl font-bold"><%= "M".equals(receveur.getSexe()) ? "Masculin" : "Féminin" %></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="md:col-span-2 space-y-6">
            <div class="bg-white rounded-2xl shadow-xl p-8 fade-in border border-gray-100" style="animation-delay: 0.25s">
                <h3 class="text-2xl font-bold text-gray-900 mb-6 flex items-center border-b border-gray-200 pb-4">
                    <span class="text-3xl mr-3">👤</span>
                    Informations Personnelles
                </h3>
                <div class="grid md:grid-cols-2 gap-6">
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">Prénom</p>
                        <p class="text-lg font-semibold text-gray-900"><%= receveur.getPrenom() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">Nom</p>
                        <p class="text-lg font-semibold text-gray-900"><%= receveur.getNom() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">CIN</p>
                        <p class="text-lg font-semibold text-gray-900"><%= receveur.getCin() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">Date de Naissance</p>
                        <p class="text-lg font-semibold text-gray-900"><%= receveur.getDateNaissance() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">Téléphone</p>
                        <p class="text-lg font-semibold text-gray-900"><%= receveur.getTelephone() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">Sexe</p>
                        <p class="text-lg font-semibold text-gray-900">
                            <%= "M".equals(receveur.getSexe()) ? "Masculin" : "Féminin" %>
                        </p>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-2xl shadow-xl p-8 fade-in border border-gray-100" style="animation-delay: 0.3s">
                <h3 class="text-2xl font-bold text-gray-900 mb-6 flex items-center border-b border-gray-200 pb-4">
                    <span class="text-3xl mr-3">🏥</span>
                    Informations Médicales
                </h3>
                <div class="grid md:grid-cols-2 gap-6">
                    <div class="bg-red-50 rounded-lg p-6 border-2 border-red-200">
                        <p class="text-sm text-gray-600 mb-2 font-medium">Groupe Sanguin</p>
                        <p class="text-3xl font-bold text-red-600"><%= receveur.getBloodGroup() %></p>
                    </div>
                    <div class="bg-purple-50 rounded-lg p-6 border-2 border-purple-200">
                        <p class="text-sm text-gray-600 mb-2 font-medium">Besoin en Poches</p>
                        <p class="text-3xl font-bold text-purple-600">🩸 <%= receveur.getBesoinPoches() %></p>
                    </div>
                    <div class="bg-orange-50 rounded-lg p-6 border-2 border-orange-200">
                        <p class="text-sm text-gray-600 mb-2 font-medium">Priorité</p>
                        <p class="text-2xl font-bold <%=
                            receveur.getReceiverPriority().name().equals("URGENT") ? "text-red-600" :
                            receveur.getReceiverPriority().name().equals("HIGH") ? "text-orange-600" :
                            receveur.getReceiverPriority().name().equals("MEDIUM") ? "text-yellow-600" :
                            "text-green-600"
                        %>">
                            <%= receveur.getReceiverPriority() %>
                        </p>
                    </div>
                    <div class="bg-blue-50 rounded-lg p-6 border-2 border-blue-200">
                        <p class="text-sm text-gray-600 mb-2 font-medium">État Actuel</p>
                        <p class="text-2xl font-bold <%=
                            receveur.getReceiverState().name().equals("WAITING") ? "text-yellow-600" :
                            receveur.getReceiverState().name().equals("IN_PROGRESS") ? "text-blue-600" :
                            receveur.getReceiverState().name().equals("COMPLETED") ? "text-green-600" :
                            "text-gray-600"
                        %>">
                            <%= receveur.getReceiverState() %>
                        </p>
                    </div>
                </div>
            </div>

            <% if (receveur.getReceiverPriority().name().equals("URGENT")) { %>
            <div class="bg-red-50 border-l-4 border-red-500 rounded-lg p-6 fade-in" style="animation-delay: 0.35s">
                <div class="flex items-start">
                    <span class="text-4xl mr-4">🚨</span>
                    <div>
                        <h4 class="text-xl font-bold text-red-800 mb-2">Priorité URGENTE</h4>
                        <p class="text-red-700">Ce receveur nécessite une attention immédiate. Veuillez traiter cette demande en priorité absolue.</p>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>

<div id="deleteModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-2xl p-8 max-w-md w-full mx-4">
        <div class="text-center mb-6">
            <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <span class="text-5xl">⚠️</span>
            </div>
            <h3 class="text-2xl font-bold text-gray-900 mb-2">Confirmer la suppression</h3>
            <p class="text-gray-600">Êtes-vous sûr de vouloir supprimer :</p>
            <p class="text-red-600 font-semibold text-xl mt-2">
                <%= receveur.getNom() %> <%= receveur.getPrenom() %>
            </p>
        </div>
        <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4 mb-6">
            <p class="text-sm text-yellow-800">⚠️ Cette action est irréversible</p>
        </div>
        <form method="post" action="${pageContext.request.contextPath}/receveurs">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="id" value="<%= receveur.getId() %>"/>
            <div class="flex space-x-4">
                <button type="button" onclick="closeDeleteModal()"
                        class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-3 px-6 rounded-lg transition">
                    Annuler
                </button>
                <button type="submit"
                        class="flex-1 bg-gradient-to-r from-red-500 to-red-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-red-600 hover:to-red-700 transition shadow-md">
                    Supprimer
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function confirmDelete() {
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }

    document.getElementById('deleteModal').addEventListener('click', function(e) {
        if (e.target === this) closeDeleteModal();
    });

    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closeDeleteModal();
    });
</script>
</body>
</html>
