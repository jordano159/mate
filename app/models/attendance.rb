# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :kid
  belongs_to :check
  validates :cause, exclusion: { in: %w[אחר],
                                 message: 'חובה לפרט סיבת היעדרות' }
   def heb_status
     if status == 1
       string1 = "נוכח/ת"
     else
       string1 = "לא נוכח/ת"
     end
   end
end
