class Mifal < ApplicationRecord
  serialize :wizard, Hash
  enum stage: [:named, :axised, :headed, :grouped, :imported_kids, :associated_kids, :buses_created, :done]
  has_many :axes
  has_many :heads, through: :axes
  has_many :groups, through: :heads
  has_many :staffs, as: :staffable
  has_many :kids, through: :axes
  has_many :checks, through: :axes
  has_many :events, as: :eventable
end
