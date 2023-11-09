class PopulateQuips < ActiveRecord::Migration[7.0]
  def up
    [
      [ %{Count me in!}, %{Count me out} ],
      [ %{I'm in!}, %{I'm out} ],
      [ %{I'm ready to get sweaty!}, %{I have to wash my hair} ],
      [ %{I want to get skinny!}, %{I'd rather eat a milkshake} ],
      [ %{I wouldn't miss it!}, %{No thanks, I heard Troy’s coming} ],
      [ %{I'll be there with bells on!}, %{Maybe next week} ],
      [ %{I can't wait!}, %{I'm recovering from a volleyball tournament}],
    ].each do |(confirmation, rejection)|
      Quip.create!(
        confirmation: confirmation,
        rejection: rejection,
        active: true
      )
    end
  end
end
