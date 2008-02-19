class Admin::ChronicController < Admin::ApplicationController
  def index
    @time = Chronic.parse(params[:duration])
    render :text => @time
    rescue Exception => e
    render :text => "Invalid format."
  end
end
