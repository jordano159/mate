# להריץ אחרי שעושים מיגרציה בשרת


# מגדיר  trash_bin לכל קבוצה, קבוצות שהן סל מחזור מוגרות trash
Group.all.each do |g|
  if g.name.start_with?("סל מחזור")
    g.update(trash_bin: :trash)
    g.kid_groups.update_all(status: :unactive)
  else
    g.update(trash_bin: :untrash)
    g.kid_groups.update_all(status: :active)
  end
end

# מכניס את הקבוצה של הילד לקבוצות שלו
# מכניס את הסטטוס והסיבה שלו להאש
Kid.all.each do |k|
  k.groups << Group.find(k.group_id)
  # לבדוק שעובד לפני שמריצים
  k.update(statuses: {"#{k.group_id}" => k.attendances.last.status}, causes: {"#{k.group_id}" => k.attendances.last.cause})
end


Mifal.all.each do |m|
  m.columns.map! { |c| c == 'group' ? 'groups' : c }
  m.save!
end
