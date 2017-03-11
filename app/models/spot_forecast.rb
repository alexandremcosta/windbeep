class SpotForecast < ApplicationRecord
  extend SpotForecast::Sync

  belongs_to :spot
end
