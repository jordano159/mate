# frozen_string_literal: true

class Check < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :kids, through: :attendances
  accepts_nested_attributes_for :attendances, allow_destroy: true
  belongs_to :group, optional: true
  belongs_to :bus, optional: true
  validates :name, presence: true
  after_update :update_attendance

  def self.search(search_term)
    Check.where(group_id: Group.where('groups.name LIKE ?', "%#{search_term}%").first.id).distinct
  end

  def previous_check
    Check.where('id < ? AND group_id = ?', id, group_id).last
  end
end

  def update_attendance
    if approved?
      attendances.each do |a|
        kid = Kid.find(a.kid_id)
        if kid.status != a.status || kid.cause != a.cause
          kid.update_columns(status: a.status, cause: a.cause)
          # kid.update_columns(cause: a.cause)
          kid.touch
        end
      end
    end
  end
