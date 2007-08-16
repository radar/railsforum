class TopicsController < ApplicationController
  before_filter :login_required, :except => [:show]
  def new
    @forum = Forum.find(params[:forum_id])
  end
  def create
    @topic = Topic.create!(params[:topic])
    params[:post][:topic_id] = @topic.id
    @post = Post.create!(params[:post])
    flash[:notice] = "Topic has been created."
    redirect_to topic_path(@topic.forum.id,@topic.id)
  end
  def show
    @topic = Topic.find(params[:id])
    @topic.increment!("views")
  end
  def reply
    @topic = Topic.find(params[:id])
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
      params[:moderated_topics].each { |id| Topic.find(id).destroy }
      flash[:notice] = "All selected topics have been deleted."
    end
    redirect_to forum_path(params[:forum_id])
  end
end
