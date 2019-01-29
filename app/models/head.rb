# frozen_string_literal: true

class Head < ApplicationRecord
  has_many :groups
  has_many :kids, through: :groups
  has_many :checks, through: :groups
  has_many :staffs, as: :staffable
  has_many :events, as: :eventable
  has_many :events, through: :groups, source: :events
  belongs_to :axis
  delegate :mifal, to: :axis
end
