<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Commande</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        On charge jQuery 
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        On charge le moteur de template mustache https://mustache.github.io/ 
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
                /*                // Quel est le client connecté ?
                 var selectedCustomer = ${userName};
                 // On fait un appel AJAX pour chercher les commandes de ce client
                 $.ajax({
                 url: "ListeCommandes",
                 // Transmettre des paramètres à la servlet
                 data: {"username": selectedCustomer},
                 dataType: "json",
                 success: // La fonction qui traite les résultats
                 function (result) {
                 $("#customers").empty();
                 // On convertit les enregistrements en table HTML
                 $.jsontotable(result.records, {id: "#customers", header: false});
                 },
                 error: showError
                 });
                 }*/
                // On fait un appel AJAX pour chercher les commandes
                var name = "${userName}";
                $.ajax({
                    url: "ListeCommandes",
                    data: {"userName": name},
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les résultats
                            function (result) {
                                $("#commandes").empty();
                                // On convertit les enregistrements en table HTML
                                $.jsontotable(result.records, {id: "#commandes", header: false});
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
        un CSS pour formatter la table 
        <link rel="stylesheet" type="text/css" href="css/tableformat.css">
    </head>
    <body>
        <h1>Bienvenue ${userName}</h1>
        On montre le formulaire de saisie 
        <h1>Edition d'une nouvelle commande</h1>
        <form id="codeForm" onsubmit="event.preventDefault(); addProduct();">
            <fieldset><legend>Ajout d'un produit à la commande</legend>
                Produit : <input id="code" name="code" size="1" maxlength="1" pattern="[A-Z]{1,1}" title="Une lettre en MAJUSCULES"><br/>
                Quantité : <input id="taux" name="taux" type="number" step="1" min="0" max="1000" size="5"><br/>
                <input type="submit" value="Ajouter">
            </fieldset>
        </form>
          La zone où les résultats vont s'afficher 
        <div id="codes"></div>

        Le template qui sert à formatter la liste des codes 
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

<!--<!DOCTYPE html>
<html>
        <head>
                <title>Commande</title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                 On charge jQuery 
                <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
                 On charge le plugin JSONToTable https://github.com/jongha/jquery-jsontotable 
                <script type="text/javascript" 	src="javascript/jquery.jsontotable.min.js"></script>
                <script>
                        $(document).ready(// Exécuté à la fin du chargement de la page
                                function () {
                                        // On remplit le <select> avec les états existants
                                        fillCustomerSelector();
                                        // Quand on sélectionnne un nouvel état, on affiche les clients de cet état
                                        $("#customer").change(showCommande);
                                }
                        );
                        
                        function fillCustomerSelector() {
                                // On fait un appel AJAX pour chercher les états existants
                                $.ajax({
                                        url: "clientInJSON",
                                        dataType: "json",
                                        error: showError,
                                        success: // La fonction qui traite les résultats
                                                function(result) {
                                                        var select = $('#custome');
                                                        // Pour chaque état dans le résultat
                                                        $.each(result.records, 
                                                                function(customerIndex) {
                                                                        // On ajoute une option dans le select
                                                                        var customerCode = result.records[customerIndex];
                                                                        var option = new Option(customerCode, customerCode);
                                                                        //var option = new Option(stateCode, stateCode, stateIndex === 0, stateIndex === 0);
                                                                        select.append($(option));
                                                                }
                                                        );
                                                        // On initialise l'affichage 
                                                        showCommande();		
                                                }
                                });								
                        }

                        
                        // Afficher les clients dans l'état sélectionné
                        function showCommande() {
                                // Quel est l'état sélectionné ?
                                var selectedCustomer = $("#customer").val();	
                                // On fait un appel AJAX pour chercher les clients de cet état
                                $.ajax({
                                        url: "customersInJSON",
                                        // Transmettre des paramètres à la servlet
                                        data: { "customer" : selectedCustomer },
                                        dataType: "json",
                                        success: // La fonction qui traite les résultats
                                                function(result) {
                                                        $("#commandes").empty();
                                                        // On convertit les enregistrements en table HTML
                                                        $.jsontotable(result.records, {id: "#commandes", header: false});
                                                },
                                        error: showError
                                });				
                        }

                        // Fonction qui traite les erreurs de la requête
                        function showError(xhr, status, message) {
                                $("#erreur").html("Erreur: " + status + " : " + message);
                        }
                </script>
                 un CSS pour formatter la table 
                <link rel="stylesheet" type="text/css" href="css/tableformat.css">
        </head>
        <body>
                
                <div id="erreur"></div>
                <form>
                        <label for="customer">Choose customer</label>
                        <select id="customer"></select>
                </form>

                 
                <h2>Commandes de ce client</h2>
                 La zone où les résultats vont s'afficher 
                <div id="commandes"></div>
        </body>
</html>-->