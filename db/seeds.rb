# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# Seeding two Axes
puts "Creating Axes..."
for i in 1..2
  Axis.create!(name: "#{i}") if Axis.find_by(name: "#{i}").nil?
  Staff.create!(name: "רכזת ציר #{i}", email: "a#{i}@gmail.com", password: "123123", password_confirmation: "123123",
    role: "user", username: "ציר #{i}", staffable_type: "Axis", staffable_id: Axis.find_by(name: "#{i}").id) if Staff.find_by(username: "ציר #{i}").nil?
end

# Seeding six Heads
puts "Creating Heads..."
for i in 1..6
  if i < 4
    Head.create!(name: "#{i}", axis_id: "#{Axis.find_by(name: "1").id}") if Head.find_by(name: "#{i}").nil?
  elsif i >= 4
    Head.create!(name: "#{i}", axis_id: "#{Axis.find_by(name: "2").id}") if Head.find_by(name: "#{i}").nil?
  end
  Staff.create!(name: "ראשראשית #{i}", email: "h#{i}@gmail.com", password: "123123", password_confirmation: "123123",
    role: "user", username: "ראש #{i}", staffable_type: "Head", staffable_id: Head.find_by(name: "#{i}").id) if Staff.find_by(username: "ראש #{i}").nil?
end

# Seeding twenty Groups
puts "Creating Groups..."
for i in 1..20
  Group.create!(name: "#{i}", head_id: "#{Head.find_by(name: "#{i/5}").id}") if Group.find_by(name: "#{i}").nil?
  Staff.create!(name: "מדריכת #{i}", email: "g#{i}@gmail.com", password: "123123", password_confirmation: "123123",
    role: "user", username: "קבוצה #{i}", staffable_type: "Group", staffable_id: Group.find_by(name: "#{i}").id) if Staff.find_by(username: "קבוצה #{i}").nil?
end

# Seeding Admin
puts "Creating Admin..."
Staff.create!(name: "גילעד", email: "gilad@gmail.com", password: "123123", password_confirmation: "123123", role: "admin", username: "Gilad", staffable_type: "Axis", staffable_id: "#{Axis.first.id}") if Staff.find_by(username: "Gilad").nil?


puts "Created Succesfully"
