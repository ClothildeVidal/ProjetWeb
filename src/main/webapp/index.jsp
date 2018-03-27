<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Please login</title>
    </head>
    <body>

        <h1>Bienvenue dans notre application</h1>

        <form action="<c:url value="affiche.jsp" />" method="POST"> 
            identifiant (untel) : <input name='loginParam'><br>
            mot de passe (ABCD): <input name='passwordParam' type='password'><br>
            <input type='submit' name='action' value='Connexion'>
        </form>
    </body>
</html>
