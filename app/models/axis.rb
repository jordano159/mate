class Axis < ApplicationRecord
  has_many :heads
  has_many :staffs, as: :staffable

  # def kids
  #   Kid.where(group_id: Head.where(self.heads.map(&:id)).)
  # end
end
