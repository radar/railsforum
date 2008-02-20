require File.dirname(__FILE__) + '/../spec_helper'
include ForumSetup
describe Topic, "creation" do
  before do
    empty_tables
    setup_forum
  end
  it "should validate the length of the subject" do
    @topic_1.subject = "Srt"
    @topic_1.save.should be_false
    @topic_1.errors_on(:subject).should_not be_empty
  end
  it "should validate the presence of subject" do
    @topic_1.subject = nil
    @topic_1.save.should be_false
    @topic_1.errors_on(:subject).should_not be_empty
  end
  it "should validate the presence of a forum_id" do
    @topic_1.forum_id = nil
    @topic_1.save.should be_false
    @topic_1.errors_on(:forum_id).should_not be_empty
  end
  it "should validate the presence of a user_id" do
    @topic_1.user_id = nil
    @topic_1.save.should be_false
    @topic_1.errors_on(:user_id).should_not be_empty
  end
  

end
