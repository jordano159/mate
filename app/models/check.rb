class Check < ApplicationRecord
  has_many :attendances, :dependent => :destroy
  has_many :kids, through: :attendances
  accepts_nested_attributes_for :attendances, :allow_destroy => true

  enum status: [ :present, :not_present ]
end
