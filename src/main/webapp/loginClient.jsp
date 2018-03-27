<%-- 
    Document   : loginClient
    Created on : 27 mars 2018, 09:03:53
    Author     : asanto01
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Bienvenue dans notre application</h1>
         <form action= "<affiche.jsp'>" method="POST"> 
            identifiant : <input name='loginParamC'><br>
            mot de passe : <input name='passwordParamC' type='password'><br>
            <input type='submit' name='action' value='Connexion'>
        </form>
    </body>
</html>
