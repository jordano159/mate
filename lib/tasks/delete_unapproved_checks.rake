task d_unapp_checks: :environment do |t|
  Check.where(approved: false || nil).destroy_all
end
