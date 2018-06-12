class Attendance < ApplicationRecord
  belongs_to :kid
  belongs_to :check
end
