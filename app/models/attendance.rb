# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :kid
  belongs_to :check
  enum fever: [ :has_fever, :no_fever ]
  validates :fever, inclusion: { in: fevers.keys }, allow_nil: true
  validates :cause, exclusion: { in: %w[אחר],
                                 message: 'חובה לפרט סיבת היעדרות' }
   def heb_status
     case status
     when 0
       heb_status = "לא נוכח/ת"
     when 1
       heb_status = "נוכח/ת"
     when 2
       heb_status = "איחר/ה"
     end
   end
end
