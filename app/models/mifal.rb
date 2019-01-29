class Mifal < ApplicationRecord
  enum stage: [ :axised, :headed, :grouped, :imported_kids ]
  has_many :axes, dependent: :destroy
  has_many :heads, through: :axes
  has_many :groups, through: :heads
  has_many :kids, through: :axes
  has_many :checks, through: :axes
  has_many :buses, dependent: :destroy
  has_many :staffs, as: :staffable, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy
  has_many :events, through: :axes, source: :events
end
