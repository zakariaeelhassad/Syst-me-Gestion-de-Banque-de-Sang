<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Donneur</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-red-50 to-pink-50 min-h-screen text-gray-800">
<div class="max-w-5xl mx-auto px-6 py-10">
    <!-- Header -->
    <header class="flex flex-col md:flex-row md:items-center md:justify-between mb-10">
        <h1 class="text-4xl font-bold text-red-600 mb-4 md:mb-0">➕ Ajouter un Nouveau Donneur</h1>
        <div class="space-x-4">
            <a href="${pageContext.request.contextPath}/"
               class="inline-block bg-gray-200 hover:bg-gray-300 text-gray-800 px-5 py-2 rounded-lg transition">
                🏠 Accueil
            </a>
            <a href="${pageContext.request.contextPath}/donneurs?action=list"
               class="inline-block bg-gradient-to-r from-blue-500 to-blue-600 text-white px-5 py-2 rounded-lg shadow hover:shadow-xl transition">
                📋 Liste des donneurs
            </a>
        </div>
    </header>

    <!-- Message d’erreur -->
    <c:if test="${not empty errorMessage}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg mb-6">
            ❌ ${errorMessage}
        </div>
    </c:if>

    <!-- Formulaire -->
    <form action="${pageContext.request.contextPath}/donneurs" method="post"
          class="bg-white rounded-2xl shadow-lg p-8 border border-gray-100 space-y-8">
        <input type="hidden" name="action" value="create"/>

        <!-- Informations personnelles -->
        <section>
            <h2 class="text-2xl font-semibold text-red-600 mb-4">🧍 Informations Personnelles</h2>

            <div class="grid md:grid-cols-2 gap-6">
                <div>
                    <label for="nom" class="block text-sm font-medium text-gray-700 mb-1">Nom *</label>
                    <input type="text" id="nom" name="nom" required maxlength="100"
                           placeholder="Ex: ALAMI"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                </div>
                <div>
                    <label for="prenom" class="block text-sm font-medium text-gray-700 mb-1">Prénom *</label>
                    <input type="text" id="prenom" name="prenom" required maxlength="100"
                           placeholder="Ex: Mohammed"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                </div>
                <div>
                    <label for="cin" class="block text-sm font-medium text-gray-700 mb-1">CIN *</label>
                    <input type="text" id="cin" name="cin" required maxlength="20"
                           placeholder="Ex: AB123456"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                </div>
                <div>
                    <label for="sexe" class="block text-sm font-medium text-gray-700 mb-1">Sexe *</label>
                    <select id="sexe" name="sexe" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                        <option value="">Sélectionnez...</option>
                        <option value="M">Homme</option>
                        <option value="F">Femme</option>
                    </select>
                </div>
            </div>

            <div class="mt-6">
                <label for="dateNaissance" class="block text-sm font-medium text-gray-700 mb-1">Date de Naissance *</label>
                <input type="date" id="dateNaissance" name="dateNaissance" required
                       max="<%= java.time.LocalDate.now().minusYears(18) %>"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                <p class="text-sm text-gray-500 mt-1">Le donneur doit avoir au moins 18 ans</p>
            </div>
        </section>

        <!-- Informations médicales -->
        <section>
            <h2 class="text-2xl font-semibold text-red-600 mb-4">🩸 Informations Médicales</h2>

            <div class="grid md:grid-cols-2 gap-6">
                <div>
                    <label for="bloodGroup" class="block text-sm font-medium text-gray-700 mb-1">Groupe Sanguin *</label>
                    <select id="bloodGroup" name="bloodGroup" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                        <option value="">Sélectionnez...</option>
                        <c:forEach var="bg" items="${bloodGroups}">
                            <option value="${bg}">${bg}</option>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <label for="donorStatus" class="block text-sm font-medium text-gray-700 mb-1">Statut du Donneur *</label>
                    <select id="donorStatus" name="donorStatus" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                        <option value="">Sélectionnez...</option>
                        <c:forEach var="status" items="${donorStatuses}">
                            <option value="${status}">${status}</option>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <label for="pocheDisponible" class="block text-sm font-medium text-gray-700 mb-1">Poches Disponibles *</label>
                    <input type="number" id="pocheDisponible" name="pocheDisponible" required min="0" value="0"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Contre-indication</label>
                    <div class="flex items-center space-x-2">
                        <input type="checkbox" id="contreIndication" name="contreIndication" value="true"
                               class="w-5 h-5 text-red-600 focus:ring-red-500 border-gray-300 rounded">
                        <label for="contreIndication" class="text-gray-700">Le donneur a une contre-indication médicale</label>
                    </div>
                </div>
            </div>

            <div class="mt-6">
                <label for="notes" class="block text-sm font-medium text-gray-700 mb-1">Notes / Observations</label>
                <textarea id="notes" name="notes" rows="4"
                          placeholder="Ajoutez des notes ou observations..."
                          class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent"></textarea>
            </div>
        </section>

        <!-- Actions -->
        <div class="flex justify-end space-x-4 pt-6 border-t">
            <a href="${pageContext.request.contextPath}/donneurs?action=list"
               class="bg-gray-200 hover:bg-gray-300 text-gray-800 px-6 py-2 rounded-lg transition">
                ❌ Annuler
            </a>
            <button type="submit"
                    class="bg-gradient-to-r from-red-500 to-pink-600 text-white px-6 py-2 rounded-lg shadow hover:shadow-xl transition">
                ✅ Enregistrer
            </button>
        </div>
    </form>
</div>

<script>
    const maxDate = new Date();
    maxDate.setFullYear(maxDate.getFullYear() - 18);
    document.getElementById('dateNaissance').max = maxDate.toISOString().split('T')[0];
</script>
</body>
</html>
