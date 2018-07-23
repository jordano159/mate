module ApplicationHelper
  def how_many_attending(object)
    counter = 0
    object.each do |kid|
      counter += kid.status if !kid.status.nil?
    end
    counter
  end
end
