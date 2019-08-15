class Mifal < ApplicationRecord
  enum stage: [ :settings, :axised, :headed, :grouped, :imported_kids ]
  serialize :bus_proposal, Hash
  serialize :group_name, Hash
  serialize :head_name, Hash
  serialize :axis_name, Hash
  serialize :columns, Array
  serialize :guide_name, Hash
  serialize :head_head_name, Hash
  has_many :axes, dependent: :destroy
  has_many :heads, through: :axes
  has_many :groups, through: :heads
  has_many :kids
  has_many :checks, through: :axes
  has_many :buses, dependent: :destroy
  has_many :staffs, as: :staffable, dependent: :destroy
  # has_many :events, through: :axes, source: :events
  has_many :events, as: :eventable

def mifal
  self
end
  def all_events
    my_events = Array.new
    self.events.each do |e|
      my_events << e
    end
    self.axes.each do |a|
      a.all_events.each do |e|
        my_events << e
      end
    end
    return my_events
  end

  def all_staffs
    my_staffs = Array.new
    self.staffs.each do |s|
      my_staffs << s
    end
    self.axes.each do |a|
      a.all_staffs.each do |s|
        my_staffs << s
      end
    end
    return my_staffs
  end
  # מחזיר ערים עם קואורדינטות
  def city_list
    names = self.kids.pluck(:city).uniq
    cities = Hash.new
    names.each do |name|
      result = Geocoder.search("#{name}")
      next unless result.present?
      cities["#{name}"] = result.first.data["lat"], result.first.data["lon"]
    end
    cities
  end


  def how_many_kids(city)
    self.kids.where(city: "#{city}").count
  end

  # מחזיר את שם העיר הכי רחוקה
  def farthest(cities, my_location)
    names = self.kids.pluck(:city).uniq
    max_dis = 0
    max_name = ""
    names.each do |name|
      distance = Geocoder::Calculations.distance_between(cities[name], my_location)
      if distance > max_dis
        max_name = name
        max_dis = distance
      end
    end
    max_name
  end

  # מחזיר את שם העיר הקרובה ביותר
  def nearest(cities, my_location)
    names = self.kids.pluck(:city).uniq
    min_dis = 10000
    min_name = ""
    names.each do |name|
      distance = Geocoder::Calculations.distance_between(cities[name], my_location)
      if distance < min_dis
        min_name = name
        min_dis = distance
      end
    end
    min_name
  end

  # בונה צירים של אוטובוסים
  def make_a_bus(cities, my_location)
    # הצהרות על דברים
    mifal_location = Geocoder.search("גבעת חביבה").first
    mifal_location = mifal_location.data["lat"], mifal_location.data["lon"]
    distance = 0
    kids_in_bus = 0
    bus_stops = Hash.new

    # מציאת היישוב הרחוק ביותר ועיבוד הנתונים שלו
    far = farthest(cities, my_location)
    kids_in_stop = how_many_kids(far)
    kids_in_bus += kids_in_stop
    bus_stops["#{far}"] = kids_in_stop
    last_loc = cities["#{far}"]
    cities.delete("#{far}")

    # לולאה שתרוץ כל פעם על היישוב הקרוב ביותר ותעבד את הנתונים שלו
    loop do
      # הכנת נתונים לעיבוד
      near = nearest(cities, last_loc)
      near_location = Geocoder.search(near).first
      near_location = near_location.data["lat"], near_location.data["lon"] if near_location.present?
      # תתחיל אוטובוס חדש  אם יהיו יותר מדי באוטובוס, אם נגמרו היישובים, או אם המרחק יהיה גדול מדי
      break if (kids_in_bus + how_many_kids(near)) > 49 || cities.empty?
      break if (distance + Geocoder::Calculations.distance_between(last_loc, mifal_location)) > 150 || (distance + Geocoder::Calculations.distance_between(last_loc, near_location)) > 200
      # תוסיף למרחק את המרחק בין התחנה הקודמת לתחנה הנוכחית
      distance += Geocoder::Calculations.distance_between(last_loc, near_location)
      kids_in_stop = how_many_kids(near)
      kids_in_bus += kids_in_stop
      bus_stops["#{near}"] = kids_in_stop
      last_loc = cities["#{near}"]
      cities.delete("#{near}")
    end
    # תוסיף את המרחק הנותר עד להגעה למפעל
    distance += Geocoder::Calculations.distance_between(last_loc, mifal_location)
    return bus_stops, kids_in_bus, distance
  end

  def make_bus_proposal
    cities = self.city_list
    location = Geocoder.search("גבעת חביבה").first
    location = location.data["lat"], location.data["lon"]
    buses = Hash.new
    i = 1
    while !cities.empty?
      buses["אוטובוס #{i}"] = self.make_a_bus(cities, location)
      i += 1
    end
    buses
  end

  # מחזיר חניכים לפי ערים, לא בשימוש כרגע
  def kid_list
    names = self.kids.pluck(:city).uniq
    cities = Hash.new
    names.each do |name|
      result = self.kids.where(city: "#{name}")
      cities["#{name}"] = result
    end
    cities
  end

  # סופר כמה חניכים יש מכל עיר, לא בשימוש כרגע
  def kid_count
    names = self.kids.pluck(:city).uniq
    cities = Hash.new
    names.each do |name|
      result = self.kids.where(city: "#{name}").count
      cities["#{name}"] = result
    end
    cities
  end

end
