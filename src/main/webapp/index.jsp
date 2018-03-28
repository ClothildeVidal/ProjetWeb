<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bienvenue</title>
        <link rel="stylesheet" href="css/accueil.css" type="text/css" media="screen" />
    <body>
        <section id="accueil">
            <section id="client">
                <p><a href="loginClient.jsp" >Client</a></p>
            </section>
            <section id="administrateur">
                <p><a href="loginAdmin.jsp" >Administrateur</a></p>
            </section>
        </section>
    </body>
</html>
