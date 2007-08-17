class ForumsController < ApplicationController
  before_filter :is_admin_redirect, :only => [:create, :new]
  before_filter :store_location, :except => [:create]
  before_filter :is_viewable?, :except => [:index]
  
  def index
    logged_in? ? @forums = Forum.find(:all).select { |forum| forum.is_visible_to <= current_user.userlvl } : @forums = Forum.find(:all).select { |forum| forum.is_visible_to == 1 }
    #perhaps make this like the good old days (bold, red fonts for administrators and so on)
    @lusers = User.find(:all, :conditions => ['login_time < ?',Time.now-15.minutes]).map { |u| u.login }.to_sentence
    @users = User.count
    @posts = Post.count
    @topics = Topic.count
    @ppt = @posts > 0 ? @posts / @topics : 0
  end
  
  def new
    @forum = Forum.new
  end
  
  def create
    begin
      @forum = Forum.create!(params[:forum])
      flash[:notice] = "Forum has been created."
      redirect_to :controller => "admin", :action => "index"
      rescue ActiveRecord::RecordInvalid
      render :action => "new"
    end
  end
  
  def edit
    @forum = Forum.find(params[:id])	
  end
  
  def update
    @forum = Forum.find(params[:id])
    @forum.update_attributes!(params[:forum])
    flash[:notice] = "#{@forum.title} has been updated."
    redirect_to :controller => "admin", :action => "index"
    rescue ActiveRecord::RecordInvalid
    render :action => "edit"
  end
  
  def show
    @forum = Forum.find(params[:id])
  end
  
  def list
    @forums = Forum.find(:all, :order => "title ASC")
  end
  
  def destroy
    @forum = Forum.find(params[:id]).destroy
    flash[:notice] = "#{@forum.title} has been deleted."
    redirect_to :controller => "admin", :action => "index"
  end
  
end
