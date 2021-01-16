import Chart from 'chart.js'

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
        legend: {
          display: false
        },
        scales: {
          xAxes: [{
            gridLines: {
              display: false
            }
          }],
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      }
    })
  })
}

$(document).on('turbolinks:load', initializePlayerChart)
