class Bus < ApplicationRecord
  has_many :kids
  has_many :checks
  belongs_to :mifal

  def last_updated_kid
     unless self.kids.blank?
       last_kid = self.kids.first
       self.kids.each do |k|
         if k.updated_at >= last_kid.updated_at && k.status == 1
          last_kid = k
         end
       end
      last_kid
     end
  end
end
