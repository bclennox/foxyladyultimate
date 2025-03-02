import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto'

export default class extends Controller {
  static targets = ['input', 'chart']
  static values = { url: String }

  #chart

  defaultOptions = {
    type: 'bar',
    options: {
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        x: {
          grid: {
            display: false
          }
        },
        y: {
          ticks: {
            beginAtZero: true
          }
        }
      }
    }
  }

  connect() {
    this.load()
  }

  async load() {
    const url = new URL(this.urlValue)
    url.searchParams.append("since", this.inputTarget.value)

    const response = await fetch(url)
    const data = await response.json()

    const options = Object.assign({}, this.defaultOptions, {
      data: {
        labels: data.map((el) => el.name),
        datasets: [{
          data: data.map((el) => el.count),
          backgroundColor: 'rgba(54, 162, 235, 0.75)'
        }]
      }
    })

    this.#chart?.destroy()
    this.#chart = new Chart(this.chartTarget, options)
  }
}
