<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Bienvenue dans notre application</h1>
        Pour avoir accès aux fichiers dans le répertoire 
        "<a href="protected/protectedPage.html">protected</a>", merci de vous identifier.<br>
        <%--
        La servlet fait : request.setAttribute("errorMessage", "Login/Password incorrect");
        La JSP récupère cette valeur dans ${errorMessage}
        --%>
        <div style="color:red">${errorMessage}</div>

        <form action="<c:url value="/" />" method="POST"> <!-- l'action par défaut est l'URL courant, qui va rappeler la servlet -->
            Identifiant : <input name='loginParam'><br>
            Mot de passe : <input name='passwordParam' type='password'><br>
            <input type='submit' name='action' value='Connexion'>
        </form>
    </body>
</html>
