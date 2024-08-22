import { Controller } from "@hotwired/stimulus";
import Swal from "sweetalert2";
//window.Swal = Swal;

//data-controller="modal"
export default class extends Controller {
  connect() {}
  confirm(event) {
    event.preventDefault();
    Swal.fire({
      title: "Sure you want to go?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#8E79B9",
      cancelButtonColor: "#e1c5e2",
      confirmButtonText: "Yes!",
    }).then((result) => {
      if (result.isConfirmed) {
        this.registered(event);
      }
    });
  }

  registered(event) {
    console.log(event);
    event.preventDefault();
    Swal.fire({
      title: "You Are Registered!",
      text: "Enjoy the gig!",
      icon: "success",
      confirmButtonText: "Start The Chat!", // route to chatrooms**
      confirmButtonColor: "#8E79B9",
    })
      .then((action) => {
        if (action.isConfirmed) {
          event.target[event.type](); // "submit"
        }
      })
      .catch(event.preventDefault());
  }
}
