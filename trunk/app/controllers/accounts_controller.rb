class AccountsController < ApplicationController
  before_filter :store_location, :only => [:profile, :list]
  before_filter :is_admin?, :only => [:ban, :ban_ip]
  def index
	redirect_to forums_path
  end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    puts current_user.save
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
	        flash[:notice] = "Logged in successfully"
      redirect_back_or_default(:action => "index")

    else
	flash[:notice] = "The username or password you provided is incorrect. Please try again."
	     redirect_back_or_default(:action => "login")
      end
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/account', :action => 'index')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/account', :action => 'index')
  end
  
  def profile
    @user = current_user
  if request.post?
  @user.update_attributes(params[:user])
  flash[:notice] = "Profile has been updated."
  end
  end
  
  def ban_ip
  @banned = BannedIp.find(:all)
  end
  
  def user
  @user = User.find_by_login(params[:login])
  @posts_percentage = @user.posts.size.to_f / Post.count.to_f * 100
  end
  
  def list
  @users = User.find(:all)
  end
  
  def ban
  @user = User.find(:first)
  if request.post?
  params[:user][:banned_by] = current_user
  @user.update_attributes(params[:user])
  flash[:notice] = "User has been banned!"
  redirect_back_or_default(:action => "list")
  end
  end
end
