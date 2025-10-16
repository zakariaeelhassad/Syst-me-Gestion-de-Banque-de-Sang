<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entities.models.Donneur" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.Period" %>
<%@ page import="java.time.LocalDate" %>
<%
    List<Donneur> donneurs = (List<Donneur>) request.getAttribute("donneurs");
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {
        session.removeAttribute("successMessage");
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Donneurs</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        .fade-in { animation: fadeIn 0.6s ease-out forwards; }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
        .slide-down { animation: slideDown 0.5s ease-out forwards; }
        @keyframes pulse { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.05); } }
        .pulse-animation { animation: pulse 2s infinite; }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 via-white to-cyan-50 min-h-screen">

<div class="container mx-auto px-4 py-8">
    <!-- Header -->
    <div class="text-center mb-8 fade-in">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-blue-500 to-cyan-600 rounded-full mb-4 shadow-lg pulse-animation">
            <span class="text-4xl">🩸</span>
        </div>
        <h1 class="text-5xl font-bold text-gray-900 mb-2 bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent">
            Gestion des Donneurs
        </h1>
        <p class="text-gray-600 text-lg">Liste complète des donneurs de sang</p>
    </div>

    <!-- Success Message -->
    <% if (successMessage != null) { %>
    <div class="max-w-4xl mx-auto mb-6 slide-down">
        <div class="bg-green-50 border-l-4 border-green-500 rounded-lg p-4 shadow-md flex items-center justify-between">
            <div class="flex items-center">
                <span class="text-3xl mr-3">✅</span>
                <p class="text-green-800 font-semibold"><%= successMessage %></p>
            </div>
            <button onclick="this.parentElement.parentElement.remove()"
                    class="text-green-600 hover:text-green-800 font-bold text-xl">
                ×
            </button>
        </div>
    </div>
    <% } %>

    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8 max-w-6xl mx-auto">
        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-blue-500 fade-in" style="animation-delay: 0.1s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Total Donneurs</p>
                    <p class="text-3xl font-bold text-blue-600"><%= donneurs != null ? donneurs.size() : 0 %></p>
                </div>
                <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">👥</span>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-green-500 fade-in" style="animation-delay: 0.2s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Disponible</p>
                    <p class="text-3xl font-bold text-green-600">
                        <%= donneurs != null ? donneurs.stream().filter(d -> "DISPONIBLE".equals(d.getDonorStatus().name())).count() : 0 %>
                    </p>
                </div>
                <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">✅</span>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-red-500 fade-in" style="animation-delay: 0.3s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Poches Totales</p>
                    <p class="text-3xl font-bold text-red-600">
                        <%= donneurs != null ? donneurs.stream().mapToInt(Donneur::getPucheDisponible).sum() : 0 %>
                    </p>
                </div>
                <div class="w-12 h-12 bg-red-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">🩸</span>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-yellow-500 fade-in" style="animation-delay: 0.4s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Contre-indications</p>
                    <p class="text-3xl font-bold text-yellow-600">
                        <%= donneurs != null ? donneurs.stream().filter(Donneur::getContreIndication).count() : 0 %>
                    </p>
                </div>
                <div class="w-12 h-12 bg-yellow-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">⚠️</span>
                </div>
            </div>
        </div>
    </div>

    <div class="max-w-6xl mx-auto mb-6 flex flex-col md:flex-row justify-between items-center gap-4 fade-in" style="animation-delay: 0.5s">
        <div class="flex items-center gap-4 w-full md:w-auto">
            <a href="${pageContext.request.contextPath}/donneurs?action=createForm"
               class="bg-gradient-to-r from-blue-500 to-cyan-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-blue-600 hover:to-cyan-700 transition shadow-lg flex items-center">
                <span class="mr-2 text-xl">➕</span>
                Nouveau Donneur
            </a>
            <a href="${pageContext.request.contextPath}/"
               class="bg-gray-500 hover:bg-gray-600 text-white font-semibold py-3 px-6 rounded-lg transition shadow-lg flex items-center">
                <span class="mr-2 text-xl">🏠</span>
                Home
            </a>
        </div>

    </div>

    <div class="max-w-6xl mx-auto">
        <% if (donneurs == null || donneurs.isEmpty()) { %>
        <div class="bg-white rounded-2xl shadow-xl p-12 text-center fade-in">
            <div class="w-32 h-32 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
                <span class="text-6xl">📋</span>
            </div>
            <h3 class="text-2xl font-bold text-gray-800 mb-2">Aucun donneur trouvé</h3>
            <p class="text-gray-600 mb-6">Commencez par ajouter votre premier donneur</p>
            <a href="${pageContext.request.contextPath}/donneurs?action=createForm"
               class="inline-block bg-gradient-to-r from-blue-500 to-cyan-600 text-white font-semibold py-3 px-8 rounded-lg hover:from-blue-600 hover:to-cyan-700 transition shadow-lg">
                ➕ Ajouter un donneur
            </a>
        </div>
        <% } else { %>

        <div class="hidden md:block bg-white rounded-2xl shadow-xl overflow-hidden fade-in" style="animation-delay: 0.6s">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-gradient-to-r from-blue-500 to-cyan-600 text-white">
                    <tr>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Donneur</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">CIN</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Groupe</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Téléphone</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Âge</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Poches</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Statut</th>
                        <th class="px-6 py-4 text-center text-sm font-bold uppercase tracking-wider">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200" id="donneursTable">
                    <% for (Donneur donneur : donneurs) {
                        int age = Period.between(donneur.getDateNaissance(), LocalDate.now()).getYears();
                    %>
                    <tr class="hover:bg-gray-50 transition donneur-row"
                        data-nom="<%= donneur.getNom().toLowerCase() %>"
                        data-prenom="<%= donneur.getPrenom().toLowerCase() %>"
                        data-cin="<%= donneur.getCin().toLowerCase() %>">
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <div class="w-10 h-10 bg-gradient-to-br from-blue-400 to-cyan-500 rounded-full flex items-center justify-center mr-3">
                                    <span class="text-xl"><%= "M".equals(donneur.getSexe()) ? "👨" : "👩" %></span>
                                </div>
                                <div>
                                    <div class="text-sm font-bold text-gray-900">
                                        <%= donneur.getPrenom() %> <%= donneur.getNom() %>
                                    </div>
                                    <div class="text-xs text-gray-500"><%= donneur.getSexe().equals("M") ? "Masculin" : "Féminin" %></div>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <%= donneur.getCin() %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-3 py-1 bg-red-100 text-red-800 rounded-full text-sm font-bold">
                                    <%= donneur.getBloodGroup() %>
                                </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <%= donneur.getTelephone() %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <%= age %> ans
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-3 py-1 <%= donneur.getPucheDisponible() > 0 ? "bg-green-100 text-green-800" : "bg-gray-100 text-gray-800" %> rounded-full text-sm font-bold">
                                    🩸 <%= donneur.getPucheDisponible() %>
                                </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-3 py-1 <%=
                                    donneur.getDonorStatus().name().equals("ACTIVE") ? "bg-green-100 text-green-800" :
                                    donneur.getDonorStatus().name().equals("INACTIVE") ? "bg-gray-100 text-gray-800" :
                                    donneur.getDonorStatus().name().equals("TEMPORARY_UNAVAILABLE") ? "bg-yellow-100 text-yellow-800" :
                                    "bg-red-100 text-red-800"
                                %> rounded-full text-xs font-bold">
                                    <%= donneur.getDonorStatus() %>
                                </span>
                            <% if (donneur.getContreIndication()) { %>
                            <span class="ml-1 text-red-500" title="Contre-indication">⚠️</span>
                            <% } %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center">
                            <div class="flex items-center justify-center space-x-2">
                                <a href="${pageContext.request.contextPath}/donneurs/<%= donneur.getId() %>"
                                   class="bg-blue-500 hover:bg-blue-600 text-white p-2 rounded-lg transition shadow-md"
                                   title="Détails">
                                    <span>👁️</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/donneurs?action=update&id=<%= donneur.getId() %>"
                                   class="bg-orange-500 hover:bg-orange-600 text-white p-2 rounded-lg transition shadow-md"
                                   title="Modifier">
                                    <span>✏️</span>
                                </a>
                                <button onclick="confirmDelete('<%= donneur.getId() %>', '<%= donneur.getPrenom() %> <%= donneur.getNom() %>')"
                                        class="bg-red-500 hover:bg-red-600 text-white p-2 rounded-lg transition shadow-md"
                                        title="Supprimer">
                                    <span>🗑️</span>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="md:hidden space-y-4" id="donneursCards">
            <% for (Donneur donneur : donneurs) {
                int age = Period.between(donneur.getDateNaissance(), LocalDate.now()).getYears();
            %>
            <div class="bg-white rounded-xl shadow-lg p-6 fade-in border-l-4 <%=
                donneur.getDonorStatus().name().equals("ACTIVE") ? "border-green-500" :
                donneur.getDonorStatus().name().equals("INACTIVE") ? "border-gray-500" :
                "border-yellow-500"
            %> donneur-card"
                 data-nom="<%= donneur.getNom().toLowerCase() %>"
                 data-prenom="<%= donneur.getPrenom().toLowerCase() %>"
                 data-cin="<%= donneur.getCin().toLowerCase() %>">

                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-gradient-to-br from-blue-400 to-cyan-500 rounded-full flex items-center justify-center mr-3">
                            <span class="text-2xl"><%= "M".equals(donneur.getSexe()) ? "👨" : "👩" %></span>
                        </div>
                        <div>
                            <h3 class="font-bold text-lg text-gray-900">
                                <%= donneur.getPrenom() %> <%= donneur.getNom() %>
                            </h3>
                            <p class="text-xs text-gray-500">#<%= donneur.getId() %> • <%= donneur.getCin() %></p>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-red-100 text-red-800 rounded-full text-sm font-bold">
                        <%= donneur.getBloodGroup() %>
                    </span>
                </div>

                <div class="grid grid-cols-2 gap-3 mb-4">
                    <div class="bg-gray-50 rounded-lg p-3">
                        <p class="text-xs text-gray-500">Âge</p>
                        <p class="font-bold text-gray-900"><%= age %> ans</p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-3">
                        <p class="text-xs text-gray-500">Poches</p>
                        <p class="font-bold text-gray-900">🩸 <%= donneur.getPucheDisponible() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-3">
                        <p class="text-xs text-gray-500">Téléphone</p>
                        <p class="font-bold text-gray-900 text-sm"><%= donneur.getTelephone() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-3">
                        <p class="text-xs text-gray-500">Statut</p>
                        <span class="inline-block px-2 py-1 <%=
                            donneur.getDonorStatus().name().equals("ACTIVE") ? "bg-green-100 text-green-800" :
                            "bg-gray-100 text-gray-800"
                        %> rounded-full text-xs font-bold">
                            <%= donneur.getDonorStatus() %>
                        </span>
                    </div>
                </div>

                <% if (donneur.getContreIndication()) { %>
                <div class="bg-red-50 border-l-2 border-red-500 rounded p-2 mb-4">
                    <p class="text-xs text-red-700 font-semibold">⚠️ Contre-indication</p>
                </div>
                <% } %>

                <div class="flex gap-2">
                    <a href="${pageContext.request.contextPath}/donneurs/<%= donneur.getId() %>"
                       class="flex-1 bg-blue-500 hover:bg-blue-600 text-white text-center py-2 rounded-lg transition font-semibold">
                        👁️ Voir
                    </a>
                    <a href="${pageContext.request.contextPath}/donneurs?action=update&id=<%= donneur.getId() %>"
                       class="flex-1 bg-orange-500 hover:bg-orange-600 text-white text-center py-2 rounded-lg transition font-semibold">
                        ✏️ Modifier
                    </a>
                    <button onclick="confirmDelete('<%= donneur.getId() %>', '<%= donneur.getPrenom() %> <%= donneur.getNom() %>')"
                            class="flex-1 bg-red-500 hover:bg-red-600 text-white py-2 rounded-lg transition font-semibold">
                        🗑️
                    </button>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
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