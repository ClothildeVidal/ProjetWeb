<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Connexion Administrateur</title>
        <link rel="stylesheet" href="css/conn-admin.css" type="text/css" media="screen" />
    </head>
    <body>
        <h1>Bonjour administrateur, <br> merci de vous authentifier</h1>


        <div id="form">
            <form action= "<c:url value='/' />" method="POST">
                Identifiant : <input name='loginParam' placeholder="Ex : untel" ><br>
                Mot de passe : <input name='passwordParam' placeholder="Ex : ABCD" type='password' >
                <input type='submit' name='action' id="button" value='Connexion'>
            </form>
            <br> </br>
        </div>
      <br><br>  <p id="Retour"><a href="index.jsp"><img src="images/retour.png" alt=""></a></p></br></br>
    </body>
</html>

