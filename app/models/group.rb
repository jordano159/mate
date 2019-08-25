# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :kids, dependent: :destroy
  belongs_to :head, optional: true
  belongs_to :mifal
  has_many :staffs, as: :staffable, dependent: :destroy
  has_many :checks, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy
  validates :hard_name, uniqueness: true
  # delegate :mifal, to: :head

  def all_events
    events
  end
end
