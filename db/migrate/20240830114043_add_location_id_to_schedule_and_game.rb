class AddLocationIdToScheduleAndGame < ActiveRecord::Migration[7.1]
  def up
    add_belongs_to :schedules, :location, null: true, index: false, foreign_key: true
    add_belongs_to :games, :location, null: true, index: false, foreign_key: true

    dillard = Location.create!(name: 'Dillard Drive Elementary', url: 'https://www.openstreetmap.org/node/357813514')
    dix = Location.create!(name: 'Dorothea Dix Park', url: 'https://www.openstreetmap.org/way/194996668')

    Schedule.instance.update!(location: dix)
    Game.update_all(location_id: dillard.id)

    change_column_null :schedules, :location_id, false
    change_column_null :games, :location_id, false
  end

  def down
    remove_belongs_to :schedules, :location
    remove_belongs_to :games, :location

    Location.destroy_all
  end
end
