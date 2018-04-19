<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
  <head>
      <meta charset="utf-8">
    <style>
       #map {
        height: 400px;
        width: 100%;
       }
    </style>
  </head>
  <body>
    <h3>Castres</h3>
    <div id="map"></div>
    <script>
      function initMap() {
        var castres = {lat: 43.623725 , lng: 2.265456};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 4,
          center: castres
        });
        var marker = new google.maps.Marker({
          position: castres,
          map: map
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOwo2G42X4V-__kqCdgvEQabCwoa_OUXE&callback=initMap">
    </script>
  </body>
</html>
