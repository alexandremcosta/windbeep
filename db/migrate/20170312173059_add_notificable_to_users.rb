class AddNotificableToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notificable, :boolean, default: true
  end
end
