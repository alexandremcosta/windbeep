class CreateSpotForecasts < ActiveRecord::Migration[5.0]
  def change
    create_table :spot_forecasts do |t|
      t.decimal :wind_speed
      t.decimal :wind_gust
      t.integer :wind_direction
      t.decimal :temperature
      t.string :model
      t.datetime :start_at

      t.references :spot, foreign_key: true

      t.timestamps
    end
  end
end
