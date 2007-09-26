class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  belongs_to :editor, :class_name => "User", :foreign_key => "edited_by_id"
  validates_length_of :text, :minimum => 4
  validates_presence_of :text, :user_id

  #belongs_to :forum, :class_name => "Forum", :foreign_key => "topic_id"
  #FIX THIS USING A PROPER BELONGS_TO
  
  def forum
    topic.forum
  end
end
