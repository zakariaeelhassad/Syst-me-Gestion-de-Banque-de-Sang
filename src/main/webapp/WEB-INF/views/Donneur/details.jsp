<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entities.models.Donneur" %>
<%@ page import="java.time.Period" %>
<%@ page import="java.time.LocalDate" %>
<%
    Donneur donneur = (Donneur) request.getAttribute("donneur");
    int age = donneur != null ? Period.between(donneur.getDateNaissance(), LocalDate.now()).getYears() : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du Donneur</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        .fade-in { animation: fadeIn 0.6s ease-out forwards; }
        @keyframes pulse { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.05); } }
        .pulse-animation { animation: pulse 2s infinite; }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 via-white to-cyan-50 min-h-screen">
<div class="container mx-auto px-4 py-8 max-w-5xl">
    <!-- Header -->
    <div class="text-center mb-8 fade-in">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-blue-500 to-cyan-600 rounded-full mb-4 shadow-lg pulse-animation">
            <span class="text-4xl">🩸</span>
        </div>
        <h1 class="text-4xl font-bold text-gray-900 mb-2 bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent">
            Détails du Donneur
        </h1>
        <p class="text-gray-600">Informations complètes du donneur #<%= donneur.getId() %></p>
    </div>

    <!-- Quick Actions -->
    <div class="flex justify-center space-x-4 mb-8 fade-in" style="animation-delay: 0.1s">
        <a href="${pageContext.request.contextPath}/donneurs?action=list"
           class="bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-2 px-6 rounded-lg transition shadow-md flex items-center">
            <span class="mr-2">←</span> Retour à la liste
        </a>
        <a href="${pageContext.request.contextPath}/donneurs?action=update&id=<%= donneur.getId() %>"
           class="bg-gradient-to-r from-orange-500 to-orange-600 text-white font-semibold py-2 px-6 rounded-lg hover:from-orange-600 hover:to-orange-700 transition shadow-md flex items-center">
            <span class="mr-2">✏️</span> Modifier
        </a>
        <button onclick="confirmDelete('<%= donneur.getId() %>', '<%= donneur.getPrenom() %> <%= donneur.getNom() %>')"
                class="bg-gradient-to-r from-red-500 to-red-600 text-white font-semibold py-2 px-6 rounded-lg hover:from-red-600 hover:to-red-700 transition shadow-md flex items-center">
            <span class="mr-2">🗑️</span> Supprimer
        </button>
    </div>

    <!-- Main Content -->
    <div class="grid md:grid-cols-3 gap-6">
        <!-- Left Column - Profile Summary -->
        <div class="md:col-span-1">
            <!-- Profile Card -->
            <div class="bg-white rounded-2xl shadow-xl p-8 text-center fade-in border border-gray-100" style="animation-delay: 0.2s">
                <div class="w-24 h-24 bg-gradient-to-br from-blue-500 to-cyan-600 rounded-full flex items-center justify-center mx-auto mb-4 shadow-lg">
                    <span class="text-5xl"><%= "M".equals(donneur.getSexe()) ? "👨" : "👩" %></span>
                </div>
                <h2 class="text-2xl font-bold text-gray-900 mb-1">
                    <%= donneur.getPrenom() %> <%= donneur.getNom() %>
                </h2>
                <p class="text-gray-500 mb-4">ID: #<%= donneur.getId() %></p>

                <div class="space-y-3 mb-6">
                    <div class="bg-red-50 border-2 border-red-200 rounded-lg p-3">
                        <p class="text-sm text-gray-600 mb-1">Groupe Sanguin</p>
                        <p class="text-3xl font-bold text-red-600"><%= donneur.getBloodGroup() %></p>
                    </div>
                    <div class="bg-green-50 border-2 border-green-200 rounded-lg p-3">
                        <p class="text-sm text-gray-600 mb-1">Poches Disponibles</p>
                        <p class="text-3xl font-bold text-green-600">🩸 <%= donneur.getPucheDisponible() %></p>
                    </div>
                </div>

                <!-- Status Badge -->
                <div class="mb-4">
                    <span class="inline-block px-4 py-2 <%=
                        donneur.getDonorStatus().name().equals("ACTIVE") ? "bg-green-500" :
                        donneur.getDonorStatus().name().equals("INACTIVE") ? "bg-gray-500" :
                        donneur.getDonorStatus().name().equals("TEMPORARY_UNAVAILABLE") ? "bg-yellow-500" :
                        "bg-red-500"
                    %> text-white rounded-full font-bold text-sm shadow-lg">
                        <%= donneur.getDonorStatus() %>
                    </span>
                </div>

                <!-- Contre-indication Badge -->
                <div>
                    <span class="inline-block px-4 py-2 <%=
                        donneur.getContreIndication() ? "bg-red-100 text-red-800 border border-red-300" : "bg-green-100 text-green-800 border border-green-300"
                    %> rounded-full font-semibold text-sm">
                        <%= donneur.getContreIndication() ? "⚠️ Contre-indication" : "✅ Apte au don" %>
                    </span>
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="bg-gradient-to-br from-blue-500 to-cyan-600 rounded-2xl shadow-xl p-6 mt-6 text-white fade-in" style="animation-delay: 0.3s">
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
                        <p class="text-xl font-bold"><%= "M".equals(donneur.getSexe()) ? "Masculin" : "Féminin" %></p>
                    </div>
                    <div class="bg-white bg-opacity-20 rounded-lg p-3 backdrop-blur-sm">
                        <p class="text-sm text-white text-opacity-90">Poches</p>
                        <p class="text-xl font-bold"><%= donneur.getPucheDisponible() %> disponible(s)</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column - Detailed Information -->
        <div class="md:col-span-2 space-y-6">
            <!-- Personal Information -->
            <div class="bg-white rounded-2xl shadow-xl p-8 fade-in border border-gray-100" style="animation-delay: 0.25s">
                <h3 class="text-2xl font-bold text-gray-900 mb-6 flex items-center border-b border-gray-200 pb-4">
                    <span class="text-3xl mr-3">👤</span>
                    Informations Personnelles
                </h3>
                <div class="grid md:grid-cols-2 gap-6">
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">Prénom</p>
                        <p class="text-lg font-semibold text-gray-900"><%= donneur.getPrenom() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">Nom</p>
                        <p class="text-lg font-semibold text-gray-900"><%= donneur.getNom() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">CIN</p>
                        <p class="text-lg font-semibold text-gray-900"><%= donneur.getCin() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">Date de Naissance</p>
                        <p class="text-lg font-semibold text-gray-900"><%= donneur.getDateNaissance() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">Téléphone</p>
                        <p class="text-lg font-semibold text-gray-900"><%= donneur.getTelephone() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <p class="text-sm text-gray-500 mb-1 font-medium">Sexe</p>
                        <p class="text-lg font-semibold text-gray-900">
                            <%= "M".equals(donneur.getSexe()) ? "Masculin" : "Féminin" %>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Medical Information -->
            <div class="bg-white rounded-2xl shadow-xl p-8 fade-in border border-gray-100" style="animation-delay: 0.3s">
                <h3 class="text-2xl font-bold text-gray-900 mb-6 flex items-center border-b border-gray-200 pb-4">
                    <span class="text-3xl mr-3">🏥</span>
                    Informations Médicales
                </h3>
                <div class="grid md:grid-cols-2 gap-6">
                    <div class="bg-red-50 rounded-lg p-6 border-2 border-red-200">
                        <p class="text-sm text-gray-600 mb-2 font-medium">Groupe Sanguin</p>
                        <p class="text-3xl font-bold text-red-600"><%= donneur.getBloodGroup() %></p>
                    </div>
                    <div class="bg-green-50 rounded-lg p-6 border-2 border-green-200">
                        <p class="text-sm text-gray-600 mb-2 font-medium">Poches Disponibles</p>
                        <p class="text-3xl font-bold text-green-600">🩸 <%= donneur.getPucheDisponible() %></p>
                    </div>
                    <div class="bg-blue-50 rounded-lg p-6 border-2 border-blue-200">
                        <p class="text-sm text-gray-600 mb-2 font-medium">Statut du Donneur</p>
                        <p class="text-xl font-bold <%=
                            donneur.getDonorStatus().name().equals("ACTIVE") ? "text-green-600" :
                            donneur.getDonorStatus().name().equals("INACTIVE") ? "text-gray-600" :
                            donneur.getDonorStatus().name().equals("TEMPORARY_UNAVAILABLE") ? "text-yellow-600" :
                            "text-red-600"
                        %>">
                            <%= donneur.getDonorStatus() %>
                        </p>
                    </div>
                    <div class="bg-<%= donneur.getContreIndication() ? "red" : "green" %>-50 rounded-lg p-6 border-2 border-<%= donneur.getContreIndication() ? "red" : "green" %>-200">
                        <p class="text-sm text-gray-600 mb-2 font-medium">Contre-indication</p>
                        <p class="text-xl font-bold text-<%= donneur.getContreIndication() ? "red" : "green" %>-600">
                            <%= donneur.getContreIndication() ? "⚠️ Oui" : "✅ Non" %>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Notes Section -->
            <% if (donneur.getNotes() != null && !donneur.getNotes().trim().isEmpty()) { %>
            <div class="bg-white rounded-2xl shadow-xl p-8 fade-in border border-gray-100" style="animation-delay: 0.35s">
                <h3 class="text-2xl font-bold text-gray-900 mb-4 flex items-center border-b border-gray-200 pb-4">
                    <span class="text-3xl mr-3">📝</span>
                    Notes
                </h3>
                <div class="bg-yellow-50 border-l-4 border-yellow-400 rounded-lg p-6">
                    <p class="text-gray-800 whitespace-pre-wrap"><%= donneur.getNotes() %></p>
                </div>
            </div>
            <% } %>

            <!-- Alert/Warning Section -->
            <% if (donneur.getContreIndication()) { %>
            <div class="bg-red-50 border-l-4 border-red-500 rounded-lg p-6 fade-in" style="animation-delay: 0.4s">
                <div class="flex items-start">
                    <span class="text-4xl mr-4">⚠️</span>
                    <div>
                        <h4 class="text-xl font-bold text-red-800 mb-2">Attention : Contre-indication</h4>
                        <p class="text-red-700">Ce donneur présente une contre-indication médicale. Veuillez consulter les notes avant d'autoriser tout don de sang.</p>
                    </div>
                </div>
            </div>
            <% } %>

            <% if (donneur.getPucheDisponible() == 0) { %>
            <div class="bg-orange-50 border-l-4 border-orange-500 rounded-lg p-6 fade-in" style="animation-delay: 0.4s">
                <div class="flex items-start">
                    <span class="text-4xl mr-4">📦</span>
                    <div>
                        <h4 class="text-xl font-bold text-orange-800 mb-2">Stock vide</h4>
                        <p class="text-orange-700">Ce donneur n'a actuellement aucune poche de sang disponible.</p>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>

<!-- Modal de Confirmation de Suppression -->
<div id="deleteModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-2xl p-8 max-w-md w-full mx-4">
        <div class="text-center mb-6">
            <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <span class="text-5xl">⚠️</span>
            </div>
            <h3 class="text-2xl font-bold text-gray-900 mb-2">Confirmer la suppression</h3>
            <p class="text-gray-600">Êtes-vous sûr de vouloir supprimer :</p>
            <p id="deleteNameDisplay" class="text-red-600 font-semibold text-xl mt-2"></p>
        </div>
        <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4 mb-6">
            <p class="text-sm text-yellow-800">⚠️ Cette action est irréversible</p>
        </div>
        <form method="post" action="${pageContext.request.contextPath}/donneurs">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" id="deleteIdHidden" name="id" value=""/>
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
    function confirmDelete(id, name) {
        document.getElementById('deleteNameDisplay').textContent = name + ' (ID: #' + id + ')';
        document.getElementById('deleteIdHidden').value = id;
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }

    document.getElementById('deleteModal').addEventListener('click', function(e) {
        if(e.target === this) closeDeleteModal();
    });

    document.addEventListener('keydown', function(e) {
        if(e.key === 'Escape') closeDeleteModal();
    });
</script>

</body>
</html>