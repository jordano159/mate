class Axis < ApplicationRecord
  has_many :heads
  has_many :staffs, as: :staffable
  has_many :kids, through: :heads
end
