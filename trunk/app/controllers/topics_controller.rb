class TopicsController < ApplicationController
  before_filter :login_required, :except => [:show]
  before_filter :is_viewable?, :only => [:show]
  before_filter :can_create_topics?, :only => [:new, :create]
  before_filter :store_location, :only => [:view, :new, :edit, :reply]
  #rescuing needed.
  
  def new
    @forum = Forum.find(params[:forum_id])
  end
  
  def create
    Topic.transaction do
      @topic = Topic.new(params[:topic].merge(:user_id => current_user.id, :forum_id => params[:forum_id]))
      @post = @topic.posts.build(params[:post].merge!(:user_id => current_user.id))
      @topic.sticky = true if params[:topic][:sticky] == 1
      @topic.save!
    end
    flash[:notice] = "Topic has been created."
    redirect_to forum_topic_path(@topic.forum.id,@topic.id)
    #example of a "proper" rescue
  rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid => @e
    flash[:notice] = "Topic was not created."
    @forum = Forum.find(params[:forum_id])
    render :template => "topics/new"
  end
  
  def show
    @topic = Topic.find(params[:id])
    @topic.increment!("views")
  end
  
  def reply
    @topic = Topic.find(params[:id])
    #is there an easier way to do this?
    @posts = @topic.posts.reverse.last(10)
    @post = Post.find(params[:quote]) if params[:quote]
  end
  
  def moderate
    case params[:commit]
    when "Lock"
      params[:moderated_topics].each { |id| Topic.find(id).update_attribute("locked",true) }
      flash[:notice] = "All selected topics have been locked."
    when "Unlock"
      params[:moderated_topics].each { |id| Topic.find(id).update_attribute("locked",false) }
      flash[:notice] = "All selected topics have been unlocked."
    when "Delete"
      #TODO: maybe ask for confirmation?
      params[:moderated_topics].each { |id| Topic.find(id).destroy }
      flash[:notice] = "All selected topics have been deleted."
    when "Sticky"
      params[:moderated_topics].each { |id| Topic.find(id).update_attribute("sticky",true) }
    when "Unsticky"
      params[:moderated_topics].each { |id| Topic.find(id).update_attribute("sticky",false) }
    end
    redirect_to forum_path(params[:forum_id])
  end
  
  #these two methods do basically the same thing
  def lock
    topic = Topic.find(params[:id])
    topic.update_attribute("locked",true)
    flash[:notice] = "This topic has been locked."
    redirect_to topic_path(topic.id)
  end
  
  def unlock
    topic = Topic.find(params[:id])
    topic.update_attribute("locked",false)
    flash[:notice] = "This topic has been unlocked."
    redirect_to topic_path(topic.id)
  end

  private
  
  def is_viewable?
    @topic = Topic.find(params[:id])
    unless (logged_in? && @topic.forum.is_visible_to <= current_user.user_level_id) || @topic.forum.is_visible_to = 1
      flash[:notice] = "You do not have the permissions to access that topic."
      redirect_to forums_path
    end
  end
  
  def can_create_topics?
    forum = Forum.find(params[:forum_id])
    unless forum.topics_created_by <= current_user.user_level_id
      flash[:notice] = "You cannot create a topic in this forum."
      redirect_back_or_default(forum_path(forum))
    end
  end
 
end
