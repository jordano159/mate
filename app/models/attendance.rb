class Attendance < ApplicationRecord
  belongs_to :kid
  belongs_to :check
  validates :cause, exclusion: { in: %w(אחר),
    message: "חובה לפרט סיבת היעדרות" }
end
