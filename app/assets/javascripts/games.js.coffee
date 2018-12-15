$(document).on 'turbolinks:load', ->
  $(document).on 'click', '.action-link', (e) ->
    e.preventDefault()
    modal_id = $(this).attr('id').replace(/link$/, 'modal')
    $("##{modal_id}").modal('show')

  el = $("#cancellations")
  $.getJSON el.data('url'), (data) ->
    chart = new Chart(el, {
      type: 'line',
      data: data,
      options: {
        elements: {
          line: {
            tension: 0
          }
        },
        tooltips: {
          mode: 'index',
          intersect: false
        },
        scales: {
          yAxes: [{
            stacked: true,
            ticks: {
              beginAtZero:true
            }
          }]
        }
      }
    })
