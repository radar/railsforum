class Forum < ActiveRecord::Base
  acts_as_list :scope => "parent_id"
  acts_as_tree
  has_many :topics, :order => "sticky DESC, created_at DESC", :dependent => :destroy
  has_many :posts, :through => :topics, :source => :posts
  validates_presence_of :title, :description
  belongs_to :visible_to, :class_name => "UserLevel", :foreign_key => "is_visible_to"
  belongs_to :creator_of_topics, :class_name => "UserLevel", :foreign_key => "topics_created_by"
  
  def last_post
    topics.empty? ? nil : topics.last.posts.last
  end
  
  def descendants
    children.map { |f| !f.children.empty? ? f.children + [f]: f }.flatten
  end
  

  
end
