<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Vous êtes connecté</title>
	</head>
	<body>
		<h1>Bienvenue ${userName}</h1>
		Vous êtes sur l'espace client.

		<form action="<c:url value='/'/>" method="POST"> 
			<input type='submit' name='action' value='logout'>
		</form>
	</body>
</html>
