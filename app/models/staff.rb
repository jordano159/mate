class Staff < ApplicationRecord
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
end
