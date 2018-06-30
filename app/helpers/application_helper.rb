module ApplicationHelper
  def how_many_attending(object)
    counter = 0
    object.kids.each do |kid|
      counter += kid.current_status if kid.current_status
    end
    counter
  end
end
