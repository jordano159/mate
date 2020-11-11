class KidGroup < ApplicationRecord
  belongs_to :kid
  belongs_to :group
  enum status: [ :active, :unactive ]
  after_create :set_default

  private
  def set_default
    self.active!
  end
end
