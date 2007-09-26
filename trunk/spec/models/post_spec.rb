require File.dirname(__FILE__) + '/../spec_helper'
include ForumSetup
describe Post, "creation" do
  before(:each) do
    empty_tables
    setup_forum
  end
  
  it "should validate the length of text" do
    @post_1.text = "Shr"
    @post_1.save.should be_false
    @post_1.errors_on(:text).should_not be_empty
  end
end
