<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrateur</title>
    </head>
    <body>
        <h1>Bienvenue ${userName}</h1>
        Vous avez maintenant accès aux fichiers dans le répertoire 
        "<a href="<c:url value="protected/protectedPage1.html"/>">protected</a>".<br>
        <form action="<c:url value='/'/>" method="POST"> 
            <input type='submit' name='action' value='Deconnexion'>
        </form>
        <hr/>
        <h3>Il y a actuellement ${applicationScope.numberConnected} utilisateurs connectés</h3>
    </body>
</html>