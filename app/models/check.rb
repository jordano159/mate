class Check < ApplicationRecord
  has_many :attendances, :dependent => :destroy
  has_many :kids, through: :attendances
  accepts_nested_attributes_for :attendances, :allow_destroy => true
  belongs_to :groups, optional: true
  validates :name, presence: true

  enum status: [ :present, :not_present ]

  def my_group
    Group.find(group_id) if group_id.present?
  end

  def self.search(search_term)
    Check.where(group_id: Group.where("groups.name LIKE ?", "%#{search_term}%").first.id).distinct
  end

  def previous_check
    Check.where("id < ? AND group_id = ?", id, group_id).last
  end
end
