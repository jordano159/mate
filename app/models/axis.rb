# frozen_string_literal: true

class Axis < ApplicationRecord
  has_many :heads, dependent: :destroy
  has_many :groups, through: :heads
  has_many :staffs, as: :staffable, dependent: :destroy
  has_many :kids, through: :heads
  has_many :checks, through: :heads
  has_many :events, as: :eventable, dependent: :destroy
  has_many :events, through: :heads, source: :events
  belongs_to :mifal
end
