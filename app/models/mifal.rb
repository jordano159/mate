class Mifal < ApplicationRecord
  has_many :axes, dependent: :destroy
  has_many :heads, through: :axes, dependent: :destroy
  has_many :groups, through: :heads, dependent: :destroy
  has_many :staffs, as: :staffable
  has_many :kids, through: :axes, dependent: :destroy
  has_many :checks, through: :axes, dependent: :destroy
  has_many :events, as: :eventable
  has_many :buses, dependent: :destroy
  enum stage: [ :axised, :headed, :grouped, :imported_kids ]
end
