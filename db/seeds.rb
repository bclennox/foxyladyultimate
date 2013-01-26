require 'yaml'

Player.delete_all
YAML.load_file(File.join(File.dirname(__FILE__), 'seeds', 'players.yml')).each_pair do |key, player|
  Player.create!(player)
end
