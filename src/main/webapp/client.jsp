<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Commande</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--On charge jQuery--> 
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <!--On charge le moteur de template mustache https://mustache.github.io/--> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        <!-- On charge le plugin JSONToTable https://github.com/jongha/jquery-jsontotable -->
        <script type="text/javascript" 	src="javascript/jquery.jsontotable.min.js"></script>
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
                var name = "${userName}";
                $.ajax({
                    url: "ListeCommandes",
                    data: {"userName": name},
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les résultats
                            /*function (result) {
                             $("#commandes").empty();
                             // On convertit les enregistrements en table HTML
                             $.jsontotable(result.records, {id: "#commandes", header: false});
                             }*/
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
            // Ajouter un code
            function addProduct() {
                $.ajax({
                    url: "addProduct",
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
        <!--un CSS pour formatter la table--> 
        <link rel="stylesheet" type="text/css" href="css/tableformat.css">
    </head>
    <body>
        <h1>Bienvenue ${userName}</h1>
        <h2>Edition d'une nouvelle commande</h2>
        <form id="codeForm" onsubmit="event.preventDefault(); addProduct();">
            <fieldset><legend>Ajout d'un produit à la commande</legend>
                Produit : <input id="code" name="code" size="1" maxlength="1" pattern="[A-Z]{1,1}" title="Une lettre en MAJUSCULES"><br/>
                Quantité : <input id="taux" name="taux" type="number" step="1" min="0" max="1000" size="5"><br/>
                <input type="submit" value="Ajouter">
            </fieldset>
        </form>
        <h2>Anciennes commandes</h2>
        <div id="codes"></div>

        <!--Le template qui sert à formatter la liste des codes--> 
        <script id="codesTemplate" type="text/template">
            <TABLE>
            <tr><th>OrderID</th><th>Produit</th><th>Quantite</th><th>Cout</th><th>Description</th></tr>
            {{! Pour chaque enregistrement }}
            {{#records}}
            {{! Une ligne dans la table }}
            <TR><TD>{{orderID}}</TD><TD>{{produit}}</TD><TD>{{quantite}}</TD><TD>{{cout}}</TD><TD>{{description}}</TD></TR>
            {{/records}}
            </TABLE>
        </script>
        <div id="commandes"></div>
        <form action="<c:url value='/'/>" method="POST"> 
            <input type='submit' name='action' value='Deconnexion'>
        </form>
    </body>
</html>