class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|

      ## Database authenticatable
      t.string :username,           :null => false, :default => ""
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps
    end
  end
end
