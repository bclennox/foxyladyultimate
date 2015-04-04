json.array!(players) do |player|
  json.name player.short_name
  json.count player.games_played
end
