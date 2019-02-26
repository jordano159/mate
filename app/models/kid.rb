# frozen_string_literal: true

class Kid < ApplicationRecord
  belongs_to :mifal
  belongs_to :group, optional: true
  belongs_to :bus, optional: true
  has_many :attendances, dependent: :destroy
  has_many :checks, through: :attendances
  accepts_nested_attributes_for :attendances, allow_destroy: true

  def to_s
    self.full_name
  end

  # ייבוא מאקסל
  def self.update_imported_kid(file, mifal_id)
    mifal = Mifal.find(mifal_id)
    header_names = %w[ken grade name last_name sex taz phone medical meds comments city parent_1 parent_1_phone
                      parent_2 parent_2_phone group_id size shabat parents swim exits]
    spreadsheet = open_spreadsheet(file)
    header = header_names
    header = header.to_a
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      kid = find_by(taz: row['taz']) || new
      kid.attributes = row.to_hash
      kid.group_id = 153
      kid.mifal_id = mifal.id
      kid.city = kid.city.strip if kid.city.present?
      kid.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then  Roo::CSV.new(file.path, packed: nil, file_warning: :ignore, csv_options: { encoding: Encoding::SJIS })
    when '.xls' then  Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def full_name
    name + ' ' + last_name
  end

  def self.filter(filter_column, filter_condition)
    Kid.where("kids.#{filter_column} LIKE ?", "%#{filter_condition}%").distinct
  end

  def heb_status
    if status == 1
      string1 = "נוכח/ת"
    else
      string1 = "לא נוכח/ת"
    end
  end

  # ייצוא וייבוא בCSV
  # def self.to_csv
  #   attributes = %w{name last_name sex phone medical
  #     meds food city ken parent_1 parent_1_phone parent_2 parent_2_phone size group_id shabat parents swim exits comments}
  #   heb_names = ["שם פרטי חניך", "שם משפחה חניך", "מגדר", "נייד", "רגישות ובעיות רפואיות", "תרופות",
  #     "אוכל", "יישוב", "קן", "שם פרטי הורה 1", "נייד של הורה 1", "שם פרטי הורה 2", "נייד של הורה 2",
  #   "מידת חולצה", "מספר קבוצה", "האם החניך/ה שומר/ת שבת",
  #    "האם תגיעו לטקס הסיום וליום ההורים?", "אישור שחייה", "כניסות ויציאות", "הערות"]
  #
  #   CSV.generate(headers: true) do |csv|
  #     csv << heb_names
  #
  #     all.each do |kid|
  #       csv << attributes.map{ |attr| kid.send(attr) }
  #     end
  #   end
  # end
  #
  # def self.my_import(file)
  #   columns = ["שם פרטי חניך", "שם משפחה חניך", "מגדר", "נייד", "רגישות ובעיות רפואיות", "תרופות",
  #     "אוכל", "יישוב", "קן", "שם פרטי הורה 1", "נייד של הורה 1", "שם פרטי הורה 2", "נייד של הורה 2",
  #   "מידת חולצה", "מספר קבוצה", "האם החניך/ה שומר/ת שבת",
  #    "האם תגיעו לטקס הסיום וליום ההורים?", "אישור שחייה", "כניסות ויציאות", "הערות"]
  #   kids = []
  #   CSV.foreach(file.path, headers: true) do |row|
  #     kids << Kid.new(name: row["שם פרטי חניך"], last_name: row["שם משפחה חניך"], sex: row["מגדר"],
  #       phone: row["נייד"], medical: row["רגישות ובעיות רפואיות"], meds: row["תרופות"],
  #       food: row["אוכל"], city: row["יישוב"], ken: row["קן"], parent_1: row["שם פרטי הורה 1"],
  #       parent_1_phone: row["נייד של הורה 1"], parent_2: row["שם פרטי הורה 2"], parent_2_phone: row["נייד של הורה 2"], size: row["מידת חולצה"],
  #       group_id: (row ["מספר קבוצה"].to_i + Group.first.id - 1), shabat: row["האם החניך/ה שומר/ת שבת?"],
  #       parents: row["האם תגיעו לטקס הסיום וליום ההורים?"], swim: row["אישור שחייה"], exits: row["כניסות ויציאות"], comments: row["הערות"])
  #   end
  #   Kid.import kids, recursive: true
  # end
end
