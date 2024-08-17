import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modalBody"]
  static values = { id: Number }
  connect() { console.log("Modal controller connected") 
  }

get_modal(event) {
  const parser = new DOMParser()
  fetch(`http://127.0.0.1:3000/gigs/${this.idValue}`)
   .then(response => response.text())
   .then((data) => {
      const gigData = parser.parseFromString(data, "text/html")
      const modal = gigData.querySelector(".confirm-card")
      this.modalBodyTarget.innerHTML = modal.innerHTML
    console.log(data)
   })
}
}
