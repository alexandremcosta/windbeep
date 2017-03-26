class AddNameToSpots < ActiveRecord::Migration[5.0]
  def change
    add_column :spots, :name, :string
  end
end
