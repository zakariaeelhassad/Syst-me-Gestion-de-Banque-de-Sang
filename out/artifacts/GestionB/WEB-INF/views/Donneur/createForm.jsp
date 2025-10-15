<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Donneur</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
<div class="container">
    <header class="page-header">
        <h1>➕ Ajouter un Nouveau Donneur</h1>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">🏠 Accueil</a>
            <a href="${pageContext.request.contextPath}/donneurs?action=list" class="btn btn-info">
                📋 Liste des donneurs
            </a>
        </div>
    </header>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">
            ❌ ${errorMessage}
        </div>
    </c:if>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/donneurs" method="post" class="donneur-form">
            <input type="hidden" name="action" value="create">

            <div class="form-section">
                <h2>Informations Personnelles</h2>

                <div class="form-row">
                    <div class="form-group">
                        <label for="nom">Nom <span class="required">*</span></label>
                        <input type="text" id="nom" name="nom" required
                               placeholder="Ex: ALAMI" maxlength="100">
                    </div>

                    <div class="form-group">
                        <label for="prenom">Prénom <span class="required">*</span></label>
                        <input type="text" id="prenom" name="prenom" required
                               placeholder="Ex: Mohammed" maxlength="100">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="cin">CIN <span class="required">*</span></label>
                        <input type="text" id="cin" name="cin" required
                               placeholder="Ex: AB123456" maxlength="20">
                    </div>

                    <div class="form-group">
                        <label for="sexe">Sexe <span class="required">*</span></label>
                        <select id="sexe" name="sexe" required>
                            <option value="">Sélectionnez...</option>
                            <option value="M">Homme</option>
                            <option value="F">Femme</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="dateNaissance">Date de Naissance <span class="required">*</span></label>
                    <input type="date" id="dateNaissance" name="dateNaissance" required
                           max="<%= java.time.LocalDate.now().minusYears(18) %>">
                    <small class="form-text">Le donneur doit avoir au moins 18 ans</small>
                </div>
            </div>

            <div class="form-section">
                <h2>Informations Médicales</h2>

                <div class="form-row">
                    <div class="form-group">
                        <label for="bloodGroup">Groupe Sanguin <span class="required">*</span></label>
                        <select id="bloodGroup" name="bloodGroup" required>
                            <option value="">Sélectionnez...</option>
                            <c:forEach var="bg" items="${bloodGroups}">
                                <option value="${bg}">${bg}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="donorStatus">Statut du Donneur <span class="required">*</span></label>
                        <select id="donorStatus" name="donorStatus" required>
                            <option value="">Sélectionnez...</option>
                            <c:forEach var="status" items="${donorStatuses}">
                                <option value="${status}">${status}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="pocheDisponible">Poches Disponibles <span class="required">*</span></label>
                        <input type="number" id="pocheDisponible" name="pocheDisponible"
                               required min="0" value="0">
                    </div>

                    <div class="form-group">
                        <label for="contreIndication">Contre-indication</label>
                        <div class="checkbox-group">
                            <input type="checkbox" id="contreIndication" name="contreIndication" value="true">
                            <label for="contreIndication">Le donneur a une contre-indication médicale</label>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="notes">Notes / Observations</label>
                    <textarea id="notes" name="notes" rows="4"
                              placeholder="Ajoutez des notes ou observations concernant ce donneur..."></textarea>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    ✅ Enregistrer le donneur
                </button>
                <a href="${pageContext.request.contextPath}/donneurs?action=list" class="btn btn-secondary">
                    ❌ Annuler
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    // Set max date to 18 years ago
    const maxDate = new Date();
    maxDate.setFullYear(maxDate.getFullYear() - 18);
    document.getElementById('dateNaissance').max = maxDate.toISOString().split('T')[0];
</script>
</body>
</html>