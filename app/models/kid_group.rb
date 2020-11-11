class KidGroup < ApplicationRecord
  belongs_to :kid
  belongs_to :group
  enum status: [ :active, :unactive ]
end
