class LandingController < ApplicationController
  def index
    render :layout => false
    @contact = Landing.new(params[:landing])
  end

  def create
    @contact = Landing.new(params[:landing])
    @contact.request = request
    respond_to do |format|
      if @contact.deliver
        # re-initialize Landing object for cleared form
        @contact = Landing.new
        format.html { render 'index'}
        format.js   { flash.now[:success] = @message = "Thank you for your message. I'll get back to you soon!" }
      else
        format.html { render 'index' }
        format.js   { flash.now[:error] = @message = "Message did not send." }
      end
    end
  end
end
