class AddNotifiedAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notified_at, :datetime
  end
end
