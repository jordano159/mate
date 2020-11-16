# frozen_string_literal: true

module ApplicationHelper
  def how_many_attending(objects, level)
    counter = 0
    objects.each do |object|
      if object.class == Attendance
        status = object.status.to_i
      else
        if level.class == Group
          status = object.statuses[level.id.to_s].to_i
          counter += status unless status.nil? || status == 2
          if status == 2
            counter += 1
          end
        else
          level.groups.each do |g|
            status = object.statuses[g.id.to_s].to_i
            counter += status unless status.nil? || status == 2
            if status == 2
              counter += 1
            end
          end
        end
      end
    end
    counter
  end


  def mobile_device?
     if session[:mobile_param]
       session[:mobile_param] == "1"
    else
        request.user_agent =~ /Mobile|webOS/
    end
  end

  def error_btn
    if mobile_device?
      html = "<hr style='width:75%;border: 1px solid #EEE;' />"
      html += "<a href='whatsapp://send?text=דיווח על תקלה&phone=972546621300' data-action='share/whatsapp/share' class='text-dark'> <i class='icon icon-bug-solid text-dark'></i> דיווח על תקלה</a>"
    else
      html = "<hr style='width:75%;border: 1px solid #EEE;' />"
      html += mail_to 'yarden11111@gmail.com', '<i class="icon icon-bug-solid"></i> דיווח על תקלה '.html_safe,class:'btn btn-warning btn-sm btn-block', subject: 'דיווח על תקלה'
    end
    html.html_safe
  end

end
