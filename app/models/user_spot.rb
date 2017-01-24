class UserSpot < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  accepts_nested_attributes_for :spot

  delegate :code, to: :spot
end

