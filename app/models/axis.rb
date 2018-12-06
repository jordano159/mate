# frozen_string_literal: true

class Axis < ApplicationRecord
  has_many :heads
  has_many :groups, through: :heads
  has_many :staffs, as: :staffable
  has_many :kids, through: :heads
  has_many :checks, through: :heads
  has_many :events, as: :eventable
  belongs_to :mifal
end
