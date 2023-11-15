module PopulatePlayerShortNames
  def self.call
    singles, duplicates = Player.all
      .group_by(&:first_name)
      .partition { _2.one? }
      .map { _1.map(&:last).flatten }

    singles.each do |player|
      player.update!(short_name: player.first_name)
    end

    duplicates.each do |player|
      player.update!(short_name: player.name)
    end
  end
end
