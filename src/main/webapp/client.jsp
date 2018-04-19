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
         <!--On charge le plugin JSONToTable https://github.com/jongha/jquery-jsontotable--> 
        <script type="text/javascript" 	src="javascript/jquery.jsontotable.min.js"></script>
        <script>
            $(document).ready(// Exécuté à la fin du chargement de la page
                    function () {
                        listProduits();
//                        fillProductSelector();
//                        showProduits();
                        showCommandes();

                    }
            );

            function fillProductSelector() {
                // On fait un appel AJAX pour chercher les produits existants
                $.ajax({
                    url: "allProduits",
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // Le code source du template est dans la page
                                var template = $('#selectTemplate').html();
                                // On combine le template avec le résultat de la requête
                                var processedTemplate = Mustache.to_html(template, result);
                                // On affiche la liste des options dans le select
                                $('#product').html(processedTemplate);
                                // On initialise l'affichage des clients
                                showCustomersInState();
                            }
                });
            }

            function showProduits() {
                // On fait un appel AJAX pour chercher les codes
                $.ajax({
                    url: "allProduits",
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // Le code source du template est dans la page
                                var template = $('#ProduitsTemplate').html();
                                // On combine le template avec le résultat de la requête
                                var processedTemplate = Mustache.to_html(template, result);
                                // On affiche la liste des options dans le select
                                $('#produits').html(processedTemplate);
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

            function listProduits() {
                // On fait un appel AJAX pour chercher les codes
                $.ajax({
                    url: "ProductForm",
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // Le code source du template est dans la page
                                var template = $('#listProdTemplate').html();
                                // On combine le template avec le résultat de la requête
                                var processedTemplate = Mustache.to_html(template, result);
                                // On affiche la liste des options dans le select
                                $('#choixProduct').html(processedTemplate);
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

//            // Supprimer un code
//            function deleteCode(code) {
//                $.ajax({
//                    url: "deleteCommande",
//                    data: orderID = table.getValueAt(table.getSelectedRow(),1).toString(),
//                    dataType: "json",
//                    success:
//                            console.log(orderID);
//                            function (result) {
//                                showCommandes();
//                                console.log(result);
//                            },
//                    error: showError
//                });
//                return false;
//            }

//            // Modifier un code
//            function modifierCode(code) {
//                $.ajax({
//                    url: "deleteCode",
//                    data: {"code": code},
//                    dataType: "json",
//                    success:
//                            function (result) {
//                                showCodes();
//                                console.log(result);
//                            },
//                    error: showError
//                });
//                return false;
//            }

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
        <!--        <form id="codeForm" onsubmit="event.preventDefault(); addProduct();">-->
        <script id="listProdTemplate" type="text/template">
            <FORM>
            <label for="product">Produit :</label>
            <select id="product">
            {{! Pour chaque enregistrement }}
            {{#records}}
            {{! Une ligne dans la table }}
            <option value="{{.}}">{{.}}</option>
            {{/records}}
            </select>
            </FORM>
        </script>
        <fieldset><legend>Ajout d'un produit à la commande</legend>
            <!--                <form>
                                <label for="product">Produit :</label>-->
            <!--<select id="product">-->
            <div id="choixProduct"></div>
            <!--</select>-->
            <!--</form>-->
            <!--Produit : <input id="code" name="code" size="1" maxlength="1" pattern="[A-Z]{1,1}" title="Une lettre en MAJUSCULES"><br/>-->
            Quantité : <input id="taux" name="taux" type="number" step="1" min="0" max="1000" size="5"><br/>
            <input type="submit" value="Ajouter">
        </fieldset>
    </form>
    <h3>Produits sélectionnés</h3>
    <div id="produits"></div>
    <!--        <script id="selectTemplate" type="text/template">
                                    {{! Pour chaque produit dans le tableau}}
                                    {{#records}}
                                            {{! Une option dans le select }}
                                            {{! le point représente la valeur courante du tableau }}
                                            <OPTION VALUE="{{.}}">{{.}}</OPTION>
                                    {{/records}}
                            </TABLE>
            </script>
            Le template qui sert à formatter la liste des codes 
            <script id="produitsTemplate" type="text/template">
                <TABLE>
                <tr><th>OrderID</th><th>Produit</th><th>Quantite</th><th>Cout</th><th>Description</th></tr>
                {{! Pour chaque enregistrement }}
                {{#records}}
                {{! Une ligne dans la table }}
                <TR><TD>{{orderID}}</TD><TD>{{produit}}</TD><TD>{{quantite}}</TD><TD>{{cout}}</TD><TD>{{description}}</TD></TR>
                {{/records}}
                </TABLE>
            </script>-->
    <h2>Anciennes commandes</h2>
    <div id="codes"></div>
    <!--Le template qui sert à formatter la liste des codes--> 
    <script id="codesTemplate" type="text/template">
            <TABLE id="table">
            <tr><th>OrderID</th><th>Produit</th><th>Quantite</th><th>Cout</th><th>Description</th></tr>
            {{! Pour chaque enregistrement }}
            {{#records}}
            {{! Une ligne dans la table }}
    <TR><TD>{{orderID}}</TD><TD>{{produit}}</TD><TD>{{quantite}}</TD><TD>{{cout}}</TD><TD>{{description}}</TD><TD><button onclick="deleteCode('{{orderID}}')" id="supp">Supprimer</button></TD><TD><button onclick="modifierCode('{{orderID}}')" id="modif">Modifier</button></TD></TR>
    {{/r    ecords}}
            </TABLE>
        </script>
        <div id="commandes"></div>
            <form action="<c:url value='/'/>" method="POST"> 
    <input type='submit' name='action' value='Deconnexion'>
</form>
<li>
    <a href="ProductForm">ProductForm Une servlet qui génère un formulaire de saisie pour la servlet ci-dessus</a></br>
    <a href="ListeCommandes">ListeCommandes Une servlet qui génère un formulaire de saisie pour la servlet ci-dessus</a>
</li>
</body>
</html>