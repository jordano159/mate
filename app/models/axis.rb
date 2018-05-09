class Axis < ApplicationRecord
  has_many :heads
  has_many :staffs, as: :staffable
end
