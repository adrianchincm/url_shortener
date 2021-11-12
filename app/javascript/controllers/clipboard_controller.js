import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [ "source", "element" ]

  copy() {    
    navigator.clipboard.writeText(this.sourceTarget.value)
    this.elementTarget.classList.remove('invisible');
    setTimeout(() => this.elementTarget.classList.add('invisible'), 1000)
  }

  redirect() {    
    window.open(this.sourceTarget.value, '_blank');
  }
}
