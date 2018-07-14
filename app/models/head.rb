class Head < ApplicationRecord
  has_many :groups
  belongs_to :axis
  has_many :kids, through: :groups
  has_many :staffs, as: :staffable
  has_many :events, as: :eventable

  # def kids
  #   Kid.where(group_id: self.groups.map(&:id))
  # end
end
