<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion Banque de Sang</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-red-50 via-white to-pink-50 min-h-screen">
<div class="container mx-auto px-4 py-8 max-w-7xl">

    <!-- Header -->
    <header class="text-center mb-12">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-red-500 to-pink-600 rounded-full mb-4 shadow-lg">
            <span class="text-4xl">🩸</span>
        </div>
        <h1 class="text-5xl font-bold text-gray-900 mb-3 bg-gradient-to-r from-red-600 to-pink-600 bg-clip-text text-transparent">
            Systeme de Gestion de Banque de Sang
        </h1>
        <p class="text-xl text-gray-600">Gérez vos donneurs, receveurs et donations efficacement</p>
    </header>

    <!-- Dashboard 3 cartes -->
    <div class="grid md:grid-cols-3 gap-6">
        <!-- Liste Donneurs -->
        <div class="bg-white rounded-2xl shadow-lg p-8 flex flex-col items-center">
            <span class="text-6xl mb-4">🩸</span>
            <h3 class="text-xl font-bold text-gray-900 mb-4">Liste des Donneurs</h3>
            <a href="donneurs?action=list"
               class="inline-block w-full text-center bg-gradient-to-r from-blue-500 to-blue-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-blue-600 hover:to-blue-700 transition-all duration-300 shadow-md">
                Voir la liste
            </a>
        </div>

        <!-- Liste Receveurs -->
        <div class="bg-white rounded-2xl shadow-lg p-8 flex flex-col items-center">
            <span class="text-6xl mb-4">🏥</span>
            <h3 class="text-xl font-bold text-gray-900 mb-4">Liste des Receveurs</h3>
            <a href="receveurs?action=list"
               class="inline-block w-full text-center bg-gradient-to-r from-cyan-500 to-cyan-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-cyan-600 hover:to-cyan-700 transition-all duration-300 shadow-md">
                Voir la liste
            </a>
        </div>

        <!-- Liste / Créer Donation -->
        <div class="bg-white rounded-2xl shadow-lg p-8 flex flex-col items-center">
            <span class="text-6xl mb-4">❤️</span>
            <h3 class="text-xl font-bold text-gray-900 mb-4">Gestion des Donations</h3>
            <a href="donations?action=list"
               class="inline-block w-full text-center bg-gradient-to-r from-red-500 to-pink-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-red-600 hover:to-pink-700 transition-all duration-300 shadow-md mb-3">
                Voir la liste
            </a>
            <a href="donations?action=createForm"
               class="inline-block w-full text-center bg-gradient-to-r from-green-500 to-emerald-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-green-600 hover:to-emerald-700 transition-all duration-300 shadow-md">
                Ajouter Donation
            </a>
        </div>
    </div>

</div>
</body>
</html>
