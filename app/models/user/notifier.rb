module User::Notifier
  def self.deliver
    forecasts = SpotForecast.notificable
    users = User.with_forecasts(forecasts).can_be_notified

    users.find_each do |user|
      UserMailer.strong_wind(user.id).deliver_later
    end

    ActiveRecord::Base.transaction do
      forecasts.notify!
      users.notify!
    end
  end
end
