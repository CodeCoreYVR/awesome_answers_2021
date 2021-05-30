window.initMap = initMap;

const labels = 'ABCDEFG';
let labelsIndex = 0;

function initMap() {
  var vancouver = {lat: 49.13446060467749, lng: -123.00805348478673};
  var map = new google.maps.Map(
      document.getElementById('map'), {zoom: 4, center: vancouver});
  var marker = new google.maps.Marker({position: vancouver, map: map});

  google.maps.event.addListener(map, 'click', function(event) {
    console.log(event.latLng.lat());
    console.log(event.latLng.lng());
    addMarker(event.latLng, map)
  })

  function addMarker(location, map) {
    const marker = new google.maps.Marker({
      position: location,
      label: labels[labelsIndex++ % labels.length],
      map: map
    })
  }
}