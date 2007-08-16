class AdminController < ApplicationController
  def index
    @posts = Post.find(:all)
    @users = User.find(:all)
  end
end
