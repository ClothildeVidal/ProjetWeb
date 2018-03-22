<%-- 
    Document   : loginClient
    Created on : 16 mars 2018, 09:08:24
    Author     : asanto01
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Client</title>
    </head>
    <body>
        <form action="<c:url value= '/ ' />" method="POST"> <!-- l'action par défaut est l'URL courant, qui va rappeler la servlet -->
		Identifiant : <input name='idClient'><br>
		Mot de passe : <input name='mdpClient' type='password'><br>
		<input type='submit' name='action' value='Connexion'>
	</form>
    </body>
</html>
