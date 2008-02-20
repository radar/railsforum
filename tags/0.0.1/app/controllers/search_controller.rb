class SearchController < ApplicationController
  def user
    @user = User.find(:first)
    render :layout => false
  end
end
