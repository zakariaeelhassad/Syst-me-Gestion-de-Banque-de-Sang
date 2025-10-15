<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Donneurs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
<div class="container">
    <header class="page-header">
        <h1>📋 Liste des Donneurs de Sang</h1>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">🏠 Accueil</a>
            <a href="${pageContext.request.contextPath}/donneurs?action=createForm" class="btn btn-success">
                ➕ Ajouter un donneur
            </a>
        </div>
    </header>

    <c:if test="${param.success == 'true'}">
        <div class="alert alert-success">
            ✅ Donneur ajouté avec succès !
        </div>
    </c:if>

    <div class="stats-section">
        <div class="stat-card">
            <span class="stat-number">${totalDonneurs}</span>
            <span class="stat-label">Donneurs Total</span>
        </div>
    </div>

    <div class="table-container">
        <c:choose>
            <c:when test="${empty donneurs}">
                <div class="empty-state">
                    <p>😔 Aucun donneur trouvé dans la base de données</p>
                    <a href="${pageContext.request.contextPath}/donneurs?action=createForm" class="btn btn-primary">
                        Ajouter le premier donneur
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>CIN</th>
                        <th>Sexe</th>
                        <th>Date de naissance</th>
                        <th>Groupe sanguin</th>
                        <th>Contre-indication</th>
                        <th>Poche disponible</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="donneur" items="${donneurs}">
                        <tr>
                            <td>${donneur.id}</td>
                            <td>${donneur.nom}</td>
                            <td>${donneur.prenom}</td>
                            <td>${donneur.cin}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${donneur.sexe == 'M'}">👨 Homme</c:when>
                                    <c:when test="${donneur.sexe == 'F'}">👩 Femme</c:when>
                                    <c:otherwise>${donneur.sexe}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${donneur.dateNaissance}</td>
                            <td>
                                <span class="badge badge-blood">${donneur.bloodGroup}</span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${donneur.contreIndication}">
                                        <span class="badge badge-danger">⚠️ Oui</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-success">✅ Non</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${donneur.pocheDisponible}</td>
                            <td>
                                        <span class="badge badge-status-${donneur.donorStatus}">
                                                ${donneur.donorStatus}
                                        </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/donneurs/${donneur.id}"
                                   class="btn btn-sm btn-info">
                                    👁️ Détails
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>