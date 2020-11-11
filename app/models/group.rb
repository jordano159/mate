class Group < ApplicationRecord
  scope :trash_bin, ->(mifal) { where(trash_bin: :trash, mifal_id: mifal.id) }
  has_many :kid_groups
  has_many :kids, through: :kid_groups
  belongs_to :head, optional: true
  belongs_to :mifal
  has_many :staffs, as: :staffable, dependent: :destroy
  has_many :checks, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy
  validates :hard_name, uniqueness: true
  enum trash_bin: [ :untrash, :trash ]
  before_destroy :kill_the_kids
  def all_events
    events
  end

  def kill_the_kids
    kids.destroy_all
  end
end
