class CreateQuips < ActiveRecord::Migration[6.1]
  def up
    create_table :quips do |t|
      t.references :player, null: false, foreign_key: true
      t.text :confirmation, null: false
      t.text :rejection, null: false
      t.boolean :approved

      t.timestamps precision: nil
    end

    player = Player.find(1)

    [
      [ %{Count me in!}, %{Count me out} ],
      [ %{I'm in!}, %{I'm out} ],
      [ %{I'm ready to get sweaty!}, %{I have to wash my hair} ],
      [ %{I want to get skinny!}, %{I'd rather eat a milkshake} ],
      [ %{I wouldn't miss it!}, %{No thanks, I heard Troy’s coming} ],
      [ %{I'll be there with bells on!}, %{Maybe next week} ],
      [ %{I can't wait!}, %{I'm recovering from a volleyball tournament}],
    ].each do |confirmation, rejection|
      Quip.create!(
        confirmation: confirmation,
        rejection: rejection,
        player: player,
        approved: true
      )
    end
  end

  def down
    drop_table :quips
  end
end
