<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrateur</title>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">

            google.charts.load("visualization", "1", {packages: ["corechart"]});
            google.setOnLoadCallback(doAjax);
//            google.setOnLoadCallback(doAjax2);
//            google.setOnLoadCallback(doAjax3);

            function drawChart(dataArray) {

                var data = google.visualization.arrayToDataTable(dataArray);
                var options = {'title': 'Chiffre d affaires'};

                var chart = new google.visualization.PieChart(document.getElementById('piechart'));
                chart.draw(data, options);
            }
//            function doAjax() {
//                $.ajax({
//                    url: "CaParProduit",
//                    dataType: "json",
//                    success: // La fonction qui traite les résultats
//                            function (result) {
//                                // On reformate le résultat comme un tableau
//                                var chartData = [];
//                                // On met le descriptif des données
//                                chartData.push(["Produit", "Ventes"]);
//                                for (var produit in result.records) {
//                                    chartData.push([produit, result.records[produit]]);
//                                }
//                                // On dessine le graphique
//                                drawChart(chartData);
//                            },
//                    error: showError
//                });
//            }
//            function doAjax2() {
//                $.ajax({
//                    url: "CaParZone",
//                    dataType: "json",
//                    success: // La fonction qui traite les résultats
//                            function (result) {
//                                // On reformate le résultat comme un tableau
//                                var chartData = [];
//                                // On met le descriptif des données
//                                chartData.push(["Zone", "Ventes"]);
//                                for (var produit in result.records) {
//                                    chartData.push([zone, result.records[zone]]);
//                                }
//                                // On dessine le graphique
//                                drawChart(chartData);
//                            },
//                    error: showError
//                });
//            }

            // Fonction qui traite les erreurs de la requête
           
            function doAjax() {
                $.ajax({
                    url: "CaParClient",
                    dataType: "json",
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // On reformate le résultat comme un tableau
                                var chartData = [];
                                // On met le descriptif des données
                                chartData.push(["Client", "Ventes"]);
                                for (var client in result.records) {
                                    chartData.push([client, result.records[client]]);
                                }
                                // On dessine le graphique
                                drawChart(chartData);
                            },
                    error: showError
                });
            }
             function showError(xhr, status, message) {
                alert("Erreur: " + status + " : " + message);
            }
        </script>
    </head>
    <body>
        <h1>Bienvenue ${userName}</h1>
        Vous avez maintenant accès aux fichiers dans le répertoire 
        "<a href="<c:url value="protected/protectedPage1.html"/>">protected</a>".<br>
        <form action="<c:url value='/'/>" method="POST"> 
            <input type='submit' name='action' value='Deconnexion'>
        </form>
        <hr/>
        <h3>Il y a actuellement ${applicationScope.numberConnected} utilisateurs connectés</h3>
        <a href='CaParProduit' target="_blank">Voir les données brutes du chiffre d affaires par produit</a><br>
        <a href='CaParClient' target="_blank">Voir les données brutes du chiffre d affaires par client</a><br>
        <div id="piechart" style="width: 900px; height: 500px;"></div>
    </body>
</html>