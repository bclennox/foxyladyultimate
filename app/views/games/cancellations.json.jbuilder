dates = @cancellations.map do |cancellation|
  cancellation.date.strftime('%b %Y')
end

json.labels dates

active = {
  label: 'Active',
  data: @cancellations.map(&:active),
  pointRadius: 0,
  backgroundColor: 'rgb(54, 162, 235)'
}

canceled = {
  label: 'Canceled',
  data: @cancellations.map(&:canceled),
  pointRadius: 0,
  backgroundColor: 'rgb(255, 99, 132)'
}

json.datasets [active, canceled]
