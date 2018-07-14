class Axis < ApplicationRecord
  has_many :heads
  has_many :staffs, as: :staffable
  has_many :kids, through: :heads
  has_many :events, as: :eventable
end
