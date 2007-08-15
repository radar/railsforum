class ForumsController < ApplicationController
	before_filter :is_admin_redirect, :only => [:create, :new]
	before_filter :store_location, :except => [:create]
	
	def index
		@forums = Forum.find(:all)
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
