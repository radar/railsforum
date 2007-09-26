class Forum < ActiveRecord::Base
  acts_as_list
  has_many :topics, :order => "sticky DESC, created_at DESC", :dependent => :destroy
  has_many :posts, :through => :topics, :source => :posts
  validates_presence_of :title, :description
  
  def last_post
    topics.empty? ? nil : topics.last.posts.last
  end
end
