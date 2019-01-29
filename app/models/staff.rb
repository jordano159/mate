# frozen_string_literal: true

class Staff < ApplicationRecord
  enum role: %i[user vip admin]
  after_initialize :set_default_role, if: :new_record?
  has_many :events, dependent: :destroy

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email,    uniqueness: true
  validates :username, uniqueness: true
  belongs_to :staffable, polymorphic: true

  def will_save_change_to_email?
    false
  end

  def self.search(search_term)
    Staff.where(
      'staffs.name LIKE ?', "%#{search_term}%"
    ).distinct
  end
end
