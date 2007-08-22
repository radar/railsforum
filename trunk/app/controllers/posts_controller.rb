class PostsController < ApplicationController
  #TODO: Rescue on error where needed.
  before_filter :login_required
  def edit
    @post = Post.find(params[:id])
    unless is_post_owner_or_admin?(params[:id])
      flash[:notice] = "You do not own that post."
      redirect_back_or_default(forums_path)
    end
    render :layout => false    
  end
  def update
    @post = Post.find(params[:id])
    @post.update_attributes!(params[:post])
    flash[:notice] = "Post has been updated."
  end
  #does this action do anything?
  def create
    begin
      @post = Post.create!(params[:post])
      flash[:notice] = "Post has been created."
      redirect_to topic_path(@post.forum.id,@post.topic.id)
    end
  end
  def destroy
    @post = Post.find(params[:id]).destroy
    flash[:notice] = "Post was deleted."
    if @post.topic.posts.size.zero?
      Topic.find(@post.topic.id).destroy
      flash[:notice] = "Post was deleted. Since post was last in topic, topic was deleted also."
      redirect_to(forum_path(@post.forum.id))
    else
      redirect_to(topic_path(@post.forum.id,@post.topic.id))
    end
  end
end