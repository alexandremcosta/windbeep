class AddNotifiedToSpotForecasts < ActiveRecord::Migration[5.0]
  def change
    add_column :spot_forecasts, :notified, :boolean, default: false
  end
end
