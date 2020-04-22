# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :staff
  belongs_to :eventable, polymorphic: true
  validates :content, presence: true
  enum level: [ :auto, :regular, :critical ]
  validates :level, inclusion: { in: levels.keys }
end
