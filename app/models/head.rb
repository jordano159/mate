# frozen_string_literal: true

class Head < ApplicationRecord
  has_many :groups
  has_many :kids, through: :groups
  has_many :checks, through: :groups
  has_many :staffs, as: :staffable, dependent: :destroy
  # has_many :events, through: :groups, source: :events
  has_many :events, as: :eventable
  belongs_to :axis
  belongs_to :mifal
  # delegate :mifal, to: :axis
  validates :hard_name, uniqueness: true

  before_destroy :kill_the_groups

  private

  def all_events
    my_events = Array.new
    self.events.each do |e|
      my_events << e
    end
    self.groups.each do |g|
      g.events.each do |e|
        my_events << e
      end
    end
    return my_events
  end

  def all_staffs
    my_staffs = Array.new
    self.staffs.each do |s|
      my_staffs << s
    end
    self.groups.each do |g|
      g.staffs.each do |s|
        my_staffs << s
      end
    end
    return my_staffs
  end

  def kill_the_groups
    groups.destroy_all
  end
end
