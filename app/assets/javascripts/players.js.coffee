$(document).on 'turbolinks:load', ->
  url = $('#player-chart').data('url')

  if url?
    $.getJSON(url, (data) ->
      Morris.Bar(
        element: 'player-chart',
        data: data,
        xkey: 'name',
        ykeys: ['count'],
        labels: ['Games Played'],
        xLabelAngle: 35,
        hideHover: true
      )
    )
