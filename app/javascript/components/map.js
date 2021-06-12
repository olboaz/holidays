const createMap = () => {

  var carte = document.getElementById('mapid')
  if(carte) {
    var map = L.map('mapid').setView({lon: 2.209667, lat: 46.232193}, 6.3);

    // add the OpenStreetMap tiles
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap contributors</a>'
    }).addTo(map);

    // show the scale bar on the lower left corner
    L.control.scale().addTo(map);


    // show a marker on the map
    //L.marker({lon: 2.333333, lat: 48.866667}).bindPopup('Paris').addTo(map);
    var markers = JSON.parse(carte.dataset.markers)
    markers.forEach((marker) => {
      L.marker({lon: marker.lng, lat: marker.lat}).bindPopup(`${marker.name}<br>${marker.pseudo}`).addTo(map);

    });


  }

}

export {createMap};
