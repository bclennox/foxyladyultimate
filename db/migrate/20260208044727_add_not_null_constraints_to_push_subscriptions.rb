class AddNotNullConstraintsToPushSubscriptions < ActiveRecord::Migration[8.0]
  def change
    change_column_null :push_subscriptions, :endpoint, false
    change_column_null :push_subscriptions, :p256dh, false
    change_column_null :push_subscriptions, :auth, false
  end
end
