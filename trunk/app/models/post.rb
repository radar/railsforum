class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :edits
  #belongs_to :forum, :class_name => "Forum", :foreign_key => "topic_id"
  #FIX THIS USING A PROPER BELONGS_TO
  
  def forum
    topic.forum
  end
end
