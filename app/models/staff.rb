class Staff < ApplicationRecord
  belongs_to :staffable, polymorphic: true
end
