<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Connexion Client</title>
        <link rel="stylesheet" href="css/conn-client.css" type="text/css" media="screen" />
    </head>
    <body>
        <h1>Connexion</h1>

<!--        <div style="color:red">${errorMessage}</div> -->
        <div id="form">
            <form action="<c:url value="/" />" method="POST"> <!-- l'action par défaut est l'URL courant, qui va rappeler la servlet -->
                Identifiant : <input name='loginParam'><br>
                Mot de passe : <input name='passwordParam' type='password'><br>
                <input type='submit' name='action' value='Connexion'>
            </form>
        </div>
        <p id="Retour"><a href="index.jsp">Retour</a></p>
    </body>
</html>
