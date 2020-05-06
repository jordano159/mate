class Group < ApplicationRecord
  has_many :kids
  belongs_to :head, optional: true
  belongs_to :mifal
  has_many :staffs, as: :staffable, dependent: :destroy
  has_many :checks, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy
  validates :hard_name, uniqueness: true

  before_destroy :kill_the_kids

  private

  def all_events
    events
  end

  def kill_the_kids
    kids.destroy_all
  end
end
