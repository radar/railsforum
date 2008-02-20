require File.dirname(__FILE__) + '/../spec_helper'

describe AccountsController do
before do
  @user = mock("user")
  @users = [@user]
end
  #Delete this example and add some real ones
  it "should display a list of the users" do
    User.should_receive(:find).with(:order => "login ASC")
    get 'index'
  end

end
