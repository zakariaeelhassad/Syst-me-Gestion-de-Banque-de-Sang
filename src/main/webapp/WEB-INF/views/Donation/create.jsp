<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entities.models.Donneur" %>
<%@ page import="org.example.entities.models.Receveur" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer une Donation</title>
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
    <!-- Header -->
    <div class="text-center mb-8 fade-in">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-red-500 to-pink-600 rounded-full mb-4 shadow-lg pulse-animation">
            <span class="text-4xl">❤️</span>
        </div>
        <h1 class="text-5xl font-bold text-gray-900 mb-2 bg-gradient-to-r from-red-600 to-pink-600 bg-clip-text text-transparent">
            Créer une Donation
        </h1>
        <p class="text-gray-600 text-lg">Enregistrer une nouvelle donation de sang</p>
    </div>

    <!-- Messages -->
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        String successMessage = (String) request.getAttribute("successMessage");
        if (errorMessage != null) {
    %>
    <div class="max-w-2xl mx-auto mb-6 slide-down">
        <div class="bg-red-50 border-l-4 border-red-500 rounded-lg p-4 shadow-md flex items-center justify-between">
            <div class="flex items-center">
                <span class="text-3xl mr-3">❌</span>
                <p class="text-red-800 font-semibold"><%= errorMessage %></p>
            </div>
            <button onclick="this.parentElement.parentElement.remove()" class="text-red-600 hover:text-red-800 font-bold text-xl">×</button>
        </div>
    </div>
    <%
    } else if (successMessage != null) {
    %>
    <div class="max-w-2xl mx-auto mb-6 slide-down">
        <div class="bg-green-50 border-l-4 border-green-500 rounded-lg p-4 shadow-md flex items-center justify-between">
            <div class="flex items-center">
                <span class="text-3xl mr-3">✅</span>
                <p class="text-green-800 font-semibold"><%= successMessage %></p>
            </div>
            <button onclick="this.parentElement.parentElement.remove()" class="text-green-600 hover:text-green-800 font-bold text-xl">×</button>
        </div>
    </div>
    <%
        }
    %>

    <!-- Form Card -->
    <div class="max-w-2xl mx-auto">
        <div class="bg-white rounded-2xl shadow-xl p-8 fade-in" style="animation-delay: 0.2s">
            <form id="donationForm" action="${pageContext.request.contextPath}/donations" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="create"/>

                <!-- Date Section -->
                <div class="mb-6">
                    <label for="date_association" class="block text-sm font-bold text-gray-700 mb-2">📅 Date de Donation</label>
                    <input type="date"
                           id="date_association"
                           name="date_association"
                           value="<%= java.time.LocalDate.now() %>"
                           required
                           class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-red-500 focus:outline-none transition shadow-sm">
                </div>

                <!-- Donneur Section -->
                <div class="mb-6">
                    <label for="donneur_id" class="block text-sm font-bold text-gray-700 mb-2">👨 Donneur</label>
                    <div class="relative">
                        <select id="donneur_id" name="donneur_id" required
                                class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-red-500 focus:outline-none transition shadow-sm appearance-none">
                            <option value="">-- Choisir un Donneur --</option>
                            <%
                                List<Donneur> donneurs = (List<Donneur>) request.getAttribute("donneurs");
                                if (donneurs != null) {
                                    for (Donneur d : donneurs) {
                            %>
                            <option value="<%= d.getId() %>" data-group="<%= d.getBloodGroup() %>">
                                <%= d.getPrenom() %> <%= d.getNom() %> - Groupe: <%= d.getBloodGroup() %>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                        <div class="absolute inset-y-0 right-0 flex items-center px-4 pointer-events-none">
                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Receveur Section -->
                <div class="mb-6">
                    <label for="receveur_id" class="block text-sm font-bold text-gray-700 mb-2">👤 Receveur</label>
                    <div class="relative">
                        <select id="receveur_id" name="receveur_id" required
                                class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-red-500 focus:outline-none transition shadow-sm appearance-none">
                            <option value="">-- Choisir un Receveur --</option>
                            <%
                                List<Receveur> receveurs = (List<Receveur>) request.getAttribute("receveurs");
                                if (receveurs != null) {
                                    for (Receveur r : receveurs) {
                            %>
                            <option value="<%= r.getId() %>" data-group="<%= r.getBloodGroup() %>">
                                <%= r.getPrenom() %> <%= r.getNom() %> - Groupe: <%= r.getBloodGroup() %>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                        <div class="absolute inset-y-0 right-0 flex items-center px-4 pointer-events-none">
                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Compatibility Info Box -->
                <div id="compatibilityBox" class="hidden mb-6 p-4 rounded-lg border-2">
                    <div class="flex items-center">
                        <span id="compatibilityIcon" class="text-3xl mr-3"></span>
                        <div>
                            <p id="compatibilityText" class="font-semibold"></p>
                            <p id="compatibilityDetails" class="text-sm mt-1"></p>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex flex-col md:flex-row gap-4">
                    <button type="submit"
                            class="flex-1 bg-gradient-to-r from-red-500 to-pink-600 text-white font-semibold py-4 px-6 rounded-lg hover:from-red-600 hover:to-pink-700 transition shadow-lg flex items-center justify-center">
                        <span class="mr-2 text-xl">💾</span>
                        Enregistrer la Donation
                    </button>
                    <a href="${pageContext.request.contextPath}/donations"
                       class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-4 px-6 rounded-lg transition shadow-md flex items-center justify-center">
                        <span class="mr-2 text-xl">←</span>
                        Annuler
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    const donneurSelect = document.getElementById('donneur_id');
    const receveurSelect = document.getElementById('receveur_id');
    const compatibilityBox = document.getElementById('compatibilityBox');
    const compatibilityIcon = document.getElementById('compatibilityIcon');
    const compatibilityText = document.getElementById('compatibilityText');
    const compatibilityDetails = document.getElementById('compatibilityDetails');

    donneurSelect.addEventListener('change', checkCompatibility);
    receveurSelect.addEventListener('change', checkCompatibility);

    function canDonateToJS(donorGroup, receiverGroup) {
        const normalize = {
            'O−': 'O_NEG',
            'O+': 'O_POS',
            'A−': 'A_NEG',
            'A+': 'A_POS',
            'B−': 'B_NEG',
            'B+': 'B_POS',
            'AB−': 'AB_NEG',
            'AB+': 'AB_POS',
        };

        donorGroup = normalize[donorGroup] || donorGroup;
        receiverGroup = normalize[receiverGroup] || receiverGroup;

        switch (donorGroup) {
            case 'O_NEG':
                return true;
            case 'O_POS':
                return ['O_POS', 'A_POS', 'B_POS', 'AB_POS'].includes(receiverGroup);
            case 'A_NEG':
                return ['A_NEG', 'A_POS', 'AB_NEG', 'AB_POS'].includes(receiverGroup);
            case 'A_POS':
                return ['A_POS', 'AB_POS'].includes(receiverGroup);
            case 'B_NEG':
                return ['B_NEG', 'B_POS', 'AB_NEG', 'AB_POS'].includes(receiverGroup);
            case 'B_POS':
                return ['B_POS', 'AB_POS'].includes(receiverGroup);
            case 'AB_NEG':
                return ['AB_NEG', 'AB_POS'].includes(receiverGroup);
            case 'AB_POS':
                return receiverGroup === 'AB_POS';
            default:
                return false;
        }
    }


    function checkCompatibility() {
        if (!donneurSelect.value || !receveurSelect.value) {
            compatibilityBox.classList.add('hidden');
            return;
        }

        const donorGroup = donneurSelect.options[donneurSelect.selectedIndex].dataset.group;
        const receiverGroup = receveurSelect.options[receveurSelect.selectedIndex].dataset.group;

        compatibilityBox.classList.remove('hidden');

        if (canDonateToJS(donorGroup, receiverGroup)) {
            compatibilityBox.className = 'mb-6 p-4 rounded-lg border-2 border-green-500 bg-green-50';
            compatibilityIcon.textContent = '✅';
            compatibilityText.textContent = 'Compatible !';
            compatibilityText.className = 'font-semibold text-green-800';
            compatibilityDetails.textContent = `Le donneur (${donorGroup}) peut donner au receveur (${receiverGroup})`;
            compatibilityDetails.className = 'text-sm mt-1 text-green-700';
        } else {
            compatibilityBox.className = 'mb-6 p-4 rounded-lg border-2 border-red-500 bg-red-50';
            compatibilityIcon.textContent = '❌';
            compatibilityText.textContent = 'Non compatible !';
            compatibilityText.className = 'font-semibold text-red-800';
            compatibilityDetails.textContent = `Le donneur (${donorGroup}) ne peut pas donner au receveur (${receiverGroup})`;
            compatibilityDetails.className = 'text-sm mt-1 text-red-700';
        }
    }


    function validateForm() {
        const dateInput = document.getElementById('date_association');
        const selectedDate = new Date(dateInput.value);
        const today = new Date();
        today.setHours(0,0,0,0);

        if (selectedDate < today) {
            alert('❌ La date de donation ne peut pas être dans le passé !');
            return false;
        }

        return true;
    }
</script>

</body>
</html>
