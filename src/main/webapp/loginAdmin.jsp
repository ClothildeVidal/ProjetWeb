
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action= "<c:url value='/' />" method="POST"> 
            identifiant : <input name='loginParam'><br>
            mot de passe : <input name='passwordParam' type='password'><br>
            <input type='submit' name='action' value='Connexion'>
        </form>
    </body>
</html>
