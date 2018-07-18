class Kid < ApplicationRecord
  belongs_to :group, optional: true
  has_many :attendances, :dependent => :destroy
  has_many :checks, through: :attendances
    accepts_nested_attributes_for :attendances, :allow_destroy => true

    def current_status
      if checks.exists?
        if checks.last.approved? && checks.last.attendances.exists?
          checks.last.attendances.where(kid_id: id).last.status
        elsif checks.last(2).first && checks.last(2).first.attendances.exists?
          checks.last(2).first.attendances.where(kid_id: id).last.status
        end
      end
    end

    def current_cause
      if checks.exists?
        if checks.last.approved? && checks.last.attendances.exists?
          checks.last.attendances.where(kid_id: id).last.cause
        elsif checks.last(2).first && checks.last(2).first.attendances.exists?
          checks.last(2).first.attendances.where(kid_id: id).last.cause
        end
      end
    end

    def full_name
      name + " " + last_name
    end

  def self.filter(filter_column, filter_condition)
    Kid.where("kids.#{filter_column} LIKE ?", "%#{filter_condition}%").distinct
  end

  def self.to_csv
    attributes = %w{name last_name sex phone medical
      meds food city ken dad dad_phone mom mom_phone size group_id shabat parents swim exits comments}
    heb_names = ["שם", "שם משפחה", "מין", "פלאפון", "רגישות ובעיות רפואיות", "תרופות",
      "אוכל", "מקום מגורים", "קן מקור", "שם אבא", "טלפון אבא", "שם אמא", "טלפון אמא",
    "מידת חולצה", "מספר קבוצה", "האם החניך/ה שומר/ת שבת?",
     "האם תגיעו לטקס הסיום וליום ההורים?", "אישור שחייה", "כניסות ויציאות", "הערות"]

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
    "מידת חולצה", "מספר קבוצה", "האם החניך/ה שומר/ת שבת?", "האם תגיעו לטקס הסיום וליום ההורים?", "אישור שחייה", "כניסות ויציאות", "הערות"]
    kids = []
    CSV.foreach(file.path, headers: true) do |row|
      kids << Kid.new(name: row["שם"], last_name: row["שם משפחה"], sex: row["מין"],
        phone: row["פלאפון"], medical: row["רגישות ובעיות רפואיות"], meds: row["תרופות"],
        food: row["אוכל"], city: row["מקום מגורים"], ken: row["קן מקור"], dad: row["שם אבא"],
        dad_phone: row["טלפון אבא"], mom: row["שם אמא"], mom_phone: row["טלפון אמא"], size: row["מידת חולצה"],
        group_id: (row ["מספר קבוצה"].to_i + Group.first.id - 1), shabat: row["האם החניך/ה שומר/ת שבת?"],
        parents: row["האם תגיעו לטקס הסיום וליום ההורים?"], swim: row["אישור שחייה"], exits: row["כניסות ויציאות"], comments: row["הערות"])
    end
    Kid.import kids, recursive: true
  end

end
