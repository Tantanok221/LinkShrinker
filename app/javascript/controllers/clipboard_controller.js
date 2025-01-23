import { Controller } from "@hotwired/stimulus"
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
    }
}