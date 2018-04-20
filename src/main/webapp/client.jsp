<%@ page contentType="text/html" pageEncoding="UTF-8" %>
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
        <link rel="stylesheet" href="css/client.css" type="text/css" media="screen" />
        <script>
            $(document).ready(// Exécuté à la fin du chargement de la page
                    function () {
                       $('#newCommande').submit(affichageComm);
                        listProduits();
                        showCommandes();
                    }
            );

            function affichageComm(event) {
                event.preventDefault();
                addProduct();
            }

            function showCommandes() {
                // On fait un appel AJAX pour chercher les commandes
                var name = "${userName}";
                $.ajax({
                    url: "ListeCommandes",
                    //url de la servlet ListeCommandes
                    data: {"userName": name},
                    //on rÃ©cupÃ¨re le nom d'utilisateur
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les rÃ©sultats
                            function (result) {
                                // Le code source du template est dans la page
                                var template = $('#codesTemplate').html();
                                // On combine le template avec le rÃ©sultat de la requÃªte
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
                    //url de la servlet ProductForm
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les rÃ©sultats
                            function (result) {
                                // Le code source du template est dans la page
                                var template = $('#listProdTemplate').html();
                                // On combine le template avec le rÃ©sultat de la requÃªte
                                var processedTemplate = Mustache.to_html(template, result);
                                // On affiche la liste des options dans le select
                                $('#choixProduct').html(processedTemplate);
                            }
                });
            }
            // Ajouter un produit
            function addProduct() {
                var id = "${userID}";
                $.ajax({
                    url: "addProduct",
                    //url de la servlet AddProductJsonServlet
                    data: {"produit":'#product'.value, "qte":'#taux'.value, "userID": id},
                    dataType: "json",
                    success: // La fonction qui traite les rÃ©sultats
                            function (result) {
                                showCommandes();
                                console.log(result);
                            },
                    error: showError
                });
                return false;
            }

            function deleteCommande(orderNum) {
                $.ajax({
                    url: "deleteCommande",
                    //url de la servlet AddProductJsonServlet
                    data: {"orderNum": orderNum},
                    dataType: "json",
                    success: // La fonction qui traite les rÃ©sultats
                            function (result) {
                                showCommandes();
                                console.log(result);
                            },
                    error: showError
                });
                return false;
            }

            // Fonction qui traite les erreurs de la requÃªte
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
        <form id="newCommande">
            <fieldset><legend>Ajout d'un produit à la commande</legend>
                <div id="choixProduct"></div>
                Quantité : <input id="taux" name="taux" type="number" step="1" min="0" max="1000" size="5"><br/>
                <input type="submit" value="Ajouter">
            </fieldset>
        </form>
    </form>
    <h2>Anciennes commandes</h2>
    <div id="codes"></div>
    <!--Le template qui sert Ã  formatter la liste des codes--> 
    <script id="codesTemplate" type="text/template">
        <TABLE id="table">
        <tr><th>OrderID</th><th>Produit</th><th>Quantite</th><th>Cout</th><th>Description</th></tr>
        {{! Pour chaque enregistrement }}
        {{#records}}
        {{! Une ligne dans la table }}
        <TR><TD>{{orderID}}</TD><TD>{{produit}}</TD><TD>{{quantite}}</TD><TD>{{cout}}</TD><TD>{{description}}</TD><TD><button onclick="deleteCommande('{{orderID}}')">Supprimer</button></TD><TD><button onclick="modifierCode('{{orderID}}')" id="modif">Modifier</button></TD></TR>
        {{/records}}
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