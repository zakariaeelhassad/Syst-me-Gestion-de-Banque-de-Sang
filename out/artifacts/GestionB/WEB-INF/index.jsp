<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion Banque de Sang</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
<div class="container">
    <header class="main-header">
        <h1>🩸 Système de Gestion de Banque de Sang</h1>
        <p class="subtitle">Gérez efficacement vos donneurs de sang</p>
    </header>

    <main class="main-content">
        <div class="card-grid">
            <div class="card">
                <div class="card-icon">📋</div>
                <h2>Liste des Donneurs</h2>
                <p>Consultez tous les donneurs enregistrés dans le système</p>
                <a href="${pageContext.request.contextPath}/donneurs?action=list" class="btn btn-primary">
                    Voir la liste
                </a>
            </div>

            <div class="card">
                <div class="card-icon">➕</div>
                <h2>Nouveau Donneur</h2>
                <p>Enregistrez un nouveau donneur dans la base de données</p>
                <a href="${pageContext.request.contextPath}/donneurs?action=createForm" class="btn btn-success">
                    Ajouter un donneur
                </a>
            </div>

            <div class="card">
                <div class="card-icon">🔍</div>
                <h2>Recherche</h2>
                <p>Recherchez un donneur par son identifiant</p>
                <form action="${pageContext.request.contextPath}/donneurs" method="get" class="search-form">
                    <input type="number" name="id" placeholder="ID du donneur" required>
                    <button type="submit" class="btn btn-info">Rechercher</button>
                </form>
            </div>
        </div>

        <div class="info-section">
            <h3>ℹ️ Informations Importantes</h3>
            <ul>
                <li>Assurez-vous que toutes les informations des donneurs sont exactes</li>
                <li>Vérifiez les contre-indications avant chaque don</li>
                <li>Maintenez à jour le statut de disponibilité des poches de sang</li>
                <li>Respectez la confidentialité des données médicales</li>
            </ul>
        </div>
    </main>

    <footer class="main-footer">
        <p>&copy; 2025 Système de Gestion Banque de Sang. Tous droits réservés.</p>
    </footer>
</div>
</body>
</html>