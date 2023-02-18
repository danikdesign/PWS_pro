import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
    static values = {
        id: String
    }
    connect() {
        console.log(this.element)
    }
    getCard() {
        Turbo.visit(`clients/${this.idValue}`)
    }
}