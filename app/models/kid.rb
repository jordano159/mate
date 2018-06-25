class Kid < ApplicationRecord
  belongs_to :group, optional: true
  has_many :attendances, :dependent => :destroy
  has_many :checks, through: :attendances
    accepts_nested_attributes_for :attendances, :allow_destroy => true

    def current_status
      if checks.exists? && checks.last.attendances.exists?
        checks.last.attendances.where(kid_id: id).last.status
      end
    end

    def current_cause
      if checks.exists? && checks.last.attendances.exists?
        checks.last.attendances.where(kid_id: id).last.cause
      end
    end

  def self.search(search_term)
    Kid.joins(:group).where(
      "kids.name LIKE ? OR kids.sex LIKE ? OR kids.last_name LIKE ? OR kids.phone LIKE ? OR
      kids.medical LIKE ? OR kids.meds LIKE ? OR kids.food LIKE ? OR kids.city LIKE ? OR
      kids.ken LIKE ? OR kids.dad LIKE ? OR kids.dad_phone LIKE ? OR kids.mom LIKE ? OR
      kids.mom_phone LIKE ? OR kids.size LIKE ? OR groups.name LIKE ?",
      "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%",
      "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%",
      "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%",
      "%#{search_term}%", "%#{search_term}%", "%#{search_term}%").distinct
  end

  def self.to_csv
    attributes = %w{name last_name sex phone medical
      meds food city ken dad dad_phone mom mom_phone size group_id}
    heb_names = ["שם", "שם משפחה", "מין", "פלאפון", "רגישות ובעיות רפואיות", "תרופות",
      "אוכל", "מקום מגורים", "קן מקור", "שם אבא", "טלפון אבא", "שם אמא", "טלפון אמא",
    "מידת חולצה", "מספר קבוצה"]

    CSV.generate(headers: true) do |csv|
      csv << heb_names

      all.each do |kid|
        csv << attributes.map{ |attr| kid.send(attr) }
      end
    end
  end

  def self.my_import(file)
    columns = ["שם", "שם משפחה", "מין", "פלאפון", "רגישות ובעיות רפואיות", "תרופות",
      "אוכל", "מקום מגורים", "קן מקור", "שם אבא", "טלפון אבא", "שם אמא", "טלפון אמא",
    "מידת חולצה", "מספר קבוצה"]
    kids = []
    CSV.foreach(file.path, headers: true) do |row|
      kids << Kid.new(name: row["שם"], last_name: row["שם משפחה"], sex: row["מין"],
        phone: row["פלאפון"], medical: row["רגישות ובעיות רפואיות"], meds: row["תרופות"],
        food: row["אוכל"], city: row["מקום מגורים"], ken: row["קן מקור"], dad: row["שם אבא"],
        dad_phone: row["טלפון אבא"], mom: row["שם אמא"], mom_phone: row["טלפון אמא"], size: row["מידת חולצה"], group_id: (row ["מספר קבוצה"].to_i + Group.first.id - 1))
      # kids << Kid.new(:name => "book #{i}")
    end
    Kid.import kids, recursive: true
  end

end
