class Admin::ForumsController < Admin::ApplicationController
  before_filter :store_location, :except => [:create, :delete, :update]
  def new
    @forum = Forum.new
    @forums = Forum.find(:all, :order => "title")
  end
  
  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      flash[:notice] = "Forum has been created."
      redirect_to forums_path
    else
      flash[:notice] = "Forum has not been created."
      render :action => "new"
    end
  end
  
  def index
    @forums = Forum.find(:all)
  end
  
  def edit
    @forum = Forum.find(params[:id])
    @forums = Forum.find(:all, :order => "title") - [@forum] - @forum.descendants
  end
  
  def update
    @forum = Forum.find(params[:id])
    if @forum.update_attributes(params[:forum])
      flash[:notice] = "Forum has been updated."
      redirect_to admin_forums_path
    else
      flash[:notice] = "Forum has not been updated."
      render :action => "edit"
    end
  end
end