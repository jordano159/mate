# frozen_string_literal: true

class Kid < ApplicationRecord
  belongs_to :mifal
  belongs_to :group, optional: true
  belongs_to :bus, optional: true
  has_many :attendances, dependent: :destroy
  has_many :checks, through: :attendances
  accepts_nested_attributes_for :attendances, allow_destroy: true

  # Callbacks
  around_save :create_kid_moved_event
  before_destroy :create_kid_left_event

  def to_s
    self.full_name
  end

  def create_kid_moved_event
    if group_id_changed? && group_id_was.present?
      event = Event.new
      event.content = "#{full_name} עבר.ה מ#{Group.find(group_id_was).name} אל #{Group.find(group_id).name}"
      event.staff_id = mifal.staffs.first.id
      event.eventable_type = "Mifal"
      event.eventable_id = mifal.id
      event.save
    end
    yield #kid.save
    puts "Success"
  end

  def create_kid_left_event
    event = Event.new
    event.content = "#{full_name} מ#{Group.find(group_id).name} עזב.ה את המפעל"
    event.staff_id = mifal.staffs.first.id
    event.eventable_type = "Mifal"
    event.eventable_id = mifal.id
    event.save
  end

  # ייבוא מאקסל
  def self.update_imported_kid(file, mifal_id)
    mifal = Mifal.find(mifal_id)
    header_names = %w[ken grade name last_name sex taz phone medical meds food comments city parent_1 parent_1_phone
                      parent_2 parent_2_phone group_id size shabat parents swim exits]
    spreadsheet = open_spreadsheet(file)
    header = header_names
    header = header.to_a
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      kid = find_by(taz: row['taz']) || new
      kid.attributes = row.to_hash
      kid.group_id = Staff.find_by(username: "#{ @level_names[0] } #{kid.group_id} #{mifal.name}").staffable.id if kid.group_id.present?
      kid.mifal_id = mifal.id
      kid.city = kid.city.strip if kid.city.present?
      kid.ken = "קן #{kid.ken}"
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
end
