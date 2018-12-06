# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :kids
  belongs_to :head
  has_many :staffs, as: :staffable
  has_many :checks
  has_many :events, as: :eventable

end
