require 'csv'

namespace :import do
  desc "Import kids from csv"

  task kids: :environment do
    filename = File.join Rails.root, "kids table.csv"
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      p row
      kid = Kid.create(name: row["שם"], last_name: row["שם משפחה"], sex: row["מין"],
        phone: row["פלאפון"], medical: row["רגישות ובעיות רפואיות"], meds: row["תרופות"],
        food: row["אוכל"], city: row["מקום מגורים"], ken: row["קן מקור"], dad: row["שם אבא"],
        dad_phone: row["טלפון אבא"], mom: row["שם אמא"], mom_phone: row["טלפון אמא"], size: row["מידת חולצה"])
        puts "#{name} + " " + #{last_name} - #{kid.errors.full_messages.join(",")}" if kid.errors.any?
        counter += 1 if kid.persisted?
      end

      puts "Imported #{counter} kids"
  end
end
