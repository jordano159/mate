class Bus < ApplicationRecord
  has_many :kids
  has_many :checks
end
