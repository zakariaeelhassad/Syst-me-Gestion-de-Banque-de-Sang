<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-red-50 to-pink-100 min-h-screen flex items-center justify-center">
<div class="bg-white shadow-lg rounded-2xl p-10 text-center max-w-lg w-full">
    <h1 class="text-4xl font-bold text-red-600 mb-4">❌ Une erreur est survenue</h1>
    <p class="text-gray-700 text-lg mb-6">${errorMessage}</p>
    <a href="${pageContext.request.contextPath}/donneurs?action=list"
       class="inline-block bg-gradient-to-r from-red-500 to-pink-600 text-white px-6 py-3 rounded-lg shadow hover:shadow-xl transition">
        ⬅ Retour à la liste
    </a>
</div>
</body>
</html>
