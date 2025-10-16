<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entities.models.DonationAssociation" %>
<%
    List<DonationAssociation> donations = (List<DonationAssociation>) request.getAttribute("donations");
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
    <title>Liste des Donations</title>
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
<body class="bg-gradient-to-br from-red-50 via-white to-pink-50 min-h-screen">

<div class="container mx-auto px-4 py-8">
    <div class="text-center mb-8 fade-in">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-red-500 to-pink-600 rounded-full mb-4 shadow-lg pulse-animation">
            <span class="text-4xl">❤️</span>
        </div>
        <h1 class="text-5xl font-bold text-gray-900 mb-2 bg-gradient-to-r from-red-600 to-pink-600 bg-clip-text text-transparent">
            Gestion des Donations
        </h1>
        <p class="text-gray-600 text-lg">Liste complète des donations de sang</p>
    </div>

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

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8 max-w-5xl mx-auto">
        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-red-500 fade-in" style="animation-delay: 0.1s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Total Donations</p>
                    <p class="text-3xl font-bold text-red-600"><%= donations != null ? donations.size() : 0 %></p>
                </div>
                <div class="w-12 h-12 bg-red-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">❤️</span>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-green-500 fade-in" style="animation-delay: 0.2s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Aujourd'hui</p>
                    <p class="text-3xl font-bold text-green-600">
                        <%= donations != null ? donations.stream()
                                .filter(d -> d.getDateAssociation().equals(java.time.LocalDate.now()))
                                .count() : 0 %>
                    </p>
                </div>
                <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">📅</span>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-blue-500 fade-in" style="animation-delay: 0.3s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Ce Mois</p>
                    <p class="text-3xl font-bold text-blue-600">
                        <%= donations != null ? donations.stream()
                                .filter(d -> d.getDateAssociation().getMonth().equals(java.time.LocalDate.now().getMonth()))
                                .count() : 0 %>
                    </p>
                </div>
                <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                    <span class="text-2xl">📊</span>
                </div>
            </div>
        </div>
    </div>

    <div class="max-w-6xl mx-auto mb-6 flex flex-col md:flex-row justify-between items-center gap-4 fade-in" style="animation-delay: 0.4s">
        <div class="flex items-center gap-4 w-full md:w-auto">
            <a href="${pageContext.request.contextPath}/donations?action=create"
               class="bg-gradient-to-r from-red-500 to-pink-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-red-600 hover:to-pink-700 transition shadow-lg flex items-center">
                <span class="mr-2 text-xl">➕</span>
                Nouvelle Donation
            </a>
            <a href="${pageContext.request.contextPath}/"
               class="bg-gray-500 hover:bg-gray-600 text-white font-semibold py-3 px-6 rounded-lg transition shadow-lg flex items-center">
                <span class="mr-2 text-xl">🏠</span>
                Home
            </a>
        </div>

    </div>

    <div class="max-w-6xl mx-auto">
        <% if (donations == null || donations.isEmpty()) { %>
        <div class="bg-white rounded-2xl shadow-xl p-12 text-center fade-in">
            <div class="w-32 h-32 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
                <span class="text-6xl">📋</span>
            </div>
            <h3 class="text-2xl font-bold text-gray-800 mb-2">Aucune donation trouvée</h3>
            <p class="text-gray-600 mb-6">Commencez par ajouter votre première donation</p>
            <a href="${pageContext.request.contextPath}/donations?action=create"
               class="inline-block bg-gradient-to-r from-red-500 to-pink-600 text-white font-semibold py-3 px-8 rounded-lg hover:from-red-600 hover:to-pink-700 transition shadow-lg">
                ➕ Ajouter une donation
            </a>
        </div>
        <% } else { %>

        <div class="hidden md:block bg-white rounded-2xl shadow-xl overflow-hidden fade-in" style="animation-delay: 0.5s">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-gradient-to-r from-red-500 to-pink-600 text-white">
                    <tr>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Date</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Donneur</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Receveur</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Groupe D</th>
                        <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Groupe R</th>
                        <th class="px-6 py-4 text-center text-sm font-bold uppercase tracking-wider">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200" id="donationsTable">
                    <% for (DonationAssociation donation : donations) { %>
                    <tr class="hover:bg-gray-50 transition donation-row"
                        data-donneur="<%= donation.getDonneur() != null ? (donation.getDonneur().getPrenom() + " " + donation.getDonneur().getNom()).toLowerCase() : "" %>"
                        data-receveur="<%= donation.getReceveur() != null ? (donation.getReceveur().getPrenom() + " " + donation.getReceveur().getNom()).toLowerCase() : "" %>">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <%= donation.getDateAssociation() %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <div class="w-10 h-10 bg-gradient-to-br from-blue-400 to-cyan-500 rounded-full flex items-center justify-center mr-3">
                                    <span class="text-xl">👨</span>
                                </div>
                                <div>
                                    <div class="text-sm font-bold text-gray-900">
                                        <%= donation.getDonneur() != null ? donation.getDonneur().getPrenom() + " " + donation.getDonneur().getNom() : "—" %>
                                    </div>
                                    <div class="text-xs text-gray-500">Donneur</div>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <div class="w-10 h-10 bg-gradient-to-br from-green-400 to-emerald-500 rounded-full flex items-center justify-center mr-3">
                                    <span class="text-xl">👤</span>
                                </div>
                                <div>
                                    <div class="text-sm font-bold text-gray-900">
                                        <%= donation.getReceveur() != null ? donation.getReceveur().getPrenom() + " " + donation.getReceveur().getNom() : "—" %>
                                    </div>
                                    <div class="text-xs text-gray-500">Receveur</div>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-3 py-1 bg-red-100 text-red-800 rounded-full text-sm font-bold">
                                <%= donation.getDonneur() != null ? donation.getDonneur().getBloodGroup() : "—" %>
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-3 py-1 bg-red-100 text-red-800 rounded-full text-sm font-bold">
                                <%= donation.getReceveur() != null ? donation.getReceveur().getBloodGroup() : "—" %>
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center">
                            <div class="flex items-center justify-center space-x-2">
                                <button onclick="confirmDelete('<%= donation.getId() %>')"
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

        <div class="md:hidden space-y-4" id="donationsCards">
            <% for (DonationAssociation donation : donations) { %>
            <div class="bg-white rounded-xl shadow-lg p-6 fade-in border-l-4 border-red-500 donation-card"
                 data-donneur="<%= donation.getDonneur() != null ? (donation.getDonneur().getPrenom() + " " + donation.getDonneur().getNom()).toLowerCase() : "" %>"
                 data-receveur="<%= donation.getReceveur() != null ? (donation.getReceveur().getPrenom() + " " + donation.getReceveur().getNom()).toLowerCase() : "" %>">

                <div class="flex items-center justify-between mb-4">
                    <span class="text-sm font-bold text-gray-500">#<%= donation.getId() %></span>
                    <span class="px-3 py-1 bg-red-100 text-red-800 rounded-full text-sm font-bold">
                        <%= donation.getDonneur() != null ? donation.getDonneur().getBloodGroup() : "—" %>
                    </span>
                </div>

                <div class="mb-4">
                    <p class="text-xs text-gray-500 mb-1">Date de donation</p>
                    <p class="font-bold text-gray-900">📅 <%= donation.getDateAssociation() %></p>
                </div>

                <div class="grid grid-cols-2 gap-3 mb-4">
                    <div class="bg-blue-50 rounded-lg p-3">
                        <p class="text-xs text-blue-600 font-semibold mb-2">👨 Donneur</p>
                        <p class="font-bold text-gray-900 text-sm">
                            <%= donation.getDonneur() != null ? donation.getDonneur().getPrenom() + " " + donation.getDonneur().getNom() : "—" %>
                        </p>
                    </div>
                    <div class="bg-green-50 rounded-lg p-3">
                        <p class="text-xs text-green-600 font-semibold mb-2">👤 Receveur</p>
                        <p class="font-bold text-gray-900 text-sm">
                            <%= donation.getReceveur() != null ? donation.getReceveur().getPrenom() + " " + donation.getReceveur().getNom() : "—" %>
                        </p>
                    </div>
                </div>

                <div class="flex gap-2">
                    <button onclick="confirmDelete('<%= donation.getId() %>')"
                            class="flex-1 bg-red-500 hover:bg-red-600 text-white py-2 rounded-lg transition font-semibold">
                        🗑️ Supprimer
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
            <p class="text-gray-600">Êtes-vous sûr de vouloir supprimer cette donation ?</p>
            <p id="deleteIdDisplay" class="text-red-600 font-semibold text-xl mt-2"></p>
        </div>
        <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4 mb-6">
            <p class="text-sm text-yellow-800">⚠️ Cette action est irréversible</p>
        </div>
        <form method="post" action="${pageContext.request.contextPath}/donations">
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

    function confirmDelete(id) {
        document.getElementById('deleteIdDisplay').textContent = 'Donation #' + id;
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