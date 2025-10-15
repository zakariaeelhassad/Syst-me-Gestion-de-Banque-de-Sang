<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Erreur</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
<h1 style="color:red;">Une erreur est survenue ❌</h1>
<p>${errorMessage}</p>
<a href="${pageContext.request.contextPath}/donneurs?action=list">⬅ Retour à la liste</a>
</body>
</html>
