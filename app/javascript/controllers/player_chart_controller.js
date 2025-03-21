import { Controller } from '@hotwired/stimulus'
import { Chart, registerables } from 'chart.js'

Chart.register(...registerables)

export default class extends Controller {
  static targets = ['input', 'chart']

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
    const url = new URL(this.element.action)
    url.searchParams.append('since', this.inputTarget.value)

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
