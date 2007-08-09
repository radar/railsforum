class Forum < ActiveRecord::Base
has_many :topics, :dependent => :destroy
has_many :posts, :through => :topics, :source => :posts
end
