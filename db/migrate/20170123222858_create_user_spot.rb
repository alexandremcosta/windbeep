class CreateUserSpot < ActiveRecord::Migration[5.0]
  def change
    create_table :user_spots do |t|
      t.references :user, foreign_key: true
      t.references :spot, foreign_key: true
    end
  end
end
