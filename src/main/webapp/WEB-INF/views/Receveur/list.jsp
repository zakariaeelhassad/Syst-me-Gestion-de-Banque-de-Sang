<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entities.models.Receveur" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.Period" %>
<%@ page import="java.time.LocalDate" %>
<%
    List<Receveur> receveurs = (List<Receveur>) request.getAttribute("Receveurs");
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
    <title>Liste des Receveurs</title>
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
<body class="bg-gradient-to-br from-purple-50 via-white to-pink-50 min-h-screen">

<div class="container mx-auto px-4 py-8">
    <!-- Header -->
    <div class="text-center mb-8 fade-in">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-purple-500 to-pink-600 rounded-full mb-4 shadow-lg pulse-animation">
            <span class="text-4xl">🏥</span>
        </div>
        <h1 class="text-5xl font-bold text-gray-900 mb-2 bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
            Gestion des Receveurs
        </h1>
        <p class="text-gray-600 text-lg">Liste complète des receveurs de sang</p>
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

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8 max-w-6xl mx-auto">
        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-purple-500 fade-in" style="animation-delay: 0.1s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Total Receveurs</p>
                    <p class="text-3xl font-bold text-purple-600"><%= receveurs != null ? receveurs.size() : 0 %></p>
                </div>
                <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">👥</span>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-red-500 fade-in" style="animation-delay: 0.2s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Urgents</p>
                    <p class="text-3xl font-bold text-red-600">
                        <%= receveurs != null ? receveurs.stream().filter(r -> "URGENT".equals(r.getReceiverPriority().name())).count() : 0 %>
                    </p>
                </div>
                <div class="w-12 h-12 bg-red-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">🚨</span>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-blue-500 fade-in" style="animation-delay: 0.3s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">En Cours</p>
                    <p class="text-3xl font-bold text-blue-600">
                        <%= receveurs != null ? receveurs.stream().filter(r -> "IN_PROGRESS".equals(r.getReceiverState().name())).count() : 0 %>
                    </p>
                </div>
                <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">⏳</span>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-green-500 fade-in" style="animation-delay: 0.4s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Poches Nécessaires</p>
                    <p class="text-3xl font-bold text-green-600">
                        <%= receveurs != null ? receveurs.stream().mapToInt(Receveur::getBesoinPoches).sum() : 0 %>
                    </p>
                </div>
                <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">🩸</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Actions Bar -->
    <div class="max-w-6xl mx-auto mb-6 flex flex-col md:flex-row justify-between items-center gap-4 fade-in" style="animation-delay: 0.5s">
        <div class="flex items-center gap-4 w-full md:w-auto">
            <a href="${pageContext.request.contextPath}/receveurs?action=create"
               class="bg-gradient-to-r from-purple-500 to-pink-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-purple-600 hover:to-pink-700 transition shadow-lg flex items-center">
                <span class="mr-2 text-xl">➕</span>
                Nouveau Receveur
            </a>
            <a href="${pageContext.request.contextPath}/"
               class="bg-gray-500 hover:bg-gray-600 text-white font-semibold py-3 px-6 rounded-lg transition shadow-lg flex items-center">
                <span class="mr-2 text-xl">🏠</span>
                Home
            </a>
        </div>

        <div class="relative w-full md:w-96">
            <input type="text"
                   id="searchInput"
                   placeholder="Rechercher par nom, prénom, CIN..."
                   class="w-full pl-12 pr-4 py-3 border-2 border-gray-300 rounded-lg focus:border-purple-500 focus:outline-none shadow-sm">
            <span class="absolute left-4 top-3.5 text-gray-400 text-xl">🔍</span>
        </div>
    </div>

    <!-- Receveurs Table/Cards -->
    <div class="max-w-6xl mx-auto">
        <% if (receveurs == null || receveurs.isEmpty()) { %>
        <div class="bg-white rounded-2xl shadow-xl p-12 text-center fade-in">
            <div class="w-32 h-32 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
                <span class="text-6xl">📋</span>
            </div>
            <h3 class="text-2xl font-bold text-gray-800 mb-2">Aucun receveur trouvé</h3>
            <p class="text-gray-600 mb-6">Commencez par ajouter votre premier receveur</p>
            <a href="${pageContext.request.contextPath}/receveurs?action=create"
               class="inline-block bg-gradient-to-r from-purple-500 to-pink-600 text-white font-semibold py-3 px-8 rounded-lg hover:from-purple-600 hover:to-pink-700 transition shadow-lg">
                ➕ Ajouter un receveur
            </a>
        </div>
        <% } else { %>

        <!-- Desktop Table View -->
        <div class="hidden md:block bg-white rounded-2xl shadow-xl overflow-hidden fade-in" style="animation-delay: 0.6s">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-gradient-to-r from-purple-500 to-pink-600 text-white">
                    <tr>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Receveur</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">CIN</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Groupe</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Téléphone</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Âge</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Besoins</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Priorité</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">État</th>
                        <th class="px-6 py-4 text-center text-sm font-bold uppercase tracking-wider">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200" id="receveursTable">
                    <% for (Receveur r : receveurs) {
                        int age = Period.between(r.getDateNaissance(), LocalDate.now()).getYears();
                    %>
                    <tr class="hover:bg-gray-50 transition receveur-row"
                        data-nom="<%= r.getNom().toLowerCase() %>"
                        data-prenom="<%= r.getPrenom().toLowerCase() %>"
                        data-cin="<%= r.getCin().toLowerCase() %>">
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <div class="w-10 h-10 bg-gradient-to-br from-purple-400 to-pink-500 rounded-full flex items-center justify-center mr-3">
                                    <span class="text-xl"><%= "M".equals(r.getSexe()) ? "👨" : "👩" %></span>
                                </div>
                                <div>
                                    <div class="text-sm font-bold text-gray-900">
                                        <%= r.getPrenom() %> <%= r.getNom() %>
                                    </div>
                                    <div class="text-xs text-gray-500"><%= r.getSexe().equals("M") ? "Masculin" : "Féminin" %></div>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <%= r.getCin() %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-3 py-1 bg-red-100 text-red-800 rounded-full text-sm font-bold">
                                    <%= r.getBloodGroup() %>
                                </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <%= r.getTelephone() %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <%= age %> ans
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-3 py-1 bg-purple-100 text-purple-800 rounded-full text-sm font-bold">
                                    🩸 <%= r.getBesoinPoches() %>
                                </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-3 py-1 <%=
                                    r.getReceiverPriority().name().equals("URGENT") ? "bg-red-100 text-red-800" :
                                    r.getReceiverPriority().name().equals("HIGH") ? "bg-orange-100 text-orange-800" :
                                    r.getReceiverPriority().name().equals("MEDIUM") ? "bg-yellow-100 text-yellow-800" :
                                    "bg-green-100 text-green-800"
                                %> rounded-full text-xs font-bold">
                                    <%= r.getReceiverPriority() %>
                                </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-3 py-1 <%=
                                    r.getReceiverState().name().equals("WAITING") ? "bg-yellow-100 text-yellow-800" :
                                    r.getReceiverState().name().equals("IN_PROGRESS") ? "bg-blue-100 text-blue-800" :
                                    r.getReceiverState().name().equals("COMPLETED") ? "bg-green-100 text-green-800" :
                                    "bg-gray-100 text-gray-800"
                                %> rounded-full text-xs font-bold">
                                    <%= r.getReceiverState() %>
                                </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center">
                            <div class="flex items-center justify-center space-x-2">
                                <a href="${pageContext.request.contextPath}/receveurs/<%= r.getId() %>"
                                   class="bg-blue-500 hover:bg-blue-600 text-white p-2 rounded-lg transition shadow-md"
                                   title="Détails">
                                    <span>👁️</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/receveurs?action=update&id=<%= r.getId() %>"
                                   class="bg-orange-500 hover:bg-orange-600 text-white p-2 rounded-lg transition shadow-md"
                                   title="Modifier">
                                    <span>✏️</span>
                                </a>
                                <button onclick="confirmDelete('<%= r.getId() %>', '<%= r.getPrenom() %> <%= r.getNom() %>')"
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

        <!-- Mobile Cards View -->
        <div class="md:hidden space-y-4" id="receveursCards">
            <% for (Receveur r : receveurs) {
                int age = Period.between(r.getDateNaissance(), LocalDate.now()).getYears();
            %>
            <div class="bg-white rounded-xl shadow-lg p-6 fade-in border-l-4 <%=
                r.getReceiverPriority().name().equals("URGENT") ? "border-red-500" :
                r.getReceiverPriority().name().equals("HIGH") ? "border-orange-500" :
                "border-yellow-500"
            %> receveur-card"
                 data-nom="<%= r.getNom().toLowerCase() %>"
                 data-prenom="<%= r.getPrenom().toLowerCase() %>"
                 data-cin="<%= r.getCin().toLowerCase() %>">

                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-gradient-to-br from-purple-400 to-pink-500 rounded-full flex items-center justify-center mr-3">
                            <span class="text-2xl"><%= "M".equals(r.getSexe()) ? "👨" : "👩" %></span>
                        </div>
                        <div>
                            <h3 class="font-bold text-lg text-gray-900">
                                <%= r.getPrenom() %> <%= r.getNom() %>
                            </h3>
                            <p class="text-xs text-gray-500">#<%= r.getId() %> • <%= r.getCin() %></p>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-red-100 text-red-800 rounded-full text-sm font-bold">
                        <%= r.getBloodGroup() %>
                    </span>
                </div>

                <div class="grid grid-cols-2 gap-3 mb-4">
                    <div class="bg-gray-50 rounded-lg p-3">
                        <p class="text-xs text-gray-500">Âge</p>
                        <p class="font-bold text-gray-900"><%= age %> ans</p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-3">
                        <p class="text-xs text-gray-500">Besoins</p>
                        <p class="font-bold text-gray-900">🩸 <%= r.getBesoinPoches() %></p>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-3">
                        <p class="text-xs text-gray-500">Priorité</p>
                        <span class="inline-block px-2 py-1 <%=
                            r.getReceiverPriority().name().equals("URGENT") ? "bg-red-100 text-red-800" :
                            r.getReceiverPriority().name().equals("HIGH") ? "bg-orange-100 text-orange-800" :
                            "bg-yellow-100 text-yellow-800"
                        %> rounded-full text-xs font-bold">
                            <%= r.getReceiverPriority() %>
                        </span>
                    </div>
                    <div class="bg-gray-50 rounded-lg p-3">
                        <p class="text-xs text-gray-500">État</p>
                        <span class="inline-block px-2 py-1 <%=
                            r.getReceiverState().name().equals("WAITING") ? "bg-yellow-100 text-yellow-800" :
                            r.getReceiverState().name().equals("IN_PROGRESS") ? "bg-blue-100 text-blue-800" :
                            "bg-green-100 text-green-800"
                        %> rounded-full text-xs font-bold">
                            <%= r.getReceiverState() %>
                        </span>
                    </div>
                </div>

                <div class="flex gap-2">
                    <a href="${pageContext.request.contextPath}/receveurs/<%= r.getId() %>"
                       class="flex-1 bg-blue-500 hover:bg-blue-600 text-white text-center py-2 rounded-lg transition font-semibold">
                        👁️ Voir
                    </a>
                    <a href="${pageContext.request.contextPath}/receveurs?action=update&id=<%= r.getId() %>"
                       class="flex-1 bg-orange-500 hover:bg-orange-600 text-white text-center py-2 rounded-lg transition font-semibold">
                        ✏️ Modifier
                    </a>
                    <button onclick="confirmDelete('<%= r.getId() %>', '<%= r.getPrenom() %> <%= r.getNom() %>')"
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

<!-- Delete Modal -->
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
        <form method="post" action="${pageContext.request.contextPath}/receveurs">
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
    // Search functionality
    document.getElementById('searchInput').addEventListener('input', function(e) {
        const searchTerm = e.target.value.toLowerCase();

        // Desktop table rows
        const rows = document.querySelectorAll('.receveur-row');
        rows.forEach(row => {
            const nom = row.dataset.nom;
            const prenom = row.dataset.prenom;
            const cin = row.dataset.cin;

            if (nom.includes(searchTerm) || prenom.includes(searchTerm) || cin.includes(searchTerm)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });

        // Mobile cards
        const cards = document.querySelectorAll('.receveur-card');
        cards.forEach(card => {
            const nom = card.dataset.nom;
            const prenom = card.dataset.prenom;
            const cin = card.dataset.cin;

            if (nom.includes(searchTerm) || prenom.includes(searchTerm) || cin.includes(searchTerm)) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    });

    // Delete modal functions
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