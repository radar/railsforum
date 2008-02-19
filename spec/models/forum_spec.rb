require File.dirname(__FILE__) + '/../spec_helper'
include ForumSetup
describe Forum, "creation" do
  before(:each) do
    empty_tables
    setup_forum
    @forum = Forum.new
  end

  it "should validate the presence of a title" do
    @forum.save.should be_false
    @forum.errors_on(:title).should_not be_empty
  end
  it "should validate the presence of a description" do
    @forum.save.should be_false
    @forum.errors_on(:description).should_not be_empty
  end
  
end

describe Forum, "in general" do
  before do
    empty_tables
    setup_forum
    @post = mock("post")
  end
  it "should be able to find the last post" do
    @forum_1.last_post.should_not be_nil
  end
  it "should not be able to find the last post" do
    @forum_2.last_post.should be_nil
  end
end
