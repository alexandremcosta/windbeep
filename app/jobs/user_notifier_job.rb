class UserNotifierJob < ApplicationJob
  def perform(*args)
    User::Notifier.deliver
  end
end
