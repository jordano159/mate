class Head < ApplicationRecord
  has_many :groups
  belongs_to :axis
end
