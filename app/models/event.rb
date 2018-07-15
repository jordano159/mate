class Event < ApplicationRecord
  belongs_to :staff
  belongs_to :eventable, polymorphic: true
  validates :content, presence: true
end
