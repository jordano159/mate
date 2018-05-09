class Head < ApplicationRecord
  has_many :groups
  belongs_to :axis
  has_many :staffs, as: :staffable
end
