class Event < ApplicationRecord
  belongs_to :staff
  belongs_to :eventable, polymorphic: true
end
