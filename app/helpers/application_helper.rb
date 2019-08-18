# frozen_string_literal: true

module ApplicationHelper
  def how_many_attending(object)
    counter = 0
    object.each do |kid|
      counter += kid.status unless kid.status.nil? || kid.status == 2
      if kid.status == 2
        counter += 1
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
      html += "<a href='whatsapp://send?text=דיווח על תקלה&phone=972546621300' data-action='share/whatsapp/share' class='btn btn-warning btn-block'>דיווח על תקלה</a>"
    else
      html = "<hr style='width:75%;border: 1px solid #EEE;' />"
      html += mail_to 'yarden11111@gmail.com', 'דיווח על תקלה', subject: 'דיווח על תקלה'
    end
    html.html_safe
  end

end
