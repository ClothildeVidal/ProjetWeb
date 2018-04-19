<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Administrateur</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!--        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        On charge jQuery 
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        On charge le moteur de template mustache https://mustache.github.io/ 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
         On charge le plugin JSONToTable https://github.com/jongha/jquery-jsontotable 
        <script type="text/javascript" 	src="javascript/jquery.jsontotable.min.js"></script>-->
        <script>
            //google.charts.load('current', {'packages': ['corechart']});
            google.charts.load('current', {'packages':['corechart']});
            //google.load("visualization", "1", {packages: ["corechart", 'controls']});
            $(document).ready(// Exécuté à la fin du chargement de la page
                    function () {                     
                        $('#graphique').submit(affichage);

                        //google.load("visualization", "1", {packages: ["corechart", 'controls']});

                    }
            );


            google.setOnLoadCallback(affichage);
//            google.setOnLoadCallback(doAjax2);
//            google.setOnLoadCallback(doAjax3);
//            function drawDashboard() {
//
//                var data = google.visualization.arrayToDataTable(dataArray);
//                var dashboard = new google.visualization.Dashboard(document.getElementById('dashboard_div'));
//                var rangeSlider = new google.visualization.ControlWrapper({
//                    'controlType': 'DateRangeFilter',
//                    'containerId': 'filter_div',
//                    'option': {
//                        'filterColumnLabel': 'Période'
//                    }
//                });
//
//                var options = {'title': 'Chiffre d\'affaires par client'};
//                var pieChart = new google.visualization.ChartWrapper({
//                    'chartType': 'PieChart',
//                    'containerId': 'chart_div',
//                    'options': {
//                        'width': 300,
//                        'height': 300,
//                        'pieSliceText': 'value',
//                        'legend': 'right'
//                    }
//                });
//                dashboard.bind(donutRangeSlider, pieChart);
//
//                // Draw the dashboard.
//                dashboard.draw(data);
//                chart.draw(data, options);
//            }

            function affichage(event) {
                console.log("ccccc");
                event.preventDefault();
                google.charts.setOnLoadCallback(doAjax);
                google.charts.setOnLoadCallback(doAjax2);
                google.charts.setOnLoadCallback(doAjax3);
            }
            function drawChart(dataArray) {

                var data = google.visualization.arrayToDataTable(dataArray);
                var options = {'title': 'Chiffre d\'affaires par client'};

                var chart = new google.visualization.PieChart(document.getElementById('piechart'));
                chart.draw(data, options);
            }

            function drawChart2(dataArray) {

                var data = google.visualization.arrayToDataTable(dataArray);
                var options = {'title': 'Chiffre d\'affaires par produit'};

                var chart = new google.visualization.PieChart(document.getElementById('piechart2'));
                chart.draw(data, options);
            }

            function drawChart3(dataArray) {

                var data = google.visualization.arrayToDataTable(dataArray);
                var options = {'title': 'Chiffre d\'affaires par zone'};

                var chart = new google.visualization.PieChart(document.getElementById('piechart3'));
                chart.draw(data, options);
            }

            function doAjax() {
                $.ajax({
                    url: "CaParClient?dateD="+$('#dateD').val()+"&dateF="+$('#dateF').val(),
                    data: $('#graphique').serialize(),
                    dataType: "json",
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // On reformate le résultat comme un tableau
                                let chartData = [];
                                // On met le descriptif des données
                                chartData.push(["Client", "Ventes"]);
                                for (let client in result.records) {
                                    chartData.push([client, result.records[client]]);
                                }
                                // On dessine le graphique
                                drawChart(chartData);
                            },
                    error: showError
                });
            }

            function doAjax2() {
                $.ajax({
                    url: "CaParProduit?dateD="+$('#dateD').val()+"&dateF="+$('#dateF').val(),
                    data: {"dateD": $("#dateD").val(), "dateF": $("#dateF").val()},
                    dataType: "json",
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // On reformate le résultat comme un tableau
                                var chartData = [];
                                // On met le descriptif des données
                                chartData.push(["Produit", "Ventes"]);
                                for (var produit in result.records) {
                                    chartData.push([produit, result.records[produit]]);
                                }
                                // On dessine le graphique
                                drawChart2(chartData);
                            },
                    error: showError
                });
            }

            function doAjax3() {
                $.ajax({
                    url: "CaParZone?dateD="+$('#dateD').val()+"&dateF="+$('#dateF').val(),
                    data: {"dateD": $("#dateD").val(), "dateF": $("#dateF").val()},
                    dataType: "json",
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // On reformate le résultat comme un tableau
                                var chartData = [];
                                // On met le descriptif des données
                                chartData.push(["Zone", "Ventes"]);
                                for (var zone in result.records) {
                                    chartData.push([zone, result.records[zone]]);
                                }
                                // On dessine le graphique
                                drawChart3(chartData);
                            },
                    error: showError
                });
            }

//            function date() {
//                $.ajax({
//                    url: "CaParZone",
//                    dataType: "json",
//                    success:
//                            function (result) {
//                                // On reformate le résultat comme un tableau
//                                var chartData = [];
//                                // On met le descriptif des données
//                                chartData.push(["Zone", "Ventes"]);
//                                for (var zone in result.records) {
//                                    chartData.push([zone, result.records[zone]]);
//                                }
//                                // On dessine le graphique
//                                drawChart3(chartData);
//                            },
//                    error: showError
//                })
//            }
            // Fonction qui traite les erreurs de la requête


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
        <a href='CaParProduit' target="_blank">Voir les données brutes du chiffre d'affaires par produit</a><br>
        <a href='CaParClient' target="_blank">Voir les données brutes du chiffre d'affaires par client</a><br>
        <a href='CaParZone' target="_blank">Voir les données brutes du chiffre d'affaires par produit</a><br>
        <form id="graphique">
            <input type="date" name="dateD" id="dateD">
            <input type="date" name="dateF" id="dateF">
            <input type='submit' value='Rafraichir'>
        </form>
        <div id="piechart" style="width: 900px; height: 500px;"></div>
        <div id="piechart2" style="width: 900px; height: 500px;"></div>
        <div id="piechart3" style="width: 900px; height: 500px;"></div>
    </body>
</html>