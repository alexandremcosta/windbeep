class UserMailer < ApplicationMailer
  def forecast_good(user_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: "Wind comming!"
  end
end
