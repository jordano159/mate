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
  # before_destroy :create_kid_left_event

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
    # event.save
    self.last_group = group.id
    puts last_group
    self.group_id = Group.find_by(hard_name: "סל מחזור #{mifal.name}").id
    puts group_id
    self.save
  end

  def undelete
    self.group_id = self.last_group
    self.save
  end

  # ייבוא מאקסל
  def self.update_imported_kid(file, mifal_id)
    mifal = Mifal.find(mifal_id)
    mifal.columns.map! { |x| x == "group" ? 'group_id' : x }
    mifal.columns.reject! {|item| item =~ /full_name|status|cause/i }
    header_names = mifal.columns
    spreadsheet = open_spreadsheet(file)
    header = header_names
    header = header.to_a
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row['taz'] = Kid.generate_taz unless row['taz'].present?
      kid = find_by(taz: row['taz']) || new
      kid.attributes = row.to_hash #סכנת הזרקת SQL
      kid.group_id = Staff.find_by(username: "#{mifal.group_name[:single]} #{kid.group_id} #{mifal.name}").staffable.id if kid.group_id.present?
      kid.mifal_id = mifal.id
      kid.city = kid.city.strip if kid.city.present?
      kid.ken = "קן #{kid.ken}" if kid.ken.present?
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

  def self.generate_taz
    random_taz = rand(100000000000..100000000000000)
    if Kid.all.pluck(:taz).include?(random_taz)
      self.generate_taz
    else
      return random_taz
    end
  end

  def heb_status
    case status
    when 0
      heb_status = "לא נוכח/ת"
    when 1
      heb_status = "נוכח/ת"
    when 2
      heb_status = "איחר/ה"
    end
  end
end
