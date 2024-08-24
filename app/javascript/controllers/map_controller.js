import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  };

  static targets = ["mapElement", "gig"];

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.mapElementTarget,
      style: "mapbox://styles/erikasmile/clzxtyhiz004301oedck405kp", // Use your custom style
      center: [139.7670, 35.6814], // Central Tokyo coordinates
      zoom: 10 // starting zoom
    });

    // adds Zoom control in the map
    this.map.addControl(new mapboxgl.NavigationControl());

    // adds km to the map
    this.map.addControl(new mapboxgl.ScaleControl());

    // loads the map
    this.map.on('load', this.onMapLoaded.bind(this));

    this.#addMarkersToMap();
    this.#fitMapToBounds(); // Add this line to fit the map to the Tokyo bounds
  }

  onMapLoaded(event) {
    this.map.resize();
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      // Create a custom marker element with the SVG
      const el = document.createElement('div');
      el.innerHTML = `<img src="${this.imagePath('marker.svg')}" width="60" height="60"/>`;

      // Create the marker
      const markerObject = new mapboxgl.Marker(el) 
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);

      // Add click event to show info window
      markerObject.getElement().addEventListener("click", () => {
        this.gigTarget.innerHTML = marker.info_window_html;
      });
    });
  }

  #fitMapToBounds() {
    const bounds = new mapboxgl.LngLatBounds(
      [139.7000, 35.6500], // Southwest coordinates of central Tokyo
      [139.8000, 35.7100] // Northeast coordinates of central Tokyo
    );
    this.map.fitBounds(bounds, { padding: 20 });
  }

  // Helper function to get the asset path
  imagePath(filename) {
    return `assets/images/${filename}`;
  }
}
