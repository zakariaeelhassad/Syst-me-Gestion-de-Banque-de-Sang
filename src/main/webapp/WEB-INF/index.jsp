<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion Banque de Sang</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }
        .card-hover {
            transition: all 0.3s ease;
        }
        .card-hover:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(239, 68, 68, 0.1), 0 10px 10px -5px rgba(239, 68, 68, 0.04);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-red-50 via-white to-pink-50 min-h-screen">
<div class="container mx-auto px-4 py-8 max-w-7xl">
    <!-- Header -->
    <header class="text-center mb-12 fade-in">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-red-500 to-pink-600 rounded-full mb-4 shadow-lg">
            <span class="text-4xl">🩸</span>
        </div>
        <h1 class="text-5xl font-bold text-gray-900 mb-3 bg-gradient-to-r from-red-600 to-pink-600 bg-clip-text text-transparent">
            Système de Gestion de Banque de Sang
        </h1>
        <p class="text-xl text-gray-600">Gérez efficacement vos donneurs de sang</p>
    </header>

    <!-- Main Content -->
    <main>
        <!-- Cards Grid -->
        <div class="grid md:grid-cols-3 gap-8 mb-12">
            <!-- Liste des Donneurs -->
            <div class="bg-white rounded-2xl shadow-lg p-8 card-hover fade-in border border-gray-100" style="animation-delay: 0.1s">
                <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl flex items-center justify-center mb-6 shadow-md">
                    <span class="text-3xl">📋</span>
                </div>
                <h2 class="text-2xl font-bold text-gray-900 mb-3">Liste des Donneurs</h2>
                <p class="text-gray-600 mb-6 leading-relaxed">
                    Consultez tous les donneurs enregistrés dans le système
                </p>
                <a href="#" class="inline-block w-full text-center bg-gradient-to-r from-blue-500 to-blue-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-blue-600 hover:to-blue-700 transition-all duration-300 shadow-md hover:shadow-lg">
                    Voir la liste
                </a>
            </div>

            <!-- Nouveau Donneur -->
            <div class="bg-white rounded-2xl shadow-lg p-8 card-hover fade-in border border-gray-100" style="animation-delay: 0.2s">
                <div class="w-16 h-16 bg-gradient-to-br from-green-500 to-emerald-600 rounded-xl flex items-center justify-center mb-6 shadow-md">
                    <span class="text-3xl">➕</span>
                </div>
                <h2 class="text-2xl font-bold text-gray-900 mb-3">Nouveau Donneur</h2>
                <p class="text-gray-600 mb-6 leading-relaxed">
                    Enregistrez un nouveau donneur dans la base de données
                </p>
                <a href="#" class="inline-block w-full text-center bg-gradient-to-r from-green-500 to-emerald-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-green-600 hover:to-emerald-700 transition-all duration-300 shadow-md hover:shadow-lg">
                    Ajouter un donneur
                </a>
            </div>

            <!-- Recherche -->
            <div class="bg-white rounded-2xl shadow-lg p-8 card-hover fade-in border border-gray-100" style="animation-delay: 0.3s">
                <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-purple-600 rounded-xl flex items-center justify-center mb-6 shadow-md">
                    <span class="text-3xl">🔍</span>
                </div>
                <h2 class="text-2xl font-bold text-gray-900 mb-3">Recherche</h2>
                <p class="text-gray-600 mb-6 leading-relaxed">
                    Recherchez un donneur par son identifiant
                </p>
                <form class="space-y-3">
                    <input
                            type="number"
                            name="id"
                            placeholder="ID du donneur"
                            required
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all"
                    >
                    <button
                            type="submit"
                            class="w-full bg-gradient-to-r from-purple-500 to-purple-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-purple-600 hover:to-purple-700 transition-all duration-300 shadow-md hover:shadow-lg"
                    >
                        Rechercher
                    </button>
                </form>
            </div>
        </div>

        <!-- Info Section -->
        <div class="bg-white rounded-2xl shadow-lg p-8 fade-in border border-gray-100" style="animation-delay: 0.4s">
            <div class="flex items-start">
                <div class="flex-shrink-0">
                    <div class="w-12 h-12 bg-gradient-to-br from-amber-500 to-orange-600 rounded-xl flex items-center justify-center shadow-md">
                        <span class="text-2xl">ℹ️</span>
                    </div>
                </div>
                <div class="ml-6">
                    <h3 class="text-2xl font-bold text-gray-900 mb-4">Informations Importantes</h3>
                    <ul class="space-y-3 text-gray-700">
                        <li class="flex items-start">
                            <span class="text-red-500 mr-3 mt-1">•</span>
                            <span>Assurez-vous que toutes les informations des donneurs sont exactes</span>
                        </li>
                        <li class="flex items-start">
                            <span class="text-red-500 mr-3 mt-1">•</span>
                            <span>Vérifiez les contre-indications avant chaque don</span>
                        </li>
                        <li class="flex items-start">
                            <span class="text-red-500 mr-3 mt-1">•</span>
                            <span>Maintenez à jour le statut de disponibilité des poches de sang</span>
                        </li>
                        <li class="flex items-start">
                            <span class="text-red-500 mr-3 mt-1">•</span>
                            <span>Respectez la confidentialité des données médicales</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="text-center mt-12 py-8 fade-in" style="animation-delay: 0.5s">
        <p class="text-gray-600">
            &copy; 2025 Système de Gestion Banque de Sang. Tous droits réservés.
        </p>
    </footer>
</div>
</body>
</html>