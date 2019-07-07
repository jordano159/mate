# frozen_string_literal: true

class Axis < ApplicationRecord
  has_many :heads, dependent: :destroy
  has_many :groups, through: :heads
  has_many :staffs, as: :staffable, dependent: :destroy
  has_many :kids, through: :heads
  has_many :checks, through: :heads
  # has_many :events, through: :heads, source: :events
  has_many :events, as: :eventable
  belongs_to :mifal

  def all_events
    my_events = Array.new
    self.events.each do |e|
      my_events << e
    end
    self.heads.each do |h|
      h.all_events.each do |e|
        my_events << e
      end
    end
    return my_events
  end

end
