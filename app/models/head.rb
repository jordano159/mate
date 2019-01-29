# frozen_string_literal: true

class Head < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :kids, through: :groups
  has_many :checks, through: :groups
  has_many :staffs, as: :staffable, dependent: :destroy
  has_many :events, as: :eventable
  has_many :events, through: :groups, source: :events
  belongs_to :axis
  delegate :mifal, to: :axis
end
