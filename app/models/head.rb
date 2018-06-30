class Head < ApplicationRecord
  has_many :groups
  belongs_to :axis
  has_many :kids, through: :groups
  has_many :staffs, as: :staffable

  # def kids
  #   Kid.where(group_id: self.groups.map(&:id))
  # end
end
