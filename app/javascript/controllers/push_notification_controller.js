import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  async connect() {
    if (!("serviceWorker" in navigator) || !("PushManager" in window)) {
      this.element.hidden = true
      return
    }

    this.registration = await navigator.serviceWorker.ready
    this.updateButton()
  }

  async toggle() {
    var subscription = await this.registration.pushManager.getSubscription()

    if (subscription) {
      await this.unsubscribe(subscription)
    } else {
      await this.subscribe()
    }

    this.updateButton()
  }

  async subscribe() {
    var vapidPublicKey = document.querySelector('meta[name="vapid-public-key"]').content
    var subscription = await this.registration.pushManager.subscribe({
      userVisibleOnly: true,
      applicationServerKey: vapidPublicKey
    })

    var json = subscription.toJSON()
    var token = document.querySelector('meta[name="csrf-token"]').content

    var response = await fetch("/push_subscription", {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-CSRF-Token": token },
      body: JSON.stringify({
        endpoint: json.endpoint,
        p256dh: json.keys.p256dh,
        auth: json.keys.auth
      })
    })

    if (!response.ok) {
      await subscription.unsubscribe()
    }
  }

  async unsubscribe(subscription) {
    var endpoint = subscription.endpoint
    var token = document.querySelector('meta[name="csrf-token"]').content

    await subscription.unsubscribe()

    await fetch("/push_subscription", {
      method: "DELETE",
      headers: { "Content-Type": "application/json", "X-CSRF-Token": token },
      body: JSON.stringify({ endpoint: endpoint })
    })
  }

  async updateButton() {
    var subscription = await this.registration.pushManager.getSubscription()

    if (subscription) {
      this.buttonTarget.textContent = "Disable Push"
    } else {
      this.buttonTarget.textContent = "Enable Push"
    }
  }
}
