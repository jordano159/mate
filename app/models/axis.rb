# frozen_string_literal: true

class Axis < ApplicationRecord
  has_many :heads
  has_many :groups, through: :heads
  has_many :staffs, as: :staffable, dependent: :destroy
  has_many :kids, through: :heads
  has_many :checks, through: :heads
  # has_many :events, through: :heads, source: :events
  has_many :events, as: :eventable
  belongs_to :mifal
  validates :hard_name, uniqueness: true

  before_destroy :kill_the_heads

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


  def all_staffs
    my_staffs = Array.new
    self.staffs.each do |s|
      my_staffs << s
    end
    self.heads.each do |h|
      h.all_staffs.each do |s|
        my_staffs << s
      end
    end
    return my_staffs
  end

  def kill_the_heads
    heads.destroy_all
  end

  def active_kids
    self.kids.where(id: KidGroup.where(group_id: self.groups.ids, status: :active).pluck(:kid_id))
  end
end
