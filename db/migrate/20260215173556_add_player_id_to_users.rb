class AddPlayerIdToUsers < ActiveRecord::Migration[8.0]
  def change
    # Add column (nullable initially for data population)
    add_column :users, :player_id, :bigint

    # Populate by matching emails (case-insensitive)
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE users
          SET player_id = (
            SELECT players.id
            FROM players
            WHERE LOWER(players.email) = LOWER(users.email)
            LIMIT 1
          )
        SQL
      end
    end

    # Add NOT NULL constraint after population
    change_column_null :users, :player_id, false

    # Add foreign key constraint
    add_foreign_key :users, :players
  end
end
