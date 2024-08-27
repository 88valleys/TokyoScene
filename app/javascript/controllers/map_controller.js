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
    this.#fitMapToFilteredMarkers(); // Fit the map to show most markers
  }

  onMapLoaded(event) {
    this.map.resize();
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      // Create a custom marker element with the SVG
      const el = document.createElement('div');
      el.innerHTML = marker.marker_html.trim();

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

  #fitMapToFilteredMarkers() {
    if (this.markersValue.length === 0) return;

    // Step 1: Calculate the average center of all markers
    let totalLat = 0;
    let totalLng = 0;

    this.markersValue.forEach((marker) => {
      totalLat += marker.lat;
      totalLng += marker.lng;
    });

    const centerLat = totalLat / this.markersValue.length;
    const centerLng = totalLng / this.markersValue.length;

    // Step 2: Filter out markers that are too far from the center
    const filteredMarkers = this.markersValue.filter((marker) => {
      const distance = this.#calculateDistance(centerLat, centerLng, marker.lat, marker.lng);
      return distance <= 5; // Set a threshold (e.g., 5 kilometers) to filter out markers that are farther away.
    });

    // Step 3: Adjust the map bounds to include only the filtered markers
    const bounds = new mapboxgl.LngLatBounds();

    filteredMarkers.forEach((marker) => {
      bounds.extend([marker.lng, marker.lat]);
    });

    this.map.fitBounds(bounds, { padding: 20, maxZoom: 15 });
  }

  // Helper function to calculate the distance between two coordinates (in kilometers)
  #calculateDistance(lat1, lng1, lat2, lng2) {
    const R = 6371; // Earth's radius in kilometers
    const dLat = this.#toRad(lat2 - lat1);
    const dLng = this.#toRad(lng2 - lng1);
    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(this.#toRad(lat1)) * Math.cos(this.#toRad(lat2)) *
      Math.sin(dLng / 2) * Math.sin(dLng / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }

  // Helper function to convert degrees to radians
  #toRad(deg) {
    return deg * (Math.PI / 180);
  }
}
