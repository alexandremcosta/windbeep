module User::Notifier
  def self.deliver
    forecasts = SpotForecast.notificable
    users = User.with_forecasts(forecasts).can_be_notified

    users.each do |user|
      UserMailer.strong_wind(user.id).deliver_later
    end

    ActiveRecord::Base.transaction do
      users.notify!
      forecasts.notify!
    end
  end
end
