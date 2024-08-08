import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  };

  static targets = ["mapElement", "gig"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.mapElementTarget,
      style: "mapbox://styles/mapbox/streets-v10",
    });

    this.#addMarkersToMap();
    this.#fitMapToBounds(); // Add this line to fit the map to the Tokyo bounds
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      // Popup loads up _info_window.html.erb partial
      // const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      const markerObject = new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        // .setPopup(popup)
        .addTo(this.map); // use GetElement to get HTML Element from marker and add event
        markerObject.getElement().addEventListener("click", () => {
        // alert("Clicked");
        this.gigTarget.innerHTML = marker.info_window_html;
      });
    });
  }

  #fitMapToBounds() {
    const bounds = new mapboxgl.LngLatBounds(
      [138.9414, 35.5233], // Southwest coordinates of Tokyo
      [140.1544, 35.8175] // Northeast coordinates of Tokyo
    );
    this.map.fitBounds(bounds, { padding: 20 });
  }
}
