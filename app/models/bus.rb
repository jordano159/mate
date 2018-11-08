class Bus < ApplicationRecord
  has_many :kids

  def populate_bus(cities)
    cities.each do |c|
      Kid.where("city = ?", c).each do |k|
        k.bus_id = self.id
        k.save
      end
    end
  end
end
