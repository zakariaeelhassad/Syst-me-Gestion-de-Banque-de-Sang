<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Donneurs</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-red-50 to-pink-50 min-h-screen text-gray-800">
<div class="max-w-7xl mx-auto px-6 py-10">
    <!-- Header -->
    <header class="flex flex-col md:flex-row md:items-center md:justify-between mb-10">
        <h1 class="text-4xl font-bold text-red-600 mb-4 md:mb-0">
            📋 Liste des Donneurs de Sang
        </h1>
        <div class="space-x-4">
            <a href="${pageContext.request.contextPath}/"
               class="inline-block bg-gray-200 hover:bg-gray-300 text-gray-800 px-5 py-2 rounded-lg transition">
                🏠 Accueil
            </a>
            <a href="${pageContext.request.contextPath}/donneurs?action=createForm"
               class="inline-block bg-gradient-to-r from-red-500 to-pink-600 text-white px-5 py-2 rounded-lg shadow hover:shadow-xl transition">
                ➕ Ajouter un donneur
            </a>
        </div>
    </header>

    <!-- Message de succès -->
    <c:if test="${param.success == 'true'}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg mb-6">
            ✅ Donneur ajouté avec succès !
        </div>
    </c:if>

    <!-- Statistiques -->
    <div class="flex justify-center mb-8">
        <div class="bg-white rounded-xl shadow-md p-6 text-center border border-gray-200">
            <span class="text-4xl font-bold text-red-600">${totalDonneurs}</span>
            <p class="text-gray-600 font-medium mt-2">Donneurs Total</p>
        </div>
    </div>

    <!-- Liste des donneurs -->
    <c:choose>
        <c:when test="${empty donneurs}">
            <div class="text-center bg-white rounded-2xl shadow p-10">
                <p class="text-gray-600 text-lg mb-4">😔 Aucun donneur trouvé dans la base de données</p>
                <a href="${pageContext.request.contextPath}/donneurs?action=createForm"
                   class="inline-block bg-gradient-to-r from-blue-500 to-blue-600 text-white px-6 py-3 rounded-lg shadow hover:shadow-lg transition">
                    ➕ Ajouter le premier donneur
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="overflow-x-auto bg-white rounded-2xl shadow-lg border border-gray-100">
                <table class="min-w-full border-collapse">
                    <thead class="bg-gradient-to-r from-red-500 to-pink-500 text-white">
                    <tr>
                        <th class="py-3 px-4 text-left">ID</th>
                        <th class="py-3 px-4 text-left">Nom</th>
                        <th class="py-3 px-4 text-left">Prénom</th>
                        <th class="py-3 px-4 text-left">CIN</th>
                        <th class="py-3 px-4 text-left">Sexe</th>
                        <th class="py-3 px-4 text-left">Date de naissance</th>
                        <th class="py-3 px-4 text-left">Groupe sanguin</th>
                        <th class="py-3 px-4 text-left">Contre-indication</th>
                        <th class="py-3 px-4 text-left">Poche disponible</th>
                        <th class="py-3 px-4 text-left">Statut</th>
                        <th class="py-3 px-4 text-left">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="donneur" items="${donneurs}">
                        <tr class="border-b hover:bg-red-50 transition">
                            <td class="py-3 px-4">${donneur.id}</td>
                            <td class="py-3 px-4 font-semibold">${donneur.nom}</td>
                            <td class="py-3 px-4">${donneur.prenom}</td>
                            <td class="py-3 px-4">${donneur.cin}</td>
                            <td class="py-3 px-4">
                                <c:choose>
                                    <c:when test="${donneur.sexe == 'M'}">👨 Homme</c:when>
                                    <c:when test="${donneur.sexe == 'F'}">👩 Femme</c:when>
                                    <c:otherwise>${donneur.sexe}</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="py-3 px-4">${donneur.dateNaissance}</td>
                            <td class="py-3 px-4">
                                <span class="inline-block px-3 py-1 bg-red-100 text-red-700 rounded-full text-sm font-medium">
                                        ${donneur.bloodGroup}
                                </span>
                            </td>
                            <td class="py-3 px-4">
                                <c:choose>
                                    <c:when test="${donneur.contreIndication}">
                                        <span class="inline-block px-3 py-1 bg-red-200 text-red-800 rounded-full text-sm font-medium">
                                            ⚠️ Oui
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-block px-3 py-1 bg-green-100 text-green-700 rounded-full text-sm font-medium">
                                            ✅ Non
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="py-3 px-4">${donneur.pocheDisponible}</td>
                            <td class="py-3 px-4">
                                <span class="inline-block px-3 py-1 bg-gray-100 text-gray-800 rounded-full text-sm font-medium">
                                        ${donneur.donorStatus}
                                </span>
                            </td>
                            <td class="py-3 px-4">
                                <a href="${pageContext.request.contextPath}/donneurs/${donneur.id}"
                                   class="inline-block bg-gradient-to-r from-blue-500 to-blue-600 text-white px-3 py-2 rounded-lg hover:shadow-md transition">
                                    👁️ Détails
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
