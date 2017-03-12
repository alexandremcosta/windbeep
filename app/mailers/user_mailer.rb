class UserMailer < ApplicationMailer
  def strong_wind(user_id)
    @user = User
      .joins(spots: :spot_forecasts)
      .includes(spots: :spot_forecasts)
      .merge(SpotForecast.strong_wind)
      .find(user_id)
    mail to: @user.email, subject: "Strong wind alert"
  end
end
