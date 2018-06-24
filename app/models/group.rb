class Group < ApplicationRecord
  has_many :kids
  belongs_to :head
  has_many :staffs, as: :staffable

  def self.search(search_term)
    Group.where(
      "groups.name LIKE ?", "%#{search_term}%" ).distinct
  end

end
