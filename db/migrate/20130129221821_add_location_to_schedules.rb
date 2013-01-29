class AddLocationToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :location, :string
  end
end
