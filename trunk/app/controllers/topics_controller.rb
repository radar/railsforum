class TopicsController < ApplicationController
before_filter :login_required, :except => [:view]
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
end
