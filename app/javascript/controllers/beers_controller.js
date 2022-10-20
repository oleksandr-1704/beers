import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'

export default class extends Controller {
  static targets = ['preview']

  async filter(event) {
    const target = this.previewTarget.id
    const filter = event.target.value
    const params = new URLSearchParams({
      filter: filter,
      target: target
    })

    const response = await get(`/beers/search?${params.toString()}`, {
      responseKind: 'turbo-stream'
    })
  }
}