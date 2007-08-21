class RanksController < ApplicationController
 #ASSIGN RANKS AUTOMATICALLY TO PEOPLE.
  before_filter :is_admin_redirect
  before_filter :store_location, [:new, :index, :show]
  def new
	  @rank = Rank.new
  end

  def create
	  @rank = Rank.create!(params[:rank])
	  flash[:notice] = "#{@rank.name} has been created."
	  redirect_to ranks_path
	  rescue Exception => @e
	  render :template => "new"
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
  @ranks = Rank.find(:all)
  end

  def show
  end
end
