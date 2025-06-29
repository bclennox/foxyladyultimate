class AddSmtpAuthToUser < ActiveRecord::Migration[8.0]
  def change
    change_table :users do |t|
      t.string :smtp_password
    end

    up_only do
      User.all.each do |user|
        user.update!(smtp_password: 'fake')
      end
    end

    change_column_null :users, :smtp_password, false
  end
end
