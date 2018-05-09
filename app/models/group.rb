class Group < ApplicationRecord
  has_many :kids
  belongs_to :head
  has_many :staffs, as: :staffable
end
