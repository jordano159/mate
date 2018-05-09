class Group < ApplicationRecord
  has_many :kids
  belongs_to :head
end
