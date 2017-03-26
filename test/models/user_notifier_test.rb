require 'test_helper'
require 'action_mailer/test_helper'

class UserNotifierTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  setup do
    user_spot = user_spots(:bruno_valid)
    User::Notifier.deliver
  end

  test ".deliver should send email" do
    assert_enqueued_emails 1
  end

  test ".deliver should update users" do
    user = users(:bruno)
    assert user.notified_at
  end

  test ".deliver should update forecasts" do
    forecast = spot_forecasts(:notificable)
    assert forecast.notified
  end
end
