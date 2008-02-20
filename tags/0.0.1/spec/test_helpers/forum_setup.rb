module ForumSetup
  #sometimes we want to empty the tables once
  def self.included(mod)
    empty_tables
  end
  
  def empty_tables
    for klass in [Forum,Post,Topic,User]
      klass.delete_all
    end
  end
  
  def setup_forum
    @user_1 = User.create!(:login => "God", :password => "whatwouldgodspasswordbe", :password_confirmation => "whatwouldgodspasswordbe", :email => "god@heaven.com")
    
    @forum_1 = Forum.create!(:title => "First Forum", :description => "This is the first forum.")
    #Leave the second forum empty.
    @forum_2 = Forum.create!(:title => "Second Forum", :description => "This is the second forum.")
    
    @topic_1 = Topic.create!(:subject => "First Topic", :forum_id => @forum_1.id, :user_id => @user_1.id)
    
    @post_1 = Post.create!(:user_id => @user_1.id, :topic_id => @topic_1.id, :text => "This is the first topic, first post!")
  end
end