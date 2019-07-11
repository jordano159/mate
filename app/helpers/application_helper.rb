# frozen_string_literal: true

module ApplicationHelper
  def how_many_attending(object)
    counter = 0
    object.each do |kid|
      counter += kid.status unless kid.status.nil?
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
    html = "<hr style='width:75%;border: 1px solid #EEE;' />"
    if mobile_device?
      html += "<a href='whatsapp://send?text=דיווח על בעיה בשולחן קליטה&phone=972558831115' data-action='share/whatsapp/share' class='btn btn-warning btn-block'>דיווח על בעיה או תקלה</a>"
    else
      html += mail_to 'itay.ariely@gmail.com', 'דיווח על בעיה או תקלה', subject: 'דיווח על בעיה או תקלה בשולחן קליטה', class:'btn btn-warning btn-block'
    end
    html.html_safe
  end
  
end
