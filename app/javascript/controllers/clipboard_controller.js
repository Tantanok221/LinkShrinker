import { Controller } from "@hotwired/stimulus"
import Toastify from "toastify-js"

export default class extends Controller {
    static values = { text: String }

    copy() {
        console.log(this.textValue)
        navigator.clipboard.writeText(this.textValue)
            .then(() => {
                console.log('Copied to clipboard:', this.textValue)
            })
            .catch(err => {
                console.error('Failed to copy:', err)
            })
        Toastify({
            text: "Copied to clipboard!",
            duration: 3000,
            newWindow: true,
            gravity: "bottom", // `top` or `bottom`
            position: "right", // `left`, `center` or `right`
            stopOnFocus: true, // Prevents dismissing of toast on hover
            style: {
                background: "white",
                color: "black"
            },
            onClick: function(){} // Callback after click
        }).showToast();
    }
}