class MessagesController < ApplicationController
  before_filter :login_required
  before_filter :store_location, :only => [:index, :new, :sen]
  
  def index
    @messages = Message.find_all_by_to_id(session[:user]).reverse
  end
  
  def new
    @message = Message.new
    @users = User.find(:all, :order => "login ASC")
  end
  
  def create
    params[:message][:from_id] = session[:user]
    @message = Message.create(params[:message])
    redirect_back_or_default(:controller => "messages", :action => "index")
    
  end
 
  def destroy
    
  end
  
  def show
    

  end
end
