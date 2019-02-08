class Mifal < ApplicationRecord
  enum stage: [ :axised, :headed, :grouped, :imported_kids ]
  has_many :axes, dependent: :destroy
  has_many :heads, through: :axes
  has_many :groups, through: :heads
  has_many :kids, through: :axes
  has_many :checks, through: :axes
  has_many :buses, dependent: :destroy
  has_many :staffs, as: :staffable, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy
  has_many :events, through: :axes, source: :events

  # מחזיר ערים עם קואורדינטות
  def city_list
    names = self.kids.pluck(:city).uniq
    cities = Hash.new
    names.each do |name|
      result = Geocoder.search("#{name}")
      cities["#{name}"] = result.first.data["lat"], result.first.data["lon"]
    end
    cities
  end

  # מחזיר חניכים לפי ערים
  def kid_list
    names = self.kids.pluck(:city).uniq
    cities = Hash.new
    names.each do |name|
      result = self.kids.where(city: "#{name}")
      cities["#{name}"] = result
    end
    cities
  end

  # סופר כמה חניכים יש מכל עיר
  def kid_count
    names = self.kids.pluck(:city).uniq
    cities = Hash.new
    names.each do |name|
      result = self.kids.where(city: "#{name}").count
      cities["#{name}"] = result
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

  # סתם כדי לחסוך זמן, לא קריטי
  def my_location
    location = Geocoder.search("גבעת חביבה").first
    location = location.data["lat"], location.data["lon"]
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
    kids_in_bus = 0
    bus_stops = []
    loop do
      far = farthest(cities, my_location)
      puts "far: #{far}"
      if (kids_in_bus + how_many_kids(far)) > 50 || cities.empty?
        unless kids_in_bus == 0 && how_many_kids(far) > 50 # במקרה ויש קן עם יותר חניכים מאשר אוטובוס, תיצור לו פשוט אוטובוס משל עצמו
          break
        end
      end
      kids_in_bus += how_many_kids(far)
      puts "kids: #{kids_in_bus}"
      bus_stops << far
      cities.delete("#{far}")
    end
    puts "kids_in_bus: #{kids_in_bus}"
    bus_stops
  end

  def make_some_noise
    cities = self.city_list
    location = Geocoder.search("גבעת חביבה").first
    location = location.data["lat"], location.data["lon"]
    buses = Hash.new
    i = 0
    while !cities.empty?
      buses["bus#{i}"] = self.make_a_bus(cities, location)
      i += 1
    end
    buses
  end

end
