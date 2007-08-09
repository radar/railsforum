class ForumsController < ApplicationController
#TODO: Rescue on error where needed.
	before_filter :is_admin_redirect, :only => [:create, :new]
	before_filter :store_location, :except => [:create]
	def index
		@forums = Forum.find(:all)
	end
	def new
		@forum = Forum.new
		end
	def create
		@forum = Forum.new(params[:forum])
		@forum.save!
		flash[:notice] = "Forum has been created."
		redirect_to :controller => "admin", :action => "index"		
	end
	def show
	@forum = Forum.find(params[:id])
	end
end
