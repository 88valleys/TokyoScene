import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2';
//window.Swal = Swal;

//data-controller="modal"
export default class extends Controller {
    connect(){
    }
    fire(event) {
        console.log(event);
        event.preventDefault();
        Swal.fire({
            title: "You Are Registered!",
            text: "Enjoy the gig!",
            icon: "success",
            button: "Aww yiss!",
        }).then((action) => {
            if (action.isConfirmed) {
              event.target[event.type](); // "submit"
            }
          })
          .catch(event.preventDefault())
      }
    }
