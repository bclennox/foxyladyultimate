self.addEventListener("push", function (event) {
  var data = event.data ? event.data.json() : {}
  var title = data.title || "Foxy Lady Ultimate"
  var options = {
    body: data.body || "",
    icon: data.icon || "/icon.png",
    data: { url: data.url || "/" }
  }

  event.waitUntil(self.registration.showNotification(title, options))
})

self.addEventListener("notificationclick", function (event) {
  event.notification.close()

  event.waitUntil(
    clients.matchAll({ type: "window" }).then(function (clientList) {
      var url = event.notification.data.url || "/"

      for (var i = 0; i < clientList.length; i++) {
        if (clientList[i].url === url && "focus" in clientList[i]) {
          return clientList[i].focus()
        }
      }

      if (clients.openWindow) {
        return clients.openWindow(url)
      }
    })
  )
})
