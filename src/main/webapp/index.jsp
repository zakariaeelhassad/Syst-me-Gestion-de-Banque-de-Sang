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
        <p class="text-xl text-gray-600">Gerez vos donneurs et receveurs efficacement</p>
    </header>

    <!-- Section Donneurs -->
    <div class="mb-12">
        <h2 class="text-3xl font-bold text-gray-800 mb-6 flex items-center">
            <span class="text-3xl mr-3">🩸</span>
            Gestion des Donneurs
        </h2>
        <div class="grid md:grid-cols-2 lg:grid-cols-2 gap-6">
            <!-- Liste des Donneurs -->
            <div class="bg-white rounded-2xl shadow-lg p-8">
                <h3 class="text-xl font-bold text-gray-900 mb-3">Liste des Donneurs</h3>
                <a href="donneurs?action=list" class="inline-block w-full text-center bg-gradient-to-r from-blue-500 to-blue-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-blue-600 hover:to-blue-700 transition-all duration-300 shadow-md">
                    Voir la liste
                </a>
            </div>

            <!-- Ajouter Donneur -->
            <div class="bg-white rounded-2xl shadow-lg p-8">
                <h3 class="text-xl font-bold text-gray-900 mb-3">Ajouter Donneur</h3>
                <a href="donneurs?action=createForm" class="inline-block w-full text-center bg-gradient-to-r from-green-500 to-emerald-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-green-600 hover:to-emerald-700 transition-all duration-300 shadow-md">
                    Ajouter
                </a>
            </div>
        </div>
    </div>

    <!-- Section Receveurs -->
    <div class="mb-12">
        <h2 class="text-3xl font-bold text-gray-800 mb-6 flex items-center">
            <span class="text-3xl mr-3">🏥</span>
            Gestion des Receveurs
        </h2>
        <div class="grid md:grid-cols-2 lg:grid-cols-2 gap-6">
            <!-- Liste des Receveurs -->
            <div class="bg-white rounded-2xl shadow-lg p-8">
                <h3 class="text-xl font-bold text-gray-900 mb-3">Liste des Receveurs</h3>
                <a href="receveurs?action=list" class="inline-block w-full text-center bg-gradient-to-r from-cyan-500 to-cyan-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-cyan-600 hover:to-cyan-700 transition-all duration-300 shadow-md">
                    Voir la liste
                </a>
            </div>

            <!-- Ajouter Receveur -->
            <div class="bg-white rounded-2xl shadow-lg p-8">
                <h3 class="text-xl font-bold text-gray-900 mb-3">Ajouter Receveur</h3>
                <a href="receveurs?action=create" class="inline-block w-full text-center bg-gradient-to-r from-teal-500 to-emerald-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-teal-600 hover:to-emerald-700 transition-all duration-300 shadow-md">
                    Ajouter
                </a>
            </div>
        </div>
    </div>

</div>
</body>
</html>
