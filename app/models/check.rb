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

  def delete_blank_checks
    Check.where("name = ? and group_id = ?", "נוכחות חדשה", self.group_id).delete_all
  end
end


def update_attendance
  if self.group && self.group.mifal.checks_num
    this_month = self.date.to_date.month
    if approved?
      attendances.each do |a|
        kid = Kid.find(a.kid_id)
        if kid.status != a.status || kid.cause != a.cause
            if kid.absences_per_month[this_month].present? && a.status == 0
              absences = kid.absences_per_month[this_month] + 1
            elsif kid.absences_per_month[this_month].present? && a.status != 0
              absences = kid.absences_per_month[this_month]
            elsif a.status == 0
              absences = 1
            else
              absences = 0
            end
            if kid.total_per_month[this_month].present? && a.status.present?
              total = kid.total_per_month[this_month] + 1
            elsif a.status.present?
              total = 1
            end
          kid.update_columns(status: a.status, cause: a.cause,
                       absences_per_month:  kid.absences_per_month.merge!(this_month => absences),
                       total_per_month: kid.total_per_month.merge!(this_month => total))

          kid.touch
        end
      end
    end
  else
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
end
