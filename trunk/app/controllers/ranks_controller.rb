class RanksController < ApplicationController

  before_filter :is_admin_redirect
  before_filter :store_location, :only => [:new, :index, :show]
  def new
	  @rank = Rank.new
  end

  def create
	  @rank = Rank.create!(params[:rank])
	  flash[:notice] = "#{@rank.name} has been created."
	  redirect_to ranks_path
	  rescue Exception => @e
	  render :template => "ranks/new"
  end

  def edit
	  @rank = Rank.find(params[:id])
  end

  def update
	  @rank = Rank.find(params[:id])
	  if @rank.update_attributes(params[:rank])
		  flash[:notice] = "#{@rank.name} has been updated."
		  redirect_to ranks_path
          else
		  flash[:notice] = "#{@rank.name} has not been updated."
		  render :template => "edit"
	  end
  end

  def destroy
	  @rank = Rank.find(params[:id]).destroy
	  flash[:notice] = "#{@rank.name} has been destroyed."
	  redirect_to ranks_path
  end

  def index
  @ranks = Rank.find(:all)
  end

  def show
  end
end
