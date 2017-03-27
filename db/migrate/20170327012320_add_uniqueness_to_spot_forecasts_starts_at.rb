class AddUniquenessToSpotForecastsStartsAt < ActiveRecord::Migration[5.0]
  def change
    add_index :spot_forecasts, [:start_at, :spot_id], unique: true
  end
end
