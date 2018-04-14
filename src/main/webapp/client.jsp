<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Commande</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- On charge jQuery -->
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <!-- On charge le moteur de template mustache https://mustache.github.io/ -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        <script>
            $(document).ready(// Exécuté à la fin du chargement de la page
                    function () {
                        // On montre la liste des codes
                        showCodes();
                        showCommandes();
                    }
            );

            function showCodes() {
                // On fait un appel AJAX pour chercher les codes
                $.ajax({
                    url: "allCodes",
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // Le code source du template est dans la page
                                var template = $('#codesTemplate').html();
                                // On combine le template avec le résultat de la requête
                                var processedTemplate = Mustache.to_html(template, result);
                                // On affiche la liste des options dans le select
                                $('#codes').html(processedTemplate);
                            }
                });
            }
            function showCommandes() {
                // On fait un appel AJAX pour chercher les commandes
                $.ajax({
                    url: "ListeCommandes",
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // Le code source du template est dans la page
                                var template = $('#codesTemplate').html();
                                // On combine le template avec le résultat de la requête
                                var processedTemplate = Mustache.to_html(template, result);
                                // On affiche la liste des options dans le select
                                $('#commandes').html(processedTemplate);
                            }
                });
            }
            // Ajouter un code
            function addCode() {
                $.ajax({
                    url: "addCode",
                    // serialize() renvoie tous les paramètres saisis dans le formulaire
                    data: $("#codeForm").serialize(),
                    dataType: "json",
                    success: // La fonction qui traite les résultats
                            function (result) {
                                showCodes();
                                console.log(result);
                            },
                    error: showError
                });
                return false;
            }

            // Supprimer un code
            function deleteCode(code) {
                $.ajax({
                    url: "deleteCode",
                    data: {"code": code},
                    dataType: "json",
                    success:
                            function (result) {
                                showCodes();
                                console.log(result);
                            },
                    error: showError
                });
                return false;
            }

            // Fonction qui traite les erreurs de la requête
            function showError(xhr, status, message) {
                alert(JSON.parse(xhr.responseText).message);
            }

        </script>
        <!-- un CSS pour formatter la table -->
        <link rel="stylesheet" type="text/css" href="css/tableformat.css">
    </head>
    <body>
        <h1>Bienvenue ${userName}</h1>
        <!-- On montre le formulaire de saisie -->
        <h1>Edition des taux de remise (AJAX)</h1>
        <form id="codeForm" onsubmit="event.preventDefault(); addCode();">
            <fieldset><legend>Saisie d'un taux de remise</legend>
                Code : <input id="code" name="code" size="1" maxlength="1" pattern="[A-Z]{1,1}" title="Une lettre en MAJUSCULES"><br/>
                Taux : <input id="taux" name="taux" type="number" step="0.01" min="0.0" max="99.99" size="5"><br/>
                <input type="submit" value="Ajouter">
            </fieldset>
        </form>
         <!-- La zone où les résultats vont s'afficher -->
        <div id="codes"></div>

        <!-- Le template qui sert à formatter la liste des codes -->
        <script id="codesTemplate" type="text/template">
            <TABLE>
            <tr><th>Code</th><th>Taux</th><th>Action</th></tr>
            {{! Pour chaque enregistrement }}
            {{#records}}
            {{! Une ligne dans la table }}
            <TR><TD>{{discountCode}}</TD><TD>{{formattedRate}}</TD><TD><button onclick="deleteCode('{{discountCode}}')">Supprimer</button></TD></TR>
            {{/records}}
            </TABLE>
        </script>
        <div id="commandes"></div>
        <form action="<c:url value='/'/>" method="POST"> 
            <input type='submit' name='action' value='Deconnexion'>
        </form>
    </body>
</html>

