# frozen_string_literal: true

class Kid < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :bus, optional: true
  has_many :attendances, dependent: :destroy
  has_many :checks, through: :attendances
  accepts_nested_attributes_for :attendances, allow_destroy: true

  # ייבוא מאקסל
  def self.update_imported_kid(file)
    header_names = %w[name last_name sex phone medical
                      meds food city ken dad dad_phone mom mom_phone size group_id shabat parents swim exits comments]
    spreadsheet = open_spreadsheet(file)
    header = header_names
    header = header.to_a
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      kid = find_by(phone: row['phone']) || new
      kid.attributes = row.to_hash
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

  # ייצוא וייבוא בCSV
  # def self.to_csv
  #   attributes = %w{name last_name sex phone medical
  #     meds food city ken dad dad_phone mom mom_phone size group_id shabat parents swim exits comments}
  #   heb_names = ["שם פרטי חניך", "שם משפחה חניך", "מגדר", "נייד", "רגישות ובעיות רפואיות", "תרופות",
  #     "אוכל", "יישוב", "קן", "שם פרטי אב", "נייד של אבא", "שם פרטי אם", "נייד של אמא",
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
  #     "אוכל", "יישוב", "קן", "שם פרטי אב", "נייד של אבא", "שם פרטי אם", "נייד של אמא",
  #   "מידת חולצה", "מספר קבוצה", "האם החניך/ה שומר/ת שבת",
  #    "האם תגיעו לטקס הסיום וליום ההורים?", "אישור שחייה", "כניסות ויציאות", "הערות"]
  #   kids = []
  #   CSV.foreach(file.path, headers: true) do |row|
  #     kids << Kid.new(name: row["שם פרטי חניך"], last_name: row["שם משפחה חניך"], sex: row["מגדר"],
  #       phone: row["נייד"], medical: row["רגישות ובעיות רפואיות"], meds: row["תרופות"],
  #       food: row["אוכל"], city: row["יישוב"], ken: row["קן"], dad: row["שם פרטי אב"],
  #       dad_phone: row["נייד של אבא"], mom: row["שם פרטי אם"], mom_phone: row["נייד של אמא"], size: row["מידת חולצה"],
  #       group_id: (row ["מספר קבוצה"].to_i + Group.first.id - 1), shabat: row["האם החניך/ה שומר/ת שבת?"],
  #       parents: row["האם תגיעו לטקס הסיום וליום ההורים?"], swim: row["אישור שחייה"], exits: row["כניסות ויציאות"], comments: row["הערות"])
  #   end
  #   Kid.import kids, recursive: true
  # end
end
