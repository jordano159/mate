# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# Seeding Axes
puts "How Many Axes?"
amount = STDIN.gets.chomp.to_i
for i in 1..amount
  Axis.create!(name: "#{i}") if Axis.find_by(name: "#{i}").nil?
  Staff.create!(name: "רכזת ציר #{i}", email: "a#{i}@gmail.com", password: "123123", password_confirmation: "123123",
    role: "user", username: "ציר #{i}", staffable_type: "Axis", staffable_id: Axis.find_by(name: "#{i}").id) if Staff.find_by(username: "ציר #{i}").nil?
end

# Seeding Heads
puts "How Many Heads?"
amount = STDIN.gets.chomp.to_i
for i in 1..amount
  Head.create!(name: "#{i}", axis_id: "#{Axis.find_by(name: "#{(i / 6) + 1}").id}") if Head.find_by(name: "#{i}").nil?
  Staff.create!(name: "ראשראשית #{i}", email: "h#{i}@gmail.com", password: "123123", password_confirmation: "123123",
    role: "user", username: "ראש #{i}", staffable_type: "Head", staffable_id: Head.find_by(name: "#{i}").id) if Staff.find_by(username: "ראש #{i}").nil?
end

# Seeding Groups
puts "How Many Groups?"
amount = STDIN.gets.chomp.to_i
for i in 1..amount
  Group.create!(name: "#{i}", head_id: "#{Head.find_by(name: "#{(i / 6) + 1}").id}") if Group.find_by(name: "#{i}").nil?
  Staff.create!(name: "מדריכת #{i}", email: "g#{i}@gmail.com", password: "321321", password_confirmation: "321321",
    role: "user", username: "קבוצה #{i}", staffable_type: "Group", staffable_id: Group.find_by(name: "#{i}").id) if Staff.find_by(username: "קבוצה #{i}").nil?
end

puts "Creating VIP..."
Staff.create!(name: "גילעד", email: "gilad@gmail.com", password: "12341234", password_confirmation: "12341234", role: "vip", username: "Gilad", staffable_type: "Axis", staffable_id: "#{Axis.first.id}") if Staff.find_by(username: "Gilad").nil?

# Seeding Admin
puts "Creating Admin..."
Staff.create!(name: "ירדן", email: "yarden11111@gmail.com", password: "12341234", password_confirmation: "12341234", role: "admin", username: "Jordan", staffable_type: "Axis", staffable_id: "#{Axis.first.id}") if Staff.find_by(username: "Jordan").nil?


puts "Created Succesfully"
