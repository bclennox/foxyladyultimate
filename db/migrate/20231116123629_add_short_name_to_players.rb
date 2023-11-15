class AddShortNameToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :short_name, :string

    up_only do
      PopulatePlayerShortNames.call
    end

    change_column_null :players, :short_name, false
  end
end
