class PostsController < ApplicationController
#TODO: Rescue on error where needed.
before_filter :login_required
def edit
@post = Post.find(params[:id])
end
def update
@post = Post.find(params[:id])
@post.update_attributes!(params[:post])
flash[:notice] = "Post has been updated."
redirect_to topic_path(@post.topic)
end
def create
	begin
	@post = Post.create!(params[:post])
	flash[:notice] = "Post has been created."
	redirect_to topic_path(@post.topic.id)
	rescue
	flash[:notice] = "Post was not created."
	redirect_back_or_default(reply_topic_path(@post.topic))
end
end
def destroy
	@post = Post.find(params[:id]).destroy
	flash[:notice] = "Post was deleted."
	if @post.topic.posts.size == 0
		Topic.find(@post.topic.id).destroy
		redirect_back_or_default(forum_path(@post.topic.forum.id))
	else
	redirect_back_or_default(topic_path(@post.topic.id))
	end
	end
end