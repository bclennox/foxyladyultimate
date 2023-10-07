import $ from 'jquery'
import Chart from 'chart.js/auto'

const initializePlayerChart = () => {
  const canvas = $('#player-chart')

  $.getJSON(canvas.data('url'), (data) => {
    const chart = new Chart(canvas, {
      type: 'bar',
      data: {
        labels: data.map((el) => el.name),
        datasets: [{
          data: data.map((el) => el.count),
          backgroundColor: 'rgba(54, 162, 235, 0.75)'
        }]
      },
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
    })
  })
}

$(document).on('turbolinks:load', initializePlayerChart)
