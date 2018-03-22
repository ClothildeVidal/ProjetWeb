<%-- 
    Document   : afficheAdmin
    Created on : 22 mars 2018, 11:39:33
    Author     : asanto01
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vous êtes connecté</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">
    </head>
    <body>
        <h1>Bienvenue ${userName}</h1>
        Vous êtes sur l'espace administrateur.
        <form action="<c:url value='/'/>" method="POST"> 
              <input type='submit' name='action' value='logout'>
        </form>
    </body>
</html>
