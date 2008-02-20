class ForumsController < ApplicationController

  before_filter :is_visible?, :only => [:show]
  
  def index
    logged_in? ? @forums = Forum.find_all_without_parent.select { |forum| forum.is_visible_to <= current_user.user_level_id } : @forums = Forum.find_all_without_parent.select { |forum| forum.is_visible_to == 1 }
    #perhaps make this like the good old days (bold, red fonts for administrators and so on)
    @lusers = User.find(:all, :conditions => ['login_time > ?',Time.now-15.minutes]).map { |u| u.login }.to_sentence
    @users = User.count
    @posts = Post.count
    @topics = Topic.count
    @ppt = @posts > 0 ? @posts / @topics : 0
  end
  
  def show
    @forum = Forum.find(params[:id])
    @topics = Topic.paginate :page => params[:page], :per_page => 30, :conditions => "forum_id = #{@forum.id}", :order => "sticky DESC, id DESC"
    @forums = @forum.children
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
