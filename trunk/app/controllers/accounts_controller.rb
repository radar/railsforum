class AccountsController < ApplicationController
  before_filter :store_location, :only => [:profile, :list]
  before_filter :is_admin?, :only => [:ban, :ban_ip]

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
      if logged_in?
	current_user.update_attribute("previous_login",current_user.login_time)
    current_user.update_attribute("login_time",Time.now)
      if params[:remember_me] == 1
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
	        flash[:notice] = "Logged in successfully"
      redirect_back_or_default(:action => "index")

    else
	flash[:notice] = "The username or password you provided is incorrect. Please try again."
      end
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(forums_path)
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(forums_path)
  end
  
  def profile
    @user = current_user
  if request.post?
	  params[:user][:crypted_password] = @user.encrypt(params[:user][:password])  if params[:user][:password] == params[:user][:password_confirmation] && !params[:user][:password].blank? 
	  flash[:notice] = "Password has been changed. Please remember to use this password from now on. Your profile has been updated." unless params[:user][:crypted_password].nil?
  @user.update_attributes(params[:user])
  flash[:notice] ||= "Your profile has been updated."
  end
  end
  #maybe move these methods into their own controller, they have nothing to do with users.
  def ban_ip
  if request.post?
  params[:banned_ip][:ban_time] = Chronic.parse(params[:banned_ip][:ban_time])
  params[:banned_ip][:ip].gsub!(".","\.").gsub!("*","[0-9]{1,3}")
  BannedIp.create(params[:banned_ip])
  flash[:notice] = "The IP range has been banned."
  end
  @banned = BannedIp.find(:all)
  end
  #This one too.
  def remove_banned_ip
  @banned_ip = BannedIp.find(params[:id]).destroy
  flash[:notice] = "The IP range has been unbanned."
  redirect_to :action => :ban_ip
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
  params[:user][:ban_time] = Chronic.parse(params[:user][:ban_time])
  @user.update_attributes(params[:user])
  flash[:notice] = "User has been banned!"
  redirect_back_or_default(:action => "list")
  end
  end
  
  def ip_is_banned
	  unless ip_banned?
	  redirect_to forums_path
	  end
	  end
end
