class Head < ApplicationRecord
  has_many :groups
  belongs_to :axis
  has_many :kids, through: :groups
  has_many :staffs, as: :staffable
  has_many :events, as: :eventable
  # has_many :events, through: :groups, source: :events, source_type: 'Event'
end
