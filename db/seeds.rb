# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# Create Mifal
puts "What's the name of your new and awesome factory?"
name = STDIN.gets.chomp
Mifal.create(name: name)

puts 'Creating VIP...'
if Staff.find_by(username: 'Gilad').nil?
  Staff.create!(name: 'גילעד', email: 'gilad@gmail.com', password: '12341234', password_confirmation: '12341234',
                role: 'vip', username: 'Gilad', staffable_type: 'Mifal', staffable_id: Mifal.find_by(name: name).id)
end

# Seeding Admin
puts 'Creating Admin...'
if Staff.find_by(username: 'Jordan').nil?
  Staff.create!(name: 'ירדן', email: 'yarden11111@gmail.com', password: '12341234', password_confirmation: '12341234',
                role: 'admin', username: 'Jordan', staffable_type: 'Mifal', staffable_id: Mifal.find_by(name: name).id)
end

# Seeding Axes
puts 'How Many Axes?'
amount = STDIN.gets.chomp.to_i
(1..amount).each do |i|
  Axis.create(name: "ציר #{i}") if Axis.find_by(name: "ציר #{i}").nil?
  next unless Staff.find_by(username: "ציר #{i}").nil?

  Staff.create(name: "רכזת ציר #{i}", email: "a#{i}@gmail.com", password: '123123', password_confirmation: '123123',
               role: 'user', username: "ציר #{i}", staffable_type: 'Axis',
               staffable_id: Axis.find_by(name: "ציר #{i}").id)
end

# Seeding Heads
puts 'How Many Heads?'
amount = STDIN.gets.chomp.to_i
puts 'How Many Heads In An Axis?'
div = STDIN.gets.chomp.to_i
(1..amount).each do |i|
  Head.create!(name: "ראש #{i}", axis_id: Axis.find_by(name: "ציר #{(i / (div + 1)) + 1}").id.to_s) if Head.find_by(name: "ראש #{i}").nil?
  next unless Staff.find_by(username: "ראש #{i}").nil?

  Staff.create!(name: "ראשראשית #{i}", email: "h#{i}@gmail.com", password: '123123', password_confirmation: '123123',
                role: 'user', username: "ראש #{i}", staffable_type: 'Head',
                staffable_id: Head.find_by(name: "ראש #{i}").id)
end

# Seeding Groups
puts 'How Many Groups?'
amount = STDIN.gets.chomp.to_i
puts 'How Many Groups In A Head?'
div = STDIN.gets.chomp.to_i
(1..amount).each do |i|
  Group.create!(name: "קבוצה #{i}", head_id: Head.find_by(name: "ראש #{(i / (div + 1)) + 1}").id.to_s) if Group.find_by(name: "קבוצה #{i}").nil?
  next unless Staff.find_by(username: "קבוצה #{i}").nil?

  Staff.create!(name: "מדריכת #{i}", email: "g#{i}@gmail.com", password: '321321', password_confirmation: '321321',
                role: 'user', username: "קבוצה #{i}", staffable_type: 'Group',
                staffable_id: Group.find_by(name: "קבוצה #{i}").id)
end



puts 'Created Succesfully'
