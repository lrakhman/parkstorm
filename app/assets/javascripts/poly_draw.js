function draw_red(region, map) {
  var geo = region.geometries[1].coordinates;
  for (var j=0; j<geo.length; j++) { 
    var coords = geo[j];
    if (coords.length > 1) {
      var polygonCoords = [];
      for(var i=0; i<coords.length; i++) {
        polygonCoords.push([coords[i][1], coords[i][0]]);
      }
      L.polygon(polygonCoords, {color: 'red'}).addTo(map);
    } else {
      for (var k=0; k< coords.length; k++) {
        coords2 = coords[k];
        var polygonCoords = [];
        for(var i=0; i<coords2.length; i++) {
          polygonCoords.push([coords2[i][1], coords2[i][0]]);
        }
        L.polygon(polygonCoords, {color: 'red'}).addTo(map);
      }
    }
  }
}

function draw_green(region, map) {
  var geo = region.geometries[1].coordinates;
  for (var j=0; j<geo.length; j++) { 
    var coords = geo[j];
    if (coords.length > 1) {
      var polygonCoords = [];
      for(var i=0; i<coords.length; i++) {
        polygonCoords.push([coords[i][1], coords[i][0]]);
      }
      L.polygon(polygonCoords, {color: 'green'}).addTo(map);
    } else {
      for (var k=0; k< coords.length; k++) {
        coords2 = coords[k];
        var polygonCoords = [];
        for(var i=0; i<coords2.length; i++) {
          polygonCoords.push([coords2[i][1], coords2[i][0]]);
        }
        L.polygon(polygonCoords, {color: 'green'}).addTo(map);
      }
    }
  }
}
