# frozen_string_literal: true

module ApplicationHelper
  def how_many_attending(object)
    counter = 0
    object.each do |kid|
      counter += kid.status unless kid.status.nil?
    end
    counter
  end
end
