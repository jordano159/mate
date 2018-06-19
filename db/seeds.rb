# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# Seeding two Axes
puts "Creating Axes..."
for i in 1..2
  Axis.create!(name: "#{i}") if Axis.find_by(name: "#{i}").nil?
end

# Seeding six Heads
puts "Creating Heads..."
for i in 1..6
  if i < 4
    Head.create!(name: "#{i}", axis_id: "#{Axis.find_by(name: "1").id}") if Head.find_by(name: "#{i}").nil?
  elsif i >= 4
    Head.create!(name: "#{i}", axis_id: "#{Axis.find_by(name: "2").id}") if Head.find_by(name: "#{i}").nil?
  end
end

# Seeding twenty Groups
puts "Creating Groups..."
for i in 1..20
  Group.create!(name: "#{i}", head_id: "#{Head.find_by(name: "#{i/5+1}").id}") if Group.find_by(name: "#{i}").nil?
end

# Seeding Admin
puts "Creating Admin..."
Staff.create!(name: "שיר", email: "shir@gmail.com", password: "123123", password_confirmation: "123123", role: "admin", username: "Shir", staffable_type: "Axis", staffable_id: "#{Axis.first.id}") if Staff.find_by(username: "Shir").nil?


puts "Created Succesfully"
