class Admin::StylesController < Admin::ApplicationController
  
  def index
    @styles = Style.find(:all)
  end
  
  def new
    @style = Style.new
  end
  
  def create
    @style = Style.new(params[:style])
    if @style.save
      flash[:notice] = "Style has been created."
      redirect_to admin_styles_path
    else
      flash[:notice] = "Style has not been created."
      render :action => "new"
    end
  end
  
  def edit
    @style = Style.find(params[:id])
  end
  
  def update
    @style = Style.find(params[:id])
    if @style.update_attributes(params[:style])
      flash[:notice] = "Style has been updated."
      redirect_to admin_styles_path
    else
      flash[:notice] = "Style has not been updated."
      render :action => "edit"
    end
  end
  
  def destroy
    @style = Style.find(params[:id])
    @style.destroy
    flash[:notice] = "Style has been deleted."
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "The style you were looking for could not be found."
  ensure
    redirect_to admin_styles_path
  end
  
  def make_default
    style = Style.find_by_is_default(true) if !style.nil?
    @style = Style.find(params[:id])
    @style.update_attribute("is_default",true)
    flash[:notice] = "The selected style has been made default."
    redirect_to admin_styles_path
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "The style you were looking for could not be found."
    redirect_to admin_styles_path
    
    
  end
end
