class User < ApplicationRecord
  has_many :user_spots
  has_many :spots, through: :user_spots

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :with_forecasts, -> (forecasts) { distinct.joins(spots: :spot_forecasts).merge(forecasts) }
  scope :can_be_notified, -> { where(notified_at: nil).or(notified_before_today).where(notificable: true) }
  scope :notified_before_today, -> { where('notified_at < ?', Time.now.beginning_of_day) }

  def self.notify!
    update_all(notified_at: Time.now)
  end

  def admin?
    email == ENV['ADMIN_EMAIL']
  end
end
