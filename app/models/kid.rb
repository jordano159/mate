class Kid < ApplicationRecord
  belongs_to :group, optional: true
  has_many :attendances, :dependent => :destroy
  has_many :checks, through: :attendances
    accepts_nested_attributes_for :attendances, :allow_destroy => true

  def self.search(search_term)
    Kid.where(
      "kids.name LIKE ? OR kids.sex LIKE ? OR kids.last_name LIKE ? OR kids.phone LIKE ? OR
      kids.medical LIKE ? OR kids.meds LIKE ? OR kids.food LIKE ? OR kids.city LIKE ? OR
      kids.ken LIKE ? OR kids.dad LIKE ? OR kids.dad_phone LIKE ? OR kids.mom LIKE ? OR
      kids.mom_phone LIKE ? OR kids.size LIKE ?",
      "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%",
      "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%",
      "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%",
      "%#{search_term}%", "%#{search_term}%").distinct
  end
end
