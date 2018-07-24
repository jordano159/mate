task d_unapp_checks: :environment do |t|
  Check.where("approved = ? and created_at > ?", false, 1.day.ago).destroy_all
  puts "Deleted today's unapproved checks"
end
