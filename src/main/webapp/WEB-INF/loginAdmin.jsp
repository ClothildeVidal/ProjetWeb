<%-- 
    Document   : loginAdmin
    Created on : 16 mars 2018, 09:10:44
    Author     : asanto01
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrateur</title>
    </head>
    <body>
        <form action="<c:url value='/' />" method="POST"> <!-- l'action par défaut est l'URL courant, qui va rappeler la servlet -->
            Identifiant (admin) : <input name='idAdmin'><br>
            Mot de passe (ABCD): <input name='mdpAdmin' type='password'><br>
            <input type='submit' name='action' value='Connexion'>
        </form>
    </body>
</html>
