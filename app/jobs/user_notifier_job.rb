class UserNotifierJob < ApplicationJob
  def perform(*args)
    users = User.distinct.joins(spots: :spot_forecasts).where('spot_forecasts.start_at > ?', Time.now)
    users.each do |user|
      UserMailer.forecast_good(@user.id).deliver_later
    end
  end
end
