class UserSpot < ApplicationRecord
  belongs_to :user
  belongs_to :spot


  validates_presence_of :user, :spot
  accepts_nested_attributes_for :spot
  delegate :code, :name, :url, to: :spot
end

